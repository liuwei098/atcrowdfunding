<%@page import="com.yc.atcrowdfunding.vo.Result"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	<link rel="stylesheet" href="css/pageStyle.css">
	<script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
    <script src="script/back-to-top.js"></script>
    <script type="text/javascript" src="jquery/jquery.ias.js"></script>
     <script type="text/javascript" src="layer/layer.js"></script>
     <script src="jquery/paging.js"></script>
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
    cursor: pointer;
}
#typeList  :not(:first-child) {
    margin-top:20px;
   
}
.label-text1,.label-text2,.label-text3 {
    margin:0 10px;
    cursor: pointer;
   	
}
.panel {
    border-radius:0;
}
h3.break {
    font-size:16px;
    display: block;
    white-space: nowrap;
    word-wrap: normal;
    overflow: hidden;
    text-overflow: ellipsis;
}
h3.break>a {
    text-decoration:none;
}
	</style>
  </head>
  <body>
	  <%
	 	 Result result=(Result)request.getAttribute("result");
	 
	  %>
	  
	<%@ include file="../commons/header.jsp" %>
    <div class="container theme-showcase" role="main">
	<%@ include file="../commons/nav.jsp" %>
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <ul id="typeList" style="list-style: none;">
								<li>分类：<span class="label-type active " onclick="changeType(this);filter()" value="-1">全部</span> 
									<c:forEach items="${typeList }" var="type">
										<span class="label-text1" onclick="changeType(this);filter()" value="${type.id }">${type.name }</span>
									</c:forEach> 
									
								</li>
								<li>状态：<span class="label-status actvie" onclick="changeStatues(this);filter()" value="-1">全部</span> 
									<span	class="label-text2" onclick="changeStatues(this);filter()" value="0">即将开始</span> 
									<span class="label-text2" onclick="changeStatues(this);filter()" value="1">众筹中</span>
									<span class="label-text2" onclick="changeStatues(this);filter()" value="2">众筹成功</span>
								</li>
								<li>排序：<span class="label-order actvie" onclick="changeTerm(this);filter()" value="0">综合排序</span> 
									<span class="label-text3" onclick="changeTerm(this);filter()" value="1">最新上线</span> 
									<span class="label-text3" onclick="changeTerm(this);filter()" value="2">金额最多</span>
									<span class="label-text3" onclick="changeTerm(this);filter()" value="3">支持最多</span>
								</li>
							</ul>
                        </div>
                        <div class="panel-footer" style="height:50px;padding:0;">
                            <div style="float:left;padding:15px;" id="total">
                            共${total }个众筹项目
                            </div>
                            <div style="float:right;">
                                <form class="navbar-form navbar-left" role="search">
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="请输入搜索的项目名称" id="searchKey" 
                                        	onkeyup="searchWord()" id="search" onclick="click(this)">
                                    </div>
	                                     <div id="show" style='display:none;position:absolute;color:gray;z-index:1000;background:white;
	                                     	opacity:0.9;width:555px;height:150px;margin-top:40px;border:1px solid #ccc'>
	                	
	               						 </div>
                                    <button type="button" class="btn btn-default" onclick="searchProject()"><i class="glyphicon glyphicon-search" ></i> 搜索</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <!--  站内搜索js -->
    <script type="text/javascript">
	    function click(obj){
			$(obj).css("display","block");
		}
	    
		function overFn(obj){
			$(obj).css("background","lightblue")
		};
		
		function outFn(obj){
			$(obj).css("background","white")
		};
		
		function clickFn(obj){
			$("#searchKey").val($(obj).html());
			$("#show").css("display","none");
		};
		
		function searchWord(obj){
			var word=$("#searchKey").val();
			var content="";
			$.post(
					"serachProjects",//url
					{"searchKeyWord":word},//请求参数
					function(data){      //执行成功的回调函数	
						if(data.obj.length>0){
							for(var i=0;i<data.obj.length;i++){
								content+="<div style='padding:5px;cursor:pointer' onmouseover='overFn(this)'  onmouseout='outFn(this)' onclick='clickFn(this)''> "+data.obj[i].name+"</div>"
							}
							$("#show").html(content);
							$("#show").css("display","block");
						}
					},	
					"json"
				
			);
		};
		
    </script>
<div class="container content1">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="row" id="showProjects">
				<c:forEach items="${projects }" var="project">
						<div class="col-md-3">
							<div class="thumbnail">
								<a href="project?id=${project.id }"><img alt="300x200"
									src="${project.titleimg }" /></a>
								<div class="caption">
									<h3 class="break">
										<a href="project">${project.name }</a>
									</h3>
									<p>
									<div style="float: left;">
										<i class="glyphicon glyphicon-screenshot" title="目标金额"></i>
										${project.money }
									</div>
									<div style="float: right;">
										<i title="截至日期" class="glyphicon glyphicon-calendar"></i>
										<fmt:formatDate value="${project.createtime}" pattern="yyyy-MM-dd"/>
									</div>
									</p>
									<br>
									<div class="progress" style="margin-bottom: 4px;">
										<div class="progress-bar progress-bar-success"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: ${project.supportmoney*100/project.money}%">
											<span>${project.supportmoney*100/project.money}% </span>
										</div>
									</div>
									<div>
										<span style="float: right;"><i
											class="glyphicon glyphicon-star-empty"></i></span> <span><i
											class="glyphicon glyphicon-user" title="支持人数"></i> ${project.supporter }</span>
									</div>
								</div>
							</div>
						</div>
				</c:forEach>
			</div>
		</div>
			
		</div>
	</div>
