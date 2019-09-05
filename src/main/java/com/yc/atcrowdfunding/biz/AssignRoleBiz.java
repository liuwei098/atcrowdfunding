package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yc.atcrowdfunding.bean.TRole;
import com.yc.atcrowdfunding.bean.TRoleExample;
import com.yc.atcrowdfunding.bean.TUserRole;
import com.yc.atcrowdfunding.bean.TUserRoleExample;
import com.yc.atcrowdfunding.dao.TRoleMapper;
import com.yc.atcrowdfunding.dao.TUserRoleMapper;

@Service
@MapperScan("com.yc.atcrowdfunding")
public class AssignRoleBiz {

	@Resource
	private TRoleMapper trm;
	
	@Resource
	private TUserRoleMapper turm;
	
	//查询所有的角色
	public  List<TRole> findAllRole() {
		return trm.selectByExample(null);
	}
	
	//根据用户id查询用户所拥有的id
	public  List<TRole> findUserRoleById(Integer id) {

		//trm.getUserRole(id);
		return trm.getUserRole(id);
	}
	
	//给用户添加角色
	@Transactional
	public void addUserRole(String ids,Integer uid) {
		 
		if( ids.contains(",")) {
			String[] splitId = ids.split(",");
			for (String str : splitId) {
				TUserRole urole =new TUserRole();
				int i = Integer.parseInt(str);
				urole.setRoleid(i);
				urole.setUserid(uid);
				turm.insertSelective(urole);
			}
		}else {
			TUserRole urole =new TUserRole();
			int i = Integer.parseInt(ids);
			urole.setRoleid(i);
			urole.setUserid(uid);
			turm.insertSelective(urole);
		}
	}
	
	//给用户 移除角色
	public void removeUserRole(String ids,Integer uid) {
		if( ids.contains(",")) {
			String[] splitId = ids.split(",");
			for (String str : splitId) {
				int i = Integer.parseInt(str);
				TUserRoleExample example = new TUserRoleExample();
				example.createCriteria().andRoleidEqualTo(i).
						andUseridEqualTo(uid);
				turm.deleteByExample(example);
			}
		}
	}
	
}
