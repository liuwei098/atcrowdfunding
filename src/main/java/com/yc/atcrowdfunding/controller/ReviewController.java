package com.yc.atcrowdfunding.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.bean.TPermission;
import com.yc.atcrowdfunding.biz.MemberBiz;
import com.yc.atcrowdfunding.biz.PermissionBiz;
import com.yc.atcrowdfunding.vo.Result;

/**
 * 业务审核控制类
 * @author 谌涣谋
 *
 */
@Controller
public class ReviewController {
	
	@Resource
	private PermissionBiz pbiz;
	
	
	@Resource
	MemberBiz mbiz;
	@ModelAttribute("menus")
	public  List<TPermission> init(HttpSession session){
		return  pbiz.findAllMenu();
		 
	}
	
	@RequestMapping("auth_cert")
	public String AuthCert(Model model,@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="5") int pageSize){
		Result result=mbiz.findReviewMember(page, pageSize);
		model.addAttribute("result", result);
		return "review/auth_cert";
	}
	
	//根据id查询实名认证会员的信息
	@RequestMapping("reviewMember")
	public String reviewMember(int id,Model model){
		TMember member=mbiz.findById(id);
		model.addAttribute("member",member);
		return "review/member_review";
	}
	
	@RequestMapping("search_member")
	public String reviewMember(String keyword,Model model,
			@RequestParam(defaultValue="1") int page,@RequestParam(defaultValue="5") int pageSize){
		Result result=mbiz.findByKeyWord(keyword,page,pageSize);
		model.addAttribute("result", result);
		return "review/auth_cert";
	}
	
	
	
	//实名验证成功向会员发送邮件提示
	@RequestMapping("member_review_success")
	@ResponseBody
	public Result Success(int id,String email){
	
		Result result=new Result();
		try{
			mbiz.reviewSuccess(id, email);
			result.setCode(1);
			result.setMessage("实名验证成功！");
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙,稍后再试！！");
		}
		return result;
	}
	
	//实名验证失败，获取失败原因向会员发送邮件提示
		@RequestMapping("member_review_fail")
		@ResponseBody
		public Result Fail(int id,String email,String reason){
		
			Result result=new Result();
			try{
				mbiz.reviewFail(id, email,reason);
				result.setCode(1);
				result.setMessage("操作成功！");
			}catch(RuntimeException e){
				e.printStackTrace();
				result.setCode(0);
				result.setMessage("服务器繁忙,稍后再试！！");
			}
			return result;
		}
}