</div>
        
       
	 <nav class="pagination" style="display: none;">
        
      </nav>
       <div id="page" class="page_div"></div>
      
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
      
   
    
<script>
	//改变众筹状态改变时样式的改变
	function changeStatues(obj){
	
		var items=$(".label-status");
		for(var i=0;i<items.length;i++){
			if(items[i]!=obj){
				items[i].className='label-text2';
			};
		}  
		var type=$(".label-status");
		type.attr("class","label-text2");
		obj.className="label-status active";
	}
		

	//改变排序状态改变时样式的改变
	function changeTerm(obj){
	
		var items=$(".label-order");
		for(var i=0;i<items.length;i++){
			if(items[i]!=obj){
				items[i].className='label-text3';
			};
		}  
		var type=$(".label-order");
		type.attr("class","label-text3");
		obj.className="label-order active";
	}

	//以下代码分类改变被选择的样式变化
	function changeType(obj){
	 	var items=$(".label-type");
		for(var i=0;i<items.length;i++){
			if(items[i]!=obj){
				items[i].className='label-text1';
			};
		}  
		
		var type=$(".label-type");
		type.attr("class","label-text1");
		obj.className="label-type active";
	}
	
	<%-- pageing();
	function pageing(){
		<%
			if("projects".equals(result.getMessage())){
		%>
		 $("#page").paging({
		    	pageNo:${result.page},
		        totalPage:${result.totalPage} ,
		        totalSize:${total},
		        callback: function(num) {
		        	window.location.href="projects?page="+num; 
		        }
		 });
		 <%}%>
	
	} --%>
	
	
	//搜索项目
	function searchProject(){
		var searchKeyWord=$("#searchKey").val();
		$.post(
			"serachProjects",
			{"searchKeyWord":searchKeyWord},
			function(data){
				console.log(data);
				showProjects(data.obj);
			}
		
		);
	 	console.log(searchKeyWord);
	}
	
	
	//根据选择的条件查询
	function filter(){
		//status -1:综合  0:即将开始  1:众筹中  2：众筹成功
		var status=$(".label-status")[0].getAttribute("value");
		//order 0:即将开始   1：最新上线   2：金额最多   3：支持最多
		var order=$(".label-order")[0].getAttribute("value");
		var tid=$(".label-type")[0].getAttribute("value");
		$.post(
			"projects_findByterm",
			{"tid":tid,"status":status,"order":order},
			function(data){
				if(data.code==200){
					showProjects(data.obj);
				}  else{
					layer.msg(data.message, {
			    	    time: 2000, //20s后自动关闭
			    	    icon:5,
			    	   
			    	    btn: ['明白了', '知道了']
			    	 });
				}  
				
			}
		);
		
	}
	
	//展示查询到的项目
	function showProjects(attr){
		var str='';
		console.log(attr);
		for(var i=0;i<attr.length;i++){
			console.log(attr[i]);
			str+="<div class='col-md-3'>" +
				"              <div class='thumbnail'>" + 
				"                <a href='project?id="+attr[i].id+"'><img alt='300x200'" + 
				"                  src='"+attr[i].titleimg+"' /></a>" + 
				"                <div class='caption'>" + 
				"                  <h3 class='break'>" + 
				"                    <a href='project?id="+attr[i].id+"'>"+attr[i].name+"</a>" + 
				"                  </h3>" + 
				"                  <p>" + 
				"                  <div style='float: left;'>" + 
				"                    <i class='glyphicon glyphicon-screenshot' title='目标金额'></i>" + 
				"                   "+attr[i].money+"" + 
				"                  </div>" + 
				"                  <div style='float: right;'>" + 
				"                    <i title='截至日期' class='glyphicon glyphicon-calendar'></i>" + 
				"                    2017-20-20" + 
				"                  </div>" + 
				"                  </p>" + 
				"                  <br>" + 
				"                  <div class='progress' style='margin-bottom: 4px;'>" + 
				"                    <div class='progress-bar progress-bar-success'" + 
				"                      role='progressbar' aria-valuenow='40' aria-valuemin='0'" + 
				"                      aria-valuemax='100' style='width: 40%'>" + 
				"                      <span>"+attr[i].supportmoney*100/attr[i].money+"% </span>" + 
				"                    </div>" + 
				"                  </div>" + 
				"                  <div>" + 
				"                    <span style='float: right;'><i" + 
				"                      class='glyphicon glyphicon-star-empty'></i></span> <span><i" + 
				"                      class='glyphicon glyphicon-user' title='支持人数'></i> "+attr[i].supporter+"</span>" + 
				"                  </div>" + 
				"                </div>" + 
				"              </div>" + 
				"            </div>";

		}
		
		$("#showProjects").html(str);
		$("#total").html("共"+attr.length+"个众筹项目")
	}
	
	$('#myTab a').click(function (e) {
	  e.preventDefault()
	  $(this).tab('show')
	});
	
	 //分页
 
  
	
	//以下jquery为ias滚动加载
	/* var ias=jQuery.ias({
		history: false,
		container : '.content1',
		item: '.col-md-3',
		pagination: '.pagination',
		next: '.next-page a',
		loader: '<div class="pagination-loading"><img src="/img/loading.gif" /></div>',
	});
	var page=1;
	 ias.on('load',function(event){
		 event.ajaxOptions.data={page:++page}
	 });
	 
	 ias.extension(new IASTriggerExtension({
		    text: '读取更多', // optionally
		    offset:5
	 }));
	 
	 ias.extension(new IASSpinnerExtension({
		    src: ' /img/loading.gif', // optionally
	})); */
</script>
  </body>
</html>