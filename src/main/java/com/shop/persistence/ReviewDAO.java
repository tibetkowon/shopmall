package com.shop.persistence;

import java.util.List;

import com.shop.domain.ReviewVO;

public interface ReviewDAO {
	
	public List<ReviewVO> readReview(int product_code)throws Exception;

	public void writeReview(ReviewVO vo)throws Exception;
	
	public void modifyReview(ReviewVO vo)throws Exception;
	
	public void deleteReview(int review_id)throws Exception;
}
