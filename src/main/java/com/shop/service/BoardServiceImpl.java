package com.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.BoardVO;
import com.shop.domain.QnADTO;
import com.shop.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;

	@Override
	public void writeQnA(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.writeQnA(vo);
	}

	@Override
	public List<BoardVO> boardList(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.boardList(product_code);
	}

	@Override
	public QnADTO readBoard(int board_num) throws Exception {
		// TODO Auto-generated method stub
		return dao.readBoard(board_num);
	}

	@Override
	public void delBoard(int board_num) throws Exception {
		// TODO Auto-generated method stub
		dao.delBoard(board_num);
	}

	@Override
	public void modifyBoard(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.modifyBoard(vo);
	}

	@Override
	public void writeReply(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.writeReply(vo);
	}

	@Override
	public void modifyReply(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.modifyReply(vo);
	}

}
