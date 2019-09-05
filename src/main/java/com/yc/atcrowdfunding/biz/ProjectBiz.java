package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yc.atcrowdfunding.bean.TParamExample;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.bean.TProjectExample;
import com.yc.atcrowdfunding.bean.TProjectType;
import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.dao.TProjectMapper;
import com.yc.atcrowdfunding.dao.TProjectTypeMapper;
import com.yc.atcrowdfunding.dao.TTypeMapper;
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
}
