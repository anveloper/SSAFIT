package com.ssafy.ssafit.model.dao;

import java.util.List;

import com.ssafy.ssafit.model.dto.Diet;

public interface DietDao {
	List<Diet> selectDiet(int memberSeq);
	void insertDiet(Diet diet);
	void deleteDiet(int foodSeq);
}
