package com.ssafy.ssafit.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Diet {
	private int memberSeq;
	private String foodName;
	private int servingSize;
	private int cal;
	private int carb;
	private int protein;
	private int fat;
	private int foodSeq;
	private int foodAte;
}
