<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="GB18030">
  <head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/main.css">
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
        <div class="col-sm-3 col-md-2 sidebar">
			<%@ include file="../commons/commons.jsp" %>
        </div>
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
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='form.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th>广告描述</th>
                  <th>状态</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1</td>
                  <td>XXXXXXXXXXXX商品广告</td>
                  <td>未审核</td>
                  <td>
                      <button type="button" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-check"></i></button>
                      <button type="button" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-pencil"></i></button>
                      <button type="button" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-remove"></i></button>
				  </td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>XXXXXXXXXXXX商品广告</td>
                  <td>已发布</td>
                  <td>
                      <button type="button" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-eye-open"></i></button>
                      <button type="button" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-pencil"></i></button>
                      <button type="button" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-remove"></i></button>
				  </td>
                </tr>
                <tr>
                  <td>3</td>
                  <td>XXXXXXXXXXXX商品广告</td>
                  <td>审核中</td>
                  <td>
                      <button type="button" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-eye-open"></i></button>
                      <button type="button" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-pencil"></i></button>
                      <button type="button" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-remove"></i></button>
				  </td>
                </tr>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="4" align="center">
						<ul class="pagination">
								<li class="disabled"><a href="#">上一页</a></li>
								<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">下一页</a></li>
							 </ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
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
        </script>
  </body>
</html>
