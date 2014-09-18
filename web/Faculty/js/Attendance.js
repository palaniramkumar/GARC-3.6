/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function saveVoidHr(){
 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Saving...</center>");
 var url="AjaxPages/addVoidHour.jsp?action=save";
 var date=$('#date').val()
 var hr=$('#hrs').val()
 var type=$('#type').val()
 var semester=$('#semester').val()
 var sec=$('#section').val()
 //alert("im in Save void Hr");
$.ajax({
                type: "POST",
                url: url,
                data:"action=save&subjectid=none&date="+date+"&hr="+hr+"&type="+type+"&semester="+semester+"&section="+sec+"&rand="+Math.random(),
                success: function(msg){
                       $('#status').html("<center>Saved</center>");
                       //alert("im in Ajax Reponse")
                       //$('#right').html(msg);
                       voidReport();
                        t=setTimeout("clearmsg()",3000);
                }
            });
}
function voidhour(){
 url="AjaxPages/addVoidHour.jsp?action=none&subjectid=none"
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').show();
 $.ajax({
                type: "POST",
                url: url,
                
                success: function(msg){
                       $('#status').html("<center>Loaded</center>");
                       $('#right').html(msg);
                       $('#date').datepicker({dateFormat: 'dd/mm/yy'});
                        t=setTimeout("clearmsg()",3000);
						voidReport();
                }
            });

}
function voidReport(){
url="AjaxPages/addVoidHour.jsp?action=showall&subjectid=none"
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').show();
 //alert("Void Report Called")
 $.ajax({
                type: "POST",
                url: url,
                
                success: function(msg){
                       $('#status').html("<center>Loaded</center>");
                       $('.blockreport').html(msg);                       
                       t=setTimeout("clearmsg()",3000);
                }
            });

}
function RmBlock(id){
url="AjaxPages/addVoidHour.jsp?action=delete&subjectid=none&id="+id;
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').show();
 $.ajax({
                type: "POST",
                url: url,
                
                success: function(msg){
                       $('#status').html("<center>Loaded</center>");
                       $('.blockreport').html(msg);
                       voidReport();
                }
            });

}
/* function cumulativeReport(){ // refer Report.js
 url="AjaxPages/ShowAttendance.jsp"
 $('#status').html("<center><img src='../images/loading.gif'/>Loading Report...</center>");
 $('#status').show();
//alert("action=report&month="+$('#monthSubject').val()+"&hour=");
 $.ajax({
                type: "POST",
                url: url,
                data:"action=report&month="+$('#monthSubject').val()+"&hour=",
                success: function(msg){
                       $('#studentlist').html(msg);
                       $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                       $('#status').html("<center>Loaded</center>");
                       
                       $(".popup").click(function () {
                             
                              var pos = $(this).position();
                                var left= pos.left;
                                $('#tooltip').css("left", left)
                                var top= pos.top-150;
                                $('#tooltip').css("top", top)
                                $('#tooltip').show();
                                //alert($(this).html())
                                $('#tooltip').html("please Wait...");
                              
                                 $.ajax({
                                    type: "POST",
                                    url: "./AjaxPages/StudentDetail.jsp",
                                    data:"student_id="+$(this).attr('title'),
                                    success: function(msg){
                                        
                                           $('#tooltip').html(msg)
                                    }
                                });
                        });
                       t=setTimeout("clearmsg()",3000);
                }
            });
}*/
function loadtopic(unit){
 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 var url="AjaxPages/ShowAttendance.jsp";
$.ajax({
                type: "POST",
                url: url,
                data:"action=loadtopic&subjectid=none&unit="+unit+"&rand="+Math.random(),
                success: function(msg){
                       $('#status').html("<center>Loaded</center>");
                       $('#li_topic').html(msg);
                        t=setTimeout("clearmsg()",3000);
                }
            });
}
function DeleteAttendance(){
 $('#dialog').dialog('open');
}
function advance(){
url="AjaxPages/ShowAttendance.jsp";

 if($.validate('action')==false)
     return;
if( $('#hrs').val().substr(-1,1)==',' ){
   alert("Please check the hour input");
   return;
}

 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
 
if( confirm("Do You want to Record Attendance. Click OK to Continue & Cancel to Block Hour")==false){
    //alert("action=block&subjectid=none&hour="+$('#hrs').val()+"&date="+$('#date').val()+"&rand="+Math.random())
    $.ajax({
                type: "POST",
                url: url,
                data:"action=block&subjectid=none&hour="+$('#hrs').val()+"&date="+$('#date').val()+"&rand="+Math.random(),
                success: function(msg){
                       $('#studentlist').html(msg);
                       $('#list li').css('width', '50%');
                      // $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                       $('#status').html("<center>Loaded</center>");
                       Alert("Successfully Blocked");
                        t=setTimeout("clearmsg()",3000);
                }
            });

    return;
}
 
$.ajax({
                type: "POST",
                url: url,
                data:"action=view&subjectid=none&hour="+$('#hrs').val()+"&date="+$('#date').val()+"&rand="+Math.random(),
                success: function(msg){
                       $('#studentlist').html(msg);
                       $('#list li').css('width', '50%');
                      // $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                       $('#status').html("<center>Loaded</center>");
                       
                        t=setTimeout("clearmsg()",3000);
                }
            });
}


