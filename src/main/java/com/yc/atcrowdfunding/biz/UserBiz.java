package com.yc.atcrowdfunding.biz;

import java.util.Date;
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
		if(name!=null && !"".equals(name.trim())) {
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
	
	//查询已注册 的登录账号
	public List<TUser> selectLoginacct(String loginacct) {
		TUserExample example = new  TUserExample();
		example.createCriteria().andLoginacctEqualTo(loginacct);
		 
		return tum.selectByExample(example);
		
	}
	
	
	//根据用户id 删除指定用户
	@Transactional
	public void deleteUserById(String ids) {
		 System.out.println("----"+ids); 
		String uisd[] = ids.split(",");
		for (String i : uisd) {
			/* System.out.println("=="+i); */
			tum.deleteByPrimaryKey(Integer.parseInt(i));
		}
	}
	
	//根据指定id 修改用户信息
	@Transactional
	public void updateUserById(String id,String username,String email) {
		TUser tu = new TUser();
		tu.setId(Integer.parseInt(id));
		tu.setEmail(email);
		tu.setUsername(username);
		System.out.println("用户id 的是"+id);
		TUserExample example = new TUserExample();
		example.createCriteria().andIdEqualTo(Integer.parseInt(id));
		tum.updateByExampleSelective(tu, example);
	}
	
	
	//添加用户信息
	public void insertUserX(String loginacct,String username,String password,String email) {
		
		TUser tu = new TUser();
		tu.setLoginacct(loginacct);
		tu.setUsername(username);
		tu.setUserpswd(password);
		tu.setEmail(email);
		tu.setCreatetime(new Date());
		
		tum.insertSelective(tu);
	}
	
}
 
