<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
	<link rel="stylesheet" href="css/pageStyle.css">
	<link type="text/css" rel="stylesheet" href="bootstrap/css/fileinput.css" />
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
      <input class="form-control has-success" id="search" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" class="btn btn-warning" onclick="searchType()"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="DeleteSelectedType()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="addModel()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered" id="adv">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th width="30"><input type="checkbox"></th>
                  <th>广告描述</th>
                  <th>图片</th>
                  <th>状态</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              	<c:forEach items="${result.obj}" var="adv" varStatus="status">
	                <tr>
	                  <td>${status.index+1+ (param.pageNum==null?0: (param.pageNum-1)*5) }</td>
	                  <td><input type="checkbox" class="checktype" value="${adv.id}"></td>
	                  <td>${adv.name}</td>
	                  <td>${adv.iconpath}</td>
	                  <td>${adv.status}</td>
	                  <td>
	                      <button type="button" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-check"></i></button>
	                      <button type="button" class="btn btn-primary btn-xs" onclick="editAdv(${adv.id})"><i class="glyphicon glyphicon-pencil"></i></button>
	                      <button type="button" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-remove"></i></button>
					  </td>
	                </tr>
                </c:forEach>
              </tbody>
			  <tfoot>

			  </tfoot>
            </table>
            <div id="page" class="page_div"></div>
            
            
            <!-- 新增用户的模态框，在修改用户中将获取一行的值放入input中，改变一些参数继续使用 -->
		<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h3>新增用户</h3>
					</div>
					<div class="modal-body">
						<form:form id="addUserForm" action="/user/addUser" method="post" class="form-horizontal">
							<div class="form-group">
								<label for="inputAccount" class="col-sm-2 control-label">广告名</label>
								<div class="col-sm-7">
									<input name="name" class="form-control" id="inputAccount" placeholder="广告名"/>
								</div>
								<label id="errorAccount" for="inputAccount" class="col-sm-3 control-label"></label>
							</div>
							<div class="form-group" >
								<label for="inputPassword" class="col-sm-2 control-label">广告图</label>
								<div class="col-sm-7">
									
									<!-- <input type="file" name="iconpath" id="fileimage" accept="image/gif, image/jpeg"/>
									<input type="hidden" name="getimg" id="getimg"/> -->
									<input type="file" name="iconpath"  class="myfile"/> 

									<!-- <input type="text" name="iconpath" class="form-control" id="inputPassword" placeholder="广告图"/>  -->
								</div>
								<label id="errorPassword" for="inputPassword" class="col-sm-3 control-label"></label>
							</div>
							<div class="form-group" >
								<label for="inputPassword" class="col-sm-2 control-label">发布人</label>
								<div class="col-sm-7">
									<select id="userid">
									</select>
								</div>
								<label id="errorPassword" for="inputPassword" class="col-sm-3 control-label"></label>
							</div>
						</form:form>
					</div>
					<div class="modal-footer">
						<button type="button" id="conf" class="btn btn-default" onclick="addUser()"">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal" οnclick="resetAddModal()">取消</button>
					</div>
				</div>				
			</div>
		</div>
		<!-- 修改用户的模态框 -->
		<div class="modal fade" id="editModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h3>修改用户</h3>
					</div>
					<div class="modal-body">
						<form id="editForm" method="post" class="form-horizontal">
							<div class="form-group" style="display:none">
								<label for="editId" class="col-sm-2 control-label">ID</label>
								<div class="col-sm-7">
									<input name="id"   class="form-control" id="editId" placeholder="ID" />
								</div>
								<label id="errorId" for="editId" class="col-sm-3 control-label"></label>
							</div>
							<div class="form-group">
								<label for="inputAccount" class="col-sm-2 control-label">广告名</label>
								<div class="col-sm-7">
									<input name="name" class="form-control" id="editAccount" placeholder="广告名"/>
								</div>
								<label id="errorAccount" for="inputAccount" class="col-sm-3 control-label"></label>
							</div>
							<div class="form-group">
								<label for="inputName" class="col-sm-2 control-label">广告图</label>
								<div class="col-sm-7">
									<input name="iconpath" class="col-sm-4 form-control" id="editName" placeholder="姓名"/>
								</div>
								<label id="errorName" for="inputName" class="col-sm-3 control-label"></label>
							</div>
							<div class="form-group">
								<label for="inputStates" class="col-sm-2 control-label">状态</label>
								<div class="col-sm-7">
									<select id="editStates" name="status">
										<option value="0">草稿</option>
										<option value="1">未审核</option>
										<option value="2">不可发布</option>
										<option value="3">已发布</option>
									</select>
								</div>
								<label id="errorStates" for="inputStates" class="col-sm-3 control-label"></label>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" id="conf" class="btn btn-default" onclick="updateAdv()">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal" οnclick="resetAddModal()">取消</button>
					</div>
				</div>				
			</div>
		</div>
		<div class="modal fade" id="Tip" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h3>提示</h3>
					</div>
					<div class="modal-body" align="center">
						<h4 id="tipContent">新增成功</h4>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">确定</button>
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
						<button type="button" class="btn btn-default" data-dismiss="modal">确定</button>
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
	<script src="bootstrap/js/fileinput.js"></script>
	<script type="text/javascript" src="bootstrap/js/zh.js"></script> 
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
            
            $(".myfile").fileinput({
                uploadUrl:"uploadImg", //接受请求地址
                uploadAsync : true, //默认异步上传
                showUpload : false, //是否显示上传按钮,跟随文本框的那个
                showRemove : false, //显示移除按钮,跟随文本框的那个
                showCaption : true,//是否显示标题,就是那个文本框
                showPreview : true, //是否显示预览,不写默认为true
                dropZoneEnabled : false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
                //minImageWidth: 50, //图片的最小宽度
                //minImageHeight: 50,//图片的最小高度
                //maxImageWidth: 1000,//图片的最大宽度
                //maxImageHeight: 1000,//图片的最大高度
                //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
                //minFileCount: 0,
                maxFileCount : 1, //表示允许同时上传的最大文件个数
                enctype : 'multipart/form-data',
                validateInitialCount : true,
                previewFileIcon : "<i class='glyphicon glyphicon-king'></i>",
                msgFilesTooMany : "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
                allowedFileTypes : [ 'image' ],//配置允许文件上传的类型
                allowedPreviewTypes : [ 'image' ],//配置所有的被预览文件类型
                allowedPreviewMimeTypes : [ 'jpg', 'png', 'gif' ],//控制被预览的所有mime类型
                language : 'zh'
            })
           //异步上传返回结果处理
            $('.myfile').on('fileerror', function(event, data, msg) {
                console.log("fileerror");
                console.log(data);
            });
            //异步上传返回结果处理
            $(".myfile").on("fileuploaded", function(event, data, previewId, index) {
                console.log("fileuploaded");
                var ref = $(this).attr("data-ref");
                $("input[name='" + ref + "']").val(data.response.url);

            }); 

            //上传前
            $('.myfile').on('filepreupload', function(event, data, previewId, index) {
                console.log("filepreupload");
            });
            
            
            //新增用户
            function addModel(){
            	$("#addUserModal").modal("show");
           		$.post(
   	              		"selectUser",
   	              		function(result){
   	              			if(result.code==200){
		           				for(var i=0;i<result.obj.length;i++){
		           					$("#userid").append("<option value='"+result.obj[i].id+"'>"+result.obj[i].username+"</option>");
		           				}
   	              			}else{
   	              				alert("新增异常，请稍后再试");
   	              			}
   	              		},
   	              		"json"
   	             );
            }
         
          
        	function addUser(){
        		var param = $("#addUserForm").serializeArray();
        		$("#conf").attr("onclick","addUser()");
        		$.ajax({
        			url:"addAdv",
        			method:"post",
        			data:param,
        			dataType:"json",
        			success:function(data){
        				if(data.message=="success"){
        					document.getElementById("al").innerText="新增成功";
        					$("#addEnd").modal('show');
        					$("#addUserModal").modal('hide');
        					//$(".table-bordered").bootstrapTable('refresh');
        					window.location.href="advertisement?pageNum=${param.pageNum}";
        				}
        			},
        			error:function(){
        				document.getElementById("al").innerText="新增失败";
        				$("#addEnd").modal('show');
        			}
        		});
        	}
        	//修改用户
        	function editAdv(id){
        		//获取选中行的数据
        		$("#adv").on("click", ":button", function(event){
        			 $("#editId").val(id);
        		     $("#editAccount").val($(this).closest("tr").find("td").eq(2).text());
        		     $("#editName").val($(this).closest("tr").find("td").eq(3).text());
        		     $("#editModal").modal("show");
        		 });
        	}
        	function updateAdv(){
        		var param = $("#editForm").serializeArray();
        		//设为disable则无法获取
        		$.ajax({
        			url:"updateAdv",
        			method:"post",
        			data:param,
        			dataType:"json",
        			success:function(data){
        				if(data.message=="success"){
        					$("#editModal").modal("hide");
        					$("#updateEnd").modal('show');
        					window.location.href="advertisement?pageNum=${param.pageNum}";
        				}
        			},
        			error:function(data){
        				alert("wrong");
        			}
        		});
        	}            
            
            function DeleteSelectedType(){
            	var a=$(".checktype");
            	var ids='';
            	for(var i=0;i<a.length;i++){
            		if(a[i].checked){
            			ids=ids+a[i].value+",";
            		}
            	}
           		$.post(
	              		"deleteAdv",
	              		{"ids":ids},
	              		function(result){
	              			if(result.code==200){
	              				alert("删除成功");
	              				window.location.href="advertisement?pageNum=${param.pageNum}";
	              			}else{
	              				alert("删除失败");
	              			}
	              		},
	              		"json"
	             );
            	
            }
            
            function deleteTType(id){
            	$.post(
           			"deleteAdv",
               		{"ids":id},
               		function(result){
               			//成功用eaayui提示用户成功
               			if(result.code==200){
               				alert("删除成功");
               				window.location.href="advertisement?pageNum=${param.pageNum}";
               			}else{
               				alert("删除失败");
               			}
               		},
               		"json"
            	);
            }
            
            function searchType(){
             	var name=$("#search").val();
        		window.location.href="advertisement?name="+name;
            }
            
            //分页
    	    $("#page").paging({
    	    	pageNo:${result.page},
    	        totalPage:${result.totalPage} ,
    	        totalSize:${result.total},
    	        callback: function(num) {
    	        	window.location.href="advertisement?pageNum="+num;	    
    	        	}
    	    })
        </script>
  </body>
</html>
