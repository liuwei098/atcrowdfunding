package com.yc.atcrowdfunding.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberServlet {
	
	//跳转个人中心
	@RequestMapping("member")
	public String Member(){
		return "front/member/member";
	}
	
	@RequestMapping("member_accttype")
	public String  Accttype(){
		return "front/member/accttype";
	}
	
	@RequestMapping("member_apply-1")
	public String  Apply1(){
		return "front/member/apply-1";
	}
	
	@RequestMapping("member_apply-2")
	public String  Apply2(){
		return "front/member/apply-2";
	}
	
	@RequestMapping("member_apply-3")
	public String  Apply3(){
		return "front/member/apply-3";
	}
	
	@RequestMapping("member_apply-4")
	public String  Apply4(){
		return "front/member/apply-4";
	}
	
	
}
