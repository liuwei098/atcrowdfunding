package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yc.atcrowdfunding.bean.TUser;
import com.yc.atcrowdfunding.bean.TUserExample;
import com.yc.atcrowdfunding.dao.TUserMapper;
import com.yc.atcrowdfunding.vo.Result;

@Service
@MapperScan("com.yc")
public class UserBiz {

	@Resource
	private TUserMapper tum;
	
	
	/**
	 * 当name为空时 表示查找所有的用户，当name不为空时，根据用户名查找指定的用户，可模糊查询
	 * @param pageNum
	 * @param pageSize
	 * @param name
	 * @return
	 */
	public Result findAllUser(int pageNum,int pageSize,String name) {
		TUserExample example = null;
		if(name!=null && !"".equals(name)) {
			example = new TUserExample();
			example.createCriteria().andUsernameLike("%"+name+"%");
		}
		Page<TUser> page=PageHelper.startPage(pageNum, pageSize);
		List<TUser> tList=tum.selectByExample(example);
		Result result=new Result();
		int total=(int) page.getTotal();
		result.setPage(pageNum);
		result.setTotal(total);
		result.setTotalPage(   total%pageSize==0 ? total/pageSize:((total/pageSize)+1) );
		result.setObj(tList);
		return result;
		 
	}
	
	
	//根据用户id 删除指定用户
	@Transactional
	public void deleteUserById(String uids) {
		System.out.println("----"+uids);
		String uisd[] = uids.split(",");
		for (String i : uisd) {
			System.out.println("=="+i);
			//tum.deleteByPrimaryKey(Integer.parseInt(i));
		}
	}
	
}
