package com.shop.domain;

import java.util.Date;

public class OrderVO {
//주문자 정보

	private int order_code;
	private String user_id;
	private String order_name;
	private String order_postcode;
	private String order_address;
	private String order_detailaddr;
	private String order_phonenum;
	private int order_sumprice;
	private Date order_date;
	private char order_check;
	public int getOrder_code() {
		return order_code;
	}
	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getOrder_name() {
		return order_name;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public String getOrder_postcode() {
		return order_postcode;
	}
	public void setOrder_postcode(String order_postcode) {
		this.order_postcode = order_postcode;
	}
	public String getOrder_address() {
		return order_address;
	}
	public void setOrder_address(String order_address) {
		this.order_address = order_address;
	}
	public String getOrder_detailaddr() {
		return order_detailaddr;
	}
	public void setOrder_detailaddr(String order_detailaddr) {
		this.order_detailaddr = order_detailaddr;
	}
	public String getOrder_phonenum() {
		return order_phonenum;
	}
	public void setOrder_phonenum(String order_phonenum) {
		this.order_phonenum = order_phonenum;
	}
	public int getOrder_sumprice() {
		return order_sumprice;
	}
	public void setOrder_sumprice(int order_sumprice) {
		this.order_sumprice = order_sumprice;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public char getOrder_check() {
		return order_check;
	}
	public void setOrder_check(char order_check) {
		this.order_check = order_check;
	}
	@Override
	public String toString() {
		return "OrderVO [order_code=" + order_code + ", user_id=" + user_id + ", order_name=" + order_name
				+ ", order_postcode=" + order_postcode + ", order_address=" + order_address + ", order_detailaddr="
				+ order_detailaddr + ", order_phonenum=" + order_phonenum + ", order_sumprice=" + order_sumprice
				+ ", order_date=" + order_date + ", order_check=" + order_check + "]";
	}

	
}
