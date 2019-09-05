package com.yc.atcrowdfunding.biz;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yc.atcrowdfunding.bean.TMemberProjectFollow;
import com.yc.atcrowdfunding.bean.TMemberProjectFollowExample;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.dao.TMemberProjectFollowMapper;
import com.yc.atcrowdfunding.dao.TProjectMapper;
import com.yc.atcrowdfunding.vo.Result;


@Service
public class FollowBiz {
	@Resource
	private TMemberProjectFollowMapper mpfm;
	@Resource
	private ProjectBiz pbiz;
	@Resource
	private TProjectMapper tpm;
	//用户点击关注按钮，关注过再点则-1  否则+1
	
	@Transactional
	public Result follow(int projectid,int memberid){
		Result result=new Result();
		TMemberProjectFollowExample example=new TMemberProjectFollowExample();
		example.createCriteria().andProjectidEqualTo(projectid).andMemberidEqualTo(memberid);
		List<TMemberProjectFollow> list=mpfm.selectByExample(example);
		TProject project=tpm.selectByPrimaryKey(projectid);
		TMemberProjectFollow follow=new TMemberProjectFollow();
		follow.setMemberid(memberid);
		follow.setProjectid(projectid);
		if(list==null ||list.isEmpty()){
			project.setFollower(project.getFollower()+1);
			result.setCode(1);
			mpfm.insertSelective(follow);
		/*	follow=new TMemberProjectFollow();
			follow.setMemberid(memberid);
			follow.setProjectid(projectid);
			follower=mpfm.updateByExampleSelective(follow, example);*/
		}else{
			result.setCode(0);
			project.setFollower(project.getFollower()-1);
			mpfm.deleteByExample(example);
		}
		tpm.updateByPrimaryKeySelective(project);
		result.setObj(project.getFollower());
		
		return result;
	}
	
	public boolean getIfFollow(int memberid,int projectid){
		TMemberProjectFollowExample example=new TMemberProjectFollowExample();
		example.createCriteria().andProjectidEqualTo(projectid).andMemberidEqualTo(memberid);
		List<TMemberProjectFollow> list=mpfm.selectByExample(example);
		System.out.println(list.size());
		if(list==null ||list.isEmpty()){
			return false;
		}
		return true;
	}

	
	public List<TProject> getProjectByMemberid(Integer memberid) {
		TMemberProjectFollowExample example=new TMemberProjectFollowExample();
		example.createCriteria().andMemberidEqualTo(memberid);
		List<TMemberProjectFollow> list= mpfm.selectByExample(example);
		List<TProject> projects=new ArrayList<>();
		for(TMemberProjectFollow follow:list){
			int id=follow.getProjectid();
			projects.add(pbiz.findProjectById(id));
		}
		return projects;
	}
		
	
	
	

}
