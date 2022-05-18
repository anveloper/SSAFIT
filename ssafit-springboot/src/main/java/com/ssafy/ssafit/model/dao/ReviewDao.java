package com.ssafy.ssafit.model.dao;

import java.util.List;

import com.ssafy.ssafit.model.dto.Review;

public interface ReviewDao {
	List<Review> selectReviewByYoutubeId(String youtubeId);
	void deleteReview(int reviewSeq);
	void insertReview(Review review);
}
