/*!
*
Created by Samuel
*/


	function AllowOnlyNumeric(e) {
		if (window.event) // IE 
		{
			if ((((
					(((((e.keyCode < 48 || e.keyCode > 57) & e.keyCode != 8) & e.keyCode != 46) & e.keyCode != 13) & e.keyCode != 9)
				 & e.keyCode != 37) & e.keyCode != 38) & e.keyCode != 39) & e.keyCode != 40){
				event.returnValue = false;
				return false;

			}
		}
		else { // Fire Fox
			if ((((
				(((((e.which < 48 || e.which > 57) & e.which != 8) & e.which != 46) & e.keyCode != 13) & e.keyCode != 9)
				 & e.keyCode != 37) & e.keyCode != 38) & e.keyCode != 39) & e.keyCode != 40){
				e.preventDefault();
				return false;

			}
		}
	}
	function AllowOnlyTelNumbers(e) {
		if (window.event) // IE 
		{
			if ((((
				((((e.keyCode < 48 || e.keyCode > 57) & e.keyCode != 8) & e.keyCode != 13) & e.keyCode != 9)
				 & e.keyCode != 37) & e.keyCode != 38) & e.keyCode != 39) & e.keyCode != 40){ {
				event.returnValue = false;
				return false;

			}
		}
		else { // Fire Fox
			if ((((
				((((e.which < 48 || e.which > 57) & e.which != 8) & e.keyCode != 13) & e.keyCode != 9)
				 & e.keyCode != 37) & e.keyCode != 38) & e.keyCode != 39) & e.keyCode != 40){ {
				e.preventDefault();
				return false;

			}
		}
	}
	
	function MyJavaFunction(title, msg) {
		//alert("This is another function bbbbbbbbbbbbb.");
		var orignalstring = document.getElementById("msgbox").innerHTML;
		var newstring = orignalstring.replace("[TITLE]", title);
		document.getElementById("msgbox").innerHTML = newstring;

		orignalstring = document.getElementById("msgbox").innerHTML;
		newstring = orignalstring.replace("[MESSAGE]", msg);
		document.getElementById("msgbox").innerHTML = newstring;

		document.getElementById('pagedimmer').style.visibility = 'visible';
		document.getElementById('pagedimmer').style.display = 'inline';
		document.getElementById('msgbox').style.visibility = 'visible';
		document.getElementById('msgbox').style.display = 'inline';
	}
	
	function DisplayReport(title, msg) {
		var orignalstring = document.getElementById("Div2").innerHTML;
		var newstring = orignalstring.replace("[TITLE]", "Employee Listing Report.");
		document.getElementById("Div2").innerHTML = newstring;

		orignalstring = document.getElementById("Div2").innerHTML;
		newstring = orignalstring.replace("[MESSAGE]", "");
		document.getElementById("Div2").innerHTML = newstring;

		document.getElementById('Div1').style.visibility = 'visible';
		document.getElementById('Div1').style.display = 'inline';
		document.getElementById('Div2').style.visibility = 'visible';
		document.getElementById('Div2').style.display = 'inline';
	}
	
	function DisplayReportxs(title, msg) {
		var orignalstring = document.getElementById("divReports2").innerHTML;
		var newstring = orignalstring.replace("[TITLE]", "Employee Listing Report.");
		document.getElementById("Div2").innerHTML = newstring;

		orignalstring = document.getElementById("divReports2").innerHTML;
		newstring = orignalstring.replace("[MESSAGE]", "");
		document.getElementById("divReports2").innerHTML = newstring;

		document.getElementById('divReports1').style.visibility = 'visible';
		document.getElementById('divReports1').style.display = 'inline';
		document.getElementById('divReports2').style.visibility = 'visible';
		document.getElementById('divReports2').style.display = 'inline';
	}
	
	function checkFileExtension(elem)
    {
        var filePath = elem.value;
 
        if (filePath.indexOf('.') == -1)
            return false;
 
        var validExtensions = new Array();
        var ext = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();
 
        validExtensions[0] = 'jpg';
        validExtensions[1] = 'jpeg';
        validExtensions[3] = 'bmp';
        validExtensions[4] = 'gif';
        validExtensions[5] = 'tif';
        validExtensions[6] = 'tiif';
 
        for (var i = 0; i < validExtensions.length; i++)
        {
            if (ext == validExtensions[i])
                return true;
        }
 
        alert('The file extension ' + ext.toUpperCase() + ' is not allowed!');
        return false;
    }

/*
hksf safgs sgsdg HTGFWDSLORTVBSZO

*/