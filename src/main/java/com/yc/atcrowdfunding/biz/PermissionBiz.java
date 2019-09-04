package com.yc.atcrowdfunding.biz;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;

import com.yc.atcrowdfunding.bean.TPermission;
import com.yc.atcrowdfunding.bean.TRolePermission;
import com.yc.atcrowdfunding.bean.TRolePermissionExample;
import com.yc.atcrowdfunding.dao.TPermissionMapper;
import com.yc.atcrowdfunding.dao.TRolePermissionMapper;


@Service
@MapperScan("com.yc")
public class PermissionBiz {
	
	@Resource
	private TPermissionMapper tm;
	
	@Resource
	private TRolePermissionMapper trpm;
	
	public List<TPermission> findAllMenu(){
		List<TPermission> root = new ArrayList<TPermission>();
		List<TPermission> childredPermissons = tm.selectByExample(null);
		System.out.println(childredPermissons);
		Map<Integer,TPermission> map = new HashMap<Integer,TPermission>();
		for (TPermission innerTPermission : childredPermissons) {
			map.put(innerTPermission.getId(), innerTPermission);
		}
		for (TPermission TPermission : childredPermissons) { //100
			//通过子查找父
			//子菜单
			TPermission child = TPermission ; //假设为子菜单
			if(child.getPid() == 0 ){
				root.add(TPermission);
			}else{
				//父节点
				TPermission parent = map.get(child.getId());
				parent.getChilds().add(child);
			}
		}
		root.sort( (TPermission p1,TPermission p2)->{return p1.getId()- p2.getId();}  );//lamda表达式 对root进行排序
		return root;

	}
	
	
	//返回所有的权限
	public List<TPermission> getPermissions(){
		return tm.selectByExample(null);
	}


	//查询角色对应的权限
	public List<TPermission> getRolePer(Integer rid) {
		
		return tm.getRolePer(rid);
	}


	public boolean updatePermission(String pids, Integer rid) {
		
		//删除当前角色所有的权限
		TRolePermissionExample example = new TRolePermissionExample();
		example.createCriteria().andRoleidEqualTo(rid);
		trpm.deleteByExample(example);
		
		//新增角色
		
		String[] split = pids.split(",");
		 
		if(split !=null && split.length>=1) {
		 
			for (String string : split) {
				System.out.println("权限啊=="+string);
				//int i = Integer.parseInt(string);
				System.out.println("-------权限id-------------"+Integer.parseInt(string));
				TRolePermission permission = new TRolePermission();
				//设置角色id
				permission.setRoleid(rid);
				//设置权限id
				permission.setPermissionid(Integer.parseInt(string));
				//保存角色权限关系
				trpm.insert(permission);
			 
			}
			return true;
		}
	 return false;
	}
	
}
