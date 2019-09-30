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

.label-type, .label-status, .label-order {
    background-color: #fff;
    color: #f60;
    padding : 5px;
    border: 1px #f60 solid;
}
#typeList  :not(:first-child) {
    margin-top:20px;
}
.label-txt {
    margin:10px 10px;
    border:1px solid #ddd;
    padding : 4px;
    font-size:14px;
}
.panel {
    border-radius:0;
}

.progress-bar-default {
    background-color: #ddd;
}
	</style>
  </head>
  <body>
 	<%@ include file="../commons/header.jsp" %>
    <div class="container theme-showcase" role="main">        
        
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="panel panel-default" >
                        <div class="panel-heading" style="text-align:center;">
                            <div class="container-fluid">
                                <div class="row clearfix">
                                    <div class="col-md-3 column">
                                        <div class="progress" style="height:50px;border-radius:0;    position: absolute;width: 75%;right:49px;">
                                          <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">1. 确认回报内容</div>
                                          </div>
                                        </div>
                                        <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                        </div>
                                    </div>
                                    <div class="col-md-3 column">
                                        <div class="progress" style="height:50px;border-radius:0;position: absolute;width: 75%;right:49px;">
                                          <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">2. 确认订单</div>
                                          </div>
                                        </div>
                                        <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(92, 184, 92, 1);
                                             border-top-color: rgba(92, 184, 92, 0);
                                             border-bottom-color: rgba(92, 184, 92, 0);
                                             border-right-color: rgba(92, 184, 92, 0);
                                        ">
                                        </div>
                                    </div>
                                    <div class="col-md-3 column">
                                        <div class="progress" style="height:50px;border-radius:0;position: absolute;width: 75%;right:49px;">
                                          <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">3. 付款</div>
                                          </div>
                                        </div>
                                        <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                        </div>
                                    </div>
                                    <div class="col-md-3 column">
                                        <div class="progress" style="height:50px;border-radius:0;">
                                          <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">4. 完成</div>
                                          </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="container-fluid">
                                <div class="row clearfix">
                                    <div class="col-md-12 column">
                                        <div class="alert alert-warning alert-dismissable" style="color:red;">
                                             <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                            <i class="glyphicon glyphicon-info-sign"></i> <strong >请在下单后15分钟内付款，否则您的订单会被自动关闭。</strong> 
                                        </div>
                                    </div>
                                </div>
                            </div>

                       <c:if test="${order.ret.type==0 }">
                       		 <div id="address" class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-12 column">
                                    <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            收货地址
                                        </b>
                                    </blockquote>
                                </div>
                                <div class="col-md-12 column" style="padding:0 120px;">
                                   <c:forEach items="${memberInfo }" var="member">
	                                   	<div class="radio">
	                                      <label>
	                                        <input onclick="getInfo()"  type="radio" name="optionsRadios" id="optionsRadios1" value="${member.remark },${member.invoictitle},${member.address }"  >
	                                     	${member.remark } ${member.invoictitle} ${member.address }
	                                      </label>
	                                    </div>
                                   </c:forEach>
                                  
                                    <div class="radio">
                                      <label>
                                        <input onclick="getInfo()" type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                        新地址
                                      </label>
                                    </div>
                                    <div style="border:10px solid #f60;border-bottom-color: #eceeef;border-width: 10px;width:20px;margin-left:20px;margin-top:-20px;
                                             border-left-color: rgba(221, 221, 221, 0);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                    "></div>
                                    <div class="panel panel-default" style="border-style: dashed;background-color:#eceeef">
                                      <div class="panel-body">
                                            <div class="col-md-12 column" >
                                                <form class="form-horizontal" action="payOrder" id="payForm">
                                                <input name="id" type="hidden" id="oid">
                                                  <div class="form-group">
                                                    <label class="col-sm-2 control-label">收货人（*）</label>
                                                    <div class="col-sm-10">
                                                      <input name="remark" type="text" id="remark" class="form-control" style="width:200px;" placeholder="姓名：xxxx" >
                                                    </div>
                                                  </div>
                                                  <div class="form-group">
                                                    <label class="col-sm-2 control-label">手机（*）</label>
                                                    <div class="col-sm-10">
                                                      <input name="invoictitle" class="form-control" type="text" style="width:200px;" placeholder="请填写11位手机号码" id="invoictitle"></input>
                                                    </div>
                                                  </div>
                                                  <div class="form-group">
                                                    <label class="col-sm-2 control-label">地址（*）</label>
                                                    <div class="col-sm-10">
                                                      <input name="address" id="address1" class="form-control" type="text" style="width:400px;" placeholder="请填写收货地址"></input>
                                                      	<a  style="text-align:center;line-height:30px;display:inline-block;font-size:16px;color:black;background:lightgrey;width:80px;height:30px" id="choose" href="javascript:getLocate()">选择位置</a>
														<a  style="text-align:center;line-height:30px;display:inline-block;font-size:16px;color:black;background:lightgrey;width:80px;height:30px;margin-left:50px;" id="choose" href="javascript:closeMap()">确定</a>
                                                      <div id="allmap" style="width:800px;height: 400px;display: none"></div>
                                                    </div>
                                                  </div>
                                                  <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-2 control-label"></label>
                                                    <div class="col-sm-10">
                                                          <a href="#pay" class="btn btn-primary">确认配送信息</a>
                                                    </div>
                                                  </div>
                                                </form>
                                            </div>
                                      </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                          </c:if>
                          <c:if test="${order.ret.type==1 }">
                          		 <form class="form-horizontal" action="payOrder1" id="payForm">
                                                <input name="id" type="hidden" id="oid">
                                                 
                                             
                               	 </form>
                          </c:if>
                        <div class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-12 column">
                                 
                                    </div>
                                </div>
                            </div>
                        </div>
                     
                        <div class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-12 column">
                                    <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            项目信息 
                                        </b>
                                    </blockquote>
                                </div>
                                <div class="col-md-12 column">
                                    <table class="table table-bordered" style="text-align:center;">
                                      <thead>
                                        <tr style="background-color:#ddd;">
                                          <td>项目名称</td>
                                          <td>发起人</td>
                                          <td width="300">回报内容</td>
                                          <td width="80">回报数量</td>
                                          <td>支持单价</td>
                                          <td>配送费用</td>
                                        </tr>
                                      </thead>
                                      <tbody>
                                        <tr>
                                          <td>${order.project.name }</td>
                                          <td>${order.member.introduce }</td>
                                          <td>${order.ret.content }</td>
                                          <td>${order.ret.freight }</td>
                                          <td style="color:#F60">￥ ${order.ret.supportmoney }</td>
                                          <td>免运费</td>
                                        </tr>
                                      </tbody>
                                    </table>
                                </div>
                                <div class="col-md-12 column">
                                  <div class="form-group">
                                  
                                  </div>
                                </div>
                                <div class="col-md-12 column">
                                    <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            账单
                                        </b>
                                    </blockquote>
                                </div>
                                
                                <div class="col-md-12 column" id="pay">
                                        <div class="alert alert-warning alert-dismissable" style="text-align:right; border:2px solid #ffc287;">
                                            <ul style="list-style:none;" >
                                                <li style="margin-top:10px;">支持金额：<span style="color:red;">￥${order.ret.supportmoney*order.ordernum}</span></li>
                                                <li style="margin-top:10px;">配送费用：<span style="color:red;">￥0.00</span></li>
                                                <li style="margin-top:10px;">优惠金额：<span style="color:red;">-￥0.00</span></li>
                                                <li style="margin-top:10px;margin-bottom:10px;"><h2>支付总金额：<span style="color:red;">￥${order.ret.supportmoney*order.ordernum}</span></h2></li>
                                                <li style="margin-top:10px;padding:5px;border:1px solid #F00;display:initial;background:#FFF;">
                                                    <i class="glyphicon glyphicon-info-sign"></i> <strong>您需要先 <a href="#address">设置配送信息</a> ,再提交订单</strong> 
                                                </li>
                                                <li style="margin-top:10px;">
                                                请在下单后15分钟内付款，否则您的订单会被自动关闭。
                                                </li>
                                                <li style="margin-top:10px;">
                                               <c:if test="${order.ret.type==0 }">
                                               	 <button id="btn" disabled="disabled" type="button" class="btn btn-warning btn-lg" onclick="payOrder()"><i class="glyphicon glyphicon-credit-card"></i> 立即付款</button>
                                               </c:if>
                                               
                                               <c:if test="${order.ret.type==1 }">
                                               	 <button id="btn" disabled="disabled" type="button" class="btn btn-warning btn-lg" onclick="payOrder2()"><i class="glyphicon glyphicon-credit-card"></i> 立即付款</button>
                                               </c:if>
                                                </li>
                                                <li style="margin-top:10px;">
                                                  <div class="checkbox">
                                                    <label>
                                                      <input type="checkbox"  onclick="changeButton(this)"> 我已了解风险和规则
                                                    </label>
                                                  </div>
                                                </li>
                                            </ul>

                                            
                                        </div>
                                </div>
                                <div class="container">
                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                            <blockquote>
                                                <p >
                                                    <i class="glyphicon glyphicon-info-sign" style="color:#2a6496;"></i> 提示
                                                </p><br>
                                                <span style="font-size:12px;">1.众筹并非商品交易，存在一定风险。支持者根据自己的判断选择、支持众筹项目，与发起人共同实现梦想并获得发起人承诺的回报。<br>
                                                2.众筹平台仅提供平台网络空间及技术支持等中介服务，众筹仅存在于发起人和支持者之间，使用众筹平台产生的法律后果由发起人与支持者自行承担。<br>
                                                3.本项目必须在2017-06-04之前达到 ￥1000000.00 的目标才算成功，否则已经支持的订单将取消。订单取消或募集失败的，您支持的金额将原支付路径退回。<br>
                                                4.请在支持项目后15分钟内付款，否则您的支持请求会被自动关闭。<br>
                                                5.众筹成功后由发起人统一进行发货，售后服务由发起人统一提供；如果发生发起人无法发放回报、延迟发放回报、不提供回报后续服务等情况，您需要直接和发起人协商解决。<br>
                                                6.如您不同意上述风险提示内容，您有权选择不支持；一旦选择支持，视为您已确认并同意以上提示内容。</span>
                                            </blockquote>
                                        </div>
                                    </div>
                                </div>
                                
                                
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
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
    <script src="script/back-to-top.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=iS5NWsbObDpG7UTo8tZzYrbbxmPdVoig"></script>
	<script>
		$('#myTab a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		})
		
		function changeButton(obj){
			if(obj.checked==true){
				$("#btn").attr("disabled",false);
			}else{
				$("#btn").attr("disabled",true);
			}
		}
		
		function payOrder(){
			var id=getOrderid();
			var info=getInfo();
			var address;
			var remark;
			var invoictitle;
			if(info=='option2'){
				
			}else{
				
				address=info.substring(info.lastIndexOf(",")+1);
				remark=info.substring(0,info.indexOf(","));
				invoictitle=info.substring(info.indexOf(",")+1,info.lastIndexOf(","));
				$("#address1").val(address);
				$("#remark").val(remark);
				$("#invoictitle").val(invoictitle);
			}
			var oid=getOrderid();
			oid=oid.split("#")[0];
			
			$("#oid").val(oid);
			
			$("#payForm").submit();
			
		}
		
		function payOrder2(){
			var oid=getOrderid();
			oid=oid.split("#")[0];
			$("#oid").val(oid);
			$("#payForm").submit();
			
		}
		
		function getOrderid(){
			var url=window.location.href;
			var orderid=url.split("=")[1];
			return orderid;
		}
		
		function getInfo(){
			var option=$("input[name='optionsRadios']");
			for(var i=0;i<option.length;i++){
				if(option[i].checked==true){
					return option[i].value;
				}
			}
		}
		var lng;
		var lat;
		function closeMap(){
			$("#allmap").css("display","none");
		}
		getLagAndLat();
		function getLagAndLat(){
			var map = new BMap.Map("allmap");
			var point = new BMap.Point(116.331398,39.897445);
			map.centerAndZoom(point,12);
			var geolocation = new BMap.Geolocation();
			geolocation.getCurrentPosition(function(r){
				if(this.getStatus() == BMAP_STATUS_SUCCESS){
					var mk = new BMap.Marker(r.point);
					map.addOverlay(mk);
					map.panTo(r.point);
					lng=point.lng;
					lat=point.lat;
				}
				else {
					alert('failed'+this.getStatus());
				}        
			},{enableHighAccuracy: true})
		}
		function getLocate(){
			
			$("#allmap").css("display","block");
			var map = new BMap.Map("allmap");
			var point = new BMap.Point(lng,lat);
			map.centerAndZoom(point,14);
			map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
			map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
			var geolocation = new BMap.Geolocation();
			geolocation.getCurrentPosition(function(r){
				if(this.getStatus() == BMAP_STATUS_SUCCESS){
					var mk = new BMap.Marker(r.point);
					map.addOverlay(mk);
					map.panTo(r.point);	
				}
				else {
					alert('failed'+this.getStatus());
				}        
			},{enableHighAccuracy: true});
			var geoc = new BMap.Geocoder();   
			map.addEventListener("click", function(e){        
				var pt = e.point;
				geoc.getLocation(pt, function(rs){
					var addComp = rs.addressComponents;
					$("#address1").val(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
				});        
			});
		}
		
	</script>
  </body>
</html>