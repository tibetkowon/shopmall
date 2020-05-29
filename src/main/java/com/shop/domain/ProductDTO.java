package com.shop.domain;

public class ProductDTO {
	private int code;
	private int price;
	private String name;
	private String buy;
	private int amount;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBuy() {
		return buy;
	}

	public void setBuy(String buy) {
		this.buy = buy;
	}

	@Override
	public String toString() {
		return "ProductDTO [code=" + code + ", price=" + price + ", name=" + name + ", buy=" + buy + ", amount="
				+ amount + "]";
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

}