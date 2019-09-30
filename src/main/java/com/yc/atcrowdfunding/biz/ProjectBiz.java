package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.bean.TMemberExample;
import com.yc.atcrowdfunding.bean.TParamExample;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.bean.TProjectExample;
import com.yc.atcrowdfunding.bean.TProjectTagExample;
import com.yc.atcrowdfunding.bean.TProjectType;
import com.yc.atcrowdfunding.bean.TProjectTypeExample;
import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.dao.TMemberMapper;
import com.yc.atcrowdfunding.dao.TProjectMapper;
import com.yc.atcrowdfunding.dao.TProjectTypeMapper;
import com.yc.atcrowdfunding.dao.TTypeMapper;
import com.yc.atcrowdfunding.vo.Result;
/**
 * 项目业务类
 * @author Administrator
 *
 */
@Service
public class ProjectBiz {
	@Resource
	private TProjectMapper tpm;
	@Resource
	private TTypeMapper ptm;
	@Resource 
	private TProjectTypeMapper tptm;
	@Resource
	private SendMailService mailService;
	@Resource
	TMemberMapper tmm;
	//根据ID查找项目
	public TProject findProjectById(int id){
		return tpm.selectByPrimaryKey(id);
	}
	
	//计算还有多少天结束
	public int  getRemainDays(int id){
		return (int) tpm.getRemainDay(id);
	}
	
	public void updateMoney(int id,int money){
		TProject project=tpm.selectByPrimaryKey(id);
		project.setSupportmoney(project.getSupportmoney()+money);
		project.setSupporter(project.getSupporter()+1);
		tpm.updateByPrimaryKeySelective(project);
	}
	
	public List<TProject> selectByMemberid(int memberid,String status){
		TProjectExample example=new TProjectExample();
		if(status.equals("-1")){
			System.out.println(6666+"=====");
			example.createCriteria().andMemberidEqualTo(memberid);
		}
		else{
			example.createCriteria().andMemberidEqualTo(memberid).andStatusEqualTo(status);
		}
		List<TProject> list= tpm.selectByExample(example);
		return list;
	}
	
	public List<TType> findAll(){
		return ptm.selectByExample(null);
	}
	
	@Transactional
	public void addProject(TProject project,String typeid){
		tpm.insertSelective(project);
		String ids[]=typeid.split(",");
		TProjectType projectType=new TProjectType();
		projectType.setProjectid(project.getId());
		for(String id:ids){
			projectType.setTypeid(Integer.parseInt(id));
			tptm.insert(projectType);
		}
	}

	public void updateStatus(String projectid) {
		TProject project=new TProject();
		project.setId(Integer.parseInt(projectid));
		project.setStatus("0");
		tpm.updateByPrimaryKeySelective(project);
		
	}
	@Transactional
	public void updateProject(TProject project, String typeid) {
		tpm.updateByPrimaryKeySelective(project);
		String ids[]=null;
		TProjectType projectType=new TProjectType();
		projectType.setProjectid(project.getId());
		TProjectTypeExample example=new TProjectTypeExample();
	
		if(!"".equals(typeid) && typeid!=null){
			example.createCriteria().andProjectidEqualTo(project.getId());
			tptm.deleteByExample(example);
			 ids=typeid.split(",");
			 for(String id:ids){
				projectType.setTypeid(Integer.parseInt(id));
				tptm.insert(projectType);
			}
		}
	}

	public Result findByStatus(int pageNum, int pageSize) {
		TProjectExample example=new TProjectExample();
		Page<TMember> page=PageHelper.startPage(pageNum,pageSize);
		example.createCriteria().andStatusEqualTo("0");
		List<TProject> list= tpm.selectByExample(example);
		Result result=new Result();
		result.setObj(list);
		int total=(int) page.getTotal();
		result.setTotal(total);
		result.setPage(pageNum);
		result.setTotalPage( total%pageSize==0 ? total/pageSize:((total/pageSize)+1));
		return result;
	}
	
	//实名验证成功，向会员发送邮件
		@Transactional
		public void reviewSuccess(int id,String email,int projectid){
			TMember member=tmm.selectByPrimaryKey(id);
			String content="【众筹网】,尊敬的会员:"+member.getLoginacct()+",您的项目审核已经通过审核,从现在起可以筹款了";
			mailService.SendReviewMail(content, email, "众筹网项目审核成功通知");
			TProject project=tpm.selectByPrimaryKey(projectid);
			project.setStatus("1");
			tpm.updateByPrimaryKeySelective(project);
		}
		
		//验证失败
		public void reviewFail(int id, String email, String reason,int projectid) {
			TMember member=tmm.selectByPrimaryKey(id);
			String content="【众筹网】,尊敬的会员:"+member.getLoginacct()+",您的项目验证未经过审核，失败原因如下\n"+reason;
			mailService.SendReviewMail(content, email, "众筹网项目审核审核失败通知");
			TProject project=tpm.selectByPrimaryKey(projectid);
			project.setStatus("9");
			tpm.updateByPrimaryKeySelective(project);
			
		}
}
