using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SerenePayroll
{

    public class MessageItem

    {
        int _Entry_ID;
        string _Message;
    

        public MessageItem(){

        }
        
        public int Entry_ID {
            get {return _Entry_ID;

            }

            set{
                _Entry_ID = value;
            }
        }

         public string Message
        {
            get{

                return _Message;
            }

            set{
                _Message = value;
            }
        }
    }
}