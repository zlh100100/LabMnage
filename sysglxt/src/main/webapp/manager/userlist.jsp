<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户列表</title> 
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
<body style="font-family:'黑体';font-size:16px">
    <div id="button_operatemenu" style="margin-top:50px;margin-left:340px">
        <button type="button" class="btn btn-default" aria-label="Left Align" onclick="toaddpage()">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                             增加用户
        </button>
        <button type="button" class="btn btn-default" aria-label="Left Align" onclick="deleteMenuBatch()">
            <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
                               删除用户
        </button>
        <!-- <button type="button" class="btn btn-default" aria-label="Left Align">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                             修改用户信息
        </button> -->
    </div>
    <div id="button_querymenu" style="margin-top:20px;margin-left:60px">                    
                     用户名:<input type="text" name="csy021" width="100px" id="csy021">
         <div style="margin-right:400px;float:right" >
            <label style="font-family:'黑体';font-size:16px">用户类型：</label>
            <select style="width:150px;height:30px" id="csy010">              
            </select>     
        </div>
        <button type="button" class="btn btn-default" aria-label="Left Align" style="float:right;margin-right:-350px" onclick="queryUserByCondition()">
            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                查询
        </button>  
        <button type="button" class="btn btn-default" aria-label="Left Align" style="float:right;margin-right:-500px" onclick="downloadUser()">
            <span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
                              导出当前页数据
        </button>
        <button type="button" class="btn btn-default" aria-label="Left Align" style="float:right;margin-right:-608px" >
            <a href="${pageContext.request.contextPath}/userManager/downloadAllUser">
                 <span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>
                                       导出全部
            </a>
        </button>        
    </div>
     <div id="list_querymenu" style="margin-top:30px;margin-left:5px">
        <table class="table table-hover" id="sy02" style="font-size:10px" >
            <tr style="width:800px;" id="menuhead">
                <td style="width:20px"><input id="allcheck" type="checkbox" onclick="setCheckbox()"/></td>
                <td >用户id</td>
                <td >用户账号</td>
                <td >用户类型</td>
                <td >操作</td>
            </tr>
        </table>
        <div class="tcdPageCode"></div>
     </div>
    
    
    <!-- Modal -->
    <div class="modal fade bs-example-modal-lg" id="changerUserModel" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">详细信息</h4>
          </div>
          <div class="modal-body" style="height:200px">
            <div id="button_querymenu" style="margin-top:30px;margin-left:60px">
                <div style="float:left;margin-right:30px">
                    <label style="font-family:'黑体';font-size:16px">用户类型：</label>
                    <select style="width:122px;height:30px" id="csy010_model" onchange="setdiv()">              
                    </select>     
                </div>                    
                 <lable>用户名:</lable><input type="text" name="csy021_model" width="100px" id="csy021_model" maxlength="21">
                 <lable>密码:</lable><input type="text" name="csy022_model" width="100px" id="csy022_model" maxlength="12"> 
                 <input type="text" name="csy02o_model" hidden="hidden" width="100px" id="csy020_model" maxlength="12"> 
                 <div style="margin-top:10px" id="sy04_message_model">
                      <div style="margin-left:100px">
                          <lable>学号:</lable><input type="text" name="csy040_model" width="80px" id="csy040_model" maxlength="20" >
                          <lable> 姓名:</lable><input type="text" name="csy041_model" width="80px" id="csy041_model" maxlength="20" >
                      </div>
                      <div style="margin-left:100px;margin-top:10px">
                          <lable> 学院:</lable><input type="text" name="csy042_model" width="80px" id="csy042_model" maxlength="30" onblur="validateCsy042(this)">
                          <lable>班级:</lable><input type="text" name="csy043_model" width="80px" id="csy043_model" maxlength="30" onblur="validateCsy043(this)">
                      </div>
                 </div>
                 <div style="float:left; margin-top:10px" hidden="hidden" id="sy03_message_model">
                      <lable>姓名:</lable><input type="text" name="csy031_model" width="80px" id="csy031_model" maxlength="20" >
                      <lable>职称:</lable><input type="text" name="csy032_model" width="80px" id="csy032_model" maxlength="30" >                   
                 </div> 
                 <div style="float:left; margin-top:10px" hidden="hidden"  id="sy05_message_model">        
                      <lable> 姓名:</lable><input type="text" name="csy051_model" width="80px" id="csy051_model" maxlength="20" >
                      <lable > 学院:</lable><input type="text" name="csy052_model" width="80px" id="csy052_model" maxlength="30" onblur="validateCsy042(this)">
                      <lable> 职称:</lable><input type="text" name="csy053_model" width="80px" id="csy053_model" maxlength="30">
                 </div>     
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-primary" id="btnSave_model" onclick="saveChangeUser()">保存</button>
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
    getAllUser(1,pageSize);
    getCsy010();
    $.ajax({
        type:'POST',
        url:"${pageContext.request.contextPath}/userManager/getUserCount",
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
	/*获取所有用户的信息 */
	function getAllUser(pageNum,pageSize){
        $("#menuhead").siblings().remove();
        $.ajax({
            type:'POST',
            url:"${pageContext.request.contextPath}/userManager/getAllUser?pageNum="+pageNum+"&pageSize="+pageSize,
            success:function(data){
                for(var i=0;i<data.list.length;i++){
                	$("#sy02").append("<tr style='width:800px;'>"
                            +"<td style='width:20px'><input input type='checkbox' id='"+data.list[i].CSY020+"'/></td>"
                            +"<td >"+data.list[i].CSY020+"</td>"
                            +"<td >"+data.list[i].CSY021+"</td>"
                            +"<td >"+data.list[i].csy011+"</td>"                             
                            +"<td style='width:300px'><button type='button' class='btn btn-primary btn-xs' onclick='deleteUser("+data.list[i].CSY020+")'>删除</button>"
                            +"&nbsp<button type='button' class='btn btn-primary btn-xs ' data-toggle='modal' data-target='#changerUserModel' onclick='changeUser("+data.list[i].CSY020+","+data.list[i].CSY010+",true)'>修改</button>"
                            +"&nbsp<button type='button' class='btn btn-primary btn-xs ' data-toggle='modal' data-target='#changerUserModel' onclick='changeUser("+data.list[i].CSY020+","+data.list[i].CSY010+",false)'>详情</button></td>"
                            +"</tr>");
                }
            }
        });
	}
	/*获取人员类型*/
	function getCsy010(){
		$("#csy010").empty();
		$.ajax({
            type:'POST',
            url:"${pageContext.request.contextPath}/menu/getCsy010",
            success:function(data){
                for(var i=0;i<data.length;i++){
                	$("#csy010").append("<option value ='"+data[i].csy010+"'>"+data[i].csy011+" </option>");
                	$("#csy010_model").append("<option value ='"+data[i].csy010+"'>"+data[i].csy011+" </option>");
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
	/*删除用户*/
	function deleteUser(userid){
		swal({  
            title:"",  
            text:"确认删除这个菜单功能吗？",  
            type:"warning",  
            showCancelButton:"true",  
            showConfirmButton:"true",  
            confirmButtonText:"确定",  
            cancelButtonText:"取消",  
            animation:"slide-from-top"  
       }, function() {
			$.ajax({
	            type:'POST',
	            url:"${pageContext.request.contextPath}/userManager/deleteUser?csy020="+userid,
	            success:function(data){
	            	if(data.statu==1){
                        $("#menuhead").siblings().remove();
                        init();
                        sweetAlert("删除成功");
                    }else{
                        sweetAlert("删除失败");
                    }
	            }
	        });
		});
	}
	/*批量删除人员信息*/
    function deleteMenuBatch(){
        var id_array=new Array();  
        $("[type='checkbox']:checked").each(function(){  
            id_array.push($(this).attr('id'));//向数组中添加元素  
        });
        if(id_array.length<=0){
        	sweetAlert("还没有选择数据");
        	return;
        }
        var idstr=id_array.join(',');//将数组元素连接起来以构建一个字符串  
        swal({  
            title:"",  
            text:"确认删除这个菜单功能吗？",  
            type:"warning",  
            showCancelButton:"true",  
            showConfirmButton:"true",  
            confirmButtonText:"确定",  
            cancelButtonText:"取消",  
            animation:"slide-from-top"  
       }, function() {
            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/userManager/deleteUserBatch?ids="+idstr,
                success:function(data){
                    if(data.statu==1){
                        $("#menuhead").siblings().remove();
                        init();
                        sweetAlert("删除成功");
                    }else{
                        sweetAlert("删除失败");
                    }
                }
            });
        });
    }
	/*按条件查询用户*/
	function queryUserByCondition(){
		$("#menuhead").siblings().remove();
		var csy010=$("#csy010").val();
        var csy021=$("#csy021").val();
        if(csy021==''){
        	csy021=null;
        }
        var sy02={
        		"csy010":csy010,
        		"csy021":csy021
        };
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/userManager/queryMenuByCondition",
            contentType:"application/json;charset=utf-8",
            data:JSON.stringify(sy02),
            dataType:"json",
            success:function(data){
            	for(var i=0;i<data.length;i++){
            		$("#sy02").append("<tr style='width:800px;'>"
                            +"<td style='width:20px'><input input type='checkbox' id='"+data[i].csy020+"'/></td>"
                            +"<td >"+data[i].csy020+"</td>"
                            +"<td >"+data[i].csy021+"</td>"
                            +"<td >"+data[i].csy010+"</td>"                             
                            +"<td style='width:300px'><button type='button' class='btn btn-primary btn-xs' onclick='deleteUser("+data[i].csy020+")'>删除</button>"
                            +"&nbsp<button type='button' class='btn btn-primary btn-xs ' data-toggle='modal' data-target='#changerUserModel' onclick='changeUser("+data[i].csy020+","+data[i].csy010+",true)'>修改</button>"
                            +"&nbsp<button type='button' class='btn btn-primary btn-xs ' data-toggle='modal' data-target='#changerUserModel' onclick='changeUser("+data[i].csy020+","+data[i].csy010+",false)'>详情</button></td>"
                            +"</tr>");
                }
            }
        });
    }
	/*下载用户列表*/
	function downloadUser(){
		//判断浏览器
		 if (!!window.ActiveXObject || "ActiveXObject" in window){
			var inTblId="sy02";
			var inWindow=null;
			try {   
	            var allStr = "";   
	            var curStr = "";   
	            if (inTblId != null && inTblId != "" && inTblId != "null") {   
	                curStr = getTblData(inTblId, inWindow);   
	            }   
	            if (curStr != null) {   
	                allStr += curStr;   
	            }else {   
	                sweetAlert("你要导出的表不存在！");   
	                return;   
	            }   
	            var fileName = getExcelFileName();   
	            doFileExport(fileName, allStr); 
	        }catch (e) {   
	            sweetAlert("导出发生异常:" + e.name + "->" + e.description + "!");   
	        }  
		}else{
			sweetAlert("请用ie浏览器进行下载");
			return;
		}
	}
	function getTblData(inTbl, inWindow) {   
        var rows = 0;   
        var tblDocument = document;   
        if (!!inWindow && inWindow != "") {   
            if (!document.all(inWindow)) {   
                return null;   
            }   
            else {   
                tblDocument = eval(inWindow).document;   
            }   
        }   
        var curTbl = tblDocument.getElementById(inTbl);   
        var outStr = "";   
        if (curTbl != null) {   
            for (var j = 0; j < curTbl.rows.length; j++) {   
                for (var i = 0; i < curTbl.rows[j].cells.length-1; i++) {   
                    if (i == 0 && rows > 0) {   
                        outStr += " \t";   
                        rows -= 1;   
                    }   
                    outStr += curTbl.rows[j].cells[i].innerText + "\t";   
                    if (curTbl.rows[j].cells[i].colSpan > 1) {   
                        for (var k = 0; k < curTbl.rows[j].cells[i].colSpan - 1; k++) {   
                            outStr += " \t";   
                        }   
                    }   
                    if (i == 0) {   
                        if (rows == 0 && curTbl.rows[j].cells[i].rowSpan > 1) {   
                            rows = curTbl.rows[j].cells[i].rowSpan - 1;   
                        }   
                    }   
                }   
                outStr += "\r\n";   
            }   
        }   
        else {   
            outStr = null;   
            sweetAlert(inTbl + "不存在!");   
        }   
        return outStr;   
    }
	/*获取名称*/
    function getExcelFileName() {   
        var d = new Date();   
        var curYear = d.getYear();   
        var curMonth = "" + (d.getMonth() + 1);   
        var curDate = "" + d.getDate();   
        var curHour = "" + d.getHours();   
        var curMinute = "" + d.getMinutes();   
        var curSecond = "" + d.getSeconds();   
        if (curMonth.length == 1) {   
            curMonth = "0" + curMonth;   
        }   
        if (curDate.length == 1) {   
            curDate = "0" + curDate;   
        }   
        if (curHour.length == 1) {   
            curHour = "0" + curHour;   
        }   
        if (curMinute.length == 1) {   
            curMinute = "0" + curMinute;   
        }   
        if (curSecond.length == 1) {   
            curSecond = "0" + curSecond;   
        }   
        var fileName = "用户信息" + "_" + (curYear+1990) + "年" + curMonth + "月" + curDate + "日" + "_"   
                       + curHour + "点" + curMinute + "分" + curSecond + "秒" + ".xls";   
        return fileName;   
    }   
    function doFileExport(inName, inStr) {   
        var xlsWin = null;   
        if (!!document.all("glbHideFrm")) {   
            xlsWin = glbHideFrm;   
        }   
        else {   
            var width = 6;   
            var height = 4;   
            var openPara = "left=" + (window.screen.width / 2 - width / 2)   
                           + ",top=" + (window.screen.height / 2 - height / 2)   
                           + ",scrollbars=no,width=" + width + ",height=" + height;   
            xlsWin = window.open("", "_blank", openPara);   
        }   
        xlsWin.document.write(inStr);   
        xlsWin.document.close();   
        xlsWin.document.execCommand('Saveas', true, inName);   
        xlsWin.close();   
    }  
	/*跳转到增加页面*/
	function toaddpage(){
	
		window.parent.$("#iframe1").attr("src", "${pageContext.request.contextPath}/manager/useroperate.jsp");  
		
	}
	function setHidden(csy010){
        if(csy010=="1"){
            $("#sy04_message").attr("hidden",false);
            $("#sy03_message").attr("hidden","hidden");
            $("#sy05_message").attr("hidden","hidden");
        } else if(csy010=="2"){
            $("#sy04_message").attr("hidden","hidden");
            $("#sy03_message").attr("hidden","hidden");
            $("#sy05_message").attr("hidden",false);
        }else if(csy010=="3"){
            $("#sy04_message").attr("hidden","hidden");
            $("#sy03_message").attr("hidden",false);
            $("#sy05_message").attr("hidden","hidden");
        }else{
            $("#sy04_message").attr("hidden","hidden");
            $("#sy03_message").attr("hidden","hidden");
            $("#sy05_message").attr("hidden","hidden");
        }
    }
	/*用户详细信息及修改信息*/
    function changeUser(csy020,csy010,ischange){
        $("#csy010_model").val(csy010);
        setHidden(csy010);
        $("#csy021_model").attr("readonly","readonly");
        if(ischange==false){
             $("#btnSave_model").attr("disabled","disabled");   
             $("#csy022_model").attr("readonly","readonly");
             $("#csy040_model").attr("readonly","readonly");
             $("#csy041_model").attr("readonly","readonly");
             $("#csy042_model").attr("readonly","readonly");
             $("#csy043_model").attr("readonly","readonly");
             $("#csy051_model").attr("readonly","readonly");
             $("#csy052_model").attr("readonly","readonly");
             $("#csy053_model").attr("readonly","readonly");
             $("#csy031_model").attr("readonly","readonly");
             $("#csy032_model").attr("readonly","readonly");
        }
        var sy02={
                "csy010":csy010,
                "csy020":csy020
        }
         $.ajax({
             type:"POST",
             url:"${pageContext.request.contextPath}/userManager/userDetail",
             contentType:"application/json;charset=utf-8",
             data:JSON.stringify(sy02),
             dataType: "json",
             success:function(data){
                 $("#csy020_model").val(data.CSY020);
                 $("#csy021_model").val(data.CSY021);
                 $("#csy022_model").val(data.CSY022);
                 if(csy010==1){
                	 console.log(data.CSY040);
                     $("#csy040_model").val(data.CSY040);
                     $("#csy041_model").val(data.CSY041);
                     $("#csy042_model").val(data.CSY042);
                     $("#csy043_model").val(data.CSY043);                                        
                 }else if(csy010==2){
                     $("#csy051_model").val(data.CSY051);
                     $("#csy052_model").val(data.CSY052);
                     $("#csy053_model").val(data.CSY053);
                 }else if(csy010==3){
                     $("#csy031_model").val(data.CSY031);
                     $("#csy032_model").val(data.CSY032);
                 }
                 
             }
      });
    } 
	
    /*保存修改后的用户信息*/
    function saveChangeUser(){
        var csy010=$("#csy010_model").val();
        var csy020=$("#csy020_model").val();
        var csy021=$("#csy021_model").val();
        var csy022=$("#csy022_model").val();
        var sy02={
                "csy010":csy010,
                "csy020":csy020,
                "csy021":csy021,
                "csy022":csy022
            };
        var csy040=$("#csy040_model").val();
        var csy041=$("#csy041_model").val();
        var csy042=$("#csy042_model").val();
        var csy043=$("#csy043_model").val();
        var sy04={
                "csy040":csy040,
                "csy041":csy041,
                "csy042":csy042,
                "csy043":csy043
        };
        var csy031=$("#csy031_model").val();
        var csy032=$("#csy032_model").val();
        var sy03={
                "csy031":csy031,
                "csy032":csy032
        };
        var csy051=$("#csy051_model").val();
        var csy052=$("#csy052_model").val();
        var csy053=$("#csy052_model").val();
        var sy05={
                "csy051":csy051,
                "csy052":csy052,
                "csy053":csy053,
        };
        var userMessage={
                "sy02":sy02,
                "sy03":sy03,
                "sy04":sy04,
                "sy05":sy05
        };
        //验证是否为空
        
        //提交保存信息
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/userManager/updateUser",
            contentType:"application/json;charset=utf-8",
            data:JSON.stringify(userMessage),
            dataType: "json",
            success:function(data){
                switch(data.statu){
                case "25":
                    sweetAlert("更新成功");
                    $("#menuhead").siblings().remove();
                    $("#btnSave_model").attr("disabled","disabled");
                    init(); 
                    break;
                case "24":
                case "34":
                case "44":
                case "54":
                case "ERROR":
                    sweetAlert("更新失败");
                    break;
                default:break;
                 
                }
            }
        });
    }
    /*验证填写学院是否正确*/
    function validateCsy042(data){
        if(data.value!=''){
             $.ajax({
                    type:"POST",
                    url:"${pageContext.request.contextPath}/userManager/validateCsy042?csy042="+data.value,
                    success:function(validata){
                        if(validata.statu=='error'){
                            sweetAlert('该学院名称有误');
                            $("#"+data.id).val('');
                        }
                    }
             });
        }
    }
    /*验证填写的班级是否正确*/
    function validateCsy043(data){
        if(data.value!=''){
            $.ajax({
                   type:"POST",
                   url:"${pageContext.request.contextPath}/userManager/validateCsy043?csy043="+data.value,
                   success:function(validata){
                       if(validata.statu=='error'){
                           sweetAlert('该班级名称有误');
                           $("#"+data.id).val('');
                       }
                   }
            });
       }
    }
    /*下载全部数据*/
/*     function downloadAllUser(){
    	 $.ajax({
             type:"POST",
             url:"${pageContext.request.contextPath}/userManager/downloadAllUser",
             success:function(validata){
            	 
             }
    	 });
    } */
</script>
</html>