package com.yc.atcrowdfunding.controller;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.annotation.MultipartConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.yc.atcrowdfunding.bean.TMember;
import com.yc.atcrowdfunding.bean.TProject;
import com.yc.atcrowdfunding.bean.TReturn;
import com.yc.atcrowdfunding.biz.FollowBiz;
import com.yc.atcrowdfunding.biz.MemberBiz;
import com.yc.atcrowdfunding.biz.ProjectBiz;
import com.yc.atcrowdfunding.biz.ProjectTypeBiz;
import com.yc.atcrowdfunding.biz.ReturnBiz;
import com.yc.atcrowdfunding.vo.Result;

@Controller
public class ProjectConroller {
	@Resource
	private ProjectBiz pbiz;
	@Resource
	private ReturnBiz rbiz;	
	@Resource
	private FollowBiz fbiz;
	@Resource
	private ProjectTypeBiz ptbiz;
	@Resource
	private MemberBiz mbiz;
	 
	@RequestMapping("project")
	private String project(Model model,@RequestParam(defaultValue="1") int id,
			@SessionAttribute(value="loginMember",required=false) TMember member){
		TProject project=pbiz.findProjectById(id);
		int day=pbiz.getRemainDays(id);
		int remainDay=Integer.parseInt(project.getDeploydate())-day;
		if(member==null){
			model.addAttribute("isFollow", 0);
		}else{
			if(fbiz.getIfFollow( member.getId(),id)){
				model.addAttribute("isFollow", 1);
			}else{
				model.addAttribute("isFollow", 0);
			}
		}
		model.addAttribute("remainDay", remainDay);
		model.addAttribute("ret", rbiz.selectByProjectid(id));
		model.addAttribute("project", project);
		return "front/project/project";
	}
	
	@RequestMapping("index")
	private String index(Model model){
		System.out.println(pbiz.findAll());
		model.addAttribute("types", pbiz.findAll());
		return "front/project/index";
	}
	
	@RequestMapping("start")
	private String start(Model model){
		return "front/project/start";
	}
	
	@RequestMapping("start-step1")
	private String startStep1(Model model){
		model.addAttribute("types", ptbiz.findAll());
		return "front/project/start-step1";
	}
	
	@RequestMapping("start-step2")
	private String startStep2(Model model){
		return "front/project/start-step2";
	}
	
	@RequestMapping("start-step3")
	private String startStep3(Model model){
		return "front/project/start-step3";
	}
	
	@RequestMapping("start-step4")
	private String startStep4(Model model){
	
		return "front/project/start-step4";
	}
	
	@PostMapping("upload")
	@ResponseBody
	public String upload(@RequestParam("upload") MultipartFile file,
			@RequestParam("CKEditorFuncNum") String callback
			) throws IllegalStateException, IOException{
		System.out.println("进来了");
		String fileName=file.getOriginalFilename();
		fileName=UUID.randomUUID().toString().substring(0,8)+fileName;
		File dest=new File("D:/blog/img/"+fileName);
		file.transferTo(dest);
		StringBuffer sb=new StringBuffer();
		sb.append("<script type=\"text/javascript\">");
		sb.append("window.parent.CKEDITOR.tools.callFunction(" + callback
           + ",'"  +"img/"+fileName+ "','')");
		sb.append("</script>");
		return sb.toString();
	}
	
	@RequestMapping("project_add")
	public String addProject(Model model,String typeid,String details,String name,String remark,
			long money,int day,int flag,int id
			,String deploydate,@RequestParam("titleimg") MultipartFile file,@SessionAttribute("loginMember")TMember member) throws IllegalStateException, IOException{
		System.out.println(typeid);
		System.out.println(file.getOriginalFilename());
		TProject project=new TProject();
		if(file.getOriginalFilename().equals("")==false){
			String fileName=UUID.randomUUID().toString().substring(0,8)+file.getOriginalFilename();
			File dest=new File("D:/blog/img/"+fileName);
			file.transferTo(dest);
			project.setTitleimg(fileName);
		}
		
		project.setDetails(details);
		project.setDay(day);
		project.setMoney(money);
		project.setDeploydate(deploydate);
		project.setRemark(remark);
	
		project.setName(name);
		project.setStatus("9");
		project.setSupporter(0);
		project.setSupportmoney(0L);
		project.setFollower(0);
		project.setCreatetime(new Date());
		project.setMemberid(member.getId());
		if(id>0){
			project.setId(id);
		}
		if(flag==0){
			pbiz.addProject(project, typeid);
		}else{
			pbiz.updateProject(project, typeid);
		}
		return "redirect:start-step2?projectid="+project.getId();
	}
	
	@RequestMapping("findAllRet")
	@ResponseBody
	public Result findAllRet(int projectid){
		Result result=new Result();
		result.setObj(rbiz.selectByProjectid(projectid));
		return result;
	}
	
	@RequestMapping("deleteRet")
	@ResponseBody
	public Result deleteRet(int id){
		Result result=new Result();
		try{
			rbiz.deleteRetById(id);
			result.setCode(1);
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
	@RequestMapping("updateRet")
	@ResponseBody
	public Result updateRet(TReturn ret){
		System.out.println(ret.getFreight());
		System.out.println(ret);
		Result result=new Result();
		try{
			rbiz.updateRetById(ret);
			result.setCode(1);
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
	@RequestMapping("addRet")
	@ResponseBody
	public Result addRet(TReturn ret){
		Result result=new Result();
		try{
			rbiz.addRet(ret);
			result.setCode(1);
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
	@RequestMapping("start_checkInfo")
	@ResponseBody
	public Result checkInfo(String introduce,String cardnum,String projectid){
		Result result=new Result();
		try{
			result=mbiz.checkCardnum(introduce,cardnum,projectid);
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
	@RequestMapping("start_findProject")
	@ResponseBody
	public Result startFindProject(int id){
		Result result=new Result();
		try{
			TProject project=pbiz.findProjectById(id);
			result.setCode(1);
			result.setObj(project);
		}catch(RuntimeException e){
			e.printStackTrace();
			result.setCode(0);
			result.setMessage("服务器繁忙，稍后再试!!!");
		}
		return result;
	}
	
	
}

