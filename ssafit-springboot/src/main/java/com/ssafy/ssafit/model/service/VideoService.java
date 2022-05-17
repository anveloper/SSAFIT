package com.ssafy.ssafit.model.service;

import java.util.List;

import com.ssafy.ssafit.model.dto.Video;


public interface VideoService {
	List<Video> getVideoList();
	List<Video> getVideoListByQuery(String key);
	List<Video> getVideoListByPartCode(int partCode);
	Video readVideoByYoutubeId(String youtubeId);
	void upViewCnt(Video video);
	
}
