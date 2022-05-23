package com.ssafy.ssafit.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.ExcerciseDao;
import com.ssafy.ssafit.model.dto.Excercise;

@Service
public class ExcerciseServiceImpl implements ExcerciseService{

	@Autowired
	ExcerciseDao excerciseDao;
	
	@Override
	public List<Excercise> getExcercises() {
		// TODO Auto-generated method stub
		return excerciseDao.selectAll();
	}

}
