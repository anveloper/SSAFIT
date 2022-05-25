package com.ssafy.ssafit.model.dao;

import com.ssafy.ssafit.model.dto.Food;

public interface FoodDao {
	Food selectCal(int memberSeq);
	void setCal(Food food);
}
