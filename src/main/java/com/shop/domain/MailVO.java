package com.shop.domain;

public class MailVO {

	private String mail_title;
	private String mail_content;

	public String getMail_title() {
		return mail_title;
	}

	public void setMail_title(String mail_title) {
		this.mail_title = mail_title;
	}

	public String getMail_content() {
		return mail_content;
	}

	public void setMail_content(String mail_content) {
		this.mail_content = mail_content;
	}

	@Override
	public String toString() {
		return "MailVO [mail_title=" + mail_title + ", mail_content=" + mail_content + "]";
	}
}
