package com.shop.domain;

public class Board_ReplyVO {
	
	private int board_num;
	private String admin_id;
	private String reply_content;
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	@Override
	public String toString() {
		return "Board_ReplyVO [board_num=" + board_num + ", admin_id=" + admin_id + ", reply_content=" + reply_content
				+ "]";
	}
}
