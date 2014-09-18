$(document).ready(function() {
   $.ajax({
                    type: "POST",
                    url: './GPoll/vote.jsp?rand='+Math.random(),
                    success: function(msg){
                       // alert(msg)
                         $('#poll').html(msg)
                    } });
                                        
	var hash = window.location.hash.substr(1);
	var href = $('#nav li a').each(function(){
		var href = $(this).attr('href');
       // alert(toLoad);
		if(hash!=""){
			var toLoad = hash+' #content';
			$('#content').load(toLoad)
        }
												
	});

	$('#nav li a').click(function(){
								  
		var toLoad = $(this).attr('href')+' #content';
		$('#content').hide('fast',loadContent);
		$('#load').remove();
		$('body').append('<span id="load">LOADING...</span>');
		$('#load').fadeIn('normal');
		window.location.hash = $(this).attr('href');
		function loadContent() {
			$('#content').load(toLoad,'',showNewContent())
		}
		function showNewContent() {
			$('#content').show('normal',hideLoader());
		}
		function hideLoader() {
			$('#load').fadeOut('normal');
		}
		return false;
		
	});

});
 function animateload(url,type,val){
          var toLoad = url+"?rand="+Math.random()+'&'+type+'='+val+' #content';

		$('#content').hide('fast',loadContent);
              //alert(toLoad)
		$('#load').remove();
		$('body').append('<span id="load">LOADING...</span>');
		$('#load').fadeIn('normal');
		window.location.hash =toLoad.substring(0, toLoad.length-8)
               // alert(toLoad.substring(0, toLoad.length-8))
		function loadContent() {
			$('#content').load(toLoad,'',showNewContent())
		}
		function showNewContent() {
			$('#content').show('normal',hideLoader());
		}
		function hideLoader() {
			$('#load').fadeOut('normal');
		}
		return false;
            }
             function animatepage(url,type,id,page){
          var toLoad = url+"?rand="+Math.random()+'&'+type+'='+id+'&page='+page+' #content';
            //alert(toLoad)
		$('#content').hide('fast',loadContent);
              //alert(toLoad)
		$('#load').remove();
		$('body').append('<span id="load">LOADING...</span>');
		$('#load').fadeIn('normal');
		window.location.hash =toLoad.substring(0, toLoad.length-8)
             //   alert(toLoad)
		function loadContent() {
			$('#content').load(toLoad,'',showNewContent())
		}
		function showNewContent() {
			$('#content').show('normal',hideLoader());
		}
		function hideLoader() {
			$('#load').fadeOut('normal');
		}
		return false;
            }

 function votepoll(n){
     var val;
     j=1;
     //alert(document.getElementById(j).value);
        for(var i=1;i<=n;i++){
            if(document.getElementById(i).checked==true)
               val=i
          
           }
     var url="./GPoll/display.jsp?option="+val+"&id="+document.getElementById("id").value+"&rand="+Math.random();
//         alert(url)
		$.ajax({
                                            type: "POST",
                                            url: url,
                                            success: function(msg){
                                                 $('#poll').html(msg)
                                            } });

    }
     function encodeMyHtml(url) {
                encodedHtml = escape(url);
                encodedHtml = encodedHtml.replace(/\//g,"%2F");
                encodedHtml = encodedHtml.replace(/\?/g,"%3F");
                encodedHtml = encodedHtml.replace(/=/g,"%3D");
                encodedHtml = encodedHtml.replace(/&/g,"%26");
                encodedHtml = encodedHtml.replace(/@/g,"%40");
                encodedHtml = encodedHtml.replace(/</g,"&lt;");
                encodedHtml = encodedHtml.replace(/>/g,"&gt;");
                return encodedHtml;
            }


 function send(){

               var topic_owner= encodeMyHtml(document.getElementById('topic_owner').value)
               var topic_text=encodeMyHtml(document.getElementById('topic_text').value)
               var topic_title=encodeMyHtml(document.getElementById('topic_title').value)
               var major=document.getElementById('major').value
               url="do_addtopic.jsp?topic_text="+topic_text+"&topic_owner="+topic_owner+"&topic_title="+topic_title+"&major="+major
               //alert(url)

               //document.getElementById("content").innerHTML=url;
               $('#content').fadeOut()
		$('#load').remove();
		$('#wrapper').append('<span id="load">LOADING...</span>');
		$('#load').fadeIn('normal');
             //   alert("1");
               $.ajax({
                                            type: "POST",
                                            url: url,
                                            success: function(msg){

                                                 $('#content').html(msg)
                                                 $('#load').fadeOut('normal');
                                                 $('#content').fadeIn('normal');

                                            } });
            }

 function feedback(){

               var title= encodeMyHtml(document.getElementById('title').value)
               var desc=encodeMyHtml(document.getElementById('desc').value)
               url="feedback.jsp?title="+title+"&desc="+desc
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