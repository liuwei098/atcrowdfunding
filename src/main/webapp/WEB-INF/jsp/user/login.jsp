<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html dir="ltr" lang="en-US">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<title>众筹网后台管理系统登录</title>
	
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
    <script src="script/back-to-top.js"></script>
    <script type="text/javascript" src="jquery/jquery.ias.js"></script>
     <script type="text/javascript" src="layer/layer.js"></script>
	</head>

	<body>
	
		<div id="container">
			<form >
				<div class="login">淘淘商城后台管理系统
				
				<span style="color:red;"></span>
				<span style="color:red"></span>
				</div>
				<div class="username-text" >用户名:</div>
				<div class="password-text">密码:</div>
				<div class="username-field">
					<input type="text" name="username"  id="loginacct" />
				</div>
				<div class="password-field">
					<input type="password" name="password" value="" id="password"/>
				</div>
				<input type="checkbox" name="remember-me" id="remember-me" /><label for="remember-me">记住用户名</label>
				<a  href="#" style="float:left; margin-top:33px;cursor:pointer;color:white">忘记密码</a>
	
				<div class="forgot-usr-pwd"></div>
				<input type="button" value="GO" style="font-size:25px ;color:white;" id='admin_login'/>
			</form>
			
		</div>
	<script type="text/javascript">
		$(function(){
			
			$("#admin_login").click(function(){
				var loginacct=$("#loginacct").val();
				var password=$("#password").val();
				$.post(
					"user_login",
					{"loginacct":loginacct,"password":password},
					function(data){
						if(data.code==0){
		     				layer.msg(data.message, {
		     		    	    time: -1, //20s后自动关闭
		     		    	    icon:5,
		     		    	   /*  shift:6, */
		     		    	    btn: ['知道了','明白了']
		     		    	 });
		     				return;
		     			}
		     			window.location.href="main";
					},
					"json"
				
				);
			});
		});
	</script>
		
	</body>
	
</html>
