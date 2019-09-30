package com.yc.atcrowdfunding.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.bean.TTypeExample;
import com.yc.atcrowdfunding.dao.TTypeMapper;
import com.yc.atcrowdfunding.util.RedisUtil;
import com.yc.atcrowdfunding.vo.Result;

/**
 * 项目分类Biz类
 * @author Administrator
 *
 */
@Service
public class ProjectTypeBiz {
	@Resource
	private TTypeMapper tm;
	@Resource
	private RedisUtil util;
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
	
	/**
	 * 查找所有项目分类，name可以根据名字模糊查询
	 * @Author lw
	 */
	public Result find(int pageNum,int pageSize,String name){
		TTypeExample example=null;
		if(name!=null && !"".equals(name)){
			example=new TTypeExample();
			example.createCriteria().andNameLike("%"+name+"%");
		}
		Page<TType> page=PageHelper.startPage(pageNum, pageSize);
		List<TType> list=tm.selectByExample(example);
		Result result=new Result();
		int total=(int) page.getTotal();
		result.setPage(pageNum);
		result.setTotal(total);
		//判断当前页删除之后是否没有数据了，如果没有，回到前一页
		if(pageNum!=1){
			if(total%pageSize==0){
				page=PageHelper.startPage(pageNum-1, pageSize);
				list= tm.selectByExample(example);
				total=(int) page.getTotal();
				result.setTotal((int) total);
				result.setPage(pageNum-1);
			}
		}
		result.setTotalPage(   total%pageSize==0 ? total/pageSize:((total/pageSize)+1) );
		result.setObj(list);
		return result;
	}

	/**
	 * 新增项目分类
	 * @param ttype
	 */
	public int addTType(TType ttype) {
		String tname=ttype.getName();
		if(tname!=null){
			TTypeExample example=new TTypeExample();
			example.createCriteria().andNameEqualTo(tname);
			List<TType> list=tm.selectByExample(example);
			if(list.size()==0){
				int i=tm.insert(ttype);
				return i;
			}
			return 0;
		}
		long length=util.lGetListSize("types");
		if(length!=0){
			for(int i=0;i<length;i++){
				util.del("atcrowdfundingtype"+util.lGetIndex("types", i));
			}
		}
		util.del("types");
		return -1;
	}
	
	/**
	 * 删除分类
	 * @param id
	 */
	@Transactional
	public void delete(String ids) {
		String s[]=ids.split(",");
		for(String id:s){
			tm.deleteByPrimaryKey(Integer.parseInt(id));
		}
		long length=util.lGetListSize("types");
		if(length!=0){
			for(int i=0;i<length;i++){
				util.del("atcrowdfundingtype"+util.lGetIndex("types", i));
			}
		}
		util.del("types");
	}
	
	/**
	 * 修改分类
	 * @param id 
	 */
	@Transactional
	public int updateType(TType ttype){
		TTypeExample example=new TTypeExample();
		example.createCriteria().andIdEqualTo(ttype.getId());
		int result=tm.updateByExample(ttype, example);
		long length=util.lGetListSize("types");
		if(length!=0){
			for(int i=0;i<length;i++){
				util.del("atcrowdfundingtype"+util.lGetIndex("types", i));
			}
		}
		util.del("types");
		return result;
	}
	
	public List<TType> findAll(){
		List<TType> list=new ArrayList<TType>();
		list= tm.selectByExample(null);
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<TType> findAll1(){
		List<TType> list=new ArrayList<TType>();
		long length=util.lGetListSize("types");
		if(length!=0){
			System.out.println("进来了");
			Map<Object, Object> result=util.hmget("atcrowdfundingtype"+util.lGetIndex("types", 0));
			if(result!=null && !result.isEmpty()){
				for(int i=0;i<length;i++){
					TType type=new TType();
					Map<Object, Object> ret=util.hmget("atcrowdfundingtype"+util.lGetIndex("types", i));
					type.setId((int)ret.get("id"));
					type.setName((String)ret.get("name"));
					type.setRemark((String)ret.get("remark"));
					list.add(type);
				}
			}
			return list;
		}
		list= tm.selectByExample(null);
		System.out.println(list);
		Map<String, Object> map=new HashMap<>();
		for(TType type:list){
			util.lSet("types", type.getId());
			RedisUtil.typeids.add(type.getId());
			map.put("id", type.getId());
			map.put("name", type.getName());
			map.put("remark", type.getRemark());
			util.hmset("atcrowdfundingtype"+type.getId(),map);
		}
		System.out.println("=========="+RedisUtil.typeids+"==========");
		 /*del key atcrowdfundingtype9 atcrowdfundingtype5 atcrowdfundingtype4 atcrowdfundingtype3 atcrowdfundingtype2 atcrowdfundingtype1*/
		return list;
	}
}
 