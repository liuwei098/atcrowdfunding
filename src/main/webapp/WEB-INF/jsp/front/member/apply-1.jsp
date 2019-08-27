<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
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
		  <li role="presentation" class="active"><a href="#"><span class="badge">1</span> 基本信息</a></li>
		  <li role="presentation"><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
		  <li role="presentation"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
		  <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
		</ul>
        
		<form role="form" style="margin-top:20px;" id="formInfo">
		  <div class="form-group">
			<label for="exampleInputEmail1">真实名称</label>
			<input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入真实名称" name="realname"/>
		  </div>
		  <div class="form-group">
			<label for="exampleInputPassword1">身份证号码</label>
			<input type="text" class="form-control" id="exampleInputPassword1" placeholder="请输入身份证号码" name="cardnum">
		  </div>
		  <div class="form-group">
			<label for="exampleInputPassword1">联系号码</label>
			<input type="text" class="form-control" id="exampleInputPassword1" placeholder="该电话不会在项目界面展示" name="tel">
		  </div>
		  <div class="form-group">
			<label for="exampleInputPassword1">客服电话</label>
			<input type="text" class="form-control" id="exampleInputPassword1" placeholder="该电话会在项目界面展示" name="customtel">
		  </div>
		   <div class="form-group">
			<label for="exampleInputPassword1" ">公司简介</label><br>
			<textarea rows="5" cols="70" name="introdce" placeholder="让我们更好了解你 不超过200个字"></textarea>
		  </div>
		  
          <button type="button" onclick="window.location.href='member_accttype'" class="btn btn-default">上一步</button>
		  <button type="button" onclick="nextApply()"  class="btn btn-success">下一步</button>
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
	<script>
        $('#myTab a').click(function (e) {
          e.preventDefault()
          $(this).tab('show')
        });   
        
      
        //获取实名验证类型
        function getType(){
        	var url=window.location.href;
        	var type=url.split("?")[1].split("=")[1];
        	return type;
        }
        
        function nextApply(){
        	var data = $("#formInfo").serialize();   
        	console.log(data);
=======
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
		  <li role="presentation" class="active"><a href="#"><span class="badge">1</span> 基本信息</a></li>
		  <li role="presentation"><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
		  <li role="presentation"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
		  <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
		</ul>
        
		<form:form  style="margin-top:20px;" id="formInfo" action="pushMemberInfo">
		  <div class="form-group">
			<label for="exampleInputEmail1">真实名称</label>
			<input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入真实名称" name="realname"/>
		  </div>
		  <div class="form-group">
			<label for="exampleInputPassword1">身份证号码</label>
			<input onkeyup="checkInfo(cardnum,this)" type="text" class="form-control" id="exampleInputPassword1" placeholder="请输入身份证号码" name="cardnum">
			<span id="cardnumInfo" style="width: 50px;height: 40px;"></span>
		  </div>
		  <div class="form-group">
			<label for="exampleInputPassword2">联系号码</label>
			<input type="text" class="form-control" id="exampleInputPassword2" placeholder="该电话不会在项目界面展示" name="tel">
		  </div>
		  <div class="form-group">
			<label for="exampleInputPassword3">客服电话</label>
			<input type="text" class="form-control" id="exampleInputPassword3" placeholder="该电话会在项目界面展示" name="cutomtel">
		  </div>
		   <div class="form-group">
			<label for="exampleInputPassword4" ">公司简介</label><br>
			<textarea  rows="5" cols="50" name="introduce" placeholder="公司简介不超过50个字" id="exampleInputPassword4"></textarea>
		  </div>
		  
		  <div class="form-group">
			<label for="exampleInputPassword5" ">公司详情</label><br>
			<textarea rows="5" cols="100" name="describe" placeholder="让我们更好了解你 不超过200个字" id="exampleInputPassword5"></textarea>
		  </div>
		  
          <button type="button" onclick="window.location.href='member_accttype'" class="btn btn-default">上一步</button>
		  <button type="button" onclick="nextApply()"  class="btn btn-success">下一步</button>
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
	<script>
        $('#myTab a').click(function (e) {
          e.preventDefault()
          $(this).tab('show')
        });   
        
      
        //获取实名验证类型
        function getType(){
        	var url=window.location.href;
        	var type=url.split("?")[1].split("=")[1];
        	return type;
        }
        
        function checkInfo(name,obj,msg){
        	console.log(obj.value);
        	var cardnum=obj.value;
        	if(!/^[0-9A-Z]{18}$/.test(cardnum)){
        		$("#cardnumInfo").html("身份证格式不对");
        		$("#cardnumInfo").css("color",'red');
        		
        	}else{
        		$("#cardnumInfo").html("");
        	}
        }
        
        
        function nextApply(){
        	var realname=$('input[name=realname]').val();
        	var tel=$('input[name=tel]').val();
        	var cutomtel=$('input[name=cutomtel]').val();
        	var describe=$('#exampleInputPassword5').val();
        	var introduce=$('#exampleInputPassword4').val();
        	var cardnum=$('input[name=cardnum]').val();
        	console.log(introduce);
        	var accttype=getType();
        	$.post(
        		"pushMemberInfo",
        		{"realname":realname,"tel":tel, "cutomtel":cutomtel,"describe":describe,"introduce":introduce,"cardnum":cardnum,"accttype":accttype},
        		function(data){
        			//window.location.href="member_apply-2";
        		}
        	);
>>>>>>> branch 'master' of https://github.com/liuwei098/atcrowdfunding.git
        }
	</script>
  </body>
</html>