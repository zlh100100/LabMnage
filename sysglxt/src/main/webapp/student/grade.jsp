<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>成绩查看</title> 
        <!-- 引入JQuery -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-easyui-1.5.1/jquery.min.js"></script>
       <!-- 引入EasyUI -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
       <!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js"></script>
       <!-- 引入EasyUI的样式文件-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/jquery-easyui-1.5.1/themes/default/easyui.css" type="text/css"/>
       <!-- 引入EasyUI的图标样式文件-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jquery-easyui-1.5.1/themes/icon.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-3.3.7/dist/css/bootstrap.min.css" />
        <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap-3.3.7/dist/js/bootstrap.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/resources/sweetalert/sweetalert.min.js"></script>
    <!-- 弹窗css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/sweetalert/sweetalert.css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body  style="font-family:'黑体';font-size:16px">
   <h2 align="center">课程成绩</h2>
   <hr/>
   <div id="button_querymenu" style="margin-top:50px;margin-left:5px">
        <table class="table table-hover" id="syllabuslist" style="font-size:10px">
            <tr style="width:800px;" id="syllabushead">
                <td>课程名称</td>
                <td>教师</td>
                <td>课时</td>
                <td>学分</td>
                <td>班级</td>
                <td>成绩</td>
                <td>备注</td>
                <td>操作</td>
            </tr>
        </table>
  </div>
  
   <div class="modal fade bs-example-modal-lg" id="gradedetail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">实验成绩详情</h4>
          </div>
          <div class="modal-body" style="height:400px">
                <table class="table table-hover" id="explist" style="font-size:10px">
            <tr style="width:800px;" id="gradeexp">
                <td>课程名称</td>
                <td>实验名称</td>
                <td>实验完成情况</td>
                <td>实验完成时间</td>
            </tr>
        </table>
        </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
       </div>
      </div>
    </div>
  </div>
</body>
<script type="text/javascript">
  $(function(){
	  $.ajax({
		  type:'POST',
		  url:"${pageContext.request.contextPath}/student/queryGrade",
          success:function(data){
        	  for(var i=0;i<data.length;i++){
        		  $("#syllabushead").siblings().remove();
        		  $("#syllabuslist").append("<tr style='width:800px;'>"
                  +"<td>"+data[i].CSY061+"</td>"
                  +"<td>"+data[i].csy051+"</td>"
                  +"<td>"+data[i].CSY062+"</td>"
                  +"<td>"+data[i].CSY063+"</td>"
                  +"<td>"+data[i].CSY069+"</td>"
                  +"<td>"+data[i].csy071+"</td>"
                  +"<td>"+data[i].CSY068+"</td>"
                  +"<td ><button type='button' class='btn btn-primary btn-xs ' data-toggle='modal' data-target='#gradedetail'  onclick='queryGradeDetai("+data[i].CSY060+")'>"
                  +"<span class='glyphicon glyphicon-plus' aria-hidden='true'></span>"
                  +"详情"
                  +"</button></td>"
                  +"</tr>");
        	  }
          }
	  });
  });
  /**查看详情*/
  function queryGradeDetai(csy060){
	  $.ajax({
          type:'POST',
          url:"${pageContext.request.contextPath}/student/queryGradeDetai?csy060="+csy060,
          success:function(data){
        	  $("#gradeexp").siblings().remove();
              for(var i=0;i<data.length;i++){
            	  $("#explist").append("<tr style='width:800px;' id='gradeexp'>"
						                  +"<td>"+data[i].csy061+"</td>"
						                  +"<td>"+data[i].csy081+"</td>"
						                  +"<td>"+data[i].csy094+"</td>"
						                  +"<td>"+data[i].csy092+"</td>"
						                  +"</tr>");
              }
          }
	  });
  }
</script>
</html>