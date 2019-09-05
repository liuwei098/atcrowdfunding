package com.yc.atcrowdfunding.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.biz.FollowBiz;
import com.yc.atcrowdfunding.vo.Result;

@Controller
public class FollowController {
	@Resource
	private FollowBiz fbiz;
	
	@RequestMapping("followProject")
	@ResponseBody
	public Result followProject(int id,@SessionAttribute(value="loginMember",required=false) TMember member){
		Result result=new Result();
		if(member==null){
			result.setCode(-1);
			result.setMessage("请先登录！！");
			return result;
		}
		result=fbiz.follow(id, member.getId());
		
		return result;
	}
	
	@RequestMapping("cancelFollow")
	@ResponseBody
	public Result cancelFollow(int id,@SessionAttribute(value="loginMember",required=false) TMember member){
		Result result=new Result();
		try{
			result=fbiz.follow(id, member.getId());
			result.setObj(fbiz.getProjectByMemberid(member.getId()));
			result.setCode(1);
		}catch(RuntimeException e){
			result.setCode(0);
			result.setMessage("服务器忙，稍后再试!!!");
		}
		return result;
	}
}
