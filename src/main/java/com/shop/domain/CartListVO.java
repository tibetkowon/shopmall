package com.shop.domain;

public class CartListVO {

	private String product_image;
	private String product_name;
	private int product_price;
	private int product_count;
	private int product_code;
	private int cart_code;
	
	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	@Override
	public String toString() {
		return "CartListVO [product_image=" + product_image + ", product_name=" + product_name + ", product_price="
				+ product_price + ", product_count=" + product_count + ", product_code=" + product_code + ", cart_code="
				+ cart_code + "]";
	}

	public int getProduct_code() {
		return product_code;
	}

	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}

	public int getCart_code() {
		return cart_code;
	}

	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}

}
