<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
     <title>公告管理</title>
    <%@include  file="/common/pt_head.jsp"%>
     <script src="${pageContext.request.contextPath}/resources/js/jquery.page.js"></script>
     <style>
       a{ text-decoration:none;}
       a:hover{ text-decoration:none;}
       .tcdPageCode{padding: 15px 20px;text-align: left;color: #ccc;text-align:center;}
       .tcdPageCode a{display: inline-block;color: #428bca;display: inline-block;height: 25px; line-height: 25px;  padding: 0 10px;border: 1px solid #ddd; margin: 0 2px;border-radius: 4px;vertical-align: middle;}
       .tcdPageCode a:hover{text-decoration: none;border: 1px solid #428bca;}
       .tcdPageCode span.current{display: inline-block;height: 25px;line-height: 25px;padding: 0 10px;margin: 0 2px;color: #fff;background-color: #428bca; border: 1px solid #428bca;border-radius: 4px;vertical-align: middle;}
       .tcdPageCode span.disabled{ display: inline-block;height: 25px;line-height: 25px;padding: 0 10px;margin: 0 2px; color: #bfbfbf;background: #f2f2f2;border: 1px solid #bfbfbf;border-radius: 4px;vertical-align: middle;}
    </style>
</head>
<body>
<body style="font-family:'黑体';width:950px;margin:0 auto">
    <div id="button_querymenu" style="margin-top:30px;margin-left:5px;width:950px">
        <div id="button_operatemenu" style="margin-top:50px;margin-left:400px">
	        <button type="button" class="btn btn-default" aria-label="Left Align" onclick="deleteBatch()" >
	            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
	                    批量删除
	        </button>
	        <button type='button' class='btn btn-default ' data-toggle='modal' data-target='#openPage'  >
                  <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                             添加公告
            </button>
        </div>
        <table class="table table-hover" id="sy14" style="font-size:10px;margin-top:20px" >
            <tr style="width:600px;" id="anouncementhead">
                <td style="width:20px"><input id="allcheck" type="checkbox" onclick="setCheckbox()"/></td>
                <td >公告名称</td>
                <td >发布时间</td>
                <td >截止时间</td>
                <td >操作</td>
            </tr>
        </table>
        <div class="tcdPageCode"></div>
    </div>

    
    
    <div class="modal fade bs-example-modal-lg" id="openPage" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">发布公告</h4>
          </div>
          <div class="modal-body" style="height:400px">
               <div>
                     <lable>公告名称:</lable><input type="text" name="csy141" width="100px" id="csy141" maxlength="30">
                     <lable>公告截止时间:</lable><input type="date" name="csy144" width="100px" id="csy144" >
               </div>
               <div style="margin-top:20px">
	                <!-- 加载编辑器的容器 -->
	                <script id="container" name="content" type="text/plain"></script>
	                <!-- 配置文件 -->
	                <script type="text/javascript"
	                    src="${pageContext.request.contextPath}/resources/UEditor/ueditor.config.js"></script>
	                <!-- 编辑器源码文件 -->
	                <script type="text/javascript"
	                    src="${pageContext.request.contextPath}/resources/UEditor/ueditor.all.js"></script>
	                <!-- 实例化编辑器 -->
	                <script type="text/javascript">
	                    ue = UE.getEditor('container');
	                </script>
              </div>
        </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
         <button type="button" class="btn btn-primary" id="btnSave_model" onclick="saveAnoucement()" >保存</button>
       </div>
      </div>
    </div>
  </div>
    
</body>
<script>
  $(function(){
	  init();
  })
  function init(){
	//查询所有公告
	     
	     pageSize=10;
	     query(1,pageSize);
	        $.ajax({
	            type:'POST',
	            url:"${pageContext.request.contextPath}/anouncement/getAnouncementCount",
	            success:function(data){
	                $(".tcdPageCode").createPage({
	                    pageCount:Math.ceil((data.count/pageSize)),
	                    current:1,
	                    backFn:function(pageNum){
	                        getAllUser(pageNum,pageSize);
	                    }
	                }); 
	            }
	        });
  }
  /*查询所有公告*/
  function query(pageNum,pageSize){
	  $.ajax({
          type:'POST',
          url:"${pageContext.request.contextPath}/anouncement/queryAllanouncement?pageNum="+pageNum+"&pageSize="+pageSize,
          success:function(data){
              $("#anouncementhead").siblings().remove();
              for(var i=0;i<data.list.length;i++){  
                  $("#sy14").append("<tr style='width:600px;'>"
                                      +"<td style='width:20px'><input  type='checkbox' id='"+data.list[i].csy140+"'/></td>"
                                      +"<td >"+data.list[i].csy141+"</td>"
                                      +"<td >"+(new Date(data.list[i].csy142).toLocaleDateString().replace(/\//g,"-").substr(0,8))+"</td>"
                                      +"<td >"+(new Date(data.list[i].csy144).toLocaleDateString().replace(/\//g,"-").substr(0,8))+"</td>"
                                      +"<td>&nbsp<button type='button' class='btn btn-primary btn-xs ' onclick='deleteanouncement("+data.list[i].csy140+")'>删除</button>"
                                      +"&nbsp<button type='button' class='btn btn-primary btn-xs ' data-toggle='modal' data-target='#openPage' onclick='detailanouncement("+data.list[i].csy140+")'>详情</button></td>"
                                      +"</tr>");
              }
          }
    });
  }
  /*新增公告*/
  function saveAnoucement(){
	  var csy141 = $("#csy141").val();
	  var csy144 = $("#csy144").val();
	  var csy143 = ue.getContent();
	  if(!(csy141&&csy144&&csy143)){
		  sweetAlert("请先完善信息");
		  return;
	  }
	  var sy14={
	      "csy141":csy141,
	      "csy144":csy144,
	      "csy143":csy143
	  };
	  $.ajax({
          type:'post',
          url:"${pageContext.request.contextPath}/anouncement/saveAnoucement",
          contentType:"application/json;charset=utf-8",
          data:JSON.stringify(sy14),
          dataType:"json",
          success:function(data){
        	  if(data.statu='success'){
        		  init();
        		  $('#openPage').modal('toggle');
                  sweetAlert("添加成功");
              }else{
                  sweetAlert("添加失败 ");
              }
          }
	  });
  }
  /*删除公告*/
  function deleteanouncement(csy140){
	  swal({  
          title:"",  
          text:"确定删除吗？",  
          type:"warning",  
          showCancelButton:"true",  
          showConfirmButton:"true",  
          confirmButtonText:"确定",  
          cancelButtonText:"取消",  
          animation:"slide-from-top"  
     }, function() {
    	 $.ajax({
             type:'POST',
             url:"${pageContext.request.contextPath}/anouncement/deleteanouncement?csy140="+csy140,
             success:function(data){
               if(data.statu='success'){
            	   init();
            	   sweetAlert("删除成功");
               }else{
            	   sweetAlert("删除失败 ");
               }
             }
    	 });
     });
  }
  /*详情*/
  function detailanouncement(csy140){
	  $("#btnSave_model").removeAttr("onclick");
	  $("#btnSave_model").attr("hidden",true);
	  $.ajax({
          type:"POST",
          url:"${pageContext.request.contextPath}/anouncement/detailanouncement?csy140="+csy140,
          success:function(data){
        	  $("#csy141").val(data.csy141);
              $("#csy144").val(new Date(data.csy144).toLocaleDateString().replace(/\//g,"-").substr(0,8));
              ue.setContent(data.csy142);
          }
	  });
  }
  /*批量删除*/
   function deleteBatch(){
	   var id_array=new Array();  
       $("[type='checkbox']:checked").each(function(){  
           id_array.push($(this).attr('id'));//向数组中添加元素  
       });
       if(id_array.length<=0){
           sweetAlert("还没有选择需要删除的信息");
           return;
       }
       swal({  
           title:"",  
           text:"确定删除吗？",  
           type:"warning",  
           showCancelButton:"true",  
           showConfirmButton:"true",  
           confirmButtonText:"确定",  
           cancelButtonText:"取消",  
           animation:"slide-from-top"  
      }, function() {
        var idstr=id_array.join(',');//将数组元素连接起来以构建一个字符串  
           $.ajax({
               type:"POST",
               url:"${pageContext.request.contextPath}/anouncement/deleteBatch?ids="+idstr,
               success:function(data){
                   if(data.statu=='success'){
                       $("#anouncementhead").siblings().remove();
                       init();
                       sweetAlert("删除成功");
                   }else{
                       sweetAlert("删除失败");
                   }
               }
           });
       });
  }
   /*设置全选及全不选*/
   function setCheckbox(){
       if($('#allcheck').is(':checked')){
           $("[type='checkbox']").attr("checked",true);
       }else{
           $("[type='checkbox']").attr("checked",false);
       }
   }
</script>
</html>