package com.yc.atcrowdfunding.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yc.atcrowdfunding.bean.TPermission;
import com.yc.atcrowdfunding.bean.TRole;
import com.yc.atcrowdfunding.biz.PermissionBiz;
import com.yc.atcrowdfunding.biz.RoleBiz;
import com.yc.atcrowdfunding.vo.Result;

@Controller
public class RoleController {
	@Resource
	private RoleBiz rbiz;
	
	@Resource
	private PermissionBiz pbiz;
	 
	//打开角色页面
	@RequestMapping("role")
	public String role(@RequestParam(defaultValue="1") int pageNum,@RequestParam(defaultValue="5") int pageSize,
			String name,Model model){
		Result result=rbiz.findAll(pageNum, pageSize, name);
		model.addAttribute("result", result);
		return "role/role";
	}
	
	//删除角色
	@RequestMapping("role_deleteRole")
	@ResponseBody
	public Result deleteRole(String ids){
		
		Result result=new Result();
		try{
			rbiz.deleteById(ids);
			result.setCode(200);
			result.setMessage("删除成功");
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(500);
			result.setMessage("服务器繁忙，稍后再试！！");
		}
		return result;
	}
	
	//打开角色新增页面
	@RequestMapping("addRole")
	public String addrole() {
		return "role/addRole";
	}
	
	//打开角色编辑页面
	@RequestMapping("editRole")
	public String editrole() {
		return "role/editRole";
	}
	
	//更新角色
	@RequestMapping("updateRoleX")
	@ResponseBody
	public Result updateRole(String id,String name) {

		//System.out.println("id===="+id+"----"+name);
		Result result=new Result();
		try{
			rbiz.updateRoleById(id, name);
			result.setCode(200);
			result.setMessage("更新成功");
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(500);
			result.setMessage("服务器繁忙，稍后再试！！");
		}
		return result;
	}
	
	//添加角色
	@RequestMapping("addRoleX")
	@ResponseBody
	public Result addRoleX(String roleName) {
		Result result = new Result();
		try {
			List<TRole> list = rbiz.findRoleX(roleName);
			if(list.size()>0) {
				result.setCode(0);
				result.setMessage("该角色已存在");
				 
			}else {
				rbiz.insertRoleX(roleName);
				result.setCode(200);
				result.setMessage("角色创建成功");
				 
			}
		} catch (RuntimeException e) {
			 result.setCode(-1);
			 result.setMessage("服务器繁忙，请稍后再试");
		}
		return  result;
	}
	

	
	
	
	
}
