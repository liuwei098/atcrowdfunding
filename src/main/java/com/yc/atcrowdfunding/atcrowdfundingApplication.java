package com.yc.atcrowdfunding;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
 
@SpringBootApplication
public class atcrowdfundingApplication extends SpringBootServletInitializer{
	
	public static void main(String[] args) {
		SpringApplication.run(atcrowdfundingApplication.class, args);
	}
	
/*	@Override
	protected void addResourceHandlers(ResourceHandlerRegistry c) {
		//c.addResourceHandler("/usr/local/blog");
		//c.addResourceHandler("D:/blog/");
		super.addResourceHandlers(c);
	}*/
	 
}
