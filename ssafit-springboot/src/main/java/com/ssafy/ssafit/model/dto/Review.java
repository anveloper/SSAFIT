package com.ssafy.ssafit.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class Review {
	private int reviewSeq;
	private String youtubeId;
	private String writer;
	private String title;
	private String content;
}
