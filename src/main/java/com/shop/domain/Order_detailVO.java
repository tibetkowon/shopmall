package com.shop.domain;

public class Order_detailVO {
//주문상품

	private int order_code;
	private int product_code;
	private int order_count;
	private int order_price;

	public int getOrder_code() {
		return order_code;
	}

	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}

	public int getProduct_code() {
		return product_code;
	}

	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}

	public int getOrder_count() {
		return order_count;
	}

	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}

	public int getOrder_price() {
		return order_price;
	}

	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}

	@Override
	public String toString() {
		return "Order_detailVO [order_code=" + order_code + ", product_code=" + product_code + ", order_count="
				+ order_count + ", order_price=" + order_price + ", order_review=" + "]";
	}

}
