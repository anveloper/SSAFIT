package com.ssafy.ssafit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.ssafit.model.dto.Video;
import com.ssafy.ssafit.model.service.VideoService;

@RestController
@RequestMapping("/video")
public class ApiVideoController {
	private static final String SUCESS = "sucess";
	private static final String FAIL = "fail";
	private static final String HEADER_AUTH = "auth-token";

	@Autowired
	private VideoService videoService;

	@GetMapping("")
	public ResponseEntity<List<Video>> list() {
		return new ResponseEntity<List<Video>>(videoService.getVideoList(), HttpStatus.OK);
	}

	@GetMapping("/{youtubeId}")
	public ResponseEntity<Video> videoById(@PathVariable String youtubeId) {
		return new ResponseEntity<Video>(videoService.readVideoByYoutubeId(youtubeId), HttpStatus.FOUND);
	}

	@GetMapping("/search")
	public ResponseEntity<List<Video>> searchVideo(@RequestParam String key) {
		return new ResponseEntity<List<Video>>(videoService.getVideoListByQuery(key), HttpStatus.OK);
	}

	@GetMapping("/partNo")
	public ResponseEntity<List<Video>> videoByPartCode(@RequestParam int code) {
		return new ResponseEntity<List<Video>>(videoService.getVideoListByPartCode(code), HttpStatus.OK);
	}

	@GetMapping("/zzim/{userId}")
	public ResponseEntity<Map<String, Object>> getZzim(@PathVariable String userId) {
		HttpStatus status = null;
		HashMap<String, Object> result = new HashMap<>();
		try {
			result.put("zzimList", videoService.getZzim(userId));
			status = HttpStatus.OK;
		} catch (Exception e) {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}

		return new ResponseEntity<Map<String, Object>>(result, status);

	}

	@PostMapping("/zzim/{userId}/{youtubeId}")
	public ResponseEntity<String> zzim(@PathVariable String userId, @PathVariable String youtubeId) {
		String msg = "";
		HashMap<String, String> params = new HashMap<>();
		HttpStatus status = null;
		params.put("userId", userId);
		params.put("youtubeId", youtubeId);

		try {
			videoService.insertZzim(params);
			msg = SUCESS;
			status = HttpStatus.CREATED;
		} catch (Exception e) {
			msg = FAIL;
			status = HttpStatus.CONFLICT;
		}

		return new ResponseEntity<String>(msg, status);

	}

	@DeleteMapping("/zzim/{userId}/{youtubeId}")
	public ResponseEntity<String> unzzim(@PathVariable String userId, @PathVariable String youtubeId) {
		String msg = "";
		HashMap<String, String> params = new HashMap<>();
		HttpStatus status = null;
		params.put("userId", userId);
		params.put("youtubeId", youtubeId);

		try {
			videoService.deleteZzim(params);
			msg = SUCESS;
			status = HttpStatus.NO_CONTENT;
		} catch (Exception e) {
			msg = FAIL;
			status = HttpStatus.CONFLICT;
		}

		return new ResponseEntity<String>(msg, status);

	}

}
