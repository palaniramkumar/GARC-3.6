/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


 $(function(){
       $('#tabs').tabs();
       $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
       $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
       $('#status').hide();
  });