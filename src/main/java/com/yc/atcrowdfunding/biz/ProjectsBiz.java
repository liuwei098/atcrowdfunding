package com.yc.atcrowdfunding.biz;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.annotation.Resource;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.bean.TProjectExample;
import com.yc.atcrowdfunding.bean.TProjectExample.Criteria;

import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.dao.TProjectMapper;

import com.yc.atcrowdfunding.vo.Result;

@Service
@MapperScan("com.yc")
/**
 * 项目总览Biz类
 * @author chccc
 *
 */
public class ProjectsBiz {
	@Resource
	private TProjectMapper tm;
	@Resource
	private ProjectTypeBiz ptbiz;
	//查找所有分页的项目，在众筹总览界面展示
	public List<TProject> findByPage(int page,int pageSize){
		List<TProject> list = null;
		TProjectExample example=null;
		//PageHelper.startPage(page, pageSize);
		list=tm.selectByExample(example);
		
		return list;
	}
	
	//根据关键字查询项目
	public Result searchProjects(String keyWord){
		Result result=new Result();
		TProjectExample example=null;
		if(!"".equals(keyWord)){
			example=new TProjectExample();
			example.createCriteria().andNameLike("%"+keyWord.trim()+"%");
		}
		result.setObj(tm.selectByExample(example));
		return result;
	}
	
	
	//查找项目的个数
	public int  findTotal(){
		return tm.countByExample(null);
	}
	
	//查询满足条件的项目
	public Result findByTerm(int tid,int order,String status,int page,int pageSize){
		/**
		 * status 众筹状态  -1:综合  0:即将开始  1:众筹中  2：众筹成功
		 * order 排序方式      0:即将开始   1：最新上线   2：金额最多   3：支持最多
		 */
		Result result=new Result();
		List<TProject> projects=null;
		System.out.println(tid);
		if(tid==-1){
			/*list=ptbiz.findByTerm(tid, page);*/
			projects=(findByPage(page,pageSize));
		}else{
			List<TType> list=ptbiz.findByTerm(tid, page,pageSize);
			
			//判断是否为空，不为空获取当前分类下的所有项目
			if(list!=null && !list.isEmpty()){
				projects=list.get(0).getProjectList();
			}
		}
	
		System.out.println(projects+"======");
		if(projects!=null){
			switch (order) {
			case 1:
				projects.sort((TProject t1,TProject t2)->{
					Calendar c1=Calendar.getInstance();
					c1.setTime(t1.getCreatetime());
					Calendar c2=Calendar.getInstance();
					c2.setTime(t2.getCreatetime());
					if(c2.before(c1)){
						return -1;
					}
					return 1;
				} );  //lamda表达式排序
				break;
			case 2:
				projects.sort((TProject t1,TProject t2)->{return (int) (t2.getMoney()-t1.getMoney());} );
				break;
			case 3:
				projects.sort((TProject t1,TProject t2)->{return t2.getSupporter()-t1.getSupporter();} );
			default:
				break;
			}
		}
		System.out.println(projects+"======");
		List<TProject> projectss=new ArrayList<TProject>();
		System.out.println(status);
		if(!"-1".equals(status)){
			for(TProject project:projects){
				if(project.getStatus().equals(status)){
					projectss.add(project);
					
				}
			}
		}else{
			projectss=projects;
		}
		
		System.out.println();
		System.out.println(projectss+"======");
		result.setObj(projectss);
		System.out.println(result.getObj());
		return result;
		
	}
}
