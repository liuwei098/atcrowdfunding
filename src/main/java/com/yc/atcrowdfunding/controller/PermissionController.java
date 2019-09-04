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
import com.yc.atcrowdfunding.biz.PermissionBiz;

@Controller

public class PermissionController {
	
	@Resource
	private PermissionBiz pbiz;
	
	//删除角色权限
	/**
	 *  更新角色权限
	 *  1、先删除当前角色的所有权限
	 *  2、在新增之前参选中的所有权限
	 * @return
	 */
	@RequestMapping("updateRole")
	@ResponseBody
	public String delRolePer(@RequestParam("pids")String pids,
			@RequestParam("rid")Integer rid) {
		//System.out.println("权限id"+pids+"角色id"+ rid);
		boolean flag = pbiz.updatePermission(pids,rid);
		
		return null;
		
	}
	
	
	
	@RequestMapping("roleP")
	@ResponseBody
	public List<TPermission> getRolePermission(Integer rid){
		List<TPermission> permissions = pbiz.getRolePer(rid);
		return permissions;
		
	}
	
	
	
	@RequestMapping("json")
	@ResponseBody
	public List<TPermission> getAllPermission(){
		//返回所有的权限
		return pbiz.getPermissions();
	}
 
	 
	@RequestMapping("permission")
	public String perssionIndex(Model model,HttpSession session){
		model.addAttribute("menus", session.getAttribute("menus"));
		return "permission/permission";
	}
}
