package com.shop.util;

import java.util.List;

public class OrderCriteria extends SearchCriteria {

	private String searchDate;

	private String start_date;
	private String end_date;
	private List<String> order_check;

	public String getSearchDate() {
		return searchDate;
	}

	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	@Override
	public String toString() {
		return super.toString() + " OrderCriteria [searchDate=" + searchDate + ", start_date=" + start_date
				+ ", end_date=" + end_date + ", order_check=" + order_check + "]";
	}

	public void setOrder_check(List<String> order_check) {
		this.order_check = order_check;
	}

	public List<String> getOrder_check() {
		return order_check;
	}
}
