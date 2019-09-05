package com.yc.atcrowdfunding.biz;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yc.atcrowdfunding.bean.TAdvertisement;
import com.yc.atcrowdfunding.bean.TAdvertisementExample;
import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.bean.TTypeExample;
import com.yc.atcrowdfunding.bean.TUser;
import com.yc.atcrowdfunding.bean.User;
import com.yc.atcrowdfunding.dao.TAdvertisementMapper;
import com.yc.atcrowdfunding.dao.TUserMapper;
import com.yc.atcrowdfunding.vo.Result;

@Service
public class AdvertisementBiz {
	
	@Resource
	private TAdvertisementMapper tam;
	
	@Resource
	private TUserMapper tum;

	/**
	 * 查询广告
	 */
	public Result select(int pageNum,int pageSize,String name) {
		TAdvertisementExample example=null;
		if(name!=null && !"".equals(name)){
			example=new TAdvertisementExample();
			example.createCriteria().andNameLike("%"+name+"%");
		}
		Page<TAdvertisement> page=PageHelper.startPage(pageNum, pageSize);
		List<TAdvertisement> list=tam.selectByExample(example);
		//根据状态码写入状态
		for(int i=0;i<list.size();i++){
			if("0".equals(list.get(i).getStatus())){
				list.get(i).setStatus("草稿");
			}else if("1".equals(list.get(i).getStatus())){
				list.get(i).setStatus("未审核");
			}else if("2".equals(list.get(i).getStatus())){
				list.get(i).setStatus("已审核");
			}else if("3".equals(list.get(i).getStatus())){
				list.get(i).setStatus("已发布");
			}
		}
		Result result=new Result();
		int total=(int) page.getTotal();
		result.setPage(pageNum);
		result.setTotal(total);
		//判断当前页删除之后是否没有数据了，如果没有，回到前一页
		if(pageNum!=1){
			if(total%pageSize==0){
				page=PageHelper.startPage(pageNum-1, pageSize);
				list= tam.selectByExample(example);
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
	 * 删除
	 * @param id
	 */
	@Transactional
	public void delete(String ids) {
		String s[]=ids.split(",");
		for(String id:s){
			tam.deleteByPrimaryKey(Integer.parseInt(id));
		}
	}
	
	/**
	 * 新增项目分类
	 * @param ttype
	 */
	public int addAdv(TAdvertisement adv) {
		String tname=adv.getName();
		if(tname!=null){
			TAdvertisementExample example=new TAdvertisementExample();
			example.createCriteria().andNameEqualTo(tname);
			List<TAdvertisement> list=tam.selectByExample(example);
			if(list.size()==0){
				int i=tam.insert(adv);
				return i;
			}
			return 0;
		}
		return -1;
	}

	public Result selectUser() {
		Result result=new Result();
		List<TUser> list=tum.selectByExample(null);
		result.setObj(list);
		result.setCode(200);
		return result;
	}

	@Transactional
	public int updateAdv(TAdvertisement adv){
		TAdvertisementExample example=new TAdvertisementExample();
		example.createCriteria().andIdEqualTo(adv.getId());
		int result=tam.updateByExample(adv, example);
		return result;
	}
}
