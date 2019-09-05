package com.yc.atcrowdfunding;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.yc.atcrowdfunding.biz.OrderBiz;
import com.yc.atcrowdfunding.biz.ProjectBiz;
import com.yc.atcrowdfunding.biz.ReturnBiz;

@RunWith(SpringRunner.class)
@SpringBootTest
public class OrderTest {
	@Resource
	private OrderBiz obiz;
	
	@Resource
	private ReturnBiz rbiz;
	@Resource
	private ProjectBiz pbiz;
	@Test
	public void testUpdateMoney(){
		System.out.println(pbiz.selectByMemberid(1, "-1"));
	}
}
