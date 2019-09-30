package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yc.atcrowdfunding.bean.TMemberProjectFollowExample;
import com.yc.atcrowdfunding.bean.TReturn;
import com.yc.atcrowdfunding.bean.TReturnExample;
import com.yc.atcrowdfunding.dao.TReturnMapper;
import com.yc.atcrowdfunding.vo.Result;

@Service
public class ReturnBiz {
	@Resource
	private TReturnMapper trm;
	public TReturn selectById(int id){
		return trm.selectByPrimaryKey(id);
	}
	public List<TReturn> selectByProjectid(int id) {
		TReturnExample example=new TReturnExample();
		example.createCriteria().andProjectidEqualTo(id);
		return trm.selectByExample(example);
	}
	
	public void updateMoney(int id,int money){
		TReturn ret=trm.selectByPrimaryKey(id);
		ret.setCount(ret.getCount()+1);
		trm.updateByPrimaryKeySelective(ret);
	}
	public void deleteRetById(int id) {
		trm.deleteByPrimaryKey(id);
	}
	public void updateRetById(TReturn ret) {
		ret.setCount(0);	
		trm.updateByPrimaryKeySelective(ret);
	}
	public void addRet(TReturn ret) {
		ret.setCount(0);
		trm.insertSelective(ret);
	}
	
	
}
