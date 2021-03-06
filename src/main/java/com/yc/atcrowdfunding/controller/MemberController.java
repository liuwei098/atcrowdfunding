package com.yc.atcrowdfunding.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.biz.FollowBiz;
import com.yc.atcrowdfunding.biz.MemberBiz;
import com.yc.atcrowdfunding.biz.OrderBiz;
import com.yc.atcrowdfunding.biz.ProjectBiz;
import com.yc.atcrowdfunding.biz.ReturnBiz;
import com.yc.atcrowdfunding.vo.Result;

@Controller
public class MemberController {
	@Resource
	private MemberBiz mbiz;
	@Resource
	private ProjectBiz pbiz;
	@Resource
	private FollowBiz fbiz;
	@Resource
	private OrderBiz obiz;
	@RequestMapping("member_tologin")
	public String login(){
		return "front/member/login";
	}
	
	@RequestMapping("member_login")
	@ResponseBody
	public Result memberLogin(String loginacct,String password,String code,HttpSession session){
		String piccode=(String) session.getAttribute("piccode");
		Result result=new Result();
		if(!piccode.equalsIgnoreCase(code)){
			result.setCode(0);
			result.setMessage("验证码错误");
			return result;
		}
		try{
			result=mbiz.login(loginacct,password);
			session.setAttribute("loginMember", result.getObj());
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("系统繁忙，稍后再试！！！");
		}
		return result;
	}
	
	@RequestMapping("minecrowdfunding")
	public String minecrowdfunding(Model model,@SessionAttribute("loginMember") TMember member){
		model.addAttribute("followProjects", fbiz.getProjectByMemberid(member.getId()));
		model.addAttribute("addProjects", pbiz.selectByMemberid(member.getId(),"-1"));
		model.addAttribute("orders", obiz.findByMemberid(member.getId()));
		return "front/member/minecrowdfunding";
	}
	
	@RequestMapping("member_toreg")
	public String toreg(){
		return "front/member/reg";
	}
	
	/*@RequestMapping("member_reg")
	@ResponseBody
	public Result reg(String loginacct,String password,String email,String code,String usertype){
		Result result=new Result();
		return result;
	}*/
	
	@RequestMapping("member_reg")
	@ResponseBody
	public Result reg(String loginacct,String password,String email,String usertype,String code,@SessionAttribute("piccode") String piccode){
		Result result=new Result();
		if(!piccode.equalsIgnoreCase(code)){
			result.setCode(0);
			result.setMessage("验证码不正确");
			return result;
		}
		TMember member=new TMember();
		member.setLoginacct(loginacct);
		member.setUserpswd(password);
		member.setEmail(email);
		member.setUsertype(usertype);
		try{
			mbiz.register(member);
			result.setCode(1);
			result.setMessage("注册成功");
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试");
		}
		return result;
	}
	
	@RequestMapping("member_logout")
	public String logout(HttpSession session){
		session.removeAttribute("loginMember");
		return "redirect:member_tologin";
	}
	
	@RequestMapping("member_findPwd")
	public String findPwd(HttpSession session){
		session.removeAttribute("loginMember");
		return "front/member/findPwd";
	}
	
	@RequestMapping("member_toupdatePwd")
	public String toupdatePwd(HttpSession session){
		return "front/member/updatePwd";
	}
	
	@RequestMapping("findPwd_sendEmail")
	@ResponseBody
	public Result sendMail(String email,HttpSession session){
		Result result=new Result();
		try{
			result=mbiz.findByEmail(email,session);
		}catch(RuntimeException e){
			result.setCode(500);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
	@RequestMapping("member_updatePwd")
	@ResponseBody
	public Result updatePwd(int id,String password){
		Result result=new Result();
		try{
			mbiz.updatePwdById(id, password);
			result.setCode(1);
			result.setMessage("修改密码成功,去登陆吧");
		}catch(RuntimeException e){
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("findPwd_checkCode")
	@ResponseBody
	public Result checkCode(String code,@SessionAttribute("emailCode") String emailCode){
		Result result=new Result();
		if(!emailCode.equals(code)){
			result.setCode(0);
			result.setMessage("验证码错误");
		}
		result.setCode(1);
		return result;
	}
}
