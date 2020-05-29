package com.shop.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.domain.BoardVO;
import com.shop.domain.QnADTO;
import com.shop.service.BoardService;

@Controller
@RequestMapping("/QnA/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
	//QnA작성
	@ResponseBody
	@RequestMapping(value = "/write" , method = RequestMethod.POST)
	public ResponseEntity<Integer> writeQnA(BoardVO vo)throws Exception{
		logger.info(vo.toString());
		ResponseEntity<Integer> entity = null;
		
		try {
			service.writeQnA(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//QnA 읽기
	@ResponseBody
	@RequestMapping(value = "/readBoard", method = RequestMethod.GET)
	public ResponseEntity<QnADTO> readBoard(int board_num)throws Exception{
		ResponseEntity<QnADTO> entity = null;
		
		try {
			entity = new ResponseEntity<QnADTO>(service.readBoard(board_num),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<QnADTO>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//QnA 삭제
	@ResponseBody
	@RequestMapping(value = "/delBoard", method = RequestMethod.GET)
	public ResponseEntity<Integer> delBoard(int board_num)throws Exception{
		ResponseEntity<Integer> entity = null;
		
		try {
			service.delBoard(board_num);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//QnA 삭제
	@ResponseBody
	@RequestMapping(value = "/modifyBoard", method = RequestMethod.POST)
	public ResponseEntity<Integer> modifyBoard(BoardVO vo)throws Exception{
		ResponseEntity<Integer> entity = null;
		
		try {
			service.modifyBoard(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	//답변등록
	@ResponseBody
	@RequestMapping(value = "/writeReply" , method = RequestMethod.POST)
	public ResponseEntity<Integer> writeReply(BoardVO vo)throws Exception{
		ResponseEntity<Integer> entity = null;
		
		try {
			service.writeReply(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	//답변 수정
	@ResponseBody
	@RequestMapping(value = "/modifyReply" , method = RequestMethod.POST)
	public ResponseEntity<Integer> modifyReply(BoardVO vo)throws Exception{
		ResponseEntity<Integer> entity = null;
		
		try {
			service.modifyReply(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);		
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
