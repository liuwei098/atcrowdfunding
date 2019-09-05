<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

    
    
    <%@ include file="../commons/header.jsp" %>
    
    
    <div class="container-fluid">
      <div class="row">
         
        
          <%@ include file="../commons/commons.jsp" %>
        
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="user">首页</a></li>
				  <li><a href="user">数据列表</a></li>
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline">
				  <div class="form-group">
				  
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select class="form-control unroles" multiple size="10" style="width:100px;overflow-y:auto;">
                       <c:forEach items="${norole }" var="no">
                        	<option value="${no.id }">${no.name }</option>
                        </c:forEach> 
                        
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                            <br>
                            <li class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select class="form-control rolesSelect" multiple size="10" style="width:100px;overflow-y:auto;">
                       
                       <c:forEach items="${roles }" var="yrole">
                       		
                        	<option value="${yrole.id }">${yrole.name }</option>
                        </c:forEach>
                        
                    </select>
				  </div>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
		</div>
	  </div>
	</div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            });
            
            //右移 添加角色 设置点击事件
            $(".glyphicon-chevron-right").click(function(){
            	//alert("你点击了 右移 添加角色 设置点击事件");
            	//1.选中的角色 移到右边去
            	var rids = "";
            	$(".unroles :selected").each(function(){
            		rids += $(this).val()+",";
            	});
            	$(".unroles :selected").appendTo(".rolesSelect");  
            	//发送请求 给用户添加选中的角色
            	var uid = "${param.uid}";
            	var url = "assignUserRole?opt=add";
            	var param = {"ids":rids,"uid":uid}
            	var callback = function(result){
					if(result.code==200){
          				alert(result.message); 
          				 window.location.href="assignRole?uid="+uid; 
          			}else{
          				alert(result.message);
          			}
            	};
            	$.post(url,param,callback);
            });
            
            //左移  移除角色 设置点击事件
            $(".glyphicon-chevron-left").click(function(){
            	//alert("你点击了 左移  移除角色 设置点击事件");
            	var uid = "${param.uid}";
            	//要移除的ids
            	var rids = "";
            	$(".rolesSelect :selected").each(function(){
            		rids += $(this).val()+",";
            	});
            	
            	//移除的效果
            	 $(".rolesSelect :selected").appendTo(".unroles");
            	
            	var param = {"ids":rids,"uid":uid};
            	var url = "assignUserRole?opt=remove";
            	//0、发送请求移除
            	var callback = function(result){
					if(result.code==200){
          				alert(result.message); 
          				 window.location.href="assignRole?uid="+uid; 
          			}else{
          				alert(result.message);
          			}
            	};
            	$.post(url,param,callback);
            	//$.get("/assignUserRole?opt=remove&uid="+uid+"&rids"+rids);
            });
            
           
            
        </script>
  </body>
</html>
