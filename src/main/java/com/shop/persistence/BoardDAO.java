package com.shop.persistence;

import java.util.List;

import com.shop.domain.BoardVO;
import com.shop.domain.QnADTO;

public interface BoardDAO {

	public void writeQnA(BoardVO vo)throws Exception;
	
	public List<BoardVO> boardList(int product_code)throws Exception;
	
	public QnADTO readBoard(int board_num)throws Exception;
	
	public void delBoard(int board_num)throws Exception;
	
	public void modifyBoard(BoardVO vo)throws Exception;
	
	public void writeReply(BoardVO vo)throws Exception;
	
	public void modifyReply(BoardVO vo)throws Exception;
	
}
