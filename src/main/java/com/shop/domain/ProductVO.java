package com.shop.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
//상품

	private int product_code;
	private String category_code;
	private String parents_code;
	private String product_name;
	private int product_price;
	private int product_discount;
	private String product_company;
	private String product_inform;
	private String product_image;
	private int product_amount;
	private char product_event; // 행사여부
	private char product_display; // 구매가능여부
	private Date product_createdate;
	private Date product_update;

	private MultipartFile file1;
	private int product_count = 1;
	public int getProduct_code() {
		return product_code;
	}
	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getParents_code() {
		return parents_code;
	}
	public void setParents_code(String parents_code) {
		this.parents_code = parents_code;
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
	public int getProduct_discount() {
		return product_discount;
	}
	public void setProduct_discount(int product_discount) {
		this.product_discount = product_discount;
	}
	public String getProduct_company() {
		return product_company;
	}
	public void setProduct_company(String product_company) {
		this.product_company = product_company;
	}
	public String getProduct_inform() {
		return product_inform;
	}
	public void setProduct_inform(String product_inform) {
		this.product_inform = product_inform;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public int getProduct_amount() {
		return product_amount;
	}
	public void setProduct_amount(int product_amount) {
		this.product_amount = product_amount;
	}
	public char getProduct_event() {
		return product_event;
	}
	public void setProduct_event(char product_event) {
		this.product_event = product_event;
	}
	public char getProduct_display() {
		return product_display;
	}
	public void setProduct_display(char product_display) {
		this.product_display = product_display;
	}
	public Date getProduct_createdate() {
		return product_createdate;
	}
	public void setProduct_createdate(Date product_createdate) {
		this.product_createdate = product_createdate;
	}
	public Date getProduct_update() {
		return product_update;
	}
	public void setProduct_update(Date product_update) {
		this.product_update = product_update;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	@Override
	public String toString() {
		return "ProductVO [product_code=" + product_code + ", category_code=" + category_code + ", parents_code="
				+ parents_code + ", product_name=" + product_name + ", product_price=" + product_price
				+ ", product_discount=" + product_discount + ", product_company=" + product_company
				+ ", product_inform=" + product_inform + ", product_image=" + product_image + ", product_amount="
				+ product_amount + ", product_event=" + product_event + ", product_display=" + product_display
				+ ", product_createdate=" + product_createdate + ", product_update=" + product_update + ", file1="
				+ file1 + ", product_count=" + product_count + "]";
	}
}