<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title> </title> 
        <!-- 引入JQuery -->
    <script type="text/javascript" src="<c:url value="resources/jquery-easyui-1.5.1/jquery.min.js"/>"></script>
       <!-- 引入EasyUI -->
    <script type="text/javascript" src="<c:url value="resources/jquery-easyui-1.5.1/jquery.easyui.min.js"/>"></script>
       <!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
    <script type="text/javascript" src="<c:url value="resources/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js"/>"></script>
       <!-- 引入EasyUI的样式文件-->
    <link rel="stylesheet" href="<c:url value="resources/jquery-easyui-1.5.1/themes/default/easyui.css"/>" type="text/css"/>
       <!-- 引入EasyUI的图标样式文件-->
    <link rel="stylesheet" type="text/css" href="<c:url value="resources/jquery-easyui-1.5.1/themes/icon.css"/>" />
    <link rel="stylesheet" href="<c:url value="resources/bootstrap-3.3.7/dist/css/bootstrap.min.css"/>" />
        <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script type="text/javascript" src="<c:url value="resources/bootstrap-3.3.7/dist/js/bootstrap.min.js"/>"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body style="font-family:'黑体'">
	<div  style="width:1366px;height:70px;background-color:#64B953;margin-top:-20px;padding:0;">
		<div style="top:20px;width:300px;">
			<h3 style="color:#5A69A0;margin-left:40px;">实验室资源管理系统</h3>
		</div>
		<div style="float:right;margin-right:150px;" >
			<label><span class="glyphicon glyphicon-user" aria-hidden="true" style="top:2px"></span>欢迎你:管理员 张三</label>
			<a href="#" style="margin-left:20px"><span class="glyphicon glyphicon-off" aria-hidden="true" style="top:2px"></span>退出</a>
		</div>
	</div>
	<div style="height:30px;width:1366px;" >
		<nav class="navbar navbar-inverse" style="background-color:#F5F5F5;">
			<ul class="nav nav-tabs" id="studentmenu" style="float:right; margin-right:200px;">
			  <li role="presentation" id="first_personalinfo" onclick="setActiveAndMenu(this)" class="active"><a href="#">个人信息</a></li>
			  <li role="presentation" id="first_student"  onclick="setActiveAndMenu(this)"><a href="#">学习资源</a></li>
			  <li role="presentation" id="first_course"  onclick="setActiveAndMenu(this)"><a href="#">课程安排</a></li>
			  <li role="presentation" id="first_gonggao"  onclick="setActiveAndMenu(this)"><a href="#">公告中心</a></li>
			  <li role="presentation" id="first_help"  onclick="setActiveAndMenu(this)"><a href="#">帮助中心</a></li>
			  <li role="presentation" id="first_zhuxiao" ><a href="#">注销</a></li>
			</ul>
		</nav>
	</div>
	<div class="easyui-layout" style="width:1366px;height:500px;">
		<div region="west" split="true" title="菜单列表" style="width:150px;font-size:15px">
			<ul class="nav nav-pills nav-stacked" id="second_menu" style="width:130px">
			  <!-- <li role="presentation" class="active" id="change" onclick="setActiveAndMenu(this)"><a href="#">修改密码</a></li> -->
			  <li role="presentation" onclick="setActiveAndMenu(this)" id="change1"><a href="#">个人信息查看</a></li>
			 <!--  <li role="presentation" onclick="menuoperate(this,'///C:/Users/付之亦/Desktop/毕业设计/页面/manager/menuoperate.html')" id="change2"><a href="#">菜单修改</a></li> -->
			</ul>
		</div>
		<div id="content" region="center"  style="padding:5px;">
			<iframe id="iframe1" name="iframe1" width="1190px" height="480px"></iframe>
		</div>
	</div>

</body>
<script type="text/javascript">
	$(function(){

	});
	/*设置active菜单*/
	function setActive(id){
		var lis=$("#"+id).siblings();
		for(var i=0;i<lis.length;i++){
			$("#"+lis[i].id).removeClass("active");
		}
		$("#"+id).addClass("active");
	}
	/*添加菜单*/
	function addmenu(data){
		var id=data.id;
		var position=id.indexOf("first_");
		if(position!=-1){
			if(position===0){
				var second_menu=$('#second_menu');
				second_menu.empty();
				var li1=$("<li role='presentation' id="+'change'+" onclick="+'menuoperate(this,'+"'///C:/Users/付之亦/Desktop/毕业设计/页面/teacher/media_upload.html'"+")>"+"<a href='#'>"+"修改密码"+"</a></li>");				
				second_menu.append(li1);
			}
		}
	}
	/*设置active的功能以及查询该功能下的子功能*/
	function setActiveAndMenu(data){
		var id=data.id;
		setActive(id);
		addmenu(data);
	}
	//打开页面
	function menuoperate(data,page){
		setActive(data.id);
		$("#iframe1").attr("src",page);		
	}
</script>
</html>