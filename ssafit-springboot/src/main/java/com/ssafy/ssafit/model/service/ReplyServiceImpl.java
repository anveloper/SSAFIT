package com.ssafy.ssafit.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.ReplyDao;
import com.ssafy.ssafit.model.dto.Reply;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	ReplyDao replyDao;
	
	@Override
	public List<Reply> getVideoReply(String youtubeId) {
		// TODO Auto-generated method stub
		return replyDao.selectReplyByYoutubeId(youtubeId);
	}

	@Override
	public void writeReply(Reply reply) {
		// TODO Auto-generated method stub
		replyDao.insertReply(reply);
	}

	@Override
	public void deleteReply(int replySeq) {
		// TODO Auto-generated method stub
		replyDao.deleteReply(replySeq);
	}

	@Override
	public void modifyReply(Reply reply) {
		// TODO Auto-generated method stub
		replyDao.updateReply(reply);
	}
	
}
