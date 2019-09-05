package com.yc.atcrowdfunding.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.biz.OrderBiz;
import com.yc.atcrowdfunding.biz.ProjectBiz;
import com.yc.atcrowdfunding.vo.Result;

@Controller
public class OrderController {
	@Resource
	private OrderBiz obiz;
	@Resource
	private ProjectBiz pbiz;
	@RequestMapping("findOrderByTerm")
	@ResponseBody
	public Result findOrderByTerm(@SessionAttribute("loginMember") TMember member,String status){
		Result result=obiz.findByTerm(member.getId(),status);
		return result;
	}
	
	@RequestMapping("cancelOrder")
	@ResponseBody
	public Result cancelOrder(int id){
		Result result=new Result();
		try{
			obiz.cancelOrder(id);
			result.setCode(1);
			result.setMessage("取消订单成功");
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
	@RequestMapping("confirmOrder")
	@ResponseBody
	public Result confirmOrder(int id){
		Result result=new Result();
		try{
			obiz.conOrdfirmer(id);
			result.setCode(1);
			result.setMessage("确认回报成功");
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
	@RequestMapping("findProjectByTerm")
	@ResponseBody
	public Result findProjectByTerm(@SessionAttribute("loginMember") TMember member,String status){
		Result result=new Result();
		try{
			result.setCode(1);
			result.setObj(pbiz.selectByMemberid(member.getId(), status));
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
}
