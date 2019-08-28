<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/theme.css">
	<style>
#footer {
    padding: 15px 0;
    background: #fff;
    border-top: 1px solid #ddd;
    text-align: center;
}
	</style>
  </head>
  <body>
 <%@ include file="../commons/header.jsp" %>
    <div class="container theme-showcase" role="main">
      <div class="page-header">
        <h1>实名认证 - 申请</h1>
      </div>

		<ul class="nav nav-tabs" role="tablist">
		  <li role="presentation" ><a href="#"><span class="badge">1</span> 基本信息</a></li>
		  <li role="presentation" ><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
		  <li role="presentation" ><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
		  <li role="presentation" class="active"><a href="#"><span class="badge">4</span> 申请确认</a></li>
		</ul>
        
		<form role="form" style="margin-top:20px;">
		  <div class="form-group">
			<label for="exampleInputEmail1">验证码</label>
			<input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入你邮箱中接收到的验证码">
		  </div>
          <button type="button" onclick="sendAgain()" class="btn btn-primary" id="send">重新发送验证码</button>
		  <button type="button" onclick="checkEmailCode()"  class="btn btn-success">申请完成</button>
		</form>
		<hr>
    </div> <!-- /container -->
        <div class="container" style="margin-top:20px;">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div id="footer">
                        <div class="footerNav">
                             <a rel="nofollow" href="http://www.atguigu.com">关于我们</a> | <a rel="nofollow" href="http://www.atguigu.com">服务条款</a> | <a rel="nofollow" href="http://www.atguigu.com">免责声明</a> | <a rel="nofollow" href="http://www.atguigu.com">网站地图</a> | <a rel="nofollow" href="http://www.atguigu.com">联系我们</a>
                        </div>
                        <div class="copyRight">
                            Copyright ?2017-2017 atguigu.com 版权所有
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
	<script>
        $('#myTab a').click(function (e) {
          e.preventDefault()
          $(this).tab('show')
        });   
        
       
        function checkEmailCode(){
        	var code=$("#exampleInputEmail1").val();
        	$.post(
        		"apply_checkEmailCode",
        		{"code":code},
        		function(data){
        			if(data.code==1){
        				 layer.msg(data.message, {
     			    	    time: -1, //20s后自动关闭
     			    	    icon:1,
     			    	   /*  shift:6, */
     			    	    btn: ['<a href="member">'+'确定</a>']
     			    	 });
        				// window.location.href="member";
        			}else{
	       				 layer.msg(data.message, {
	  			    	    time: -1, //20s后自动关闭
	  			    	    icon:5,
	  			    	   /*  shift:6, */
	  			    	    btn: ['明白了', '知道了']
	  			    	 });
     				}
        		}
        	);
        }
        
        //再次发送验证码
        var countdown=0; 
       	var _generate_code = $("#send");
    	sendAgain();
        function sendAgain(){
       	  	var disabled = $("#send").attr("disabled");  
            if(disabled){ 
           		return false;
           	}
            $.ajaxSettings.async = false;
            $.post(
	    		"member_sendEmail",
	    		{"email":""},
	    		function(data){
	    			if(data.code>0 && data.code<60){
	    				countdown=data.code;
	    			}
	    		}
    		); 
    		 $.ajaxSettings.async = false;
    		settime();
        	
        }
        function settime() {  
            if (countdown == 0) {  
              _generate_code.attr("disabled",false);  
              _generate_code.html("重新发送验证码");  
              countdown = 60;  
              return false;  
            } else {  
              $("#send").attr("disabled", true);  
              $("#send").html("重新发送(" + countdown + ")");  
              countdown--;  
            }  
            setTimeout(function() {  
              settime();  
            },1000);  
          }  
	</script>
  </body>
</html>