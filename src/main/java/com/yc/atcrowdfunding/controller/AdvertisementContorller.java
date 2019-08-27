package com.yc.atcrowdfunding.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yc.atcrowdfunding.bean.TPermission;
import com.yc.atcrowdfunding.biz.PermissionBiz;

@Controller
public class AdvertisementContorller {

	@Resource
	private PermissionBiz pbiz;
	

	
	@ModelAttribute("menus")
	public  List<TPermission> init(HttpSession session){
		return  pbiz.findAllMenu();
	}
	
	@RequestMapping("advertisement")
	public String toAdv(){
		return "bizmanager/auth_adv";
	}
}
