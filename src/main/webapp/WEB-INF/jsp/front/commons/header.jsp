<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="navbar-wrapper">
	<div class="container">
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<a class="navbar-brand" href="#" style="font-size: 32px;">互联网众筹系统</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse"
					style="float: right;">
					<ul class="nav navbar-nav">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i>
								${loginMember.loginacct }<span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
								<c:if test="${loginMember!=null }">
									<li><a href="member"><i
										class="glyphicon glyphicon-scale"></i> 会员中心</a></li>
								
								<li><a href="member_logout"><i
										class="glyphicon glyphicon-off"></i> 退出系统</a></li>
								</c:if>
								<c:if test="${loginMember==null }">
									<li><a href="member_tologin"><i
										class="glyphicon glyphicon-scale"></i> 登录</a></li>
								
								</c:if>
							</ul></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
</div>