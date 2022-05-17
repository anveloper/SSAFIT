package com.ssafy.ssafit.model.dao;

import java.util.List;

import com.ssafy.ssafit.model.dto.Video;

public interface VideoDao {
	List<Video> selectVideos();
	List<Video> selectVideosByPartCode(int partCode);
	List<Video> selectVideosByQuery(String key);
	Video selectVideoByYoutubeId(String youtubeId);
	void updateVideo(Video video);
}
