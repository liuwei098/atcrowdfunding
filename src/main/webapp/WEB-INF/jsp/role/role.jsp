<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" href="css/doc.min.css">
	<link rel="stylesheet" href="ztree/zTreeStyle.css">
	
	<link rel="stylesheet" href="css/pageStyle.css">
	<link rel="stylesheet" type="text/css" href="easyui/css/easyui.css" />
	<link rel="stylesheet" type="text/css" href="easyui/css/icon.css" />
	
	
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

 
    <%pageContext.setAttribute("info","角色维护"); %>
    
    
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
      <input class="form-control has-success" type="text" placeholder="请输入查询条件" id="rolename">
    </div>
  </div>
  <button type="button" class="btn btn-warning" onclick="searchRole()"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="DeleteSelectedRole()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='addRole'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" disabled="true"></th>
                  <th>角色名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${result.obj}" var="item" varStatus="status">
                	<tr>
	                  <td>${item.id }</td>
					  <td><input type="checkbox" class="checkRole"  value="${item.id }"/></td>
	                  <td>${item.name }</td>
	                  <td>
					      <button type="button" id="ss"  rid="${item.id }"
					      			class="btn btn-success btn-xs assignPermissionModel"
										onclick="assignPermission('${item.id }')"> 
					      			 
					      		<i class=" glyphicon glyphicon-check"></i>
					      </button>
					      <button type="button" class="btn btn-primary btn-xs" onclick="editRoleX(${item.id },'${item.name }')"><i class=" glyphicon glyphicon-pencil"></i></button>
						  <button type="button" class="btn btn-danger btn-xs" onclick="deleteRole(${item.id})"><i class=" glyphicon glyphicon-remove"></i></button>
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

<!-- 模态框 -->
	<div class="modal fade" id="permissionModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配权限</h4>
				</div>
				<div class="modal-body"> 
					<!-- 展示权限树 -->
						<div>
							<ul id="permissionTree" class="ztree"></ul>
						</div>
						 
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="addPermission">分配权限</button>
				</div>
			</div>
		</div>
	</div>



	<script src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="easyui/js/jquery.easyui.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="script/docs.min.js"></script>
	<script src="ztree/jquery.ztree.all-3.5.min.js"></script>
	<script src="jquery/paging.js"></script>
 
	
	
	<script type="text/javascript" src="layer/layer.js"></script>
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
            
            var ids="";
            function DeleteSelectedRole(){
            	var a=$(".checkRole");
            	for(var i=0;i<a.length;i++){
            		if(a[i].checked){
            			ids=ids+a[i].value+",";
            		}
            	}
           		$.post(
	              		"role_deleteRole",
	              		{"ids":ids},
	              		function(result){
	              			//alert(result.code);
	              			//成功用eaayui提示用户成功
	              			if(result.code==200){
	              				alert(result.message);
	              				window.location.href="role?pageNum=${param.pageNum}";
	              			}else{
	              				alert(result.message);
	              				 
	              			}
	              		},
	           
	             );
            	
            }
     	 /*       删除单个记录 */
            function deleteRole(id){
            	$.post(
            		"role_deleteRole",
            		{"ids":id},
            		function(result){
            			//成功用eaayui提示用户成功
            			if(result.code==200){
            				alert(result.message);
            			window.location.href="role?pageNum=${param.pageNum}";
            				 
            			}else{
            				alert(result.message);
            				 
            			}
            		}
            		 
            	);
            }
     	 //查询角色
     	 function searchRole(){
     		 var name=$("#rolename").val();
     		 window.location.href="role?name="+name;
     		 
     	 }
          
     	 //修改角色
     	 function editRoleX(id,name){
     		 window.location.href="editRole?id="+id+"&name="+name;
     	 }
     	 
     	 //保存ztree 对象 
         var ztreeObj;
         
         $("#addPermission").click(function(){
        	// alert("你点击了 分配权限按钮");
        	//1 获取当前已选择的权限
        	var nodes = ztreeObj.getCheckedNodes(true);
        	//2.将这些权限的id 和角色的id 发给程序
        	var pids = "";
        	
        	$.each(nodes,function(){
        		pids += this.id+",";
        	});
        	//alert("权限id"+pids);
        	var rids = $(this).attr("rids");
        	//alert("角色id"+rids);
        	//3.使用程序保存这个角色对应的权限值
        	$.get("updateRole?pids="+pids+"&rid="+rids,function(){
        		alert("权限分配成功");
        		$('#permissionModal').modal("hide");
        	});
         });
         
         
    	 //用户角色分配权限
    	 //点击按钮 打开模态框  查出所有的权限  在模态框中树形显示  将当前用户拥有的权限选中
          function assignPermission(id){
    		
    		 
    		 var options = {
    				 		backdrop:'static',
    				 		show:true
    		 			}
    		 //js的this 会经常飘移
    		 //permissionTree  显示出 权限树
    		 initPermissionTree(id);
    		
    		 //勾选当前角色的权限
        	 $('#permissionModal').modal(options);
    		 //将角色id保存到模态框
    		 //打开模态框将角色id传递给
    		 $('#addPermission').attr("rids",id);
    	 } 
    	 
    	 
    	 //treeId: 是权限树ul的id
    	 //treeNode 当前节点的信息
    	 function showIcon(treeId,treeNode){
    		 $("#"+treeNode.tId+"_ico").removeClass().addClass(treeNode.icon);
    	 }
    	 
    	 //传入角色id，将当前角色拥有的权限勾选
    	 function checkPermission(rid){
    		 $.getJSON("roleP?rid="+rid,function(data){
    			// alert(rid + " "+ztreeObj);
    			//ztree对象的方法
    			//参数1 要勾选的节点  参数2 是否勾选  3 是否和父节点级联互动  4是否调用之前的callback
    			$.each(data,function(){
    				
    				var node = ztreeObj.getNodeByParam("id",this.id,null);
	    			ztreeObj.checkNode(node,true,false);
    			})
    			
    		 });
    	 }
    	 
    	 
    	 //初始化权限树
    	 function initPermissionTree(rid){
    		 var setting = {
    				data : {
    					simpleData : {
    						enable : true,
    						idKey: "id",
    						pIdKey: "pid"
    						},
    		 
    		 			key: {
    		 				url:"" 
    		 			}
    				},
    				view : {
    					//自定义显示效果
    					addDiyDom: showIcon
    					},
    				check: {
    					enable: true
    				}
    			};
    		 //从数据库查出所有权限节点数据
    		 //发送ajax请求获取到所有权限 的json数据
    		var zNodes;
    		$.getJSON("json",function(nodes){
    			 
    			$.each(nodes,function(){
    				if(this.pid == 0 ){
	    				this.open = true;
    				}
    			});
    			//如果不是用var声明的遍历，这个变量就默认变为全局的
    			ztreeObj = $.fn.zTree.init($("#permissionTree"),setting,nodes);
    			 checkPermission(rid);
    			
    		})
    		
    		 
    	 }
     
    //分页
	    $("#page").paging({
	    	pageNo:${result.page},
	        totalPage:${result.totalPage} ,
	        totalSize:${result.total},
	        callback: function(num) {
	        	window.location.href="role?pageNum="+num;	        }
	    });
	    
	    
	    //点击链接  链接变为红色
	     $("a[href='role']").css("color","red");
	    //用户维护 样式设置
      
       $("a[href='role']").parents("list-group-item").removeClass("tree-closed");
       $("a[href='role']").parent().parent("ul").show();
	
     
       
	</script>
  </body>
</html>
 