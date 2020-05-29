package com.shop.persistence;

import java.util.List;
import java.util.Map;

import com.shop.domain.DateSearchDTO;

public interface Ad_ChartDAO {

	public List<Map<String,Object>> prt_cateChart()throws Exception;
	
	public List<Map<String,Object>> cateChart(int prt_code)throws Exception;

	public List<Map<String,Object>> multi_cateChart(List<Integer> codes)throws Exception;

	public List<Map<String,Object>> getAllRank()throws Exception;
	
	public List<Map<String,Object>> getCateRank(int cate_code)throws Exception;
	
	public List<Map<String,Object>> getPrtRank(int prt_code)throws Exception;
	
	public List<Map<String,Object>> searchPeriodSales(DateSearchDTO dto)throws Exception;

	public List<Map<String,Object>> searchTop10(DateSearchDTO dto)throws Exception;

	public List<Map<String,Object>> searchPrtSales(DateSearchDTO dto)throws Exception;

	public List<Map<String,Object>> searchCateSales(Map<String,Object> map)throws Exception;
	
	public List<Map<String,Object>> user_create(DateSearchDTO dto)throws Exception;
	
	public List<Map<String,Object>> order_count(DateSearchDTO dto)throws Exception;
	
	
	
}
