package com.goodiware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.common.Util;
import com.goodiware.mapper.AdminMapper;
import com.goodiware.mapper.ReferenceMapper;
import com.goodiware.vo.Department;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Position;
import com.goodiware.vo.Reference;

@Service("referenceService")
public class ReferenceServiceImpl implements ReferenceService {

	@Autowired
	ReferenceMapper referenceMapper;

	@Override
	public void insertRef(Reference reference) {

		referenceMapper.insertReference(reference);
		
	}



}
