<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
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
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        	<%@ include file="../commons/commons.jsp" %>
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="search" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" class="btn btn-warning" onclick="searchType()"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="DeleteSelectedType()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='form'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered" id="tab">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"></th>
                  <th width="300">分类名称</th>
                  <th>简介</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              	<c:forEach items="${result.obj}" var="type" varStatus="status">
              		<tr>
	                  <td>${status.index+1+ (param.pageNum==null?0: (param.pageNum-1)*5) }</td>
					  <td><input type="checkbox" class="checktype" value="${type.id}"></td>
	                  <td>${type.name}</td>
	                  <td>${type.remark}</td>
	                  <td>
					      <button type="button" class="btn btn-primary btn-xs" onclick="editTType(${type.id})"><i class=" glyphicon glyphicon-pencil"></i></button>
						  <button type="button" class="btn btn-danger btn-xs" onclick="deleteTType(${type.id})"><i class=" glyphicon glyphicon-remove"></i></button>
					  </td>
	                </tr>
              	</c:forEach>
              </tbody>
              <tfoot>
              
              </tfoot>
            </table>
            <div id="page" class="page_div"></div>
            
            
            <!-- 修改项目分类的模态框 -->
		<div class="modal fade" id="editModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h3>修改项目分类</h3>
					</div>
					<div class="modal-body">
						<form id="editForm" method="post" class="form-horizontal">
							<div class="form-group" style="display:none">
								<label for="editId" class="col-sm-2 control-label">ID</label>
								<div class="col-sm-7">
									<input type="id" name="id"   class="form-control" id="editId" placeholder="ID" />
								</div>
								<label id="errorId" for="editId" class="col-sm-3 control-label"></label>
							</div>
							<div class="form-group">
								<label for="inputAccount" class="col-sm-2 control-label">类型名</label>
								<div class="col-sm-7">
									<input name="name" class="form-control" id="editAccount" placeholder="类型名"/>
								</div>
								<label id="errorAccount" for="inputAccount" class="col-sm-3 control-label"></label>
							</div>
							<div class="form-group" >
								<label for="inputPassword" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-7">
									<input type="text" name="remark" class="form-control" id="editPassword" placeholder="描述"/>
								</div>
								<label id="errorPassword" for="inputPassword" class="col-sm-3 control-label"></label>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" id="conf" class="btn btn-default" onclick="updateUser()">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal" οnclick="resetAddModal()">取消</button>
					</div>
				</div>				
			</div>
		</div>

 		<div class="modal fade" id="updateEnd" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h3>提示</h3>
					</div>
					<div class="modal-body" align="center">
						<h4 id="al">修改成功</h4>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="reflash()">确定</button>
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

    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="easyui/js/jquery.easyui.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
	<script src="jquery/paging.js"></script>
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
            
            
          //修改
        	function editTType(id){
        		 $("#tab").on("click", ":button", function(event){
        			 $("#editId").val(id);
        		     $("#editAccount").val($(this).closest("tr").find("td").eq(2).text());
        		     $("#editPassword").val($(this).closest("tr").find("td").eq(3).text());
        		     $("#editModal").modal("show");
        		 });
        	}
          
        	function updateUser(){
        		var param = $("#editForm").serializeArray();
        		//设为disable则无法获取
        		$.ajax({
					url:"updateTType",
					method:"post",
					data:param,
					dataType:"json",
					success:function(result){
						if(result.message=="success"){
							$("#editModal").modal("hide");
							$("#updateEnd").modal('show');
						}
					},
					error:function(result){
						alert("wrong");
					}
				});
        	}

        	//刷新
            function reflash(){
            	window.location.href="project_type?pageNum=${param.pageNum}";
        	}
            
            function DeleteSelectedType(){
            	var a=$(".checktype");
            	var ids='';
            	for(var i=0;i<a.length;i++){
            		if(a[i].checked){
            			ids=ids+a[i].value+",";
            		}
            	}
            /* 	QC - 品质控制
            	CMO / CMS - 配置管理员 */
           		$.post(
	              		"deleteType",
	              		{"ids":ids},
	              		function(result){
	              			//成功用eaayui提示用户成功
	              			if(result.code==200){
	              				$.messager.show({  
	              			        title:'删除成功',  
	              			        msg:result.message,  
	              			        showType:'show',
	              			        timeout:2000
	              			   }); 
	              				window.location.href="project_type?pageNum=${param.pageNum}";
	              			}else{
	              				//失败用layer插件提示用户失败
	              				layer.msg('用户名或者密码错误', {
	              			    	    time: 5000, //20s后自动关闭
	              			    	    icon:5,
	              			    	   /*  shift:6, */
	              			    	    btn: ['明白了', '知道了']
	              			    });
	              			}
	              		},
	              		"json"
	             );
            	
            }
            
            function deleteTType(id){
            	$.post(
           			"deleteType",
               		{"ids":id},
               		function(result){
               			window.location.href="project_type?pageNum=${param.pageNum}";
               			//成功用eaayui提示用户成功
               			if(result.code==200){
               				$.messager.show({  
               			        title:'删除成功',  
               			        msg:result.message,  
               			        showType:'show',
               			        timeout:2000
               			   }); 
               			}else{
               				//失败用layer插件提示用户失败
               				 layer.msg('用户名或者密码错误', {
               			    	    time: 5000, //20s后自动关闭
               			    	    icon:5,
               			    	   /*  shift:6, */
               			    	    btn: ['明白了', '知道了']
               			    	 });
               			}
               		},
               		"json"
            	);
            }
            
        	function searchType(){
             	var name=$("#search").val();
        		window.location.href="project_type?name="+name;
            }
            
            //分页
    	    $("#page").paging({
    	    	pageNo:${result.page},
    	        totalPage:${result.totalPage} ,
    	        totalSize:${result.total},
    	        callback: function(num) {
    	        	window.location.href="project_type?pageNum="+num;	    
    	        	}
    	    })
        </script>
  </body>
</html>
