package com.shop.domain;

import java.util.Date;

public class BoardVO {
//게시판 
	private int board_num;
	private String user_id;
	private int product_code;
	private String board_title;
	private String board_content;
	private Date board_createday;
	private char board_reply;
	
	public int getProduct_code() {
		return product_code;
	}
	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}
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
	@Override
	public String toString() {
		return "BoardVO [board_num=" + board_num + ", user_id=" + user_id + ", product_code=" + product_code
				+ ", board_title=" + board_title + ", board_content=" + board_content + ", board_createday="
				+ board_createday + ", board_reply=" + board_reply + "]";
	}
	public char getBoard_reply() {
		return board_reply;
	}
	public void setBoard_reply(char board_reply) {
		this.board_reply = board_reply;
	}

	
}