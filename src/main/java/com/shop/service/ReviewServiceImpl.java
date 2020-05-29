package com.shop.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.domain.ReviewVO;
import com.shop.persistence.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Inject
	private ReviewDAO dao;

	@Override
	public List<ReviewVO> readReview(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.readReview(product_code);
	}

	@Override
	@Transactional
	public void writeReview(ReviewVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.writeReview(vo);
	}

	@Override
	public void modifyReview(ReviewVO vo) throws Exception {
		// TODO Auto-generated method stub
		
		
		dao.modifyReview(vo);
	}

	@Override
	public void deleteReview(int review_id) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteReview(review_id);
	}
}
