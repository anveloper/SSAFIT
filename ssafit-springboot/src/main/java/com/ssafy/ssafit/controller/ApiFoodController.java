package com.ssafy.ssafit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ssafit.model.dto.Food;
import com.ssafy.ssafit.model.service.FoodService;

@RestController
@RequestMapping("/food")
public class ApiFoodController {
	@Autowired
	FoodService foodService;
	
	@GetMapping("/{memberSeq}")
	public ResponseEntity<Food> cal(@PathVariable int memberSeq){
		return new ResponseEntity<Food>(
				foodService.getCal(memberSeq), HttpStatus.OK );
	}
	
	@PostMapping("")
	public ResponseEntity<Integer> set(@RequestBody Food food){
		foodService.setCal(food);
		return new ResponseEntity<Integer>(
				food.getCal(),HttpStatus.OK);
		
	}
}
