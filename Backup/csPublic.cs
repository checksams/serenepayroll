using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Microsoft.Win32; 


namespace SerenePayroll
{
    public class csPublic
    {
        public String HelloWorld(String strGreetings)
        {
            bool v_bool;
            String strCustomerID;
            String strKey;
            String strGreet;
            String strRegDate, strRegDate2;
            DateTime dt = DateTime.Now;
            DateTime RegesteredDt;
            TimeSpan diffResult;
            int v_dateDiff = 0, v_next_year, v_RenewCount;
            v_bool = false;
            String strResponce="";
            int v_g_prd = 0;
            try
            {
                strRegDate = dt.ToString("dd") + "/" + dt.ToString("MM") + "/" + dt.ToString("yyyy");
                v_next_year = dt.Year + 1;
                strRegDate2 = dt.ToString("dd") + "/" + dt.ToString("MM") + "/" + v_next_year.ToString();
                System.Diagnostics.Debug.WriteLine("dt.ToString dd=" + dt.ToString("dd") + " " + dt.ToString("MM") + " " + dt.ToString("yyyy") + " strRegDate=" + strRegDate + " strRegDate2=" + strRegDate2);
                
                Microsoft.Win32.RegistryKey key,key2, keyRead;
                keyRead = Microsoft.Win32.Registry.CurrentUser.OpenSubKey("DescribeSRS");
                if (keyRead == null)
                {
                    key = Microsoft.Win32.Registry.CurrentUser.CreateSubKey("DescribeSRS");
                    key.SetValue("Key", "HTGFWDSLORTVBSZO");
                    key.SetValue("CustomerID", "1");
                    key.SetValue("RenewCount", "0");
                    key.SetValue("CustomerResponse", strGreetings); 
                    
                    System.Diagnostics.Debug.WriteLine("strRegDate   ======  " + strRegDate);

                    key.SetValue("RegDt", strRegDate);
                    key.SetValue("RegDt2", strRegDate2);
                    System.Diagnostics.Debug.WriteLine("strRegDate   ======  " + strRegDate);
                
                    key.Close();
                    v_bool = true;
                    System.Diagnostics.Debug.WriteLine("ssssPass....");
                }
                else
                {
                    strCustomerID = (String)keyRead.GetValue("CustomerID");
                    v_RenewCount = Convert.ToInt32(keyRead.GetValue("RenewCount"));
                    strKey = (String)keyRead.GetValue("Key");
                    strGreet = (String)keyRead.GetValue("CustomerResponse");
                    System.Diagnostics.Debug.WriteLine("strRegDate   ffffffff  " + strRegDate);
                
                    strRegDate = (String)keyRead.GetValue("RegDt");
                    System.Diagnostics.Debug.WriteLine("strRegDate   gggggggg  " + strRegDate);
                
                    RegesteredDt = DateTime.ParseExact(strRegDate, "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture);
                    diffResult = dt.Subtract(RegesteredDt);
                    v_dateDiff= diffResult.Days;

                    if (strGreet == "" || strGreet == null)
                    {
                        System.Diagnostics.Debug.WriteLine("Register....strCustomerID=" + strCustomerID + " strKey=" + strKey);

                        key = Microsoft.Win32.Registry.CurrentUser.CreateSubKey("DescribeSRS");
                        System.Diagnostics.Debug.WriteLine("Register.222...strCustomerID=" + strCustomerID + " strKey=" + strKey + " strGreetings=" + strGreetings);

                        key.SetValue("CustomerResponse", strGreetings);
                        System.Diagnostics.Debug.WriteLine("Register.333...strCustomerID=" + strCustomerID + " strKey=" + strKey + " strGreetings=" + strGreetings);
                    
                        key.Close();
                        strGreet = strGreetings;
                        System.Diagnostics.Debug.WriteLine("Register..444..strCustomerID=" + strCustomerID + " strKey=" + strKey + " strGreetings=" + strGreetings);

                    }
                    if (!(strGreet == "" || strGreet == null) && !(strGreetings == "" || strGreetings == null) && !(strGreetings == "" || strGreet == null))
                    {
                        key = Microsoft.Win32.Registry.CurrentUser.CreateSubKey("DescribeSRS");
                        System.Diagnostics.Debug.WriteLine("Register.444...strCustomerID=" + strCustomerID + " strKey=" + strKey + " strGreetings=" + strGreetings);

                        key.SetValue("CustomerResponse", strGreetings);
                        System.Diagnostics.Debug.WriteLine("Register.555...strCustomerID=" + strCustomerID + " strKey=" + strKey + " strGreetings=" + strGreetings);

                        key.Close();
                        strGreet = strGreetings;
                        

                    }

                    //Validation area now
                    System.Diagnostics.Debug.WriteLine("Pfffass....strCustomerID=" + strCustomerID + " strKey=" + strKey + " strGreet=" + strGreet + " dateDiff=" + diffResult.Days.ToString());
                    if (strCustomerID == "1")
                    {
                        if (strKey == "HTGFWDSLORTVBSZO" && strGreet == strKey)
                        {
                            v_bool = true;
                            System.Diagnostics.Debug.WriteLine("Pfffass....TRUE..");
                        }
                        else {
                            if (v_dateDiff <= v_g_prd)
                            {
                                v_bool = true;
                                System.Diagnostics.Debug.WriteLine("Ppppppass....TRUE..Days=" + v_dateDiff.ToString());
                            }
                            else if (v_dateDiff < 0) {
                                key2 = Microsoft.Win32.Registry.CurrentUser.CreateSubKey("DescribeSRS");
                                key2.SetValue("strRegDate", "01/01/1901");
                                key2.Close();
                                v_bool = false; 
                                System.Diagnostics.Debug.WriteLine("Pfalse....FALSE..Days=" + v_dateDiff.ToString());
                            }
                            else if (v_dateDiff > v_g_prd)
                            {
                                v_bool = false;
                                System.Diagnostics.Debug.WriteLine("Pfffass....FALSE..Days=" + v_dateDiff.ToString());
                            }                         
                        }
                    }
                }
                if (v_bool != true)
                {
                    strResponce = "You need to provide a product key to use this application.";

                    if (v_dateDiff > v_g_prd)
                    {
                        strResponce = "Your trial version has expired.";
                    }  
                }
                else {
                    strResponce = "Hello.";
                }
                System.Diagnostics.Debug.WriteLine("strResponce....strResponce=" + strResponce);
                keyRead.Close();
                return strResponce;
            }
            catch (Exception ex)
            {
                strResponce = "";
                System.Diagnostics.Debug.WriteLine("Writing Error..."+ex.Message );

                return strResponce;
            }
        }



    }
    
}