package com.ssafy.ssafit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ssafit.model.dto.Reply;
import com.ssafy.ssafit.model.service.ReplyService;

@RestController
@RequestMapping("/reply")
public class ApiReplyController {
	
	@Autowired
	ReplyService replyService;
	
	@GetMapping("/{youtubeId}")
	public ResponseEntity<List<Reply>> videoReply(@PathVariable String youtubeId){
		return new ResponseEntity<List<Reply>>(
				replyService.getVideoReply(youtubeId), HttpStatus.OK);
	}
	
	@PostMapping("")
	public ResponseEntity<String> insert(@RequestBody Reply reply){
		replyService.writeReply(reply);
		return new ResponseEntity<String>(
				"SUCESS", HttpStatus.CREATED);
	}
	
	@PutMapping("")
	public ResponseEntity<String> update(@RequestBody Reply reply){
		replyService.modifyReply(reply);
		return new ResponseEntity<String>(
				"SUCESS", HttpStatus.ACCEPTED);
	}
	
	@DeleteMapping("/{replySeq}")
	public ResponseEntity<String> delete(@PathVariable int replySeq){
		replyService.deleteReply(replySeq);
		return new ResponseEntity<String>(
				"SUCESS", HttpStatus.MOVED_PERMANENTLY);	
	}
	
}
