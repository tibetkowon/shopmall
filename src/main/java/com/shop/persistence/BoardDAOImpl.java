package com.shop.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.BoardVO;
import com.shop.domain.QnADTO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/BoardMapper";

	@Override
	public void writeQnA(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".writeQnA", vo);
	}

	@Override
	public List<BoardVO> boardList(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".boardList", product_code);
	}

	@Override
	public QnADTO readBoard(int board_num) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".readBoard", board_num);
	}

	@Override
	public void delBoard(int board_num) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".delBoard", board_num);
	}

	@Override
	public void modifyBoard(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".modifyBoard", vo);
	}

	@Override
	public void writeReply(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".writeReply",vo);
	}

	@Override
	public void modifyReply(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".modifyReply", vo);
	}
}
