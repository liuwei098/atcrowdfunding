<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="GB18030">
  <head>
    <meta charset="GB18030">
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
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">新增</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form">
				  <div class="form-group">
					<label for="exampleInputPassword1">登陆账号</label>
					<input type="text" class="form-control" id="Uloginacct" placeholder="请输入登陆账号">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">用户名称</label>
					<input type="text" class="form-control" id="Uusername" placeholder="请输入用户名称">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">用户密码</label>
					<input type="text" class="form-control" id="Upassword" placeholder="请输入用户密码">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input type="email" class="form-control" id="Uemail" placeholder="请输入邮箱地址">
					<p class="help-block label label-warning" id="emialFormat"></p>
				  </div>
				  <button type="button" class="btn btn-success" onclick="addUserX()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
				  <button type="button" class="btn btn-danger" onclick="window.location.href=''"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
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
            
            
            function addUserX(){
            	var loginacct = Uloginacct.value;
            	 
            	var username = Uusername.value;
            	var email = Uemail.value;
            	var password = Upassword.value;
            	var re=/^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
            	if(loginacct==""  && loginacct.length==0){
        			 alert("登录账号不能为空")
        		}else if(username==""){
        			 alert("用户名称不能为空")
        		}else if(email=="" ){
            		   alert("邮箱不能为空")
            	} else if(!email.match(re)){
            		$("#emialFormat").text("请输入合法的邮箱地址, 格式为： xxxx@xxxx.com");
            		 
            	}else{
            		
            		var url = "addUserX"
                    	var param={"loginacct":loginacct,"username":username,"password":password,"email":email}
                    	var callback = function(result){
                    		if(result.code==200){
                    			alert(result.message);
                    			window.location.href="user?pageNum=1"; 
                    		}else if(result.code==0){
                    			alert(result.message);
                    			 
                    		}else{
                    			alert(reuslt.message);
                    		}
                    	}
                    	$.post(url,param,callback);
                    	 
            	}
            	
            	
            
            }
            
            
        </script>
  </body>
</html>
