package com.ssafy.ssafit.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.VideoDao;
import com.ssafy.ssafit.model.dto.Video;

@Service
public class VideoServiceImpl implements VideoService {

	@Autowired
	VideoDao videoDao;

	@Override
	public List<Video> getVideoList() {
		return videoDao.selectVideos();
	}

	@Override
	public List<Video> getVideoListByQuery(String key) {
		return videoDao.selectVideosByQuery(key);
	}

	@Override
	public List<Video> getVideoListByPartCode(int partCode) {
		return videoDao.selectVideosByPartCode(partCode);
	}

	@Override
	public Video readVideoByYoutubeId(String youtubeId) {
		Video video = videoDao.selectVideoByYoutubeId(youtubeId);
		this.upViewCnt(video);
		return video;
	}

	@Override
	public void upViewCnt(Video video) {
		if (video != null) {
			video.setViewCnt(video.getViewCnt() + 1);
			videoDao.updateVideo(video);
		}
	}

	@Override
	public List<Video> getZzim(String userId) {
		return videoDao.selectZzim(userId);
	}

	@Override
	public void insertZzim(HashMap<String, String> params) {
		videoDao.insertZzim(params);
	}

	@Override
	public void deleteZzim(HashMap<String, String> params) {
		videoDao.deleteZzim(params);
	}

}
