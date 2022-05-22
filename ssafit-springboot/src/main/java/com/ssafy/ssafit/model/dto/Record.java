package com.ssafy.ssafit.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class Record {
	private int recordSeq;
	private int userSeq;
	private int exNo;
	private String userId;
	private String exName;
	private String date;
	private int weight;
	private int reps;
	private int sets;
	private int volume;
}
