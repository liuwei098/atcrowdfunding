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
import com.yc.atcrowdfunding.util.MD5Util;
import com.yc.atcrowdfunding.vo.Result;

@Service
public class MemberBiz {
	@Resource
	private TMemberMapper tmm;
	@Resource
	private SendMailService mailService;
	
	@Resource
	private MD5Util util;
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
	
	//验证失败
	public void reviewFail(int id, String email, String reason) {
		TMember member=tmm.selectByPrimaryKey(id);
		String content="【众筹网】,尊敬的会员:"+member.getLoginacct()+",您的实名验证未经过审核，失败原因如下\n"+reason;
		mailService.SendReviewMail(content, email, "众筹网实名认证审核失败通知");
		member.setAuthstatus("0");
		tmm.updateByPrimaryKeySelective(member);
		
	}

	public Result findByKeyWord(String keyword,int pageNum,int pageSize) {
		TMemberExample example=new TMemberExample();
		example.createCriteria().andLoginacctLike("%"+keyword+"%");
		example.or().andCardnumLike("%"+keyword+"%");
		example.or().andRealnameLike("%"+keyword+"%");
		example.or().andLoginacctLike("%"+keyword+"%");
		Page<TMember> page=PageHelper.startPage(pageNum, pageSize);
		List<TMember> list= tmm.selectByExample(example);
		Result result=new Result();
		result.setObj(list);
		int total=(int) page.getTotal();
		result.setTotal(total);
		result.setPage(pageNum);
		result.setTotalPage( total%pageSize==0 ? total/pageSize:((total/pageSize)+1));
		return result;
	}

	public Result login(String loginacct, String password) {
		TMemberExample example=new TMemberExample();
		password=util.string2MD5(loginacct+password);
		example.createCriteria().andLoginacctEqualTo(loginacct).andUserpswdEqualTo(password);
		List<TMember> list=tmm.selectByExample(example);
		Result result=new Result();
		if(list==null || list.isEmpty()){
			result.setCode(0);
			result.setMessage("用户名或者密码错误");
			return result;
		}
		result.setCode(1);
		result.setObj(list.get(0));
		return result;
	}
	
	public void register(TMember member){
		member.setUsername("  ");
		member.setAuthstatus("0");
		member.setUserpswd(util.string2MD5(member.getUserpswd()));
		tmm.insertSelective(member);
	}
	
}
