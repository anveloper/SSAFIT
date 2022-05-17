package com.ssafy.ssafit.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Video {
	private int videoSeq;
	private String youtubeId;
	private String videoTitle;
	private int viewCnt;
	private int partCode;
}
