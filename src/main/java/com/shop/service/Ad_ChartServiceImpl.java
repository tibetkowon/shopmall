
package com.shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.DateSearchDTO;
import com.shop.persistence.Ad_ChartDAO;

@Service
public class Ad_ChartServiceImpl implements Ad_ChartService {

	@Autowired
	private Ad_ChartDAO dao;

	@Override
	public List<Map<String, Object>> prt_cateChart() throws Exception {
		// TODO Auto-generated method stub
		return dao.prt_cateChart();
	}

	@Override
	public List<Map<String, Object>> cateChart(int prt_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.cateChart(prt_code);
	}

	@Override
	public List<Map<String, Object>> multi_cateChart(List<Integer> codes) throws Exception {
		// TODO Auto-generated method stub
		return dao.multi_cateChart(codes);
	}

	@Override
	public List<Map<String, Object>> getAllRank() throws Exception {
		// TODO Auto-generated method stub
		return dao.getAllRank();
	}

	@Override
	public List<Map<String, Object>> getCateRank(int cate_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.getCateRank(cate_code);
	}

	@Override
	public List<Map<String, Object>> getPrtRank(int prt_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.getPrtRank(prt_code);
	}

	@Override
	public Map<String, JSONArray> searchChart(DateSearchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		Map<String,JSONArray> data = new HashMap<String,JSONArray>();
		
		List<Map<String, Object>> periodSales = dao.searchPeriodSales(dto);
		List<Map<String,Object>> top10 = dao.searchTop10(dto);
		List<Map<String,Object>> prt_sales = dao.searchPrtSales(dto);
		
		JSONArray jsonData = new JSONArray();
		JSONArray task = new JSONArray();
		JSONArray jsonData2 = new JSONArray();
		JSONArray task2 = new JSONArray();
		JSONArray jsonData3 = new JSONArray();
		JSONArray task3 = new JSONArray();
		JSONArray jsonData4 = new JSONArray();
		JSONArray task4 = new JSONArray();

		//일일 매출 삽입
		task.add("날짜");
		task.add("매출");
		jsonData.add(task);
		
		for(Map<String, Object> map : periodSales) {			
		JSONArray line = new JSONArray();
		line.add(map.get("ORDER_DATE"));
		line.add(map.get("SALES"));
		
		jsonData.add(line);
		}
		//top 10 삽입
		task2.add("상품명");
		task2.add("판매량");
		jsonData2.add(task2);
		
		for(Map<String,Object> map : top10) {
			JSONArray bar = new JSONArray();
			bar.add(map.get("PRODUCT_NAME"));
			bar.add(map.get("SALES"));
			
			jsonData2.add(bar);
		}
		
		//카테고리판매
		task3.add("카테고리");
		task3.add("수량");
		jsonData3.add(task3);
		
		for(Map<String,Object> map : prt_sales) {
			JSONArray bar = new JSONArray();
			bar.add(map.get("CATEGORY_NAME"));
			bar.add(map.get("COUNT"));
			
			jsonData3.add(bar);
		}
		
		// 주문수, 가입수
		List<Map<String,Object>> user = dao.user_create(dto);
		List<Map<String,Object>> order = dao.order_count(dto);

		
		task4.add("날짜");
		task4.add("주문 수");
		task4.add("가입 수");
		
		jsonData4.add(task4);
		
		for(int i=0; i < user.size(); i++) {
			JSONArray count = new JSONArray();
			Map<String,Object> userMap = user.get(i);
			Map<String,Object> orderMap = order.get(i);
			count.add(userMap.get("DAYS"));
			count.add(orderMap.get("COUNT"));
			count.add(userMap.get("COUNT"));
			
			jsonData4.add(count);
			}
		
		data.put("periodSales", jsonData);
		data.put("top10", jsonData2);
		data.put("prt_sales", jsonData3);
		data.put("count", jsonData4);
		return data;
	}

	@Override
	public List<Map<String,Object>> searchCateSales(DateSearchDTO dto,List<Integer> cate_code) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("dto", dto);
		map.put("cate_code", cate_code);
		
		return dao.searchCateSales(map);
	}

}
