package com.ssafy.ssafit.model.service;

import java.util.List;

import com.ssafy.ssafit.model.dto.Diet;

public interface DietService {
	List<Diet> getDiet(int memberSeq);
	Diet writeDiet(Diet diet);
	void deleteDiet(int foodSeq);
}