function attendance(){
    $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
url="AjaxPages/ShowAttendance.jsp"
curpage=attendance;
$.ajax({
                type: "POST",
                url: url,
                data:"action=showall&subjectid=none&rand="+Math.random(),
                success: function(msg){
                       $('#right').html(msg);
                       $('#date').datepicker({dateFormat: 'dd/mm/yy'});
                       $("#dialog").dialog( 'destroy' ) ;
                        $("#dialog").dialog({
                        bgiframe: true,
                        resizable: false,
                        height:50,
                        width: 325,
                        modal: true,
                        autoOpen: false,
                        overlay: {
                                backgroundColor: '#000',
                                opacity: 0.5
                        },
                        buttons: {
                                'Continue': function() {
                                         $(this).dialog('close');
                                            url="AjaxPages/ShowAttendance.jsp"
                                             $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
                                             $('#status').show();
                                            $.ajax({
                                                            type: "POST",
                                                            url: url,
                                                            data:"action=delete&subjectid=none&hour="+$('#hrs').val()+"&date="+$('#date').val()+"&rand="+Math.random(),
                                                            success: function(msg){
                                                                   $('#right').html(msg);
                                                                   $('#list li').css('width', '50%');
                                                                   $('#date').datepicker({dateFormat: 'dd/mm/yy'});
                                                                   $('#status').html("<center>Deleted</center>");
                                                                    attendance();
                                                            }
                                                        });
                                },
                                Cancel: function() {
                                        $(this).dialog('close');
                                }
                        }
                });
                        $('button').button();
                       $('#status').html("<center>Loaded</center>");
                        t=setTimeout("clearmsg()",3000);
                }
            });
}



function feedAttendance(mode){

 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Submitting</center>");
var url="AjaxPages/ShowAttendance.jsp"
var arg="&student=";
 $("#right input[type=checkbox]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
          arg=arg+$("#"+n.id).val()+"-"+ ($("#"+n.id).is(':checked')?"A":"P") +'~';
        }
      }
    );

         arg="action="+mode+"&subjectid=none&date="+ encodeMyHtml($('#date').val())+"&topic="+$('#topic').val()+"&hour="+$('#hrs').val()+arg;
       // $('#status').html(arg);
       //alert(arg);
        $.ajax({
                type: "POST",
                url: url,
                data:arg,
                success: function(msg){
                       $('#status').html("Adding...");
                       $('#date').datepicker({dateFormat: 'dd/mm/yy'});
                      // $('#right').html(msg);
                      // setTimeout("attendance()",2000);
                       attendance();
                }
            });
}
function selectgroup(student_id){
$("#"+student_id+" input[type=checkbox]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
           if($("#"+n.id).is(':checked'))
                $("#"+n.id).attr('checked', false);
            else
                $("#"+n.id).attr('checked', true);
        }
      }
    );
}
function InvertSelect(){
    $("#right input[type=checkbox]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
           if($("#"+n.id).is(':checked'))
                $("#"+n.id).attr('checked', false);
            else
                $("#"+n.id).attr('checked', true);
        }
      }
    );
}