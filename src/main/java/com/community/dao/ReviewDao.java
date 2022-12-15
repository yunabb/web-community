package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Review;

public class ReviewDao {

	private static ReviewDao instance = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {
		return instance;
	}
	
	public void insertReview(Review review) {
		SqlMapper.insert("reviews.insertReview", review);
	}
	
	@SuppressWarnings("unchecked")
	public List<Review> getReviewsByPostNo(int postNo) {
		return (List<Review>) SqlMapper.selectList("reviews.getReviewsByPostNo", postNo);
	}
	
	public Review getReview(int reviewNo) {
		return (Review) SqlMapper.selectOne("reviews.getReview", reviewNo);
	}
	
	public void updateReview(Review review) {
		SqlMapper.update("reviews.updateReview", review);
	}
}