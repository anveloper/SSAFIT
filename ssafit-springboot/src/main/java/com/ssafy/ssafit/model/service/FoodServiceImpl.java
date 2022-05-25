package com.ssafy.ssafit.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.FoodDao;
import com.ssafy.ssafit.model.dto.Food;

@Service
public class FoodServiceImpl implements FoodService{

	@Autowired
	FoodDao foodDao;
	
	@Override
	public Food getCal(int memberSeq) {
		// TODO Auto-generated method stub
		return foodDao.selectCal(memberSeq);
	}

	@Override
	public void setCal(Food food) {
		// TODO Auto-generated method stub
		foodDao.setCal(food);
	}
	
}
