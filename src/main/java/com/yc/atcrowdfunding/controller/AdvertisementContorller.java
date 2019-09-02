package com.yc.atcrowdfunding.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.yc.atcrowdfunding.bean.TAdvertisement;
import com.yc.atcrowdfunding.bean.TPermission;
import com.yc.atcrowdfunding.biz.AdvertisementBiz;
import com.yc.atcrowdfunding.biz.PermissionBiz;
import com.yc.atcrowdfunding.vo.Result;


@Controller
public class AdvertisementContorller {

	@Resource
	private PermissionBiz pbiz;
	
	@Resource
	private AdvertisementBiz abiz;
	
	//全局变量 存储图片上传路径
	private String mynewpic;
	
	@ModelAttribute("menus")
	public  List<TPermission> init(HttpSession session){
		return  pbiz.findAllMenu();
	}
	
	/**
	 * 展示广告的首页，查询
	 */
	@RequestMapping("advertisement")
	public String toAdv(@RequestParam(defaultValue="1") int pageNum,@RequestParam(defaultValue="5") int pageSize,
			String name,Model model){
		Result result=abiz.select(pageNum,pageSize,name);
		model.addAttribute("result",result);
		return "bizmanager/auth_adv";
	}
	
	/**
	 * 删除操作
	 */
	@PostMapping("deleteAdv")
	@ResponseBody
	public Result deleteType(String ids){
		Result result=new Result();
		try{
			abiz.delete(ids);
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
	 * 新增操作 ajax提交post请求
	 */
	@PostMapping("addAdv")
	@ResponseBody
	public Result doAdd(TAdvertisement adv,Model model){
		adv.setStatus("3");
		adv.setIconpath(mynewpic);
		abiz.addAdv(adv);
		Result result=new Result();
		result.setMessage("success");
		return result;
	}

	/**
	 * 查询所有用户名
	 */
	@PostMapping("selectUser")
	@ResponseBody
	public Result selectUser(String id){
		Result result=abiz.selectUser();
		return result;
	}
	
	@RequestMapping("uploadImg")
	@ResponseBody
    public void uploadFile(MultipartFile iconpath,Model model)
            throws IllegalStateException, IOException {
        // 原始图片名称
        String oldFileName = iconpath.getOriginalFilename(); // 获取上传文件的原名
        File dest=new File("d:/blog/upload/"+oldFileName);
        // 将内存中的数据写入磁盘
        iconpath.transferTo(dest);
        // 将路径名存入全局变量mynewpic
        mynewpic = "/upload/"+oldFileName;
        model.addAttribute("data", mynewpic);
        //return mynewpic;
    }
	
	/**
	 * 修改操作
	 */
	@PostMapping("updateAdv")
	@ResponseBody
	public Result updateType(TAdvertisement adv,Model model){
		Result result=new Result();
		try{
			abiz.updateAdv(adv);
			result.setMessage("success");
		}catch(RuntimeException e){
			e.printStackTrace();
		}
		return result;
	}
}
