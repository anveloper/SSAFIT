package com.ssafy.ssafit.model.service;

import java.util.List;

import com.ssafy.ssafit.model.dto.Review;

public interface ReviewService {
	List<Review> getReviewList(String youtubeId);
	void createReview(Review review);
	void deleteReview(int reviewSeq);
	
}
