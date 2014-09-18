/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function clearmsg(){
    $('.status').hide();
    //$('#err').html("");
    clearTimeout(t);
}

$(document).ready( function() {
$("#login").hide();
 $('.status').hide();
  home();
$.getScript("../common/servertime.jsp", function(){

});
 });
function home(){
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
    $.ajax({
                type: "POST",
                url: "./AjaxPages/home.jsp",
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#top_div').html(msg);
                        $("#report").hide();
                        t=setTimeout("clearmsg()",3000);
                        }
    });
    }
function forum(){
        $('#status').show();
        $('#status').html("<center><img src='../images/loading.gif'/>Editing Assesment</center>");
        url="AjaxPages/forum.jsp"
        $.ajax({
                type: "POST",
                url: url,
                success: function(msg){
                       $('#status').html("<center>Loaded Successful</center>");
                        $('#top_div').html(msg);
                        t=setTimeout("clearmsg()",3000);
                }
            });
    }
    function post(){
        $('#status').show();
        $('#status').html("<center><img src='../images/loading.gif'/>Editing Assesment</center>");
        url="AjaxPages/post.jsp"
        $.ajax({
                type: "POST",
                url: url,
                success: function(msg){
                       $('#status').html("<center>Loaded Successful</center>");
                        $('#top_div').html(msg);
                        t=setTimeout("clearmsg()",3000);
                }
            });
    }
     function feedback(){
        $('#status').show();
        $('#status').html("<center><img src='../images/loading.gif'/>Editing Assesment</center>");
        url="AjaxPages/feedback.jsp"
        $.ajax({
                type: "POST",
                url: url,
                success: function(msg){
                       $('#status').html("<center>Loaded Successful</center>");
                        $('#top_div').html(msg);
                        new nicEditor().panelInstance('desc');
                        t=setTimeout("clearmsg()",3000);
                }
            });
    }
    function sendfeedback(){
        $('#status').show();
        $('#status').html("<center><img src='../images/loading.gif'/>Sending Feedback</center>");
       var title= encodeMyHtml(document.getElementById('title').value)
       var desc=nicEditors.findEditor('desc').getContent()
       url="./AjaxPages/feedback.jsp?title="+title+"&desc="+desc;
       $.ajax({
            type: "POST",
            url: url,
            success: function(msg){
                 //alert(msg)
                 $('#content').html(msg)
                  nicEditors.findEditor('desc').setContent("");
                  document.getElementById('title').value="";
                  $('#status').html("Feedback Sent");
                  t=setTimeout("clearmsg()",3000);
            } });
    }
 function animateload(url,type,val){
  var toLoad = "./AjaxPages/"+url+"?rand="+Math.random()+'&'+type+'='+val;
  $('#status').show();
  $('#status').html("<center><img src='../images/loading.gif'/>Editing Assesment</center>");
  //window.location.hash =toLoad.substring(0, toLoad.length-8)
   // alert(toLoad.substring(0, toLoad.length-8))
  
  $.ajax({
            type: "POST",
            url: toLoad,
            success: function(msg){
                   $('#status').html("<center>Loaded Successful</center>");
                    $('#top_div').html(msg);
                    //nicEditors.findEditor('topic_text').setContent(msg);
                    t=setTimeout("clearmsg()",3000);
          }
      });
  }
   function animatepage(url,type,id,page){
      var toLoad = "./AjaxPages/"+url+"?rand="+Math.random()+'&'+type+'='+id+'&page='+page;
      $('#status').show();
      $('#status').html("<center><img src='../images/loading.gif'/>Editing Assesment</center>");
      //window.location.hash =toLoad.substring(0, toLoad.length-8)
       // alert(toLoad.substring(0, toLoad.length-8))
       //alert(toLoad);
      $.ajax({
                type: "POST",
                url: toLoad,
                success: function(msg){
                       $('#status').html("<center>Loaded Successful</center>");                       
                        $('#top_div').html(msg);
                        if(url=="AddTopic.jsp")
                            new nicEditor().panelInstance('topic_text');
                        if(url=="ReplyToPost.jsp")
                            new nicEditor().panelInstance('post_text');
                         document.getElementById('form1').onsubmit=function() {
                            document.getElementById('form1').target = 'inline'; //'upload_target' is the name of the iframe
                          }
                        t=setTimeout("clearmsg()",3000);
              }
          });
    }