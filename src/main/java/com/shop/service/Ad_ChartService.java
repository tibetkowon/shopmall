package com.shop.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;

import com.shop.domain.DateSearchDTO;

public interface Ad_ChartService {

	public List<Map<String,Object>> prt_cateChart() throws Exception;

	public List<Map<String,Object>> cateChart(int prt_code) throws Exception;
	
	public List<Map<String,Object>> multi_cateChart(List<Integer> codes)throws Exception;

	public List<Map<String,Object>> getAllRank()throws Exception;
	
	public List<Map<String,Object>> getCateRank(int cate_code)throws Exception;
	
	public List<Map<String,Object>> getPrtRank(int prt_code)throws Exception;

	public Map<String,JSONArray> searchChart(DateSearchDTO dto)throws Exception;

	public List<Map<String,Object>> searchCateSales(DateSearchDTO dto,List<Integer> cate_code)throws Exception;
	
}
