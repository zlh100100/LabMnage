<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
     <title>实验室申请审核</title>
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
    <!-- echarts -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<body style="font-family:'黑体';width:950px;margin:0 auto">
    <div id="button_operatemenu" style="margin-top:50px;margin-left:340px">
        <button type="button" class="btn btn-default" aria-label="Left Align" data-toggle='modal' data-target='#labapply'>
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                            审核通过
        </button>
        <button type="button" class="btn btn-default" aria-label="Left Align" >
            <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
                           审核不通过
        </button>
    </div>
	<div id="applyexp" style="height:350px;margin-top:20px;margin-right:20px;">
	        <table class="table table-hover" id="applylist">
              <tr style="width:800px;" id="applyhead">
                <td style="width:20px"><input id="allcheck" type="checkbox" onclick="setCheckbox()"/></td>
                <td>实验室名称</td>
                <td>实验室位置</td>
                <td>实验室类别</td>
                <td>申请人</td>
                <td>申请时间</td>
                <td>申请目的</td>
                <td>备注</td>
                <td>操作</td>
            </tr>
	        </table>
	        <div class="tcdPageCode"></div>
    </div>
   
    
    
     <div class="modal fade bs-example-modal-lg" id="labapply" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">实验室申请信息</h4>
          </div>
          <div class="modal-body" style="height:350px;width:600px;margin-left:80px">
            <div style="margin-left:250px">
	           <p><label style="width:100px;text-align:right">实验室序号:</label><label>111111</label></p>
	           <p><label style="width:100px;text-align:right">实验室名称:</label><label>111111</label></p>
	           <p><label style="width:100px;text-align:right">实验室类型:</label><label>111111</label></p>
	           <p><label style="width:100px;text-align:right">实验室目的:</label><label>111111</label></p>
	           <p><label style="width:100px;text-align:right" >申请目的:</label><label>111111</label></p>
	           <p><label style="width:100px;text-align:right">实验室位置:</label ><select style="width:150px;height:27px"></select></p>
	           <p><label style="width:100px;text-align:right">实验室时间:</label><select style="width:150px;height:27px"></select></p>
	        </div>
	        <div id="button_operatemenu" style="margin-top:20px;margin-left:250px">
                <button type="button" class="btn btn-default" aria-label="Left Align" >
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                                             审核通过
                </button>
                <button type="button" class="btn btn-default" aria-label="Left Align" >
                    <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
                                             审核不通过
                </button>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-primary" id="btnSaveLab_model" >保存</button>
          </div>
        </div>
      </div>
    </div>
</body>
 <script type="text/javascript">
    $(function(){
    	init();	   	
    });
    function init(){
    	pageSize=10;
        queryLabApply(1,pageSize);
        $.ajax({
            type:'POST',
            url:"${pageContext.request.contextPath}/lab/queryLabApplyCount",
            success:function(data){
                $(".tcdPageCode").createPage({
                    pageCount:Math.ceil((data.count/pageSize)),
                    current:1,
                    backFn:function(pageNum){
                        queryLabApply(pageNum,pageSize);
                    }
                }); 
            }
        });        
    }
    function queryLabApply(pageNum,pageSize){
    	$.ajax({
            type:'post',
            url:'${pageContext.request.contextPath}/lab/queryLabApply?pageNum='+pageNum+'&pageSize='+pageSize,
            success:function(data){
                $("#applyhead").siblings().remove();
                for(var i=0;i<data.list.length;i++){
                    $("#applylist").append("<tr style='width:800px;' >"
                                                +"<td style='width:20px'><input type='checkbox' /></td>"
                                                +"<td>"+data.list[i].csy111+"</td>"
                                                +"<td>"+data.list[i].csy112+"</td>"
                                                +"<td>"+data.list[i].csy101+"</td>"
                                                +"<td>"+data.list[i].csy021+"</td>"
                                                +" <td>"+data.list[i].csy121+"</td>"
                                                +"<td>"+data.list[i].csy122+"</td>"
                                                +"<td>"+data.list[i].csy123+"</td>"
                                                +"<td><button type='button' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#labapply' onclick='shenhe("+data.list[i].csy120+")' >审核</button></td>"
                                                +" </tr>");
                }
            }
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
    /*审核*/
    function shenhe(data){
    	$.ajax({
            type:'post',
            url:'${pageContext.request.contextPath}/lab/shenhe?csy120='+data,
            success:function(resultdata){
    }
 </script>
</html>
