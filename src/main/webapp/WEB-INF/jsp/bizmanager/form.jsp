<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<jsp:useBean id="TType" class="com.yc.atcrowdfunding.bean.TType" scope="request"/>
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
	<link rel="stylesheet" type="text/css" href="easyui/css/easyui.css" />
	<link rel="stylesheet" type="text/css" href="easyui/css/icon.css" />
	<style>
	form{
		margin-left: 400px;
		margin-top: 100px;
	}

	</style>
  </head>
  
  <body>
  	 <%@ include file="../commons/header.jsp" %>
    <div class="container-fluid">
      <div class="row">
         <%@ include file="../commons/commons.jsp" %>
         <form:form action="doAdd" modelAttribute="TType">
         	<label>${result.message}</label><br/><br/>
         	类型名：<form:input path="name"/><br/><br/>
         	描&nbsp&nbsp&nbsp述：<form:input path="remark"/><br/>
         	<input type="submit" value="确定"/><br/>
         </form:form>
      </div>
    </div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
        <script type="text/javascript">
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
            
           /*  $("#tijiao").click(function(){
            	$.ajax(
            		type:"POST",
            		url:"doAdd",
            		function(){
            		
            	});
            }); */
        </script>
  </body>
</html>
 
 