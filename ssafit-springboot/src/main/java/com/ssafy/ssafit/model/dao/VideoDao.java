package com.ssafy.ssafit.model.dao;

import java.util.HashMap;
import java.util.List;

import com.ssafy.ssafit.model.dto.Video;

public interface VideoDao {
	List<Video> selectVideos();

	List<Video> selectVideosByPartCode(String partCode);

	List<Video> selectVideosByQuery(String key);

	Video selectVideoByYoutubeId(String youtubeId);

	void updateVideo(Video video);

	List<Video> selectZzim(String userId);

	void insertZzim(HashMap<String, String> params);

	void deleteZzim(HashMap<String, String> params);

	void insertVideo(HashMap<String, String> params);
}
