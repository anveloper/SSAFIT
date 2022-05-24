package com.ssafy.ssafit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ssafit.model.dto.Excercise;
import com.ssafy.ssafit.model.service.ExcerciseService;

@RestController
@RequestMapping("/ex")
public class ApiExcerciseController {
	
	@Autowired
	ExcerciseService excerciseService;
	
	@GetMapping("")
	public ResponseEntity<List<Excercise>> list(){
		return new ResponseEntity<List<Excercise>>(
				excerciseService.getExcercises(), HttpStatus.OK);
	}
}
