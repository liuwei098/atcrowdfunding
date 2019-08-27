<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th>公司简介</th>
                  <th>资质图片</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
               <c:forEach items="${result.obj }" var="item" varStatus="status">
                <tr>
                  <td>${item.id }</td>
                  <td>${item.introduce }</td>
              	  <td><img src="${item.iconpath }" style="width:150px;height:100px"></td>
                  <td>
                      <button type="button" class="btn btn-success btn-xs" onclick="review(${item.id})""><i class="glyphicon glyphicon-eye-open"></i></button>
				  </td>
                </tr>
                </c:forEach>
               
              </tbody>
			  <tfoot>
			
			  </tfoot>
            </table>
              <div id="page" class="page_div"></div>
          </div>
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
    	//分页
	    $("#page").paging({
	    	pageNo:${result.page},
	        totalPage:${result.totalPage},
	        totalSize:${result.total},
	        callback: function(num) {
	        	window.location.href="auth_cert?pageNum="+num;
	        }
	    });
    	
    	//点击进入审核界面
    	function review(id){
    		window.location.href="reviewMember?id="+id;
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
