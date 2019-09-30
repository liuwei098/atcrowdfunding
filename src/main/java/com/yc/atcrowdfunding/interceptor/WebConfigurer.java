package com.yc.atcrowdfunding.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.yc.atcrowdfunding.bean.TPermission;
import com.yc.atcrowdfunding.biz.PermissionBiz;

@Configuration
public class WebConfigurer implements WebMvcConfigurer {
	 @Resource
	 PermissionBiz pbiz;
	 @Override
	 public void addInterceptors(InterceptorRegistry registry) {
		 
        // 拦截所有请求，通过判断是否有 @LoginRequired 注解 决定是否需要登录
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/minecrowdfunding");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/pay-step1");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/pay-step2");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/pay-step3");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/start");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/start-step1");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/start-step2");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/start-step3");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/start-step4");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member_accttype");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member_apply-4");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member_apply-3");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member_apply-2");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member_apply-1");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member_check_repeat");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/pushMemberInfo");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/pushIconpath");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member_getimgae");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/member_sendEmail");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/apply_checkEmailCode");
        registry.addInterceptor(LoginInterceptor()).addPathPatterns("/orderDetail");
        
        registry.addInterceptor(LoginUserInterceptor()).addPathPatterns("/main");
        registry.addInterceptor(PayHandler()).addPathPatterns("/pay-step1");
       /* List<TPermission> list=pbiz.getPermissions();
        for(TPermission permission:list){
        	if(permission.getUrl().equals("main")){
        		list.remove(permission);
        		break;
        	}
        }
        for(TPermission permission:list){
        	registry.addInterceptor(AccessInterceptor()).addPathPatterns("/"+permission.getUrl());
        }*/
	 }
	 
	 @Bean
	 public LoginInterceptor LoginInterceptor() {
		 return new LoginInterceptor();
	 }
	 
	 @Bean
	 public LoginInterceptor AuthorityInterceptor() {
		 return new LoginInterceptor();
	 }
	 
	 @Bean
	 public PayHandler PayHandler() {
		 return new PayHandler();
	 }
	 
	 @Bean
	 public PayHandler AuthorityInterceptor1() {
		 return new PayHandler();
	 }
	 
	 @Bean
	 public LoginUserInterceptor LoginUserInterceptor(){
		 return new LoginUserInterceptor();
	 }
	 
	 @Bean
	 public LoginUserInterceptor AuthorityInterceptor2(){
		 return new LoginUserInterceptor();
	 }
	 
	 @Bean
	 public AccessInterceptor AccessInterceptor(){
		 return new AccessInterceptor();
	 }
	 
	 @Bean
	 public AccessInterceptor AuthorityInterceptor3(){
		 return new AccessInterceptor();
	 }
}