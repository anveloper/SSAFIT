package com.ssafy.ssafit.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.VideoDao;
import com.ssafy.ssafit.model.dto.Video;

@Service
public class VideoServiceImpl implements VideoService{

	@Autowired
	VideoDao videoDao;
	
	@Override
	public List<Video> getVideoList() {
		// TODO Auto-generated method stub
		return videoDao.selectVideos();
	}

	@Override
	public List<Video> getVideoListByQuery(String key) {
		// TODO Auto-generated method stub
		return videoDao.selectVideosByQuery(key);
	}

	@Override
	public List<Video> getVideoListByPartCode(int partCode) {
		// TODO Auto-generated method stub
		return videoDao.selectVideosByPartCode(partCode);
	}

	@Override
	public Video readVideoByYoutubeId(String youtubeId) {
		// TODO Auto-generated method stub
		Video video = videoDao.selectVideoByYoutubeId(youtubeId);
		this.upViewCnt(video);
		return video;
	}

	@Override
	public void upViewCnt(Video video) {
		// TODO Auto-generated method stub
		video.setViewCnt(video.getViewCnt() + 1);
		videoDao.updateVideo(video);
	}

}
