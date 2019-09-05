<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
		  <li role="presentation" class="active"><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
		  <li role="presentation"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
		  <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
		</ul>
        
        
		<form:form  style="margin-top:20px;" action="pushIconpath" enctype="multipart/form-data" id="test_form">
		  <div class="form-group">
			<label for="exampleInputEmail1">手执相关证件照片</label>
			<input type="file" class="form-control" id="file" name="iconpath">
            <br>
            <img src="img/pic.jpg" id="image" style="width: 400px;height: 350px">
		  </div>
          <button type="button" onclick="window.location.href='member_apply-1'" class="btn btn-default">上一步</button>
		  <input type="button" onclick="submitForm()"  class="btn btn-success" value="下一步">
		</form:form>
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
        
        getImage();
	   	 //上一步时获取刚刚取得的图片
	   	 function getImage(){
	   		 $.post(
		    		"member_getimgae",
		    		{},
		    		function(data){
		    			if(data==null || data==""){
		    				document.getElementById('image').src = "img/pic.jpg"
		    			}else{
		    				document.getElementById('image').src = data+"";
		    			}
		    		}
		    	 );
	   	 }
        
       //判断是否选择图片，选择则上传，否则提示会员
       function submitForm(){
    	 var form = document.getElementById('test_form');
    	 var imgsrc=$("#image").attr("src");
    	 if(imgsrc!="img/pic.jpg" && imgsrc!=""){
    		 form.submit();
    	 }else{
	   		 layer.msg("请选择资质照片", {
		    	    time: -1, //20s后自动关闭
		    	    icon:5,
		    	   /*  shift:6, */
		    	    btn: ['知道了','明白了']
		   	  });
    	 }
    	
    	
    	
    	 
       }
        
        //图片回显js
        document.getElementById('file').onchange = function() {
		    var imgFile = this.files[0];
		    var fr = new FileReader();
		    fr.onload = function() {
		        document.getElementById('image').src = fr.result;
		    };
		    fr.readAsDataURL(imgFile);
		};
	</script>
   
 
  </body>
</html>