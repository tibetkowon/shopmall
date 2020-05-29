package com.shop.domain;

import java.util.Date;

public class QnADTO {

	private int board_num;
	private String user_id;
	private int product_code;
	private String board_title;
	private String board_content;
	private Date board_createday;
	private char board_reply;
	private String reply_content;
	
	private String product_name;
	private int product_price;
	private String product_inform;
	private int product_amount;
	private String product_image;
	private char product_event;
	
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getProduct_code() {
		return product_code;
	}
	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public Date getBoard_createday() {
		return board_createday;
	}
	public void setBoard_createday(Date board_createday) {
		this.board_createday = board_createday;
	}
	public char getBoard_reply() {
		return board_reply;
	}
	public void setBoard_reply(char board_reply) {
		this.board_reply = board_reply;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	@Override
	public String toString() {
		return "QnADTO [board_num=" + board_num + ", user_id=" + user_id + ", product_code=" + product_code
				+ ", board_title=" + board_title + ", board_content=" + board_content + ", board_createday="
				+ board_createday + ", board_reply=" + board_reply + ", reply_content=" + reply_content
				+ ", product_name=" + product_name + ", product_price=" + product_price + ", product_inform="
				+ product_inform + ", product_amount=" + product_amount + ", product_image=" + product_image
				+ ", prodct_event=" + product_event + "]";
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
	public String getProduct_inform() {
		return product_inform;
	}
	public void setProduct_inform(String product_inform) {
		this.product_inform = product_inform;
	}
	public int getProduct_amount() {
		return product_amount;
	}
	public void setProduct_amount(int product_amount) {
		this.product_amount = product_amount;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public char getProduct_event() {
		return product_event;
	}
	public void setProduct_event(char prodct_event) {
		this.product_event = prodct_event;
	}
}
