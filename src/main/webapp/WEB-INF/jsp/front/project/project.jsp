<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<link rel="stylesheet" href="css/theme.css">
	<style>
#footer {
    padding: 15px 0;
    background: #fff;
    border-top: 1px solid #ddd;
    text-align: center;
}
#topcontrol {
  color: #fff;
  z-index: 99;
  width: 30px;
  height: 30px;
  font-size: 20px;
  background: #222;
  position: relative;
  right: 14px !important;
  bottom: 11px !important;
  border-radius: 3px !important;
}

#topcontrol:after {
  /*top: -2px;*/
  left: 8.5px;
  content: "\f106";
  position: absolute;
  text-align: center;
  font-family: FontAwesome;
}

#topcontrol:hover {
    color: #fff;
    background: #18ba9b;
    -webkit-transition: all 0.3s ease-in-out;
    -moz-transition: all 0.3s ease-in-out;
    -o-transition: all 0.3s ease-in-out;
    transition: all 0.3s ease-in-out;
}
.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
    border-bottom-color: #ddd;
}
.nav-tabs>li>a {
    border-radius: 0;
}
	</style>
  </head>
  <body>
 	<%@ include file="../commons/header.jsp" %>
    <div class="container theme-showcase" role="main">

       	<%@ include file="../commons/nav.jsp" %>
    
    
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="jumbotron nofollow" style="    padding-top: 10px;">
                        <h3>
                      ${project.name }
                        </h3>
                        <div style="float:left;width:70%;">
                         ${project.remark }
                        </div>
                        <div style="float:right;">
                            <button type="button" class="btn btn-default" onclick="follow(${project.id},this)" id="follow_btn">
                            <i style='color:${isFollow==1? "grey" : "#f60"}' class="glyphicon glyphicon-heart" id="heart"></i> 关注 ${project.follower }</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="row clearfix">
                        <div class="col-md-8 column">
                            <img alt="140x140" width="740" src="img/product_detail_head.jpg" />
                           ${project.details }
                           
                        </div>
                        <div class="col-md-4 column">
                            <div class="panel panel-default" style="border-radius: 0px;">
                                <div class="panel-heading" style="background-color: #fff;border-color: #fff;">
                                    <span class="label label-success"><i class="glyphicon glyphicon-tag"></i> 
                                    	<c:if test="${project.status==0 }">即将开始</c:if>
                                    	<c:if test="${project.status==1 }">众筹中</c:if>
                                    	<c:if test="${project.status==2 }">众筹成功</c:if>
                                    	<c:if test="${project.status==3 }">众筹失败</c:if>
                                    </span>
                                </div>
                                <div class="panel-body">
                                    <h3 >
                                        已筹资金：${project.supportmoney }
                                    </h3>
                                    <p><span>目标金额 ： ${project.money }</span><span style="float:right;">达成 ： ${100*project.supportmoney/project.money }%</span></p>
                                    <div class="progress" style="height:10px; margin-bottom: 5px;">
                                      <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:  ${100*project.supportmoney/project.money}%;"></div>
                                    </div>
                                    <p>剩余 ${remainDay } 天</p>
                                    <div>
                                     <p><span>已有${project.supporter }人支持该项目</p>
                                     <button type="button" class="btn  btn-warning btn-lg btn-block" data-toggle="modal" data-target="#myModal">立即支持</button>
                                    </div>
                                </div>
                                <div class="panel-footer" style="    background-color: #fff;
                                    border-top: 1px solid #ddd;
                                    border-bottom-right-radius: 0px;
                                    border-bottom-left-radius: 0px;">
                                <div class="container-fluid">
                                    <div class="row clearfix">
                                        <div class="col-md-3 column" style="padding:0;">
                                <img alt="140x140" src="img/services-box2.jpg" data-holder-rendered="true" style="width: 80px; height: 80px;">
                                </div>
                                <div class="col-md-9 column">
                                    <div class="">
                                        <h4>
                                            <b>${project.member.introduce }</b> <span style="float:right;font-size:12px;" class="label label-success">已认证</span>
                                        </h4>
                                        <p style="font-size:12px">
                                            ${project.member.describe1 }

                                        </p>
                                        <p style="font-size:12px">
                                        客服电话:${project.member.cutomtel }
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
					<c:forEach items="${ret }" var="item">
						<div class="panel panel-default" style="border-radius: 0px;">
							<div class="panel-heading">
								<h3 >
									￥${item.supportmoney } <span style="float:right;font-size:12px;">限一份，${item.count }位支持者</span>
								</h3>
							</div>
							<div class="panel-body">
	                            <p>配送费用：包邮</p>
	                            <p>预计发放时间：项目筹款成功后的${project.deploydate }天内</p>
	                            <button type="button" class="btn  btn-warning btn-lg" onclick="window.location.href='pay-step1?returnid='+${item.id }+'&projectid='+${project.id} ">支持</button>
	                            <br><br>
	                            <p>${item.content }</p>
							</div>
						</div>
					</c:forEach>
                    
					
					<div class=" panel panel-default" style="border-radius: 0px;">
						<div class="panel-heading">
							<h3 >
								风险提示
							</h3>
						</div>
						<div class="panel-body">
                            <p>1.众筹并非商品交易，存在一定风险。支持者根据自己的判断选择、支持众筹项目，与发起人共同实现梦想并获得发起人承诺的回报。<br>
