package com.yc.atcrowdfunding.biz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
/**
 * 邮箱发送业务类
 * @author Administrator
 *
 */
@Service
public class SendMailService {
	@Autowired
	private JavaMailSender javaMailSender;
	@Value("${mail.fromMail.addr}")
	private String from;
	//发送验证码的邮件信息
	public String sendEmail(String to,String subject){
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		mailMessage.setFrom(from);
		mailMessage.setTo(to);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = dateFormat.format(new Date());
        String code=createCode();
        String content = "【众筹网】您本次【"+date+"】操作的验证码是：["+code+"]<br>提示：请勿泄露验证码。";
		mailMessage.setSubject(subject);
		mailMessage.setText(content);
		javaMailSender.send(mailMessage);
		return code;
	}
	
	//随机生成6位验证码
	public String createCode() {
		Random rad = new Random();
		String result = rad.nextInt(1000000) + "";
		if (result.length() != 6) {
			return createCode();
		}
		return result;
	}

	// 实名验证的邮件信息
	public void SendReviewMail(String content, String to, String subject) {
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		mailMessage.setFrom(from);
		mailMessage.setTo(to);
		mailMessage.setSubject(subject);
		mailMessage.setText(content);
		javaMailSender.send(mailMessage);
	}
}
