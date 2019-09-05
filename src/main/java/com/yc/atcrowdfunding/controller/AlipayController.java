package com.yc.atcrowdfunding.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.bean.TOrder;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.bean.TReturn;
import com.yc.atcrowdfunding.biz.OrderBiz;
import com.yc.atcrowdfunding.biz.ProjectBiz;
import com.yc.atcrowdfunding.biz.ReturnBiz;
import com.yc.atcrowdfunding.vo.Result;

@Controller
public class AlipayController {
	@Resource
	private OrderBiz obiz;
	@Resource
	private ProjectBiz pbiz;
	@Resource
	private ReturnBiz rbiz;
	
	
	@RequestMapping("alipay")
	public String AliPay(Model model){
		return "front/alipay/alipay";
	}
	
	@RequestMapping("alipay.trade.close")
	public String AlipayTradeClose(){
		return "front/alipay/alipay.trade.close";
	}
	
	@RequestMapping("alipay.trade.fastpay.refund.query")
	public String AlipayTradeQuery(){
		return "front/alipay/alipay.trade.fastpay.refund.query";
	}
	
	@RequestMapping("alipay.trade.page.pay")
	public String AlipayTradePage(){
		return "front/alipay/alipay_trade_page_pay";
	}
	
	@RequestMapping("alipay.trade.refund")
	public String AlipayTradeRefund(){
		return "front/alipay/alipay.trade.refund";
	}
	
	@RequestMapping("notify_url")
	public String notifyUrl(){
		return "front/alipay/notify_url";
	}
	
	@RequestMapping("return_url")
	public String returnUrl(){
		return "front/alipay/return_url";
	}
	
	
	@RequestMapping("pay-step1")
	public String PayStep1(Model model,@RequestParam(defaultValue="1") int projectid,int returnid){
		TProject project=pbiz.findProjectById(projectid);
		model.addAttribute("ret", rbiz.selectById(returnid));
	/*	System.out.println(project);*/
		model.addAttribute("project",project );
		return "front/alipay/pay_step1";
	}
	
	@RequestMapping("pay-step-2")
	public String PayStep2(int retid,Model model,@SessionAttribute("loginMember") TMember member){
		List<TOrder> list=obiz.findByMemberid(member.getId());
		Set<TOrder> info=new HashSet<>();
	
		//去除重复的收货地址
		for(TOrder order:list){
			if(order.getAddress()!=null && order.getInvoictitle()!=null && order.getRemark()!=null){
				info.add(order);
			}
		}
		
		System.out.println(info.size());
		model.addAttribute("memberInfo",info);
		model.addAttribute("order", obiz.selectById(retid));
		return "front/alipay/pay_step2";
	}
	
	@RequestMapping("insert_order")
	@ResponseBody
	public Result PayStep2(@RequestParam(defaultValue="1") int projectid,int retid,int money,String ordernum,
			@SessionAttribute(value="loginMember",required=false) TMember member){
		Result result=new Result();
		try{
			System.out.println(money);
			TOrder order=obiz.updateState(projectid, retid, money,member.getId(),ordernum);
			result.setCode(order.getId());
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务繁忙，稍后再试！！！");
		}
		return result;
	}
	
	@RequestMapping("payOrder")
	public String payOrder(Model model,TOrder order){
		order=obiz.updateAddress(order);
		model.addAttribute("order", order);
		return AliPay(model);
	}
	
}
