package com.ssafy.ssafit.model.service;

import java.util.List;

import com.ssafy.ssafit.model.dto.Record;

public interface RecordService {
	List<Record> getListbyId(String userId);
	void writeRecord(Record record);
}
