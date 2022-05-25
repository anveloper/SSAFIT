package com.ssafy.ssafit.model.service;

import java.util.List;

import com.ssafy.ssafit.model.dto.Record;

public interface RecordService {
	List<Record> getListbyId(String userId);
	List<Record> getListbyIdEx(Record record);
	void writeRecord(Record record);
	void deleteRecord(int recordSeq);
}
