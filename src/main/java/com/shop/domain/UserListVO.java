package com.shop.domain;

import java.util.Date;

public class UserListVO {

	private String user_id;
	private String user_name;
	private int user_point;
	private Date user_createdate;
	private Date user_update;
	private int order_count;
	private int total_price;

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

	public int getOrder_count() {
		return order_count;
	}

	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}

	public int getTotal_price() {
		return total_price;
	}

	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}

	@Override
	public String toString() {
		return "UserListVO [user_id=" + user_id + ", user_name=" + user_name + ", user_point=" + user_point
				+ ", user_createdate=" + user_createdate + ", user_update=" + user_update + ", order_count="
				+ order_count + ", total_price=" + total_price + "]";
	}

}
