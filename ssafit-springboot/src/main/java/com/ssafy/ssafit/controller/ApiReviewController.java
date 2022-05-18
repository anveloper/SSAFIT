package com.ssafy.ssafit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ssafit.model.dto.Review;
import com.ssafy.ssafit.model.service.ReviewService;

@RestController
@RequestMapping("/review")
public class ApiReviewController {
	private static final String SUCESS = "sucess";
	private static final String FAIL = "fail";
	
	@Autowired
	ReviewService reviewService;
	
	@GetMapping("/{youtubeId}")
	public ResponseEntity<List<Review>> list(@PathVariable String youtubeId){ 
		return new ResponseEntity<List<Review>>(
				reviewService.getReviewList(youtubeId),HttpStatus.FOUND);
	}
	
	@PostMapping("")
	public ResponseEntity<String> write(@RequestBody Review review){
		System.out.println(review);
		reviewService.createReview(review);
		return new ResponseEntity<String>(
				SUCESS,HttpStatus.CREATED);
	}
	
	@DeleteMapping("/{reviewSeq}")
	public ResponseEntity<String> delete(@PathVariable int reviewSeq){
		reviewService.deleteReview(reviewSeq);
		return new ResponseEntity<String>(
				SUCESS,HttpStatus.ACCEPTED);
	}
}
	
	
