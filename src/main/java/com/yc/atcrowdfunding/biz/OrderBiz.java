package com.yc.atcrowdfunding.biz;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yc.atcrowdfunding.bean.TOrder;
import com.yc.atcrowdfunding.bean.TOrderExample;
import com.yc.atcrowdfunding.bean.TProjectType;
import com.yc.atcrowdfunding.bean.TProjectTypeExample;
import com.yc.atcrowdfunding.bean.TReturn;
import com.yc.atcrowdfunding.bean.TType;
import com.yc.atcrowdfunding.dao.TOrderMapper;
import com.yc.atcrowdfunding.dao.TProjectTypeMapper;
import com.yc.atcrowdfunding.util.DateUtil;
import com.yc.atcrowdfunding.vo.Result;

@Service
public class OrderBiz {
	@Autowired
	private TOrderMapper om;
	
	@Resource
	private ProjectBiz pbiz;
	@Resource
	private ProjectTypeBiz ptbiz;
	@Resource
	private ReturnBiz rbiz;
	@Resource TProjectTypeMapper tptm;
	public TOrder selectById(int id){
		return om.selectByPrimaryKey(id);
	}
	
	//点击支持之后插入订单
	public TOrder updateState(int projectid,int retid,int money,int memberid,String ordernum){
		TOrder order=new TOrder();
		order.setProjectid(projectid);
		order.setMemberid(memberid);
		order.setReturnid(retid);
		order.setMoney(money);
		order.setStatus("0");
		order.setOrdernum(ordernum);
		order.setCreatedate(DateUtil.formatDate(new Date()));
		om.insertSelective(order);
		return order;
	}
	
	//查找以往的订单的收货信息
	public List<TOrder> findByMemberid(Integer id) {
		TOrderExample example=new TOrderExample();
		example.createCriteria().andMemberidEqualTo(id);
		return om.selectByExample(example);
	}
	
	@Transactional
	public TOrder updateAddress(TOrder order) {
		om.updateByPrimaryKeySelective(order);
		order=om.selectByPrimaryKey(order.getId());
		return order;
	}
	
	@Transactional
	public void updateMoney(String id){
		TOrder order=new TOrder();
		order.setId(Integer.parseInt(id));
		order.setStatus("2");
		System.out.println(order);
		order=om.selectByPrimaryKey(Integer.parseInt(id));
		om.updateByPrimaryKeySelective(order);
		System.out.println(order+"========");
		System.out.println(rbiz);
		System.out.println(order.getReturnid());
		rbiz.updateMoney(order.getReturnid(), order.getMoney());
		pbiz.updateMoney(order.getProjectid(), order.getMoney());
	}

	public Result findByTerm(Integer id, String status) {
		Result result=new Result();
		TOrderExample example=new TOrderExample();;
		if(!status.equals("-1")){
			if(status.equals("0")){
				example.createCriteria().andMemberidEqualTo(id).andStatusEqualTo(status);
			}else{
				example.createCriteria().andMemberidEqualTo(id).andStatusEqualTo("1");
				example.or().andMemberidEqualTo(id).andStatusEqualTo("2");
			}
		}else{
			System.out.println("进来了");
			example.createCriteria().andMemberidEqualTo(id);
		}
		List<TOrder> list=om.selectByExample(example);
		result.setObj(list);
		return result;
	}

	public void cancelOrder(int id) {
		om.deleteByPrimaryKey(id);
		
	}

	public void conOrdfirmer(int id) {
		TOrder order=new TOrder();
		order.setId(id);
		order.setStatus("2");
		om.updateByPrimaryKeySelective(order);
		
	}

	public TOrder findOrderById(int id) {
		return om.selectByPrimaryKey(id);
		
	}

	public Result findMoneyByType() {
		Result result=new Result();
		List<TType> typeList=ptbiz.findAll1();
		List<Integer> moneys=new ArrayList<>();
		List<TProjectType> projectTypes=null;
		List<TOrder> orders=null;
		for(TType type:typeList){
			TProjectTypeExample example=new TProjectTypeExample();
			example.createCriteria().andTypeidEqualTo(type.getId());
			projectTypes=tptm.selectByExample(example);
			int money=0;
			for(TProjectType projectType:projectTypes){
				TOrderExample orderExample=new TOrderExample();
				orderExample.createCriteria().andProjectidEqualTo(projectType.getProjectid());
				orders=om.selectByExample(orderExample);
				
				for(TOrder order:orders){
					money+=order.getMoney();
				}
				
			}
			moneys.add(money);
		}
		result.setObj(moneys);
		return result;
		
	}

	public Result findRetMoney() {
		Result result=new Result();
		List<Integer> moneys=new ArrayList<>();
		int money1=0;
		int money2=0;
		List<TOrder> list=om.selectByExample(null);
		for(TOrder order:list){
			if(order.getRet().getType().equals("0")){
				money1+=order.getMoney();
			}else{
				money2+=order.getMoney();
			}
		}
		moneys.add(money1);
		moneys.add(money2);
		result.setObj(moneys);
		return result;
	}

	public Result getMonthMoney() {
		Result result=new Result();
		List<Integer> profits=new ArrayList<>();
		
		for(int month=1;month<=12;month++ ){
			String month1;
			if(month<10){
				month1="0"+month;
			}else{
				month1=month+"";
			}
			System.out.println(month1);
			Integer money=om.selectMoneyByMonth(month1);
			if(money==null){
				money=0;
			}
			System.out.println(money);
			profits.add(money);
		}
		result.setObj(profits);
		return result;
	}
}
