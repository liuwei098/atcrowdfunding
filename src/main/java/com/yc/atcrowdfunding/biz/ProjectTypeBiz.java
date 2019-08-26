package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.bean.TTypeExample;
import com.yc.atcrowdfunding.dao.TTypeMapper;

/**
 * 项目分类Biz类
 * @author Administrator
 *
 */
@Service
public class ProjectTypeBiz {
	@Resource
	private TTypeMapper tm;
	
	//项目总览页面根据分类查找项目，page用于滚动加载
	public List<TType> findByTerm(Integer id,int page,int pageSize){
		TTypeExample example=null;
		if(id!=null){
			example=new TTypeExample();
			example.createCriteria().andIdEqualTo(id);
		}
		//PageHelper.startPage(1, 4);
		List <TType> list= tm.selectByExample(example);
		
		return list;
	}
}
