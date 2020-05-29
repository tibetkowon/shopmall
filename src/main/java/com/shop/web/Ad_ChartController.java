package com.shop.web;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.domain.DateSearchDTO;
import com.shop.service.Ad_ChartService;

@Controller
@RequestMapping("/chart/*")
public class Ad_ChartController {
	private static final Logger logger = LoggerFactory.getLogger(Ad_ChartController.class);
	
	@Inject
	private Ad_ChartService service;
	
	@ResponseBody
	@RequestMapping(value = "/getPrt_cateChart" , method = RequestMethod.GET)
	public ResponseEntity<JSONArray> prt_cateChart()throws Exception{
		ResponseEntity<JSONArray> entity = null;
		try {
			
		List<Map<String,Object>> list = service.prt_cateChart();
		logger.info(list.toString());
		
		JSONArray data = new JSONArray();
		JSONArray task = new JSONArray();
		task.add("Task");
		task.add("test");
		
		data.add(task);
		
		for(Map<String,Object> map : list) {
			JSONArray pie = new JSONArray();
			pie.add(map.get("CATEGORY_NAME"));
			pie.add(map.get("COUNT"));
			
			data.add(pie);
		}
		entity = new ResponseEntity<JSONArray>(data,HttpStatus.OK);
		
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<JSONArray>(HttpStatus.BAD_REQUEST);
		}
			
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/getCateChart" , method = RequestMethod.GET)
	public ResponseEntity<JSONArray> prt_cateChart(int prt_code)throws Exception{
		ResponseEntity<JSONArray> entity = null;
		try {
			
			List<Map<String,Object>> list = service.cateChart(prt_code);
			logger.info(list.toString());
			
			JSONArray data = new JSONArray();
			JSONArray task = new JSONArray();
			task.add("Task");
			task.add("test");
			
			data.add(task);
			
			for(Map<String,Object> map : list) {
				JSONArray pie = new JSONArray();
				pie.add(map.get("CATEGORY_NAME"));
				pie.add(map.get("COUNT"));
				
				data.add(pie);
			}
			entity = new ResponseEntity<JSONArray>(data,HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<JSONArray>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/getMulti_CateChart" , method = RequestMethod.POST)
	public ResponseEntity<JSONArray> prt_cateChart(@RequestParam(value = "codes[]")List<Integer> codes)throws Exception{
		logger.info(codes.toString());
		ResponseEntity<JSONArray> entity = null;
		try {
			
			List<Map<String,Object>> list = service.multi_cateChart(codes);
			logger.info(list.toString());
			
			JSONArray data = new JSONArray();
			JSONArray task = new JSONArray();
			task.add("Task");
			task.add("test");
			
			data.add(task);
			
			for(Map<String,Object> map : list) {
				JSONArray pie = new JSONArray();
				pie.add(map.get("CATEGORY_NAME"));
				pie.add(map.get("COUNT"));
				
				data.add(pie);
			}
			entity = new ResponseEntity<JSONArray>(data,HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<JSONArray>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/getAllRank" , method = RequestMethod.GET)
	public ResponseEntity<JSONArray> GetAllRank()throws Exception{
		ResponseEntity<JSONArray> entity = null;
		try {
			
			List<Map<String,Object>> list = service.getAllRank();
			logger.info(list.toString());
			
			JSONArray data = new JSONArray();
			JSONArray task = new JSONArray();
			task.add("상품명");
			task.add("판매량");
			
			data.add(task);
			
			for(Map<String,Object> map : list) {
				JSONArray bar = new JSONArray();
				bar.add(map.get("PRODUCT_NAME"));
				bar.add(map.get("COUNT"));
				
				data.add(bar);
			}
			entity = new ResponseEntity<JSONArray>(data,HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<JSONArray>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/getPrtRank" , method = RequestMethod.GET)
	public ResponseEntity<JSONArray> getPrtRank(int prt_code)throws Exception{
		ResponseEntity<JSONArray> entity = null;
		try {
			
			List<Map<String,Object>> list = service.getPrtRank(prt_code);
			logger.info(list.toString());
			
			JSONArray data = new JSONArray();
			JSONArray task = new JSONArray();
			task.add("상품명");
			task.add("판매량");
			
			data.add(task);
			
			for(Map<String,Object> map : list) {
				JSONArray bar = new JSONArray();
				bar.add(map.get("PRODUCT_NAME"));
				bar.add(map.get("COUNT"));
				
				data.add(bar);
			}
			entity = new ResponseEntity<JSONArray>(data,HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<JSONArray>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/getCateRank" , method = RequestMethod.GET)
	public ResponseEntity<JSONArray> getCateRank(int cate_code)throws Exception{
		ResponseEntity<JSONArray> entity = null;
		try {
			
			List<Map<String,Object>> list = service.getCateRank(cate_code);
			logger.info(list.toString());
			
			JSONArray data = new JSONArray();
			JSONArray task = new JSONArray();
			task.add("상품명");
			task.add("판매량");
			
			data.add(task);
			
			for(Map<String,Object> map : list) {
				JSONArray bar = new JSONArray();
				bar.add(map.get("PRODUCT_NAME"));
				bar.add(map.get("COUNT"));
				
				data.add(bar);
			}
			entity = new ResponseEntity<JSONArray>(data,HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<JSONArray>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/searchChart" , method = RequestMethod.POST)
	public ResponseEntity<Map<String,JSONArray>> searchChart(DateSearchDTO dto)throws Exception{
		logger.info(dto.toString());
		ResponseEntity<Map<String,JSONArray>> entity = null;
		try {
			entity = new ResponseEntity<Map<String,JSONArray>>(service.searchChart(dto),HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,JSONArray>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/search_cateSales" , method = RequestMethod.POST)
	public ResponseEntity<JSONArray> search_cateSales(DateSearchDTO dto,@RequestParam(value = "cate_code[]")List<Integer> cate_code)throws Exception{
		ResponseEntity<JSONArray> entity = null;
		logger.info(dto.toString());
		logger.info(cate_code.toString());
		try {
			
		List<Map<String,Object>> list = service.searchCateSales(dto,cate_code);
		logger.info(list.toString());
		
		JSONArray data = new JSONArray();
		JSONArray task = new JSONArray();
		task.add("Task");
		task.add("test");
		
		data.add(task);
		
		for(Map<String,Object> map : list) {
			JSONArray pie = new JSONArray();
			pie.add(map.get("CATEGORY_NAME"));
			pie.add(map.get("COUNT"));
			
			data.add(pie);
		}
		entity = new ResponseEntity<JSONArray>(data,HttpStatus.OK);
		
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<JSONArray>(HttpStatus.BAD_REQUEST);
		}
			
		return entity;
	}
}