2.众筹平台仅提供平台网络空间及技术支持等中介服务，众筹仅存在于发起人和支持者之间，使用众筹平台产生的法律后果由发起人与支持者自行承担。<br>
3.本项目必须在2017-06-09之前达到￥10000.00 的目标才算成功，否则已经支持的订单将取消。订单取消或募集失败的，您支持的金额将原支付路径退回。<br>
4.请在支持项目后15分钟内付款，否则您的支持请求会被自动关闭。<br>
5.众筹成功后由发起人统一进行发货，售后服务由发起人统一提供；如果发生发起人无法发放回报、延迟发放回报、不提供回报后续服务等情况，您需要直接和发起人协商解决。<br>
6.如您不同意上述风险提示内容，您有权选择不支持；一旦选择支持，视为您已确认并同意以上提示内容。</p>
						</div>
					</div>
                    
                    <div><h2>为你推荐</h2><hr></div>
					<div class="prjtip panel panel-default" style="border-radius: 0px;">
						<div class="panel-body">
                            <img src="img/product-3.png" width="100%" height="100%">
						</div>
					</div>
                    
					<div class="prjtip panel panel-default" style="border-radius: 0px;">
						<div class="panel-body">
                            <img src="img/product-4.jpg" width="100%" height="100%">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
    

        <div class="container" style="margin-top:20px;">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div id="footer">
                        <div class="footerNav">
                             <a rel="nofollow" href="http://www.atguigu.com">关于我们</a> | <a rel="nofollow" href="http://www.atguigu.com">服务条款</a> | <a rel="nofollow" href="http://www.atguigu.com">免责声明</a> | <a rel="nofollow" href="http://www.atguigu.com">网站地图</a> | <a rel="nofollow" href="http://www.atguigu.com">联系我们</a>
                        </div>
                        <div class="copyRight">
                            Copyright ?2010-2014atguigu.com 版权所有
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
      
    </div> <!-- /container -->
    
    
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
      <div class="modal-dialog "  style="width:960px;height:400px;" role="document">
        <div class="modal-content" data-spy="scroll" data-target="#myScrollspy">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">选择支持项</h4>
          </div>
          <div class="modal-body">
<div class="container-fluid">
	<div class="row clearfix">
		<div class="col-sm-3 col-md-3 column" id="myScrollspy">
            <ul class="nav nav-tabs nav-stacked">
            <c:forEach items="${project.returnList }" var="ret">
                <li class="active"><a href="#section-1">￥${ret.supportmoney }</a></li>
             </c:forEach>
            </ul>
		</div>
		<div id="navList" class="col-sm-9 col-md-9 column" style="height:400px;overflow-y:auto;">
         	 <c:forEach items="${ret }" var="ret">
	            <h2 id="section-1" style="border-bottom:1px dashed #ddd;" >
	            <span style="font-size:20px;font-weight:bold;">￥${ret.supportmoney }</span>
	            <span style="font-size:12px;margin-left:60px;">限额一份，${ret.count }位支持者</span></h2>
	            <p>配送费用：全国包邮</p>
	            <p>预计发放时间：项目筹款成功后的${project.deploydate }天内</p>
	            <button type="button" class="btn  btn-warning btn-lg " onclick="window.location.href='pay-step1?returnid='+${ret.id }+'&projectid='+${project.id} ">支持</button>
	            <br><br>
	            <p>${ret.content }</p>
            </c:forEach>
            <hr>
        </div>
	</div>
</div>
          </div>
        </div>
      </div>
    </div>
    
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
    <script src="script/back-to-top.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
     <script type="text/javascript" src="jquery/lsbridge.min.js"></script>
    <script type="text/javascript" src="easyui/js/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/js/jquery.easyui.min.js"></script>
	<script>
	    $(".prjtip img").css("cursor", "pointer");
	    $(".prjtip img").click(function(){
	        window.location.href = 'project.html';
	    });
	    
	    function follow(id,obj){
	    	var str="";
	    	$.post(
    			"followProject",
    	    	{"id":id},
    	    	function(data){
    	    		if(data.code==-1){
    	    			layer.msg(data.message, {
    			    	    time: -1, //20s后自动关闭
    			    	    icon:5,
    			    	   /*  shift:6, */
    			    	    btn: ['知道了','明白了']
    			    	 });
    	    			return;
    	    		}
    	    		if(data.code==0){
    	    			str+=' <i style="color:#f60" class="glyphicon glyphicon-heart" id="heart"></i> 关注'+data.obj;
    	    		}else{
    	    			str+=' <i style="color:grey" class="glyphicon glyphicon-heart" id="heart"></i> 关注'+data.obj;
    	    		}
    	    		$("#follow_btn").html(str);
    	    	}	
	    	);
	    }
	    
	    lsbridge.subscribe('project_success', function(data) {
        	$.messager.show({  
    	        title:'公告',  
    	        msg:data.message,  
    	        showType:'show',
    	        timeout:0
    	   }); 
        });
	</script>
  </body>
</html>