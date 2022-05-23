package com.ssafy.ssafit.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.ssafit.model.dao.RecordDao;
import com.ssafy.ssafit.model.dto.Record;

@Service
public class RecordServiceimpl implements RecordService{
	
	@Autowired
	RecordDao recordDao;

	@Override
	public List<Record> getListbyId(String userId) {
		// TODO Auto-generated method stub
		return recordDao.selectRecordById(userId);
	}

	@Override
	public void writeRecord(Record record) {
		// TODO Auto-generated method stub
		recordDao.insertRecord(record);
	}
	
	

}
