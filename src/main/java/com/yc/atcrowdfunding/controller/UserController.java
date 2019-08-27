package com.yc.atcrowdfunding.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yc.atcrowdfunding.bean.TPermission;
import com.yc.atcrowdfunding.bean.TUser;
import com.yc.atcrowdfunding.biz.PermissionBiz;
import com.yc.atcrowdfunding.biz.UserBiz;
import com.yc.atcrowdfunding.vo.Result;




@Controller
public class UserController {
	
	@Resource
	private UserBiz ubiz;
	
	@Resource
	private PermissionBiz pbiz;
	
	@ModelAttribute("menus")
	public  List<TPermission> init(HttpSession session){
		return  pbiz.findAllMenu();
		 
	}
	
	 
	
	
	@RequestMapping("main")
	public String user(TUser user,HttpSession session){
		//List<TPermission> list=pbiz.findAllMenu();
		//session.setAttribute("menus", list);
		return "user/main";
	}
	
	//显示所有用户，和模糊查询的用户
	@RequestMapping("user")
	public String Tuser(@RequestParam(defaultValue = "1")int pageNum,HttpSession session,
			@RequestParam(defaultValue = "5")int pageSize,String name,Model model) {
		
		Result result = ubiz.findAllUser(pageNum, pageSize, name);
		model.addAttribute("result", result);
		//List<TPermission> list=pbiz.findAllMenu();
		//session.setAttribute("menus", list);
		return "user/user";
	}
	
	
	//根据id删除用户
	@RequestMapping("deleteUser")
	@ResponseBody
	public Result deleteUser(String  ids) {
		// System.out.println("id 是   "+ids);
		Result result = new Result();
		try {
			//ubiz.deleteUserById(ids);
			result.setCode(200);
			result.setMessage("删除成功");
		} catch (RuntimeException e) {
			result.setCode(-1);
			result.setMessage("业务繁忙，删除失败，请稍后再试！！");
		}
		
		return result;
		
	}
	
	
	//编辑用户页面
	@RequestMapping("edit")
	public String edit() {
		return "user/edit";
	}
	
	//处理编辑用户
	@RequestMapping("editUser")
	@ResponseBody
	public Result editUser(String id,String username,String email) {
		Result result = new Result();
		try {
			ubiz.updateUserById(id, username, email);
			result.setCode(200);
			result.setMessage("修改成功");
		} catch (RuntimeException e) {
			result.setCode(-1);
			result.setMessage("业务繁忙，修改失败，请稍后再试！！");
		}
		return result;
	}
	
	
	//打开新增用户页面
	@RequestMapping("addUser")
	public String add() {
		return "user/addUser";
	}
	
	
	@RequestMapping("addUserX")
	@ResponseBody
	public Result addUserX(String loginacct,String username,String password,String email) {
		Result result = new Result();
		try {
			List<TUser> list = ubiz.selectLoginacct(loginacct);
			
			if(list.size()>0) {
				 
				result.setCode(0);
				result.setMessage("该登录账号已注册");
			}else {
				ubiz.insertUserX(loginacct, username, password, email);
				result.setCode(200);
				result.setMessage("新增成功");
			}
		} catch (RuntimeException e) {
			result.setCode(-1);
			result.setMessage("业务繁忙，新增失败，请稍后再试！！");
		}
		return result;
	}
	
	
	//  为用户 设置权限 assignRole
	@RequestMapping("assignRole")
	public String assignRole() {
		return "user/assignRole";
	}
	
	
	
	
	
	
	
}
