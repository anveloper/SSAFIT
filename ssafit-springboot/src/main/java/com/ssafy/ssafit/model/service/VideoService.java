package com.ssafy.ssafit.model.service;

import java.util.HashMap;
import java.util.List;

import com.ssafy.ssafit.model.dto.Video;

public interface VideoService {
	List<Video> getVideoList();

	List<Video> getVideoListByQuery(String key);

	List<Video> getVideoListByPartCode(String partCode);

	Video readVideoByYoutubeId(String youtubeId);

	void upViewCnt(Video video);

	void insertZzim(HashMap<String, String> params);

	void deleteZzim(HashMap<String, String> params);

	List<Video> getZzim(String userId);

	void createVideo(HashMap<String, String> params);

	void updatePartCode(HashMap<String, String> param);

}
