package com.yc.atcrowdfunding.controller;

import javax.annotation.Resource;
import javax.print.DocFlavor.READER;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.biz.ProjectBiz;
import com.yc.atcrowdfunding.biz.ProjectTypeBiz;
import com.yc.atcrowdfunding.biz.ProjectsBiz;
import com.yc.atcrowdfunding.vo.Result;

@Controller
public class ProjectsController {
	@Resource
	private ProjectsBiz pbiz;
	@Resource
	private ProjectTypeBiz tbiz;
	@Resource
	private ProjectTypeBiz ptbiz;
	//此变量暂时没用
	private final String PATH="D:/blog/";
	@RequestMapping("projects")
	private String projects(Model model,@RequestParam(defaultValue="1") int page,@RequestParam(defaultValue="8") int pageSize){
		System.out.println(pbiz.findByPage(page,pageSize));
		model.addAttribute("projects", pbiz.findByPage(page,pageSize));
		model.addAttribute("path",PATH);
		int total=pbiz.findTotal();
		model.addAttribute("total", total);
		Result result=new Result();
		result.setPageSize(8);
		result.setPage(page);
		result.setTotal(total);
		result.setTotalPage(total%pageSize==0 ? total/pageSize:((total/pageSize)+1));
		result.setMessage("projects");
		model.addAttribute("result", result);
		
		model.addAttribute("typeList",ptbiz.findAll1());
		return "front/project/projects";
	}
	
	//根据条件查询
	@RequestMapping("projects_findByterm")
	@ResponseBody
	private Result findByTerm(String tid,int order,String status,@RequestParam(defaultValue="1") int page,@RequestParam(defaultValue="8") int pageSize){
		/**
		 * status -1:综合  0:即将开始  1:众筹中  2：众筹成功
		 * order 0:即将开始   1：最新上线   2：金额最多   3：支持最多
		 */
		Result result=new Result();
		try{
			result=pbiz.findByTerm(Integer.parseInt(tid), order, status, page,pageSize);
			result.setCode(200);
			result.setMessage("search");
		}catch(RuntimeException e){
			result.setCode(500);
			result.setMessage("服务器繁忙，请稍后再试！！！");
		}
		return result;
	}
	
	@RequestMapping("serachProjects")
	@ResponseBody
	private Result searchProjects(String searchKeyWord,@RequestParam(defaultValue="1") int page){
		/**
		 * status -1:综合  0:即将开始  1:众筹中  2：众筹成功
		 * order 0:即将开始   1：最新上线   2：金额最多   3：支持最多
		 */
		System.out.println(searchKeyWord);
		Result result=new Result();
		result=pbiz.searchProjects(searchKeyWord);
		return result;
	}
}
