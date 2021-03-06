<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
    <base href="<%=basePath%>">
<title>资源下载</title>

<%@include  file="/common/pt_head.jsp"%>
 <script src="${pageContext.request.contextPath}/resources/js/jquery.page.js"></script>
<style type="text/css">
body{
    padding:0 10px;
}
table{
    table-layout:fixed;
}
.text{
    word-break:keep-all;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}
.file-operate{
    width:100%;
    display: flex;
    height:50px;
    align-items: center;
    justify-content: space-between;
}

#upload{
    background-color: #286090;
/*     width:72px; */
    height:30px;
    border:none;
    color:#ffffff;
    letter-spacing: 3px;
}
/* #search{
    border:1px solid #ffffff;
    width:77px;
    height:28px;
} */
#search:focus{
    outline: none;
}
.search-div{
   /*  border: 1px solid rgba(119,119,119,0.6); */
    height:30px;
    width:100px;
    padding-left: 3px;
}
.number-div{
}
#icon:hover{
    cursor: pointer;

}
#icon{
    position: relative;
}
.operate{
    display: flex;
    width:500px;
    align-items: center;
    justify-content: space-around;

}
.download{
    background-color: transparent;
    border: none;
}
.download:focus{
    outline: none;
}
.checkbox{
    display:inline-block;
    height:15px;
    width:15px;
    vertical-align:middle;
    position: absolute;
    top:-2px;
}
.checkbox-div{
    display: inline-block;
    position:relative;
    margin-right:5px;
    margin-left:-5px;
    height:15px;
    width:15px;
}
.select-num{
    position: fixed;
    bottom: 0;
    left:0;
    width: 100%;
    height:40px;
    line-height: 40px;
    background-color:rgba(119,119,119,0.1);
    border-top:1px solid rgba(119,119,119,0.5) ;
    vertical-align:middle;
    padding:0 20px;
}
.select-file{
    float: left;
}
#cancel-all {
    float: right;

}
#select-all{
    float: right;
}
.select-style{
    width: 40px;
    height:25px;
    line-height:26px;
    text-align: center;
    margin-left:15px;
    margin-top: 7px;
    cursor: pointer;
}
#title{
    width:76px;
    text-align: center;
    border: 1px solid rgba(119,119,119,0.6);
    font-size: 12px;
    color:black;
    border-radius: 2px;
    background-color:rgb(229,229,240) ;
}
</style>
</head>

