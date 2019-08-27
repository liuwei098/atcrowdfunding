package com.yc.atcrowdfunding.biz;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;


import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.dao.TMemberMapper;

/**
 * 会员实名认证Biz类
 * @author chm
 *
 */
@Service
public class MemberApplyBiz {
	@Resource
	private  TMemberMapper tm;
	
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
}
