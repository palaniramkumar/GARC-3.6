		
	// Trap Backspace(8) and Enter(13) - 
// Except bksp on text/textareas, enter on textarea/submit

if (typeof window.event != 'undefined') // IE
  document.onkeydown = function() // IE
    {
    var t=event.srcElement.type;
    var kc=event.keyCode;
    return ((kc != 8 && kc != 13) || ( t == 'text' &&  kc != 13 ) ||
             (t == 'textarea') || ( t == 'submit' &&  kc == 13))
    }
else
  document.onkeypress = function(e)  // FireFox/Others 
    {
    var t=e.target.type;
    var kc=e.keyCode;
    if ((kc != 8 && kc != 13) || ( t == 'text' &&  kc != 13 ) ||
        (t == 'textarea') || ( t == 'submit' &&  kc == 13))
        return true
    else {
        alert('Sorry Backspace/Enter is not allowed here'); // Demo code
        return false
    }
   }
   
   		
   var oLastBtn=0;
   bIsMenu = false;
   //No RIGHT CLICK************************
   if (window.Event)
   document.captureEvents(Event.MOUSEUP);
   function nocontextmenu()
   {
   event.cancelBubble = true
   event.returnValue = false;
   return false;
   }
   function norightclick(e)
   {
   if (window.Event)
   {
   if (e.which !=1)
   return false;
   }
   else
   if (event.button !=1)
   {
   event.cancelBubble = true
   event.returnValue = false;
   return false;
   }
   }
   document.oncontextmenu = nocontextmenu;
   document.onmousedown = norightclick;
   function onKeyDown() {
   if ((event.altKey) || ((event.keyCode == 8) ||((event.ctrlKey) && ((event.keyCode == 78) || (event.keyCode == 82))) 
   
   ||(event.keyCode == 116)||(event.keyCode == 122)))
   {
   event.keyCode = 0;
   event.returnValue = false;
   }
   }

document.attachEvent("onkeydown", my_onkeydown_handler); 
function my_onkeydown_handler() 
{ 
switch (event.keyCode) 
{ 

case 116 : // 'F5' 
event.returnValue = false; 
event.keyCode = 0; 
window.status = "We have disabled F5"; 
break; 
} 
} 
