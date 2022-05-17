package com.ssafy.ssafit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ssafit.model.dto.Video;
import com.ssafy.ssafit.model.service.VideoService;

@RestController
@RequestMapping("/video")
public class ApiVideoController {
	
	@Autowired
	private VideoService videoService;
	
	@GetMapping("")
	public ResponseEntity<List<Video>> list(){
		return new ResponseEntity<List<Video>>(
				videoService.getVideoList(),HttpStatus.OK);
	}
	
	@GetMapping("/{youtubeId}")
	public ResponseEntity<Video> videoById(@PathVariable String youtubeId){
		return new ResponseEntity<Video>(
				videoService.readVideoByYoutubeId(youtubeId), HttpStatus.FOUND);
	}
	
	@GetMapping("/search")
	public ResponseEntity<List<Video>> searchVideo(
			@RequestParam String key){
		return new ResponseEntity<List<Video>>(
				videoService.getVideoListByQuery(key), HttpStatus.OK);
	}
	
	@GetMapping("/partNo")
	public ResponseEntity<List<Video>> videoByPartCode(@RequestParam int code){
		return new ResponseEntity<List<Video>>(
				videoService.getVideoListByPartCode(code), HttpStatus.OK);
	}
}
