package com.shop.service;

import java.util.List;

import javax.inject.Inject;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.shop.domain.MailVO;
import com.shop.domain.UserVO;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Inject
	JavaMailSender mailSender;

	@Override
	public String mailAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		double random = Math.random();
		String number = Integer.toString((int)(random * 1000000) +1);
		System.out.println(number);
		try {
			
		MimeMessage msg = mailSender.createMimeMessage();
		
		msg.addRecipient(RecipientType.TO,new InternetAddress(email));
		
		msg.addFrom(new InternetAddress[] {new InternetAddress("kowon0519@gmail.com","쇼핑몰") } );
		
		msg.setSubject("메일 인증 번호", "utf-8");
		msg.setText("인증번호는 : " + number, "utf-8");
		
		mailSender.send(msg);
		}catch(Exception e) {
			e.printStackTrace();
		} return number;
	}

	@Override
	public void find_id(String email,List<String> ids) throws Exception {
		// TODO Auto-generated method stub		
		try {
		MimeMessage msg = mailSender.createMimeMessage();
		
		msg.addRecipient(RecipientType.TO,new InternetAddress(email));
		
		msg.addFrom(new InternetAddress[] {new InternetAddress("kowon0519@gmail.com","쇼핑몰") } );
		
		msg.setSubject("아이디", "utf-8");
		msg.setText("아이디는 : " + ids.toString() + "입니다.","utf-8");
		
		mailSender.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

	@Override
	public void find_pw(String email, String pw) throws Exception {
		// TODO Auto-generated method stub
		try {
		MimeMessage msg = mailSender.createMimeMessage();
		
		msg.addRecipient(RecipientType.TO,new InternetAddress(email));
		
		msg.addFrom(new InternetAddress[] {new InternetAddress("kowon0519@gmail.com","쇼핑몰") } );
		
		msg.setSubject("임시 비밀번호", "utf-8");
		msg.setText("임시비밀번호  : " + pw ,"utf-8");
		
		mailSender.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	@Override
	public void sendMails(MailVO vo,List<UserVO> mails) throws Exception {
		// TODO Auto-generated method stub
		try {
			InternetAddress[] email= new InternetAddress[mails.size()];
			for(int i=0; i<mails.size(); i++) {
				email[i]= new InternetAddress(mails.get(i).getUser_email());
				System.out.println(mails.get(i).getUser_email());
			}
			
			MimeMessage msg = mailSender.createMimeMessage();
			
			msg.addRecipients(RecipientType.TO,email);
			
			msg.addFrom(new InternetAddress[] {new InternetAddress("kowon0519@gmail.com","쇼핑몰") } );
			
			msg.setSubject(vo.getMail_title(), "utf-8");
			
			msg.setContent(vo.getMail_content(), "text/html;charset=UTF-8");

			mailSender.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	
	
}
