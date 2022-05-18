package com.ssafy.ssafit.model.dao;

import java.util.List;

import com.ssafy.ssafit.model.dto.Reply;

public interface ReplyDao {
	List<Reply> selectReplyByYoutubeId(String youtubeId);
	void insertReply(Reply reply);
	void updateReply(Reply reply);
	void deleteReply(int replySeq);
}
