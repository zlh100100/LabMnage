<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录页面</title> 
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body style="font-family:'黑体';font-size:16px">
	<div id="button_operatemenu" style="margin-top:50px;margin-left:340px">
		<button type="button" class="btn btn-default" aria-label="Left Align">
  			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
  					增加功能
		</button>
		<button type="button" class="btn btn-default" aria-label="Left Align">
  			<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
  					删除功能
		</button>
		<button type="button" class="btn btn-default" aria-label="Left Align">
  			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
  					修改功能
		</button>
	</div>
	<div id="selectinput_type" style="margin-left:180px;margin-top:80px">
		<div >
			<!-- <label style="font-size:16px" >人员类型:</label>
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu_type" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="margin-top:-2px">
					    人员类型
				<span class="caret"></span>
			</button>				 
			<ul class="dropdown-menu" aria-labelledby="dropdownMenu_type" style="margin:0px;padding:0px">
				<li id="teacher"><a href="#">教师</a></li>
				<li ><a href="#">学生</a></li>
				<li ><a href="#">管理员</a></li>
				<li ><a href="#">科研人员</a></li>
			</ul> -->
			<label>人员类型：</label>
			<select style="width:150px;height:30px" title="人员类型">
			  <option value ="volvo">Volvo</option>
			  <option value ="saab">Saab</option>
			  <option value="opel">Opel</option>
			  <option value="audi">Audi</option>
            </select>
		</div>
		<div class="dropdown" style="float:right;top: -36px;right: 420px;">
			<label style="font-size:16px">一级菜单:</label>
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu_first" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="margin-top:-2px">
				    一级菜单
				<span class="caret"></span>
			</button>
			<ul class="dropdown-menu" aria-labelledby="dropdownMenu_first">
				<li><a href="#">个人信息</a></li>
				<li><a href="#">学习资源</a></li>
				<li><a href="#">课程安排</a></li>
				<li><a href="#">公告中心</a></li>
				<li><a href="#">帮助中心</a></li>
			</ul>
		</div>
		<div class="dropdown" style="float:right;top: -36px;right: 40px;">
			<label style="font-size:16px">二级菜单:</label>
			<button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu_second" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="margin-top:-2px">
				    二级菜单
			<span class="caret"></span>
			</button>
			<ul class="dropdown-menu" aria-labelledby="dropdownMenu_second">
				<li><a href="#">修改密码</a></li>
				<li><a href="#">个人信息</a></li>
				<li><a href="#">管理员</a></li>
				<li><a href="#">科研人员</a></li>
			</ul>
		</div>
	</div>
	<div id="input_value" style="margin-top:80px;margin-left:50px;padding:0">
		功能id:<input type="text" name="menu_id" width="100px" >
		功能名称:<input type="text" name="menu_name" width="100px">
		功能对应页面:<input type="text" name="menu_page" width="100px" style="float:right;margin-right:176px">
	</div>
	<div id="button_menu" style="margin-top:80px;margin-left:400px">
		<div class="btn-group" role="group">
    		<button type="button" class="btn btn-default" style="width:120px">
    			<span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
    			保存
    			</button>
  		</div>
  		<div class="btn-group" role="group">
    		<button type="button" class="btn btn-default" style="width:120px">
    			<span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span>
    			取消
    		</button>
  		</div>
	</div>
</body>

