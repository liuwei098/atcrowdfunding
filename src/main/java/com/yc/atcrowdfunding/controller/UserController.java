package com.yc.atcrowdfunding.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	private PermissionBiz pbiz;
	
	@Resource
	private UserBiz ubiz;
	
	@RequestMapping("main")
	public String user(TUser user,HttpSession session){
		List<TPermission> list=pbiz.findAllMenu();
		session.setAttribute("menus", list);
		return "user/main";
	}
	
	//显示所有用户，和模糊查询的用户
	@RequestMapping("user")
	public String Tuser(@RequestParam(defaultValue = "1")int pageNum,
			@RequestParam(defaultValue = "5")int pageSize,String name,Model model) {
		
		Result result = ubiz.findAllUser(pageNum, pageSize, name);
		model.addAttribute("result", result);
		return "user/user";
	}
	
	
	//根据id删除用户
	@RequestMapping("deleteUser")
	@ResponseBody
	public Result deleteUser(String  id) {
		 
		Result result = new Result();
		try {
			ubiz.deleteUserById(id);
			result.setCode(200);
			result.setMessage("删除成功");
		} catch (RuntimeException e) {
			result.setCode(-1);
			result.setMessage("业务繁忙，删除失败，请稍后再试！！");
		}
		
		return result;
		
	}
	
	
	
}
