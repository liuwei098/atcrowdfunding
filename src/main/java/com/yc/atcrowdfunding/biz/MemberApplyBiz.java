package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;


import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.bean.TMemberExample;
import com.yc.atcrowdfunding.dao.TMemberMapper;
import com.yc.atcrowdfunding.vo.Result;

/**
 * 会员实名认证Biz类
 * @author chm
 *
 */
@Service
public class MemberApplyBiz {
	@Resource
	private  TMemberMapper tm;
	//改变实名认证状态
	public void chageAuthstatus(TMember member, HttpSession session){
		member.setAuthstatus("1");
		TMember loginMember=(TMember) session.getAttribute("loginMember");
		if(loginMember==null){
			member.setId(1);
		}else{
			member.setId(loginMember.getId());
		}
		tm.updateByPrimaryKeySelective(member);
	}
	
	//检查信息是否重复
	public Result checkRepeat(String name,String value){
		Result result=new Result();
		TMemberExample example=new TMemberExample();
		List<TMember> list=null;
		int count=0;
		
		//检验身份证号码
		if("cardnum".equals(name)){
			example.createCriteria().andCardnumEqualTo(value);
			list=tm.selectByExample(example);
			if(null != list && !list.isEmpty()){
				result.setMessage("身份证已被注册");
				count=1;
			}
		}
		
		//检验电话号码
		if("tel".equals(name)){
			example.createCriteria().andTelEqualTo(value);
			list=tm.selectByExample(example);
			if(null != list && !list.isEmpty()){
				result.setMessage("电话已被注册");
				count=1;
			}
		}
		result.setCode(count);
		
		return result;
	}
}
