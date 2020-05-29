package com.shop.domain;

import java.util.Date;

public class FAQVO {

	private int faq_num;
	private String faq_title;
	private String faq_writer;
	private String faq_content;
	private Date faq_writedate;
	private Date faq_lastupdate;
	private int faq_ref;
	private int faq_re_level;
	private int faq_re_step;
	private char writer_only;
	private char admin_reply;

	public int getFaq_num() {
		return faq_num;
	}

	public void setFaq_num(int faq_num) {
		this.faq_num = faq_num;
	}

	public String getFaq_title() {
		return faq_title;
	}

	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}

	public String getFaq_writer() {
		return faq_writer;
	}

	public void setFaq_writer(String faq_writer) {
		this.faq_writer = faq_writer;
	}

	public String getFaq_content() {
		return faq_content;
	}

	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}

	public Date getFaq_writedate() {
		return faq_writedate;
	}

	public void setFaq_writedate(Date faq_writedate) {
		this.faq_writedate = faq_writedate;
	}

	public int getFaq_ref() {
		return faq_ref;
	}

	public void setFaq_ref(int faq_ref) {
		this.faq_ref = faq_ref;
	}

	public int getFaq_re_level() {
		return faq_re_level;
	}

	public void setFaq_re_level(int faq_re_level) {
		this.faq_re_level = faq_re_level;
	}

	public int getFaq_re_step() {
		return faq_re_step;
	}

	public void setFaq_re_step(int faq_re_step) {
		this.faq_re_step = faq_re_step;
	}

	@Override
	public String toString() {
		return "FAQVO [faq_num=" + faq_num + ", faq_title=" + faq_title + ", faq_writer=" + faq_writer
				+ ", faq_content=" + faq_content + ", faq_writedate=" + faq_writedate + ", faq_lastupdate="
				+ faq_lastupdate + ", faq_ref=" + faq_ref + ", faq_re_level=" + faq_re_level + ", faq_re_step="
				+ faq_re_step + ", writer_only=" + writer_only + ", admin_reply=" + admin_reply + "]";
	}

	public Date getFaq_lastupdate() {
		return faq_lastupdate;
	}

	public void setFaq_lastupdate(Date faq_lastupdate) {
		this.faq_lastupdate = faq_lastupdate;
	}

	public char getWriter_only() {
		return writer_only;
	}

	public void setWriter_only(char writer_only) {
		this.writer_only = writer_only;
	}

	public char getAdmin_reply() {
		return admin_reply;
	}

	public void setAdmin_reply(char admin_reply) {
		this.admin_reply = admin_reply;
	}

}
