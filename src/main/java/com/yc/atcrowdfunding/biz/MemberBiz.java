package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.bean.TMemberExample;
import com.yc.atcrowdfunding.dao.TMemberMapper;
import com.yc.atcrowdfunding.vo.Result;

@Service
public class MemberBiz {
	@Resource
	private TMemberMapper tmm;
	@Resource
	private SendMailService mailService;
	//查询所有未实名验证的会员
	public Result findReviewMember(int pageNum,int pageSize){
		TMemberExample example=new TMemberExample();
		Page<TMember> page=PageHelper.startPage(pageNum,pageSize);
		example.createCriteria().andAuthstatusEqualTo("1");
		List<TMember> list= tmm.selectByExample(example);
		Result result=new Result();
		result.setObj(list);
		int total=(int) page.getTotal();
		result.setTotal(total);
		result.setPage(pageNum);
		result.setTotalPage( total%pageSize==0 ? total/pageSize:((total/pageSize)+1));
		return result;
	}
	
	//根据id查找会员
	public TMember findById(int id){
		return tmm.selectByPrimaryKey(id);
	}
	
	//实名验证成功，向会员发送邮件
	@Transactional
	public void reviewSuccess(int id,String email){
		TMember member=tmm.selectByPrimaryKey(id);
		String content="【众筹网】,尊敬的会员:"+member.getLoginacct()+",您的实名验证已经通过审核,从现在起可以发起众筹了";
		mailService.SendReviewMail(content, email, "众筹网实名认证成功通知");
		member.setAuthstatus("2");
		tmm.updateByPrimaryKeySelective(member);
		
	}
}
