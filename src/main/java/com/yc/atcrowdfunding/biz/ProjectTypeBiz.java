package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.bean.TTypeExample;
import com.yc.atcrowdfunding.dao.TTypeMapper;
import com.yc.atcrowdfunding.vo.Result;

@Service
public class ProjectTypeBiz {
	@Resource
	private TTypeMapper tm;
	public TType findByTerm(Integer id){
		TTypeExample example=null;
		if(id!=null){
			example=new TTypeExample();
			example.createCriteria().andIdEqualTo(id);
		}
		List <TType> list= tm.selectByExample(example);
		if(list!=null &&  !list.isEmpty()){
			return list.get(0);
		}
		return null;
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
		System.out.println(tname);
		if(tname!=null){
			TTypeExample example=new TTypeExample();
			example.createCriteria().andNameEqualTo(tname);
			List<TType> list=tm.selectByExample(example);
			System.out.println(list);
			if(list.size()==0){
				int i=tm.insert(ttype);
				return i;
			}
			return 0;
		}
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
	}
}
