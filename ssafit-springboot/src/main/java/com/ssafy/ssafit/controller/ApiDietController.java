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

import com.ssafy.ssafit.model.dto.Diet;
import com.ssafy.ssafit.model.service.DietService;

@RestController
@RequestMapping("/diet")	
public class ApiDietController {
	@Autowired
	DietService dietService;
	
	@GetMapping("/{memberSeq}")
	public ResponseEntity<List<Diet>> list(@PathVariable int memberSeq){
		return new ResponseEntity<List<Diet>>(
				dietService.getDiet(memberSeq), HttpStatus.OK);
	}
	
	@PostMapping("")
	public ResponseEntity<Diet> write(@RequestBody Diet diet){
		System.out.println(diet);
		return new ResponseEntity<Diet>(
				dietService.writeDiet(diet), HttpStatus.ACCEPTED);
	}
	
	@DeleteMapping("/{foodSeq}")
	public ResponseEntity<String> delete(@PathVariable int foodSeq){
		dietService.deleteDiet(foodSeq);
		return new ResponseEntity<String>(
				"SUCESS",HttpStatus.OK);
	}
}
