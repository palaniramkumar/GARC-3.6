/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function clearmsg(){
    $('.status').hide();
    //$('#err').html("");
    clearTimeout(t);
}
$(document).ready(function() {
    home();
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
                        t=setTimeout("clearmsg()",3000);
                }
            });
    }
    function sendfeedback(){

               var title= encodeMyHtml(document.getElementById('title').value)
               var desc=encodeMyHtml(document.getElementById('desc').value)
               url="./AjaxPages/feedback.jsp?title="+title+"&desc="+desc
//alert(url)
               //document.getElementById("content").innerHTML=url;
               $('#content').fadeOut()
		$('#load').remove();
		$('body').append('<span id="load">LOADING...</span>');
		$('#load').fadeIn('normal');
             //   alert("1");
               $.ajax({
                                            type: "POST",
                                            url: url,
                                            success: function(msg){
                                                 //alert(msg)
                                                 $('#content').html(msg)
                                                 $('#load').fadeOut('normal');
                                                 $('#content').fadeIn('normal');

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
                        t=setTimeout("clearmsg()",3000);
              }
          });
    }