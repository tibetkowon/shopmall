package com.shop.domain;

import java.util.Date;

public class UserVO {
//회원정보

	private String user_id;
	private String user_name;
	private String user_pw;
	private String user_postcode;
	private String user_address;
	private String user_detailaddr;
	private String user_phonenum;
	private char user_mail_check;
	private char user_auth;
	private int user_point;
	private Date user_createdate;
	private Date user_update;
	private String user_email;
	
	
	private String extraAddress;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_postcode() {
		return user_postcode;
	}
	public void setUser_postcode(String user_postcode) {
		this.user_postcode = user_postcode;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_detailaddr() {
		return user_detailaddr;
	}
	public void setUser_detailaddr(String user_detailaddr) {
		this.user_detailaddr = user_detailaddr;
	}
	public String getUser_phonenum() {
		return user_phonenum;
	}
	public void setUser_phonenum(String user_phonenum) {
		this.user_phonenum = user_phonenum;
	}
	public char getUser_mail_check() {
		return user_mail_check;
	}
	public void setUser_mail_check(char user_mail_check) {
		this.user_mail_check = user_mail_check;
	}
	public char getUser_auth() {
		return user_auth;
	}
	public void setUser_auth(char user_auth) {
		this.user_auth = user_auth;
	}
	public int getUser_point() {
		return user_point;
	}
	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}
	public Date getUser_createdate() {
		return user_createdate;
	}
	public void setUser_createdate(Date user_createdate) {
		this.user_createdate = user_createdate;
	}
	public Date getUser_update() {
		return user_update;
	}
	public void setUser_update(Date user_update) {
		this.user_update = user_update;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	@Override
	public String toString() {
		return "UserVO [user_id=" + user_id + ", user_name=" + user_name + ", user_pw=" + user_pw + ", user_postcode="
				+ user_postcode + ", user_address=" + user_address + ", user_detailaddr=" + user_detailaddr
				+ ", user_phonenum=" + user_phonenum + ", user_mail_check=" + user_mail_check + ", user_auth="
				+ user_auth + ", user_point=" + user_point + ", user_createdate=" + user_createdate + ", user_update="
				+ user_update + ", user_email=" + user_email + ", extraAddress=" + extraAddress + "]";
	}
	public String getExtraAddress() {
		return extraAddress;
	}
	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}


}
