package com.ssafy.ssafit.model.service;

import java.util.List;

import com.ssafy.ssafit.model.dto.Reply;

public interface ReplyService {
	List<Reply> getVideoReply(String youtubeId);
	void writeReply(Reply reply);
	void deleteReply(int replySeq);
	void modifyReply(Reply reply);
}
