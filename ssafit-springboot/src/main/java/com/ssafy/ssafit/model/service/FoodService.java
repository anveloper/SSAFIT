package com.ssafy.ssafit.model.service;

import com.ssafy.ssafit.model.dto.Food;

public interface FoodService {
	Food getCal(int memberSeq);
	void setCal(Food food);
	void deleteCal(int memberSeq);
}
