package com.yc.atcrowdfunding.controller;

import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.biz.MemberApplyBiz;
import com.yc.atcrowdfunding.biz.SendMailService;
import com.yc.atcrowdfunding.vo.Result;
/**
 * 会员实名认证控制类 
 * @author chm
 *
 */
@Controller
public class MemberApplyServlet {
	@Resource
	private SendMailService mailService;
	
	@Resource
	private MemberApplyBiz mabiz;
	
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
	
	
	//将实名认证的信息存入session
	@RequestMapping("pushMemberInfo")
	@ResponseBody
	public Result pushInfo(String realname,String cardnum,String tel,String cutomtel,String introduce, 
			String describe,HttpSession session,String accttype){
		System.out.println(realname);
		TMember member=new TMember();
		member.setRealname(realname);
		member.setCardnum(cardnum);
		member.setTel(tel);
		member.setCutomtel(cutomtel);
		member.setIntroduce(introduce);
		member.setDescribe1(describe);
		Result result=new Result();
		member.setAccttype(accttype);
		session.setAttribute("memberInfo", member);
		System.out.println(member);
		return result;
	}
	
	//将认证相片上传 并且把路径存入session
	@RequestMapping("pushIconpath")
	public String pushIconPath(@RequestParam("iconpath") MultipartFile iconpath,HttpSession session){
		String name=iconpath.getOriginalFilename();
		String path=UUID.randomUUID().toString().substring(0,9)+name;
		TMember member=(TMember) session.getAttribute("memberInfo");
		if(member==null){
			member=new TMember();
		}
		member.setIconpath(path);
		System.out.println(path);
		session.setAttribute("memberInfo", member);
		return "redirect:member_apply-3";
	}
	
	//向认证邮箱发送验证码
	@RequestMapping("member_sendEmail")
	@ResponseBody
	public Result sendMail(String email,HttpSession session){
		Result result=new Result();
		try{
			String emailCode=mailService.sendEmail(email, "众筹网实名验证验证码");
			session.setAttribute("emailCode", emailCode);
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(500);
			result.setMessage("服务器繁忙，稍后再试！！！");
		}
		return result;
	}
	
	//判断申请时填写的验证码是否与服务器发的一致
	@RequestMapping("apply_checkEmailCode")
	@ResponseBody
	public Result checkApplyEmailCode(String code,HttpSession session){
		Result result=new Result();
		try{
			String emailCode=(String) session.getAttribute("emailCode");
			if(code.equals(emailCode)){
				result.setCode(1);
				result.setMessage("申请已完成，请等待后台审核，一般会在3~5个工作日完成！点击确定跳回个人中心");
			}else{
				result.setCode(0);
				result.setMessage("验证码输入不正确！");
			}
			TMember member=(TMember) session.getAttribute("memberInfo");
			mabiz.chageAuthstatus(member,session);
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(500);
			result.setMessage("服务器繁忙，稍后再试！！！");
		}
		return result;
	}
}
