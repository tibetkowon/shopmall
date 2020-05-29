package com.shop.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.ReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/ReviewMapper";

	@Override
	public List<ReviewVO> readReview(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".readReview", product_code);
	}

	@Override
	public void writeReview(ReviewVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".writeReview", vo);
	}

	@Override
	public void modifyReview(ReviewVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".modifyReview", vo);
	}
	
	@Override
	public void deleteReview(int review_id) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".deleteReview", review_id);
	}
}
