<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form" action="editUser" method="get">
				
				  <div class="form-group">
					<label for="exampleInputLoginacct">登陆账号</label>
					<input type="text" class="form-control" id="exampleInputLoginacct" name ="eloginacct" value="${param.loginacct }" readonly="readonly">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1" >用户名称</label>
					<input type="text" class="form-control" id="exampleInputusername" name="eusername" value="${param.username}">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input type="email" class="form-control" id="exampleInputEmail1" name="email" value="${param.email}">
					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
				  </div>
				  <button type="button" class="btn btn-success" onclick="updateUser1()" ><i class="glyphicon glyphicon-edit"  ></i> 修改</button>
				  <button type="button" class="btn btn-danger" onclick="reSetUser1()"><i class="glyphicon glyphicon-refresh"  ></i> 重置</button>
				  
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
           
        </script>
        
        
       <script type="text/javascript">
       
       
      
       		function reSetUser1(){
       			//alert("你点击了重置按钮");
       			window.location.href = ""; 
       		}
       		
       		function updateUser1(){
       			//alert("你点击了修改按钮");
       			var id = ${param.id};
       			
       			var username = exampleInputusername.value;
       			var email = exampleInputEmail1.value;
       			var param = {"id":id,"username":username,"email":email};
       			var url = "editUser";
       			var callback = function(result){
       				 
            		if( result.code ==200){
            			alert(result.message);
            			 window.location.href="user?pageNum=1"; 
            			
            		}else{
            			alert(result.message);
            		} 
            	}
            	$.post( url,param,callback);
	
       			
       		}
       </script>
        
        
  </body>
</html>


