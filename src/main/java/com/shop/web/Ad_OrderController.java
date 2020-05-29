package com.shop.web;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.domain.OrderVO;
import com.shop.service.Ad_OrderService;
import com.shop.util.OrderCriteria;
import com.shop.util.PageMaker;

@Controller
@RequestMapping("/admin/order/*")
public class Ad_OrderController {
	private static final Logger logger = LoggerFactory.getLogger(Ad_OrderController.class);
	
	@Inject
	private Ad_OrderService service;
	
	@RequestMapping(value = "/list" , method = RequestMethod.GET)
	public void orderList(OrderCriteria cri,Model model)throws Exception{
		logger.info(cri.toString());
		if(cri.getSearchDate() != null && cri.getSearchDate() != "") {		
				cri.setStart_date(cri.getSearchDate().substring(0,10));
				cri.setEnd_date(cri.getSearchDate().substring(cri.getSearchDate().indexOf("-")+2));
		}

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.orderCount(cri));
		
		model.addAttribute("orders", service.orderList(cri));
		model.addAttribute("pageMaker", pm);

	}
	@ResponseBody
	@RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
	public ResponseEntity<Integer> update_status(OrderVO vo)throws Exception{
		logger.info(vo.toString());
		ResponseEntity<Integer> entity = null;
		
		try {
			service.update_status(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkUpdate", method = RequestMethod.POST)
	public ResponseEntity<Integer> update_status(@RequestParam(value = "code[]")List<Integer> codes,char status)throws Exception{
		logger.info(codes.toString());
		ResponseEntity<Integer> entity = null;
		try {
			service.check_update(codes, status);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getOrder" , method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> getOrder(int order_code)throws Exception{
		ResponseEntity<Map<String,Object>> entity = null;
		
		try {
			entity = new ResponseEntity<Map<String,Object>>(service.getOrder(order_code),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
}
