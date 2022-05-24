package com.ssafy.ssafit.model.dao;

import java.util.List;

import com.ssafy.ssafit.model.dto.Record;

public interface RecordDao {
	List<Record> selectRecordById(String userId);
	List<Record> selectRecordByIdEx(Record record);
	void insertRecord(Record record);
	void deleteRecord(int recordSeq);
}
