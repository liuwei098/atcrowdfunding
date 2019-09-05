<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="loginacct" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="password" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		 
		  <div>
	  		 <label>验证码</label>
              <input type="text" placeholder="请输入验证码..." name="code" id="code">
             <a href="javascript:change();"> <img src="getValidCode" id="pic" style="width:80px" height="40px"></a>
		  </div>
        <div class="checkbox">
         
          <br>
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="reg.html">我要注册</a>
          </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
      </form>
    </div>
     <div id="page" class="page_div"></div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script>
 		

    function dologin() {
     	var loginacct=$("#loginacct").val();
     	var password=$("#password").val();
     	var code=$("#code").val();
     	if(loginacct=="" || password==""){
     		layer.msg("请输入用户名和密码", {
	    	    time: -1, //20s后自动关闭
	    	    icon:5,
	    	   /*  shift:6, */
	    	    btn: ['知道了','明白了']
	    	 });
     		return;
     	}
     	if(code.length!=4){
     		layer.msg("请输入4位验证码", {
	    	    time: -1, //20s后自动关闭
	    	    icon:5,
	    	   /*  shift:6, */
	    	    btn: ['知道了','明白了']
	    	 });
     		return;
     	}
     	$.post(
     		"member_login",
     		{"loginacct":loginacct,"password":password,"code":code},
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
     			window.location.href="index";
     		}
     	);
    }
    
    function change() {
		document.getElementById("pic").src = "getValidCode?time=" + new Date().getTime();
	}
    </script>
    
   
  </body>
</html>