package com.yc.atcrowdfunding.controller;

import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.biz.FollowBiz;
import com.yc.atcrowdfunding.biz.ProjectBiz;
import com.yc.atcrowdfunding.biz.ReturnBiz;

@Controller
public class ProjectConroller {
	@Resource
	private ProjectBiz pbiz;
	@Resource
	private ReturnBiz rbiz;	
	@Resource
	private FollowBiz fbiz;

	@RequestMapping("project")
	private String project(Model model,@RequestParam(defaultValue="1") int id,
			@SessionAttribute(value="loginMember",required=false) TMember member){
		TProject project=pbiz.findProjectById(id);
		int day=pbiz.getRemainDays(id);
		int remainDay=Integer.parseInt(project.getDeploydate())-day;
		if(member==null){
			model.addAttribute("isFollow", 0);
		}else{
			if(fbiz.getIfFollow( member.getId(),id)){
				model.addAttribute("isFollow", 1);
			}else{
				model.addAttribute("isFollow", 0);
			}
		}
		model.addAttribute("remainDay", remainDay);
		model.addAttribute("ret", rbiz.selectByProjectid(id));
		model.addAttribute("project", project);
		return "front/project/project";
	}
	
	@RequestMapping("index")
	private String index(Model model){
		System.out.println(pbiz.findAll());
		model.addAttribute("types", pbiz.findAll());
		return "front/project/index";
	}
}

