package com.shop.domain;

public class CartVO {
//장바구니
	
	private int cart_code;
	private int product_code;
	private String user_id;
	private int product_count;

	public int getCart_code() {
		return cart_code;
	}

	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}

	public int getProduct_code() {
		return product_code;
	}

	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	@Override
	public String toString() {
		return "CartVO [cart_code=" + cart_code + ", product_code=" + product_code + ", user_id=" + user_id + ", product_count="
				+ product_count + "]";
	}
}
