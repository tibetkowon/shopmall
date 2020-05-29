package com.shop.util;

public class CategoryCriteria extends SearchCriteria{

	private String mainCategory;
	private String subCategory;
	
	public String getMainCategory() {
		return mainCategory;
	}
	public void setMainCategory(String mainCategory) {
		this.mainCategory = mainCategory;
	}
	public String getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}
	@Override
	public String toString() {
		return super.toString() + "CategoryCriteria [mainCategory=" + mainCategory + ", subCategory=" + subCategory + "]";
	}
	

}


