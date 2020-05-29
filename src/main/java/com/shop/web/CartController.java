package com.shop.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.domain.CartVO;
import com.shop.domain.UserVO;
import com.shop.service.CartService;

@Controller
@RequestMapping("cart")
public class CartController {
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
	@Inject
	private CartService service;
	
	@RequestMapping("/cart")
	public void cart(HttpSession session,Model model) throws Exception {
		logger.info("장바구니");
		
		UserVO vo = (UserVO) session.getAttribute("userVO");
		if(vo != null) {			
		String user_id = vo.getUser_id();
		model.addAttribute("cartList", service.cartList(user_id));
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/addCart" , method = RequestMethod.POST)
	public ResponseEntity<Integer> addCart(CartVO vo)throws Exception{
		logger.info("장바구니 추가 "+vo.toString());
		ResponseEntity<Integer> entity = null;
		
		try {
			service.addCart(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/updateCount" , method = RequestMethod.POST)
	public ResponseEntity<Integer> updateCount(CartVO vo)throws Exception{
		logger.info(vo.toString());
		ResponseEntity<Integer> entity = null;	
		
		try {
			
			service.countUpdate(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/delete/{cart_code}" , method = RequestMethod.POST)
	public ResponseEntity<Integer> delete(@PathVariable("cart_code")int cart_code)throws Exception{
		ResponseEntity<Integer> entity = null;	
		
		try {
			
			service.delete(cart_code);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/deleteAll/{user_id}" , method = RequestMethod.POST)
	public ResponseEntity<Integer> deleteAll(@PathVariable("user_id")String user_id)throws Exception{
		logger.info(user_id);
		ResponseEntity<Integer> entity = null;	
		
		try {
			
			service.deleteAll(user_id);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/checkDelete" , method = RequestMethod.POST)
	public ResponseEntity<Integer> checkDelete(@RequestParam(value = "checkArr[]")List<Integer> checkArr)throws Exception{
		logger.info(checkArr.toString());
		ResponseEntity<Integer> entity = null;	
		
		try {
			for(int cart_code : checkArr) {
				service.delete(cart_code);
			}
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
