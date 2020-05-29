package com.shop.domain;

import java.util.Date;

public class OrderListVO {

	
	private Date order_date;
	private int product_amount;
	private int product_code;
	private String product_name;
	private int order_sumprice;
	private int order_code;
	private char order_check;
	private String user_id;
	
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getOrder_sumprice() {
		return order_sumprice;
	}
	public void setOrder_sumprice(int order_sumprice) {
		this.order_sumprice = order_sumprice;
	}
	public int getOrder_code() {
		return order_code;
	}
	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}
	@Override
	public String toString() {
		return "OrderListVO [order_date=" + order_date + ", product_amount=" + product_amount + ", product_code="
				+ product_code + ", product_name=" + product_name + ", order_sumprice=" + order_sumprice
				+ ", order_code=" + order_code + ", order_check=" + order_check + ", user_id=" + user_id + "]";
	}
	public int getProduct_amount() {
		return product_amount;
	}
	public void setProduct_amount(int product_amount) {
		this.product_amount = product_amount;
	}
	public int getProduct_code() {
		return product_code;
	}
	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}
	public char getOrder_check() {
		return order_check;
	}
	public void setOrder_check(char order_check) {
		this.order_check = order_check;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
}
