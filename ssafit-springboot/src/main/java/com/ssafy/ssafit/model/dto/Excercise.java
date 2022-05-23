package com.ssafy.ssafit.model.dto;

import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Excercise {
	private int exNo;
	private String exName;
	private int partNo;
}
