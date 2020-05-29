package com.shop.domain;

public class CategoryVO {
//카테고리
	
	private String category_code;
	private String parents_code;
	private String category_name;

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

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	@Override
	public String toString() {
		return "CategoryVO [category_code=" + category_code + ", parents_code=" + parents_code + ", category_name="
				+ category_name + "]";
	}
}
