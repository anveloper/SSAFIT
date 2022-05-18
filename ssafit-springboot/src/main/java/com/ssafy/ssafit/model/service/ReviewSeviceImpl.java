package com.ssafy.ssafit.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.ReviewDao;
import com.ssafy.ssafit.model.dto.Review;

@Service
public class ReviewSeviceImpl implements ReviewService{

	@Autowired
	ReviewDao reviewDao;
	@Override
	public List<Review> getReviewList(String youtubeId) {
		// TODO Auto-generated method stub
		return reviewDao.selectReviewByYoutubeId(youtubeId);
	}

	@Override
	public void createReview(Review review) {
		// TODO Auto-generated method stub
		reviewDao.insertReview(review);
	}

	@Override
	public void deleteReview(int reviewSeq) {
		// TODO Auto-generated method stub
		reviewDao.deleteReview(reviewSeq);
	}

}
