/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * ramkumar sept 24 2009 @3 52.13 pm
 */

function clearmsg(){
  $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').hide();
 clearTimeout(t);
}
function QuestionBankView2(){
url="AjaxPages/QuestionBankDownload.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#content_wrapper').show();
                        $('#content_wrapper').html(msg)
                        $('#tabs').tabs();
                        $('#report').hide();
                        t=setTimeout("clearmsg()",3000);
                   }
 });
}