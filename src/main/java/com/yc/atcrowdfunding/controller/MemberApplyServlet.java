package com.yc.atcrowdfunding.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
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
	
	//检验信息是否重复
	@RequestMapping("member_check_repeat")
	@ResponseBody
	public Result CheckRepeat(String name,String value){
		Result result=mabiz.checkRepeat(name, value);
		return result;
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
		//随机生成一段字符串与文件名拼接 防止重名
		String path=UUID.randomUUID().toString().substring(0,9)+name;
		File dest=new File("D:/blog/"+path);
		try {
			iconpath.transferTo(dest);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		TMember member=(TMember) session.getAttribute("memberInfo");
		if(member==null){
			member=new TMember();
		}
		member.setIconpath(path);
		System.out.println(path);
		session.setAttribute("memberInfo", member);
		return "redirect:member_apply-3";
	}
	
	//获取照片，用于上一步时显示资质图片
	@RequestMapping("member_getimgae")
	@ResponseBody
	public String getMemberImage(HttpSession session){
		TMember member=(TMember) session.getAttribute("memberInfo");
		if(member==null){
			member=new TMember();
		}
		String path=member.getIconpath();
		return path;
	}
	
	//向认证邮箱发送验证码
	@RequestMapping("member_sendEmail")
	@ResponseBody
	public Result sendMail(String email,HttpSession session){
	
		Result result=new Result();
		try{
			if("".equals(email)){
				email=(String) session.getAttribute("applyEmail");
			}else{
				session.setAttribute("applyEmail", email);
			}
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(500);
			result.setMessage("服务器繁忙，稍后再试！！！");
		}
		
		//以下代码是判断离上一次发送验证码距离了多久时间
		
		Calendar calendar=Calendar.getInstance();//获取当前时间
		//如果还没发送过验证码就直接返回0
		if(session.getAttribute("codeTime")==null){
			//发送验证码
			String emailCode=mailService.sendEmail(email, "众筹网实名验证验证码");
			session.setAttribute("emailCode", emailCode);
			session.setAttribute("codeTime", calendar);
			result.setCode(0);
			return result;
		}
		//获取上一次发送验证码的时间
		Calendar codeTime=(Calendar) session.getAttribute("codeTime");
		int codeSecond=codeTime.get(Calendar.SECOND);//上一次的秒数
		int codeMinute=codeTime.get(Calendar.MINUTE);//上一次的分钟数
		int nowSecond=calendar.get(Calendar.SECOND);//当前秒数
		int nowMinute=calendar.get(Calendar.MINUTE);//当前分钟数
		int second=0;
		
		/**
		 * 判断离上一次验证码发送隔了多久时间
		 * 
		 */
		if( (nowMinute-codeMinute==1 || nowMinute-codeMinute==0) && nowSecond<codeSecond){
			
			second=nowSecond+60-codeSecond;
			
		}
		else if( (nowMinute==codeMinute) && nowSecond>codeSecond && nowSecond-codeSecond!=60 ){
			
			second=nowSecond-codeSecond;
			
		}else{
			session.removeAttribute("codeTime");
			//发送验证码
			String emailCode=mailService.sendEmail(email, "众筹网实名验证验证码");
			session.setAttribute("emailCode", emailCode);
		}
		result.setCode(60-second);
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
