package com.shop.domain;

import java.util.Date;

public class ReviewVO {
//리뷰 , 평점

	private int review_id;
	private String user_id;
	private int product_code;
	private String review_content;
	private Date review_date;
	
	private int rno;

	public int getReview_id() {
		return review_id;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
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

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

	@Override
	public String toString() {
		return "ReviewVO [review_id=" + review_id + ", user_id=" + user_id + ", product_code=" + product_code
				+ ", review_content=" + review_content + ", review_date="
				+ review_date + ", rno=" + rno + "]";
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}
}
