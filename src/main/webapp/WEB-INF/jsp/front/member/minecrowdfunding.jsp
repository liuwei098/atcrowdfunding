<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

	</style>
  </head>
  <body>
  <%@ include file="../commons/header.jsp" %>
<div class="container">
	<div class="row clearfix">
		<div class="col-sm-3 col-md-3 column">
			<div class="row">
				<div class="col-md-12">
					<div class="thumbnail" style="    border-radius: 0px;">
						<img src="${loginMember.iconpath }" class="img-thumbnail" alt="A generic square placeholder image with a white border around it, making it resemble a photograph taken with an old instant camera">
						<div class="caption" style="text-align:center;">
							<h3>
								${loginMember.loginacct}
							</h3>
							<span class="label label-danger" style="cursor:pointer;" onclick="window.location.href='member_accttype'">	<span class="label label-danger" style="cursor:pointer;" onclick="window.location.href='member_accttype'">
								<c:if test="${loginMember.authstatus==0 }">
									未实名认证
								</c:if>
								<c:if test="${loginMember.authstatus==1 }">
									实名认证审核中
								</c:if>
								<c:if test="${loginMember.authstatus==2 }">
									已实名认证
								</c:if>
							</span></span>
						</div>
					</div>
				</div>
			</div>
			<div class="list-group">
				<div class="list-group-item" style="cursor:pointer;" onclick="window.location.href='member'">
					资产总览<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
				</div>
				<div class="list-group-item active">
					我的众筹<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
				</div>
			</div>
		</div>
            <div class="col-sm-9 col-md-9 column">
              <ul id="myTab" style="" class="nav nav-pills" role="tablist">
                <li role="presentation" class="active"><a href="#home" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">我的众筹</a></li>
                <li role="presentation"><a href="#profile">众筹资产</a></li>
              </ul>
              <div id="myTabContent" class="tab-content" style="margin-top:10px;">
                  <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
                  
                        <ul id="myTab1" class="nav nav-tabs">
                          <li role="presentation" class="active"><a href="#support">我支持的</a></li>
                          <li role="presentation"><a href="#attension">我关注的</a></li>
                          <li role="presentation"><a href="#add">我发起的</a></li>
                            <li class=" pull-right">
                                 <button type="button" class="btn btn-warning" onclick="window.location.href='start.html'">发起众筹</button>
                            </li>
                        </ul>                  
                        <div id="myTab1" class="tab-content" style="margin-top:10px;">
                            <div role="tabpanel" class="tab-pane fade active in" id="support" aria-labelledby="home-tab">
                                <div class="container-fluid">
                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                             <span class="label label-warning  color" style="cursor: pointer;color: black" onclick="changeColor(this);showAllOrder()">全部</span> 
                                             <span class="label  color" style="color:#000;cursor: pointer;" onclick="showPayOrder();changeColor(this)">已支付</span> 
                                             <span class="label  color" style="color:#000;cursor: pointer;"onclick="showNoPayOrder();changeColor(this)">未支付</span> 
                                        </div>
                                        <div class="col-md-12 column" style="margin-top:10px;padding:0;">
                                            <table class="table table-bordered" style="text-align:center;">
                                              <thead>
                                                <tr style="background-color:#ddd;">
                                                  <td>项目信息</td>
                                                  <td width="90">支持日期</td>
                                                  <td width="120">支持金额（元）</td>
                                                  <td width="80">回报数量</td>
                                                  <td width="80">交易状态</td>
                                                  <td width="120">操作</td>
                                                </tr>
                                              </thead>
                                              <tbody id="supportbody">
                                           		<c:forEach items="${orders }" var="order">
                                           			<tr>
	                                                  <td style="vertical-align:middle;">
	                                                    <div class="thumbnail">
	                                                        <div class="caption">
	                                                            <h3>
	                                                               ${order.project.name }
	                                                            </h3>
	                                                            <p>
	                                                                                                                 订单编号:${order.id}
	                                                            </p>
	                                                            <p>
	                                                                <div style="float:left;"><i class="glyphicon glyphicon-screenshot" title="目标金额" ></i> 已完成 ${order.project.supportmoney*100/order.project.money}% </div>
	                                                                <div style="float:right;"><i title="截至日期" class="glyphicon glyphicon-calendar"></i> 持续时间${order.project.day}天 </div>
	                                                            </p>
	                                                            <br>
	                                                                <div class="progress" style="margin-bottom: 4px;">
	                                                                  <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: ${order.project.supportmoney*100/order.project.money}%">
	                                                                    <c:if test="${order.project.status==0 }"><span>即将开始</span></c:if>
								                                    	<c:if test="${order.project.status==1 }"><span>众筹中</span></c:if>
								                                    	<c:if test="${order.project.status==2 }"><span>众筹成功</span></c:if>
								                                    	<c:if test="${order.project.status==3 }"><span>众筹失败</span></c:if>
	                                                                  </div>
	                                                                </div>
	                                                        </div>
	                                                    </div>
	                                                  </td>
	                                                  <td style="vertical-align:middle;">${order.createdate }</td>
	                                                  <td style="vertical-align:middle;">1.00<br>(运费：0.00 )</td>
	                                                  <td style="vertical-align:middle;">1</td>
	                                                  <c:if test="${order.status==0 }">
	                                                  	<td style="vertical-align:middle;">待付款</td>
	                                                  </c:if>
	                                                   <c:if test="${order.status==1}">
	                                                  	<td style="vertical-align:middle;">已付款</td>
	                                                  </c:if>
	                                                   <c:if test="${order.status==2 }">
	                                                  	<td style="vertical-align:middle;">交易关闭</td>
	                                                  </c:if>
	                                                  <td style="vertical-align:middle;">
	                                                    <div class="btn-group-vertical" role="group" aria-label="Vertical button group">
	                                                           <c:if test="${order.status==0 }">
	                                                  			  <button type="button" class="btn btn-default" onclick="pay(${order.ret.id})">去付款</button>
	                                                  			  <button type="button" class="btn btn-default" onclick="cancelOrder(${order.id})">取消订单</button>
	                                                  			</c:if>
	                                                  			<c:if test="${order.status==1 }">
	                                                  			  <button type="button" class="btn btn-default" onclick="confirmOrder(${order.id})">确认收到回报</button>
	                                                  			  
	                                                  			</c:if>
	                                                          <button type="button" class="btn btn-default" onclick="findDetails(${order.id})">交易详情</button>
	                                                    </div>
	                                                  </td>
	                                                </tr>
	                                               
                                           		</c:forEach>
                                              </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                         
                            
                            
                            
                            <div role="tabpanel" class="tab-pane fade" id="attension" aria-labelledby="attension-tab">
                                <div class="container-fluid">
                                    <div class="row clearfix">
                                        <div class="col-md-12 column" style="padding:0;">
                                            <table class="table table-bordered" style="text-align:center;">
                                              <thead>
                                                <tr style="background-color:#ddd;">
                                                  <td>项目信息</td>
                                                  <td width="120">支持人数</td>
                                                  <td width="120">关注人数</td>
                                                  <td width="120">操作</td>
                                                </tr>
                                              </thead>
                                              <tbody id="body">
                                             	 <tr>
                                               		<c:forEach items="${followProjects }"  var="project">
														
															<td style="vertical-align: middle;">
																<div class="thumbnail">
																	<div class="caption">
																		<p>${project.name }</p>
																		<p>
																			<i class="glyphicon glyphicon-jpy"></i> 已筹集${project.supportmoney }元
																		</p>
																		<p>
																		<div style="float: left;">
																			<i class="glyphicon glyphicon-screenshot"
																				title="目标金额"></i> 已完成 ${project.supportmoney*100/project.money}%
																		</div>
																		<div style="float: right;">
																			<i class="glyphicon glyphicon-calendar"></i> 持续时间${project.deploydate}天
																		</div>
																		</p>
																		<br>
																		<div class="progress" style="margin-bottom: 4px;">
																			<div class="progress-bar progress-bar-success"
																				role="progressbar" aria-valuenow="40"
																				aria-valuemin="0" aria-valuemax="100"
																				style="width:  ${project.supportmoney*100/project.money}%">
																					<c:if test="${project.status==0 }"><span>即将开始</span></c:if>
											                                    	<c:if test="${project.status==1 }"><span>众筹中</span></c:if>
											                                    	<c:if test="${project.status==2 }"><span>众筹成功</span></c:if>
											                                    	<c:if test="${project.status==3 }"><span>众筹失败</span></c:if>
																			</div>
																		</div>
																	</div>
																</div>
															</td>
															<td style="vertical-align: middle;">${project.supporter}</td>
															<td style="vertical-align: middle;">${project.follower}</td>
															<td style="vertical-align: middle;">
																<div class="btn-group-vertical" role="group"
																	aria-label="Vertical button group">
																	<button type="button" class="btn btn-default" onclick="cancelFollow(${project.id})">取消关注</button>
																</div>
															</td>
														
													</c:forEach>
													</tr>
                                              </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane fade  " id="add" aria-labelledby="add-tab">
                                <div class="container-fluid">
                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                             <span class="label label-warning color1" onclick="changeColor1(this);getStatusOrder(-1)" style="color: black;cursor: pointer;">全部</span>
                                             <span class="label color1" onclick="changeColor1(this);getStatusOrder(0)" style="color: black;cursor: pointer;">审核中</span>
                                             <span class="label color1" style="color:#000;cursor: pointer;" onclick="changeColor1(this);getStatusOrder(1)">众筹中</span> 
                                             <span class="label color1" style="color:#000;cursor: pointer;" onclick="changeColor1(this);getStatusOrder(2)">众筹成功</span>  
                                             <span class="label color1" style="color:#000;cursor: pointer;" onclick="changeColor1(this);getStatusOrder(3)">众筹失败</span>
                                        </div>
                                        <div class="col-md-12 column" style="padding:0;margin-top:10px;">
                                            <table class="table table-bordered" style="text-align:center;">
                                              <thead>
                                                <tr style="background-color:#ddd;">
                                                  <td>项目信息</td>
                                                  <td width="120">募集金额（元）</td>            
                                                 
                                                </tr>
                                              </thead>
                                              <tbody id="addbody">
                                              	<c:forEach items="${addProjects }" var="project">
                                              		<tr>
	                                                  <td style="vertical-align:middle;">
	                                                    <div class="thumbnail">
	                                                        <div class="caption">
	                                                            <p>
	                                                                ${project.name }
	                                                            </p>
	                                                            <p>
	                                                                <div style="float:left;"><i class="glyphicon glyphicon-screenshot" title="目标金额" ></i> 已完成  ${project.supportmoney*100/project.money }% </div>
	                                                                <div style="float:right;"><i title="截至日期" class="glyphicon glyphicon-calendar"></i>持续时间${project.deploydate}天</div>
	                                                            </p>
	                                                            <br>
	                                                                <div class="progress" style="margin-bottom: 4px;">
	                                                                  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:  ${project.supportmoney*100/project.money }%">
	                                                                   <c:if test="${project.status==0 }"><span>即将开始</span></c:if>
								                                    	<c:if test="${project.status==1 }"><span>众筹中</span></c:if>
								                                    	<c:if test="${project.status==2 }"><span>众筹成功</span></c:if>
								                                    	<c:if test="${project.status==3 }"><span>众筹失败</span></c:if>
	                                                                  </div>
	                                                                </div>
	                                                        </div>
	                                                    </div>
	                                                  </td>
	                                                  <td style="vertical-align:middle;">${project.money }<br></td>
	                                                 
	                                                 
                                                </tr>
                                              	</c:forEach>
                                              </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>                            
                        </div>
                  
                  </div>
                  <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
                  众筹资产
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
                            Copyright ?2017-2017atguigu.com 版权所有
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
	<script type="text/javascript">
		$('#myTab a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});
		
		$('#myTab1 a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});
		
		/* 改变选中的颜色 */
		function changeColor(obj){
			var items=$(".color");
			for(var i=0;i<items.length;i++){
				if(items[i]!=obj){
					items[i].className="label color";
				}
			}
			obj.className="label label-warning  color";
		}
		
		function changeColor1(obj){
			var items=$(".color1");
			for(var i=0;i<items.length;i++){
				if(items[i]!=obj){
					items[i].className="label color1";
				}
			}
			obj.className="label label-warning  color1";
		}
		
		function cancelFollow(projectid){
			$.post(
				"cancelFollow",
				{"id":projectid},
				function(data){
					if(data.code==0){
						alert(data.message);
					}else{
						showOrder(data);
					}
				}
			);
		}
		
		function showOrder(data){
			var str="";
			for(var i=0;i<data.obj.length;i++){
				str+='<td style="vertical-align: middle;">' +
					'    <div class="thumbnail">' + 
					'      <div class="caption">' + 
					'        <p>'+data.obj[i].name+'</p>' + 
					'        <p>' + 
					'          <i class="glyphicon glyphicon-jpy"></i> 已筹集'+data.obj[i].supportmoney+'元' + 
					'        </p>' + 
					'        <p>' + 
					'        <div style="float: left;">' + 
					'          <i class="glyphicon glyphicon-screenshot"' + 
					'            title="目标金额"></i> 已完成 '+(data.obj[i].supportmoney*100/data.obj[i].money)+'%' + 
					'        </div>' + 
					'        <div style="float: right;">' + 
					'          <i class="glyphicon glyphicon-calendar"></i> 持续时间'+data.obj[i].deploydate+'天' + 
					'        </div>' + 
					'        </p>' + 
					'        <br>' + 
					'        <div class="progress" style="margin-bottom: 4px;">' + 
					'          <div class="progress-bar progress-bar-success"' + 
					'            role="progressbar" aria-valuenow="40"' + 
					'            aria-valuemin="0" aria-valuemax="100"' + 
					'            style="width:  '+data.obj[i].supportmoney*100/data.obj[i].money+'%">';
					if(data.obj[i].status==0){
						str+='<span>即将开始</span>';
					}
					if(data.obj[i].status==1){
						str+='<span>众筹中</span>';
					}
					if(data.obj[i].status==2){
						str+='<span>众筹成功</span>';
					}
					if(data.obj[i].status==3){
						str+='<span>众筹失败</span>';
					}
					
					str+='          </div>' + 
					'        </div>' + 
					'      </div>' + 
					'    </div>' + 
					'  </td>' + 
					'  <td style="vertical-align: middle;">'+data.obj[i].supporter+'</td>' + 
					'  <td style="vertical-align: middle;">'+data.obj[i].follower+'</td>' + 
					'  <td style="vertical-align: middle;">' + 
					'    <div class="btn-group-vertical" role="group"' + 
					'      aria-label="Vertical button group">' + 
					'      <button type="button" class="btn btn-default" onclick="cancelFollow('+data.obj[i].id+')">取消关注</button>' + 
					'    </div>' + 
					'  </td>';

				}
				console.log(str)
				$("#body").html(str);
			};
			function showPayOrder(){
				$.post(
					"findOrderByTerm",
					{"status":1},
					function(data){
						showTermOrder(data);
					}
				);
			}
			
			function showAllOrder(){
				$.post(
					"findOrderByTerm",
					{"status":-1},
					function(data){
						console.log(data);
						showTermOrder(data);
					}
				);
			}
			
			function showTermOrder(data){
				var str="";
				for(var i=0;i<data.obj.length;i++){
					str+="  <tr>" +
						"  <td style='vertical-align:middle;'>" + 
						"    <div class='thumbnail'>" + 
						"        <div class='caption'>" + 
						"            <h3>" + 
						"               "+data.obj[i].project.name + 
						"            </h3>" + 
						"            <p>" + 
						"           订单编号:"+data.obj[i].id + 
						"            </p>" + 
						"            <p>" + 
						"                <div style='float:left;'><i class='glyphicon glyphicon-screenshot' title='目标金额' ></i> 已完成 "+data.obj[i].project.supportmoney*100/data.obj[i].project.money+"% </div>" + 
						"                <div style='float:right;'><i title='截至日期' class='glyphicon glyphicon-calendar'></i> 持续时间"+data.obj[i].project.day+"天 </div>" + 
						"            </p>" + 
						"            <br>" + 
						"                <div class='progress' style='margin-bottom: 4px;'>"+
						"                  <div class='progress-bar progress-bar-danger' role='progressbar' aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' style='width: "+data.obj[i].project.supportmoney*100/data.obj[i].project.money+"%'>" ; 
						if(data.obj[i].project.status==0){
							str+="<span>即将开始</span>";
						}
						if(data.obj[i].project.status==1){
							str+="<span>众筹中</span>";
						}
						if(data.obj[i].project.status==2){
							str+="<span>众筹成功</span>";
						}
						if(data.obj[i].project.status==3){
							str+="<span>众筹失败</span>";
						}
						str+="  </div>" + 
						"                </div>" + 
						"        </div>" + 
						"    </div>" + 
						"  </td>" + 
						"  <td style='vertical-align:middle;'>"+data.obj[i].createdate +"</td>" + 
						"  <td style='vertical-align:middle;'>1.00<br>(运费：0.00 )</td>" + 
						"  <td style='vertical-align:middle;'>1</td>";
						" <div class='progress-bar progress-bar-danger' role='progressbar' aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' style='width: "+data.obj[i].project.supportmoney*100/data.obj[i].project.money+"%'>" ; 
						if(data.obj[i].status==0){
							str+="<td style='vertical-align:middle;'>待付款</td>";
						}
						if(data.obj[i].status==1){
							str+="<td style='vertical-align:middle;'>已付款</td>";
						}
						if(data.obj[i].status==2){
							str+="<td style='vertical-align:middle;'>交易关闭</td>";
						}
					
						str+="  <td style='vertical-align:middle;'>" + 
						"    <div class='btn-group-vertical' role='group' aria-label='Vertical button group'>";
						if(data.obj[i].status==1){
							  str+="<button type='button' onclick='confirmOrder("+data.obj[i].id+")' class='btn btn-default'>确认收到回报</button>";
						}
						if(data.obj[i].status==0){
							  str+="<button type='button' onclick='pay("+data.obj[i].id+")'  class='btn btn-default'>去付款</button>";
							  str+="<button type='button' onclick='cancelOrder("+data.obj[i].id+")' class='btn btn-default'>取消订单</button>";
						}
						str+=" <button type='button' onclick='findDetails("+data.obj[i].id+")' class='btn btn-default'>交易详情</button>" + 
						"    </div>" + 
						"  </td>" + 
						"</tr>";
					}
					
					$("#supportbody").html(str);
			}
			
			function showNoPayOrder(){
				$.post(
						"findOrderByTerm",
						{"status":0},
						function(data){
							showTermOrder(data);
						}
					);
			}
			
			function pay(id){
				window.location.href="pay-step-2?retid="+id;
			}
			
			function cancelOrder(id){
				if(!confirm("确认删除吗")){
					return false;
				}
				$.post(
					"cancelOrder",
					{"id":id},
					function(data){
						
						layer.msg(data.message, {
				    	    time: -1, //20s后自动关闭
				    	    icon:6,
				    	   /*  shift:6, */
				    	    btn: ['知道了','明白了']
				    	 });
						if(data.code==1){
							showNoPayOrder();
						}
					}
				);
			}
			
			function confirmOrder(id){
				if(!confirm("确认收到回报吗")){
					return false;
				}
				$.post(
					"confirmOrder",
					{"id":id},
					function(data){

						layer.msg(data.message, {
				    	    time: -1, //20s后自动关闭
				    	    icon:6,
				    	   /*  shift:6, */
				    	    btn: ['知道了','明白了']
				    	 });
						if(data.code==1){
							showPayOrder();
						}
					}
				);
			}
			
			function findDetails(id){
				window.location.href="orderDetail?id="+id;			}
			
			
			
			function getStatusOrder(status){
				$.post(
					"findProjectByTerm",
					{"status":status},
					function(data){
						showStatusOrder(data);
					}
				);
			}
			
			function showStatusOrder(data){
				var str="";
				for(var i=0;i<data.obj.length;i++){
					str+="<tr>" +
						"    <td style='vertical-align:middle;'>" + 
						"      <div class='thumbnail'>" + 
						"          <div class='caption'>" + 
						"              <p>" + 
						"                  "+data.obj[i].name + 
						"              </p>" + 
						"              <p>" + 
						"                  <div style='float:left;'><i class='glyphicon glyphicon-screenshot' title='目标金额' ></i> 已完成 "+ data.obj[i].supportmoney*100/data.obj[i].money+"% </div>" + 
						"                  <div style='float:right;'><i title='截至日期' class='glyphicon glyphicon-calendar'></i>持续时间"+data.obj[i].deploydate+"天</div>" + 
						"              </p>" + 
						"              <br>" + 
						"                  <div class='progress' style='margin-bottom: 4px;'>" + 
						"                    <div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='40' aria-valuemin='0' aria-valuemax='100' style='width:  "+ data.obj[i].supportmoney*100/data.obj[i].money+"%'>" ; 
						if(data.obj[i].status==0){
							str+="<span>即将开始</span>";
						}
						if(data.obj[i].status==1){
							str+="<span>众筹中</span>";
						}
						if(data.obj[i].status==2){
							str+="<span>众筹成功</span>";
						}
						if(data.obj[i].status==3){
							str+="<span>众筹失败</span>";
						}
						str+="                    </div>" + 
						"                  </div>" + 
						"          </div>" + 
						"      </div>" + 
						"    </td>" + 
						"    <td style='vertical-align:middle;'>"+data.obj[i].money+"<br></td>" + 
						"" + 
						"" + 
						"</tr>";
				}
				$("#addbody").html(str);
			}
	</script>
  </body>
</html>