<body  style="font-family:'黑体';font-size:16px">
	<div class="file-operate">

		<div class="operate">
			<div class="search-div">
				<input type="text"
					id="search_text" placeholder="搜索">
			</div>
			<button type="button" class="btn btn-default" aria-label="Left Align" id="search" style="margin-left: 30px;height: 31px;;margin-top:-1px" onclick="searchResource()">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                         搜索
                </button> 
            <button id="upload" type="button" class="btn btn-default" aria-label="Left Align" style="margin-left: -40px;height: 31px;;margin-top:-1px;text-align:center;line-height:31px"> 
                 <span class="glyphicon glyphicon-upload" aria-hidden="true" style="line-hight:31px;text-align:center">上传</span>
            </button>
			<form id="fileupload" enctype="multipart/form-data">
				<input id="file" name="file" type="file" style="display: none; ">
			</form>
		</div>
	</div>
	<table class="table table-hover" style="font-family:'黑体';font-size:10px">
		<!-- <thead>
			
		</thead> -->
		<tbody id="t_body" >
			<tr >
                <th style="width:30%">文件</th>
                <th style="width:20%">更新时间</th>
                <th style="width:13%">大小</th>
                <th style="width:15%">上传者</th>
                <th style="width:9%">操作</th>
            </tr>
		</tbody>
	</table>
	<div class="select-num">
		<div class="select-file">
			已选择<span id="select-file-num">0</span>个文件
		</div>
		<div id="cancel-all" class="select-style">取消</div>
		<div id="select-all" class="select-style">全选</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
    $(".checkbox-div").hide();
    $(".select-num").hide();
    $("#title").hide();
    var flag=true;
    $("#icon").on("click",function(){
        $("#title").css("display","none");
        if(flag==true) {
            $(".checkbox-div").show();
            $(".select-num").show();
            flag=false;
        }
        else if(flag==false){
            $(".checkbox-div").hide();
            $(".select-num").hide();
            flag=true;
        }
    });
    $("#select-all").on("click",function(){
        $(".checkbox").attr("checked","checked");
    });
    $("#cancel-all").on("click",function(){
        $(".checkbox").attr("checked",false);
        $(".checkbox-div").hide();
        $(".select-num").hide();
        flag=true;
    });
    $("#icon").on("mouseover",function(){

        $("#title").css({"top":"26px","left":"7px","display":"block"});
    });
    $("#icon").on("mouseout",function(){
        $("#title").css("display","none");
    })

    $.ajax({
		type:'POST',
		url:"${pageContext.request.contextPath}/resourceDownload/resourceShow",
		success:function(data){
			var Data = data;
			console.log(Data);
			var resourcelist;
			var personList;
			var typeList;
			for(var key in Data) {
				console.log(key);
				console.log(Data[key])
				if("Sy13"==key){
					resourcelist = Data[key];
				}
				if("Sy02"==key){
					personList = Data[key];
				}
				if("Sy16"==key){
					typeList = Data[key];
				}
				
			}
			for(var i=0;i<resourcelist.length;i++){
				console.log(resourcelist[i].csy136);
				var name;
				var type;
				if(resourcelist[i].csy020==personList[i].csy020){
					name = personList[i].csy021;
				}
				if(resourcelist[i].csy160==typeList[i].csy160){
					type = typeList[i].csy161;
				}
				console.log(personList[0].csy021);
				var date = new Date(resourcelist[i].csy136);
				var dateTime = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
				$("#t_body").append("<tr><td class='text'><div class='checkbox-div'>"
						+"</div><a class='download' href='${pageContext.request.contextPath}/resourceDownload/resourceDown?filepath=" + resourcelist[i].csy134 + "'>"+resourcelist[i].csy134.substring(resourcelist[i].csy134.lastIndexOf("/")+1)+"</a></td>"
						+"<td>"+dateTime+"</td>"
						+"<td>"+resourcelist[i].csy138+"</td>"
						+"<td>"+name+"</td>"
						+"<td><a class='download' href='${pageContext.request.contextPath}/resourceDownload/resourceDown?filepath=" + resourcelist[i].csy134 + "'>"
						+"<span class='glyphicon glyphicon-save'></span>"
						+"</button></td>"
						+"</tr>");
				}
				
		}

		
	});
    /*初始化*/
    function init(){
    	$("#t_body tr :not(:first)").remove();
        $.ajax({
            type:'POST',
            url:"${pageContext.request.contextPath}/resourceDownload/resourceShow",
            success:function(data){
                var Data = data;
                console.log(Data);
                var resourcelist;
                var personList;
                var typeList;
                for(var key in Data) {
                    console.log(key);
                    console.log(Data[key])
                    if("Sy13"==key){
                        resourcelist = Data[key];
                    }
                    if("Sy02"==key){
                        personList = Data[key];
                    }
                    if("Sy16"==key){
                        typeList = Data[key];
                    }
                    
                }
                for(var i=0;i<resourcelist.length;i++){
                    console.log(resourcelist[i].csy136);
                    var name;
                    var type;
                    if(resourcelist[i].csy020==personList[i].csy020){
                        name = personList[i].csy021;
                    }
                    if(resourcelist[i].csy160==typeList[i].csy160){
                        type = typeList[i].csy161;
                    }
                    console.log(personList[0].csy021);
                    var date = new Date(resourcelist[i].csy136);
                    var dateTime = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
                    $("#t_body").append("<tr><td class='text'><div class='checkbox-div'>"
                            +"</div><a class='download' href='${pageContext.request.contextPath}/resourceDownload/resourceDown?filepath=" + resourcelist[i].csy134 + "'>"+resourcelist[i].csy131+"</a></td>"
                            +"<td>"+dateTime+"</td>"
                            +"<td>"+resourcelist[i].csy138+"</td>"
                            +"<td>"+name+"</td>"
                            +"<td><a class='download' href='${pageContext.request.contextPath}/resourceDownload/resourceDown?filepath=" + resourcelist[i].csy134 + "'>"
                            +"<span class='glyphicon glyphicon-save'></span>"
                            +"</button></td>"
                            +"</tr>");
                    }
                    
            }

            
        });
    }
    // 文件上传功能
    $("#upload").click(function() {
    	$("#file").click();
    });
    $("#file").change(function() {
    	var formElem = $("#fileupload");
    	var formData = new FormData(formElem[0]);
    	$.ajax({
    		type:'POST',
    		url:"${pageContext.request.contextPath}/resourceDownload/resourceUp",
    		data:formData,
    		contentType:false,
    		processData:false,
    		success:function(data){
    			init();
    			
    			sweetAlert(data);
    		}
    	});
    });
})
/**
 * 搜索功能
 */
function searchResource(){
  		var resourceName = $("#search_text").val();
  		alert(resourceName);
  		$.ajax({
  			type:'POST',
  			url:"${pageContext.request.contextPath}/resourceDownload/searchResource",
  			data: {'searchitems':resourceName.toString()}, 
  			success:function(data){
  				var Data = data;
  				var resourcelist;
  				var personList;
  				var typeList;
  				var error=null;
  				for(var key in Data) {
  					console.log(key);
  					console.log(Data[key])
  					if("Sy13"==key){
  						resourcelist = Data[key];
  					}
  					if("Sy02"==key){
  						personList = Data[key];
  					}
  					if("Sy16"==key){
  						typeList = Data[key];
  					}
  					if("error"==key){
  						error=Data[key];
  					}
  				}
  				if(error!=null){
  					sweetAlert(error[0]);
  				}else{
	  				$("#t_body").empty(); 
  					for(var i=0;i<resourcelist.length;i++){
  	  					var name;
  	  					var type;
  	  					if(resourcelist[i].csy020==personList[i].csy020){
  	  						name = personList[i].csy021;
  	  					}
  	  					if(resourcelist[i].csy160==typeList[i].csy160){
  	  						type = typeList[i].csy161;
  	  					}
  	  					console.log(personList[0].csy021);
  	  					var date = new Date(resourcelist[i].csy136);
  	  					var dateTime = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
  	  					$("#t_body").append("<tr><td class='text'><div class='checkbox-div'>"
  	  							+"</div><a class='download' href='${pageContext.request.contextPath}/resourceDownload/resourceDown?filepath=" + resourcelist[i].csy134 + "'>"+resourcelist[i].csy131+"</a></td>"
  	  							+"<td>"+dateTime+"</td>"
  	  							+"<td>"+resourcelist[i].csy138+"</td>"
  	  							+"<td>"+name+"</td>"
  	  							+"<td><a class='download' href='${pageContext.request.contextPath}/resourceDownload/resourceDown?filepath=" + resourcelist[i].csy134 + "'>"
  	  							+"<span class='glyphicon glyphicon-save'></span>"
  	  							+"</button></td>"
  	  							+"</tr>")
  	  					}
  					sweetAlert("搜索成功！");
  					
  				}
  			}
  		});
  	}


</script>
</html>
