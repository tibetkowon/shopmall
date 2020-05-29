package com.shop.domain;

public class OrderDTO {

	private int product_code;
	private String product_name;
	private String product_image;
	private int product_price;
	private int order_count;
	private int order_code;

	public int getProduct_code() {
		return product_code;
	}

	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public int getOrder_count() {
		return order_count;
	}

	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}

	@Override
	public String toString() {
		return "OrderDTO [product_code=" + product_code + ", product_name=" + product_name + ", product_image="
				+ product_image + ", product_price=" + product_price + ", order_count=" + order_count
				+  ", order_code=" + order_code + "]";
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}


	public int getOrder_code() {
		return order_code;
	}

	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}
}
