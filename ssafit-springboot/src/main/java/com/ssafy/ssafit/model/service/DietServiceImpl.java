package com.ssafy.ssafit.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.DietDao;
import com.ssafy.ssafit.model.dto.Diet;

@Service
public class DietServiceImpl implements DietService{
	@Autowired
	DietDao dietDao;
	
	@Override
	public List<Diet> getDiet(int memberSeq) {
		// TODO Auto-generated method stub
		return dietDao.selectDiet(memberSeq);
	}

	@Override
	public Diet writeDiet(Diet diet) {
		// TODO Auto-generated method stub
		dietDao.insertDiet(diet);
		return diet;
	}

	@Override
	public void deleteDiet(int foodSeq) {
		dietDao.deleteDiet(foodSeq);
	}

}
