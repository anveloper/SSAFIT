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

import com.ssafy.ssafit.model.dto.Record;
import com.ssafy.ssafit.model.service.RecordService;

@RestController
@RequestMapping("/record")
public class ApiRecordController {
	
	@Autowired
	RecordService recordService;
	
	@GetMapping("/{userId}")
	public ResponseEntity<List<Record>> list(@PathVariable String userId){
		return new ResponseEntity<List<Record>>(
				recordService.getListbyId(userId), HttpStatus.OK);
	}
	
	@PostMapping("")
	public ResponseEntity<String> list(@RequestBody Record record){
		record.setVolume(record.getSets()*record.getWeight()*record.getReps());
		System.out.println(record);
		recordService.writeRecord(record);
		return new ResponseEntity<String>(
				"SUCESS",HttpStatus.OK);	
	}
	
	@PostMapping("/ex")
	public ResponseEntity<List<Record>> listEx(@RequestBody Record record){
		System.out.println(record);
		return new ResponseEntity<List<Record>>(
				recordService.getListbyIdEx(record), HttpStatus.OK);
	}
	
	@DeleteMapping("/{recordSeq}")
	public ResponseEntity<String> delete(@PathVariable int recordSeq){
		recordService.deleteRecord(recordSeq);
		return new ResponseEntity<String>(
				"SUCESS", HttpStatus.NO_CONTENT);
	}
}
