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
		  <li role="presentation" class="active"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
		  <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
		</ul>
        
		<form role="form" style="margin-top:20px;">
		  <div class="form-group">
<<<<<<< HEAD
<<<<<<< HEAD
			<label for="exampleInputEmail1">邮箱地址</label>
			<input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入用于接收验证码的邮箱地址">
		  </div>
          <button type="button" onclick="window.location.href='member_apply-2'" class="btn btn-default">上一步</button>
		  <button type="button" onclick="window.location.href='member_apply-4'"  class="btn btn-success">下一步</button>
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
                            Copyright ?2017-2017atguigu.com 版权所有
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
	<script>
        $('#myTab a').click(function (e) {
          e.preventDefault()
          $(this).tab('show')
        });        
=======
			<label for="exampleInputEmail1" >邮箱地址</label>
			<input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入用于接收验证码的邮箱地址">
		  </div>
          <button type="button" onclick="window.location.href='member_apply-2'" class="btn btn-default">上一步</button>
		  <button type="button" onclick="sendMail()"  class="btn btn-success">下一步</button>
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
                            Copyright ?2017-2017atguigu.com 版权所有
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
        
        //向实名邮箱发送验证码
        function sendMail(){
        	var email=$("#exampleInputEmail1").val();
        	var flag=/^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z]{2,5}$/.test(email);
        	if(flag==false){
				layer.msg('请输入正确的邮箱', {
		    	    time: -1, //永久不关闭
		    	    icon:0,
		    	   /*  shift:6, */
		    	    btn: [ '知道了']
	    	 	});
				return;
        	}
        	$.post(
        		"member_sendEmail",
        		{"email":email},
        		function(data){
        			if(data.code==500){
        				layer.msg('data.message', {
	  			    	    time: -1, //永久不关闭
	  			    	    icon:5,
	  			    	   /*  shift:6, */
	  			    	    btn: [ '知道了']
	  			    	 });
        				return;
        			}
        			window.location.href="member_apply-4"
        		}
        	);
        }
>>>>>>> branch 'master' of https://github.com/liuwei098/atcrowdfunding.git
=======
			<label for="exampleInputEmail1" >邮箱地址</label>
			<input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入用于接收验证码的邮箱地址">
		  </div>
          <button type="button" onclick="window.location.href='member_apply-2'" class="btn btn-default">上一步</button>
		  <button type="button" onclick="sendMail()"  class="btn btn-success">下一步</button>
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
                            Copyright ?2017-2017atguigu.com 版权所有
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
        
        //向实名邮箱发送验证码
        function sendMail(){
        	var email=$("#exampleInputEmail1").val();
        	var flag=/^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z]{2,5}$/.test(email);
        	if(flag==false){
				layer.msg('请输入正确的邮箱', {
		    	    time: -1, //永久不关闭
		    	    icon:0,
		    	   /*  shift:6, */
		    	    btn: [ '知道了']
	    	 	});
				return;
        	}
        	$.post(
        		"member_sendEmail",
        		{"email":email},
        		function(data){
        			if(data.code==500){
        				layer.msg('data.message', {
	  			    	    time: -1, //永久不关闭
	  			    	    icon:5,
	  			    	   /*  shift:6, */
	  			    	    btn: [ '知道了']
	  			    	 });
        				return;
        			}
        			window.location.href="member_apply-4"
        		}
        	);
        }
>>>>>>> branch 'master' of https://github.com/liuwei098/atcrowdfunding.git
	</script>
  </body>
</html>