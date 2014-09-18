/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var semester;
var section;
var batch;


function GetSection(bat,sem){
url="./index.jsp"
//alert("hi")
$.ajax({
                type: "POST",
                url: url,
                data:"action=show&semester="+sem+"&batch="+bat,
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        $('#subSection').html(msg)
                        $("#Section").dynatree({
                          fx: { height: "toggle", duration: 200 },
                          autoCollapse: true,
                          onActivate: function(dtnode) {
                            $("#echoActive").text(dtnode.data.title);
                          },
                          onDeactivate: function(dtnode) {
                            $("#echoActive").text("-");
                          }
                        });
                        $("#Report").dynatree({
                          fx: { height: "toggle", duration: 200 },
                          autoCollapse: true,
                          onActivate: function(dtnode) {
                            $("#echoActive").text(dtnode.data.title);
                          },
                          onDeactivate: function(dtnode) {
                            $("#echoActive").text("-");
                          }
                        });
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}

function SemesterResult(sem,bat,sec){
url="./AjaxPages/SemesterResult.jsp";
$('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
//alert("hi")
semester=sem;
batch=bat;
section=sec;
$.ajax({
                type: "POST",
                url: url,
                data:"action=show&semester="+sem+"&batch="+bat+"&section="+sec,
                success: function(msg){
                        // alert(msg+"hi")
                        $('#studentList').show();
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#studentList').html(msg)
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}

function EditSemesterResult(id,sem,sec,bat){
url="./AjaxPages/SemesterResult.jsp";
$('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
//alert("hi")
$.ajax({
                type: "POST",
                url: url,
                data:"action=edit&semester="+sem+"&batch="+bat+"&section="+sec+"&student_id="+id,
                success: function(msg){
                        //alert(msg)
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#studentMark').show();
                        $('#studentList').hide();
                        $('#studentMark').html(msg)
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}

function AddSemesterResult(sem,bat,sec,id){
    $('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
//alert("hi")
url="./AjaxPages/SemesterResult.jsp"
var arg="&";
 $("#studentMark input[type=text]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
          arg=arg+n.id+"="+$("#"+n.id).val()+"&";
        }
      }
    );
$("#studentMark select").each(
        function(i,n) {
            if(n.id!="none"){
            arg=arg+n.id+"="+$("#"+n.id).val()+'&';
        }
      });
         arg="action=add&semester="+sem+"&batch="+bat+"&section="+sec+"&student_id="+id+arg;
        // $('#status').html("./AjaxPages/Result.jsp?"+arg);
        //alert(arg)
        //$('#status').html(arg);
        $.ajax({
                type: "POST",
                url: url,
                data:arg,
                success: function(msg){
                   // alert(msg)
                       //alert(('#examtype').val());
                       $('#status').html("<center>Updated</center>");
                       //$('#studentMark').html(msg)
                       SemesterResult(sem,bat,sec)
                }
            });
}


function SemesterClassReport(){
    $('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
url="./AjaxPages/SemesterResult.jsp"
//alert("action=showclassreport&semester="+semester+"&batch="+batch+"&section="+section)
$.ajax({
                type: "POST",
                url: url,
                data:"action=showclassreport&semester="+semester+"&batch="+batch+"&section="+section,
                success: function(msg){
                        //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#studentList').html(msg);
                        $('#studentMark').html("");
                        t=setTimeout("clearmsg()",3000);
                       }
 });
}


function SemesterSubjectReport(){
    $('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
url="./AjaxPages/SemesterResult.jsp"
//alert("hi")
$.ajax({
                type: "POST",
                url: url,
                data:"action=showsubjectreport&semester="+semester+"&batch="+batch+"&section="+section,
                success: function(msg){
                        //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#studentList').html(msg);
                        $('#studentMark').html("");
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}

function OverallReport(){
    $('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
url="./AjaxPages/SemesterResult.jsp"
//alert("hi")
$.ajax({
                type: "POST",
                url: url,
                data:"action=overallreport&semester="+semester+"&batch="+batch+"&section="+section,
                success: function(msg){
                        //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#studentList').html(msg);
                        $('#studentMark').html("");
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}