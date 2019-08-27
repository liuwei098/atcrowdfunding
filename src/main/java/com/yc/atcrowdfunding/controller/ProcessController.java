package com.yc.atcrowdfunding.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yc.atcrowdfunding.bean.TPermission;
import com.yc.atcrowdfunding.biz.PermissionBiz;
//import com.yc.atcrowdfunding.biz.ProcessBiz;

@Controller
public class ProcessController {

	@Resource
	private PermissionBiz pbiz;
	
	/*@Resource
	private ProcessBiz pcbiz;*/

	@ModelAttribute("menus")
	public  List<TPermission> init(HttpSession session){
		return  pbiz.findAllMenu();
	}
	
	@RequestMapping("process")
	public String toProcess(){
		return "bizmanager/process";
	}
}
