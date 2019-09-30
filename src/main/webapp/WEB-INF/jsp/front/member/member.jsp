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
						<img src="img/${loginMember.iconpath }" class="img-thumbnail" alt="">
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
				<div class="list-group-item active">
					资产总览<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
				</div>
				<div class="list-group-item " style="cursor:pointer;" onclick="window.location.href='minecrowdfunding'">
					我的众筹<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
				</div>
			</div>
		</div>
        <div class="col-sm-9 col-md-9 column">
        <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            我的钱包
                                        </b>
                                    </blockquote>
            <div id="main" style="width: 600px;height:400px;"></div>
            <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                        各分类投资数额
                                        </b>
                                    </blockquote>
            <div id="main1" style="width: 600px;height:400px;"></div>
            <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            比例
                                        </b>
                                    </blockquote>
            <div id="main2" style="width: 600px;height:400px;"></div>
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
    <script src="script/echarts.js"></script>
     <script type="text/javascript" src="jquery/lsbridge.min.js"></script>
    <script type="text/javascript" src="easyui/js/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/js/jquery.easyui.min.js"></script>
	<script>
	
	  lsbridge.subscribe('project_success', function(data) {
      	$.messager.show({  
  	        title:'公告',  
  	        msg:data.message,  
  	        showType:'show',
  	        timeout:0
  	   }); 
      });
	  
		$('#myTab a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		})
		$('#myTab1 a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		})

        var myChart = echarts.init(document.getElementById('main'));

		var profits=new Array();
		getMonthProfits();
		function getMonthProfits(){
			$.ajaxSettings.async = false;
			$.post(
				"getMonthSupportMoney",
				{},
				function(data){
					for(var i=0;i<data.obj.length;i++){
						profits[i]=data.obj[i];
					}
				},
				"json"
					
			);
			$.ajaxSettings.async = true;
				
			
		}
		
		
        // 指定图表的配置项和数据
option = {
    xAxis: {
        type: 'category',
        data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月','八月','九月','十月','十一月','十二月']
    },
    yAxis: {
        type: 'value'
    },
    series: [{
        data: profits,
        type: 'line'
    }]
};
myChart.setOption(option);
var myChart1 = echarts.init(document.getElementById('main1'));

var types;
var moneys;
getAllTypes();
getAllMoneys();
function getAllTypes(){
	$.ajaxSettings.async = false;
	$.post(
		"member_findAllType",
		{},
		function(data){
			types=data.obj;
		}
			
	);
	
	$.ajaxSettings.async = true;
}

function getAllMoneys(){
	$.ajaxSettings.async = false;
	$.post(
		"findTypeMoney",
		{},
		function(data){
			moneys=data.obj;
		}
			
	);
	
	$.ajaxSettings.async = true;
}

        // 指定图表的配置项和数据
option1 = {
    color: ['#3398DB'],
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    grid: {
        left: '10%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : types,
            axisTick: {
                alignWithLabel: true
            }
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'投资数额',
            type:'bar',
            barWidth: '60%',
            data:moneys
        }
    ]
};

        // 使用刚指定的配置项和数据显示图表。
        myChart1.setOption(option1);
        
        var myChart2 = echarts.init(document.getElementById('main2'));

	var typemoney;
	getAllTypeMoney();
	function getAllTypeMoney(){
		$.ajaxSettings.async = false;
		$.post(
			"findRetTypeMoney",
			{},
			function(data){
				typemoney=data.obj;
			}
				
		);
	}

        
        // 指定图表的配置项和数据
option2 = {
    title : {
        text: '虚拟物品和实物回报投资金额比例',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['实物回报','虚拟物品'],
    },
    series : [
        {
            name: '访问来源',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:[
                {value:typemoney[0], name:'实物回报'},
                {value:typemoney[1], name:'虚拟物品'},
              
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
};

        // 使用刚指定的配置项和数据显示图表。
        myChart2.setOption(option2);
	</script>
  </body>
</html>