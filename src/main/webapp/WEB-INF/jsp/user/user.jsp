<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>       

<!DOCTYPE html>
<html>
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
  <style type="text/css">
	

</style>

  <body>

	<%pageContext.setAttribute("info","用户维护"); %>

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
      <input class="form-control has-success" type="text" placeholder="请输入查询条件(用户名称)" id="uname">
    </div>
  </div>
  <button type="button" class="btn btn-warning" onclick="searchUser()"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteAll()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='addUser'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" disabled="true"></th>
                  <th>账号</th>
                  <th>用户名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              
              <c:forEach items="${result.obj }" var="u" varStatus="status">
                <tr>
                  <td id="uid">${u.id }</td>
				  <td><input type="checkbox" class="checkeduid" value="${u.id }"></td>
                  <td>${u.loginacct }</td>
                  <td>${u.username }</td>
                  <td>${u.email }</td>
                  <td>
				      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
				      <button type="button" class="btn btn-primary btn-xs"  onclick="editUser(${u.id },'${u.loginacct }','${u.username }','${u.email }' )" ><i class=" glyphicon glyphicon-pencil"></i></button>
					  <button type="button" class="btn btn-danger btn-xs"  onclick="deleteUser(${u.id } )"><i class=" glyphicon glyphicon-remove"></i></button>
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
    <script type="text/javascript" src="easyui/js/jquery.easyui.min.js"></script>
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
	        	window.location.href="user?pageNum="+num;
	        }
	    });
	</script>
	
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
            
            //根据用户名查询 模糊查询
            function searchUser(){
            	 var name = uname.value;
            	 window.location.href = "user?name="+name;
            	
            }
            
            $("tbody .btn-success").click(function(){
            	
                window.location.href = "assignRole";
            });
            
            //编辑用户
            function editUser(id,loginacct,username,email){
            	/* alert(loginacct); */
            	window.location.href = "edit?id="+id+"&loginacct="+loginacct+"&username="+username+"&email="+email;
            }
            
            
            
            //根据id删除用户
            function deleteUser(ids){
            	
            	var url="deleteUser";
            	var usid=uid.value;
            	var param={"ids":ids};
            	var callback = function(result){
            		
            		 
            		if( result.code ==200){
            			alert(result.message);
            			 window.location.href="user?pageNum=${param.pageNum}"; 
            			
            		}else{
            			alert(result.message);
            		} 
            	}
            	$.post( url,param,callback);

            }
            
            //根据多个id删除用户
          var ids = "";
          function deleteAll(){
        	  var a= $(".checkeduid");
        	   for(var i=0;i<a.length;i++){
          		if(a[i].checked){
          			  
          			ids=ids+a[i].value+",";
          		}
          	} 
        	   
          		var url = "deleteUser";
          		var param = {"ids":ids};
          		
          		var callback = function(result){
          			if(result.code==200){
          				
          				alert(result.message); 
          				 window.location.href="user?pageNum=${param.pageNum}"; 
          			}else{
          				alert(result.message);
          			}
          		};
        	 $.post(url,param,callback);
          }
           
          //用户维护 样式设置
          $("a[href='user']").css("color","red");
          $("a[href='user']").parents("list-group-item").removeClass("tree-closed");
          $("a[href='user']").parent().parent("ul").show();
          
          
          
        </script>
  </body>
</html>
  