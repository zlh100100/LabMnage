<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>异常日志信息</title> 
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
<body  style="font-family:'黑体';font-size:16px">
   <h2 align="center">异常日志信息</h2>
   <hr/>
   <div id="button_querymenu" style="margin-top:50px;margin-left:5px">
        <table class="table table-hover" id="exceptionrecordlist" style="font-size:10px">
            <tr style="width:800px;" id="exceptionrecordhead">
                <td>异常信息</td>
                <td>异常详情</td>
                <td>时间</td>
                <td>登陆id</td>
                <td>访问方法</td>
            </tr>
        </table>
        <div class="tcdPageCode"></div>
     </div>
</body>
<script type="text/javascript">
  $(function(){
	  init();
  });
  function init(){
	  pageSize=20;
      querySy18(1,pageSize);
       $.ajax({
           type:'POST',
           url:"${pageContext.request.contextPath}/log/querySy18Count",
           success:function(data){
               $(".tcdPageCode").createPage({
                   pageCount:Math.ceil((data.count/pageSize)),
                   current:1,
                   backFn:function(pageNum){
                       querySy18(pageNum,pageSize);
                   }
               }); 
           }
       });     
  }
  function querySy18(pageNum,pageSize){
	  $.ajax({
          type:'POST',
          url:"${pageContext.request.contextPath}/log/querySy18?pageNum="+pageNum+"&pageSize="+pageSize,
          success:function(data){
              $("#exceptionrecordhead").siblings().remove();
              for(var i=0;i<data.list.length;i++){                 
                  $("#exceptionrecordlist").append("<tr style='width:800px;'>"
                  +"<td>"+data.list[i].csy181+"</td>"
                  +"<td>"+data.list[i].csy182+"</td>"
                  +"<td>"+data.list[i].csy183+"</td>"
                  +"<td>"+data.list[i].csy184+"</td>"
                  +"<td>"+data.list[i].csy185+"</td>"
                  +"</tr>");
              }
          }
      });
  }
</script>
</html>