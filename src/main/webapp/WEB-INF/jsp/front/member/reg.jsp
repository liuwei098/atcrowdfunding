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
	<link rel="stylesheet" href="css/style1.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form class="form-signin" role="form" id="register">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" onkeyup="checkInfo(this)" class="form-control" name="loginacct" id="loginacct" placeholder="请输入登录账号,3-8个字符" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
			<span id="loginacctInfo">&nbsp;</span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input name="userpswd" onkeyup="checkInfo(this)" type="password" class="form-control" id="password" placeholder="请输入登录密码，6-16个字符" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
			<span id="passwordInfo">&nbsp;</span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input name="email" onkeyup="checkInfo(this)" type="text" class="form-control" id="email" placeholder="请输入邮箱地址" style="margin-top:10px;">
			<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
			<span id="mailInfo">&nbsp;</span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select class="form-control" name="usertype" id="usertype">
                <option value="1">企业</option>
                <option value="0">个人</option>
            </select>
		  </div>
		    <div>
	  		 <label>验证码</label>
              <input type="text" placeholder="请输入验证码..." name="code" id="code">
             <a href="javascript:change();"> <img src="getValidCode" id="pic" style="width:80px" height="40px"></a>
		  </div>
		   <div id="slideBar"></div>
        <div class="checkbox">
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="member_tologin">我有账号</a>
          </label>
        </div>
     
      </form>
    </div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
     <script type="text/javascript" src="layer/layer.js"></script>
     <script type="text/javascript" src="jquery/style.js"></script>
    <script type="text/javascript">
    var dataList = ["0","1"];
    var options = {
        dataList: dataList,
        success:function(){  
           nextApply();
        },
        fail: function(){
             
        }
    };
    SliderBar("slideBar", options);
    
	    function change() {
			document.getElementById("pic").src = "getValidCode?time=" + new Date().getTime();
		}
	  //检验用户名和邮箱是否重复
        function filterRepeat(name,value){
        	$.post(
        		"member_check_repeat1",
        		{"name":name,"value":value},
        		function(data){
        			console.log(data);
       				if(name=="loginacct"){
       					if(data.code==1){
       						$("#loginacctInfo").html(data.message);
       						$("#loginacctInfo").css("color",'red');
       					}else{
       						$("#loginacctInfo").html("");
       					}
       				}
       				if(name=="email"){
       					if(data.code==1){
           					$("#mailInfo").html(data.message);
           					$("#mailInfo").css("color",'red');
           				}else{
           					$("#mailInfo").html("");
           				}
       				}
        			
        		}
        	);
        	
        	
        }
        
        //检验信息格式
        function checkInfo(obj){
        	var value=obj.value;
        	var name=obj.id;
   			if(name=="loginacct"){
	        	if(value.length<3 || value.length>8){
	        		$("#loginacctInfo").html("请输入3-8个字符");
	        		$("#loginacctInfo").css("color",'red');
	        		
	        	}else{
	        		filterRepeat(name,value);
	        		
	        	}
   			}else if(name=="email"){
   				if(!/^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z]{2,5}$/.test(value)){
	        		$("#mailInfo").html("邮箱格式不对");
	        		$("#mailInfo").css("color",'red');
	        		
	        	}else{
	        		filterRepeat(name,value);
	        		$("#mailInfo").html("");
	        	}
   			}else if(name=="password"){
   				if(value.length<6 || value.length>16){
	        		$("#passwordInfo").html("请输入6-16个字符");
	        		$("#passwordInfo").css("color",'red');
	        		
	        	}else{
	        		$("#passwordInfo").html("");
	        		
	        	}
   			}
        }
        
       //检验信息并注册
        function nextApply(){	
        	var loginacct=$('#loginacct').val();
        	var password=$('#password').val();
        	var email=$('#email').val();
        	var usertype=$('#usertype').val();
      		var code=$("#code").val();
      		var loginacctInfo=$("#loginacctInfo").html();
      		var passwordInfo=$("#passwordInfo").html();
      		var mailInfo=$("#mailInfo").html();
        	if(loginacctInfo.length!=0 || mailInfo.length!=0 || passwordInfo.length!=0){
        			layer.msg("信息有误，请核对信息", {
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
        	var member=$("#register").serialize();
        	console.log("999999"+member);
        	$.post(
        		"member_reg",
        	 	{"loginacct":loginacct,"email":email, "password":password,"code":code,"usertype":usertype},
        		
        		function(data){
        			if(data.code==0){
	        			layer.msg(data.message, {
	    		    	    time: -1, //20s后自动关闭
	    		    	    icon:5,
	    		    	   /*  shift:6, */
	    		    	    btn: ['知道了','明白了']
	    		    	 });
        			}
        			if(data.code==1){
        				layer.msg(data.message, {
	    		    	    time: -1, //20s后自动关闭
	    		    	    icon:5,
	    		    	   /*  shift:6, */
	    		    	    btn: ['<a href="member_tologin">知道了</a>','']
	    		    	 });
        			}
        		}
        	);
        }
    </script>
  </body>
</html>