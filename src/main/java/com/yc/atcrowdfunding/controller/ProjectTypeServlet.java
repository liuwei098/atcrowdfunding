package com.yc.atcrowdfunding.controller;


import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.biz.ProjectTypeBiz;
import com.yc.atcrowdfunding.vo.Result;

@Controller
public class ProjectTypeServlet {
	
	@Resource
	private ProjectTypeBiz ptb;
	
	/**
	 * 分页查询所有项目分类
	 * @param pageNum 
	 * @param pageSize
	 * @param name
	 * @param model
	 * @return
	 */
	@RequestMapping("project_type")
	public String ProjectType(@RequestParam(defaultValue="1") int pageNum,@RequestParam(defaultValue="5") int pageSize,
			String name,Model model){
		Result result=ptb.find(pageNum, pageSize, name);
		model.addAttribute("result", result);
		return "bizmanager/projectType";
	}
	
	/**
	 * 跳转到新增页面
	 */
	@RequestMapping("form")
	public String addType(){
		return "bizmanager/form";
	}
	
	/**
	 * 新增操作 form表单提交post请求
	 */
	@PostMapping("doAdd")
	public String doAdd(TType ttype,Model model){
		Result result=new Result();
		int reval=ptb.addTType(ttype);
		if(reval==0){
			result.setMessage("您输入的类型名已经存在");
			model.addAttribute("result", result);
			return "bizmanager/form";
		}else if(reval==-1){
			result.setMessage("系统繁忙，请稍后再试");
			model.addAttribute("result", result);
			return "bizmanager/form";
		}else{
			result.setMessage("新增成功！！！");
		}
		return ProjectType(1,5,null,model);
	}
	
	/**
	 * 删除操作
	 */
	@PostMapping("deleteType")
	@ResponseBody
	public Result deleteType(String ids){
		Result result=new Result();
		try{
			ptb.delete(ids);
			result.setCode(200);
			result.setMessage("删除成功");
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(500);
			result.setMessage("服务器繁忙，稍后再试！！");
		}
		return result;
	}
	
	/**
	 * 修改操作
	 */
	public String updateType(){
		return "";
	}
}
