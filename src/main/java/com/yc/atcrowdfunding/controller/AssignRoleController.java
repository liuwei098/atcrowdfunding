package com.yc.atcrowdfunding.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yc.atcrowdfunding.bean.TRole;
import com.yc.atcrowdfunding.biz.AssignRoleBiz;
import com.yc.atcrowdfunding.vo.Result;
 

@Controller
public class AssignRoleController {

	@Resource
	private AssignRoleBiz arbiz;
	
	
	
// 显示用户拥有与未拥有的权限 assignRole
	@RequestMapping("assignRole")
	public String assignRole(Integer uid,Model model) {
		//System.out.println("来到权限分配也页面，要分配角色用户的id是："+uid);
		//1.查出所有权限
		List<TRole> roles = arbiz.findAllRole();
		 
		//2.查出当前用户拥有的权限
		List<TRole> userRole = arbiz.findUserRoleById(uid);
		Map<Integer, TRole> map = new HashMap<Integer, TRole>();
		for (TRole tRole : userRole) {
			map.put(tRole.getId(), tRole);
		}
		//3 用户未分配的权限
		List<TRole> noRoles = new ArrayList<TRole>();
		for (TRole tRole : roles) {
			if(!map.containsKey(tRole.getId())) {
				//用户未拥有权限
				noRoles.add(tRole);
			}
		}
		//用户未拥有的
		model.addAttribute("norole", noRoles);
		//用户已拥有的
		model.addAttribute("roles", userRole);
		// System.out.println("拥有的角色"+userRole);
		return "user/assignRole";
	}
	
	
 
	//给用户添加角色
	@RequestMapping("assignUserRole")
	@ResponseBody
	public Result setUserRole(String ids,Integer uid
			,@RequestParam("opt")String opt) {
		Result result = new Result();
		if( "add".equals(opt)) {
			System.out.println("开始分配角色");
			try {
				arbiz.addUserRole(ids, uid);
				result.setCode(200);
				result.setMessage("分配角色成功");
			} catch (RuntimeException e) {
				result.setCode(-1);
				result.setMessage("业务繁忙，分配角色失败，请稍后再试！！！！");
			}
		}else if("remove".equals(opt)) {
			System.out.println("开始移除角色");
			try {
				arbiz.removeUserRole(ids, uid);
				result.setCode(200);
				result.setMessage("移除角色成功");
			} catch (RuntimeException e) {
				result.setCode(-1);
				result.setMessage("业务繁忙，分配角色失败，请稍后再试！！！！");
			}
		}
		
		return result;
	}
	
	/*
	 * //
	 * 
	 * @RequestMapping("permission") public String permission() { return
	 * "role/permission"; }
	 */
}
