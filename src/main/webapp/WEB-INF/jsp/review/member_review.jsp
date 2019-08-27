<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/pageStyle.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>
	
    <%@ include file="../commons/header.jsp" %>

    <div class="container-fluid">
      <div class="row">
           <%@ include file="../commons/commons.jsp" %>
          
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			 
			  <div class="panel-body">
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th>公司简介</th>
                  <th>真实姓名</th>
                   <th>身份证号</th>
                   <th>联系电话</th>
                   <th>客服电话</th>
                   <th>电子邮箱</th>
                   <th>资质图片</th>
               
                </tr>
              </thead>
              <tbody>
              
                <tr>
                  <td>${member.id }</td>
                  <td>${member.introduce }</td>
              	  <td>${member.realname }</td>
              	  <td>${member.cardnum }</td>
              	  <td>${member.tel }</td>
              	  <td>${member.cutomtel }</td>
              	  <td>${member.email }</td>
              	    <td><a onclick="largerImg()" style="cursor: pointer;"><img src="${member.iconpath }" style="width:150px;height:100px"></a></td>
                
                </tr>
              </tbody>
            </table>
      	      
          <!--  	 审核失败填写原因模态窗口 -->
			<div class="modal fade" id="editModal" tabindex="-1"
				role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h3>实名审核失败原因</h3>
						</div>
						<div class="modal-body">
							<form id="editForm" method="post" class="form-horizontal">
								<textarea rows="10" cols="30"
									style="width: 500px; height: 200px;; opacity: 0.4;"
									placeholder="请填写审核不通过原因"></textarea>
								<br>
								<input type="button" value="提交" onclick="reject1()">
								<input type="button" value="取消" onclick="cancel('editModal')">
	
							</form>
						</div>
	
					</div>
				</div>
			</div>
			
			<!-- 图片放大模态窗口 -->
			<div class="modal fade" id="largerImage" tabindex="-1"
				role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h3>资质照片</h3>
						</div>
						<div class="modal-body">
							<img alt="" src="${member.iconpath }" style="width: 400px;height: 200px;">
						</div>
						<input type="button" value="确认" onclick="cancel('largerImage')">
					</div>
				</div>
			</div>
	
			<table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th>公司详细信息</th>
                </tr>
              </thead>
              <tbody>
              
                <tr>
                   <td>${member.id }</td>
                  <td style="height: 150px;">${member.describe1 }</td>
                	
                </tr>
              </tbody>
            </table>
				 
          </div>
				<button type="button" class="btn btn-success btn-xs"
					onclick="pass(this,${member.id})" value="${member.email }" >
					<i class="glyphicon glyphicon-eye-open"
						style="width: 70px; height: 20px; text-align: center;"> 审核通过</i>
				</button>
				<button type="button" class="btn btn-success btn-xs"
					onclick="fail(this,${member.id})" value="${member.email }" id="btn_fail"  mid="${member.id }">
					<i class="glyphicon glyphicon-eye-open"
						style="width: 70px; height: 20px; text-align: center;">
						审核失败</i>
				</button>

		</div>
			</div>
        </div>
      </div>
      
    </div>
	
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
	<script src="jquery/paging.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
	 <script>
    	//审核通过
    	function pass(obj,id){
    		var email=obj.value;
    	 	$.post(
    			"member_review_success",
    			{"id":id,"email":email},
    			function(data){
    				if(data.code==1){
    					 layer.msg(data.message, {
      			    	    time: -1, //20s后自动关闭
      			    	    icon:1,
      			    	   /*  shift:6, */
      			    	    btn: ['<a href="auth_cert">'+'确定</a>']
      			    	 });
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
    	
    	//审核失败出现填写原因模态窗口
    	function fail(obj,id){
    		$("#editModal").modal("show");
    		
    	}
    	
    	//查看资质照片大图
    	function largerImg(){
    		$("#largerImage").modal("show");
    	}
    	
    	//关闭模态窗口
    	function cancel(id){
    		$("#"+id).modal("hide");
    	}
    	
    	//点击提交拒绝信息按钮
    	function reject1(){
    		var email=$("#btn_fail").val();
    		var id=document.getElementById("btn_fail").getAttribute("mid");
    		
    		$("#editModal").modal("hide");
    	}
    	
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
      
  </body>
</html>
