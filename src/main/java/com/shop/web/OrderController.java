package com.shop.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.domain.OrderVO;
import com.shop.domain.Order_detailVO;
import com.shop.domain.ProductVO;
import com.shop.domain.UserVO;
import com.shop.service.CartService;
import com.shop.service.OrderService;
import com.shop.service.ProductService;
import com.shop.util.Criteria;
import com.shop.util.PageMaker;

@Controller
@RequestMapping("/order/*")
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Inject
	private OrderService  o_service;
	@Inject
	private CartService c_service;
	@Inject
	private ProductService p_service;
	
	@RequestMapping("/order")
	public void order(Model model,HttpSession session)throws Exception{
		UserVO vo = (UserVO)session.getAttribute("userVO");
		model.addAttribute("cartList", c_service.cartList(vo.getUser_id()));
	}
	@RequestMapping("/checkOrder")
	public String test(@RequestParam("check_cart") List<Integer> cart_code,Model model)throws Exception{
		logger.info(cart_code.toString());

		model.addAttribute("cartList",c_service.checkList(cart_code));
		
		return "/order/order";
	}
	@Transactional
	@RequestMapping(value="/insert",method = RequestMethod.POST)
	public String orderInsert(@RequestParam("cart_code")List<Integer> cart_code,OrderVO vo,RedirectAttributes rttr)throws Exception{
		logger.info(cart_code.toString());
		logger.info(vo.toString());
		
		o_service.insertOrder(cart_code, vo);
		
		for(int i : cart_code) {
			c_service.delete(i);
		}
		
		rttr.addFlashAttribute("msg", "buy-success");
		return "redirect:/order/success";
	}
	@RequestMapping("/success")
	public void success()throws Exception{	
	}
	
	@RequestMapping("/list")
	public void list(HttpSession session,Model model,Criteria cri)throws Exception{
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(o_service.orderListCount(((UserVO)session.getAttribute("userVO")).getUser_id()));
		
		model.addAttribute("orders", o_service.orderList(((UserVO)session.getAttribute("userVO")).getUser_id(),cri));
		model.addAttribute("pageMaker",pm);
		
	}
	@RequestMapping(value = "/quickOrder/{code}", method = RequestMethod.GET)
	public String quickOrder(Model model , @PathVariable("code")int product_code) throws Exception{

		model.addAttribute("product", p_service.productSelect(product_code));
		return "/order/quickOrder";
	}
	@RequestMapping(value = "/quickOrder", method = RequestMethod.POST)
	public String quickOrder(Model model , ProductVO vo) throws Exception{
		ProductVO pro = p_service.productSelect(vo.getProduct_code());
		pro.setProduct_count(vo.getProduct_count());
		model.addAttribute("product", pro);
		return "/order/quickOrder";
	}
	@RequestMapping(value = "/quickInsert" , method = RequestMethod.POST)
	public String qickOrder_In(OrderVO vo,Order_detailVO d_vo,RedirectAttributes rttr)throws Exception{
		logger.info(vo.toString());
		logger.info(d_vo.toString());
		
		o_service.quickOrder(vo, d_vo);
		
		rttr.addFlashAttribute("msg", "buy-success");
		return "redirect:/order/success";
	}
	@RequestMapping(value = "/detail/{code}" , method = RequestMethod.GET)
	public String detail(@PathVariable("code")int order_code ,HttpSession session, Model model )throws Exception{
		String  user_id = ((UserVO)session.getAttribute("userVO")).getUser_id();
		
		model.addAttribute("detail", o_service.detail(order_code,user_id));
		return "order/detail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete/{code}",method = RequestMethod.POST)
	public ResponseEntity<Integer> orderDelete(@PathVariable("code")int order_code)throws Exception{
		ResponseEntity<Integer> entity = null;
		
		try {
			o_service.delete(order_code);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
