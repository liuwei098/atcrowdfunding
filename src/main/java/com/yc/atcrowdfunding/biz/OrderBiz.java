package com.yc.atcrowdfunding.biz;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yc.atcrowdfunding.bean.TOrder;
import com.yc.atcrowdfunding.bean.TOrderExample;
import com.yc.atcrowdfunding.dao.TOrderMapper;
import com.yc.atcrowdfunding.util.DateUtil;
import com.yc.atcrowdfunding.vo.Result;

@Service
public class OrderBiz {
	@Resource
	private TOrderMapper om;
	
	@Resource
	private ProjectBiz pbiz;
	
	@Resource
	private ReturnBiz rbiz;
	
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
		om.updateByPrimaryKeySelective(order);
		System.out.println(order+"========");
		order=om.selectByPrimaryKey(Integer.parseInt(id));
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
}
