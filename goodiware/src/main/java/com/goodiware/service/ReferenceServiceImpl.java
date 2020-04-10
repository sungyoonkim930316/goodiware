package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.ReferenceMapper;
import com.goodiware.vo.Reference;

@Service("referenceService")
public class ReferenceServiceImpl implements ReferenceService {

	@Autowired
	ReferenceMapper referenceMapper;

	@Override
	public void insertRef(Reference reference) {

		referenceMapper.insertReference(reference);
		
	}

	@Override
	public List<Reference> findRefWithPaging(HashMap<String, Object> params) {
		
		return referenceMapper.selectRefWithPaging(params);
		
	}

	@Override
	public int findRefCount(HashMap<String, Object> params) {
		
		return referenceMapper.selectRefCount(params);
		
	}

	@Override
	public Reference findRefByRefNo(int refNo) {
		
		return referenceMapper.selectRefByRefNo(refNo);
		
	}

	@Override
	public Reference findUploadFileByRefNo(int refNo) {
		
		return referenceMapper.selectUploadRefByRefNo(refNo);
	}

	@Override
	public void deleteReference(int refNo) {
		
		referenceMapper.deleteReference(refNo);
		
	}

	@Override
	public void updateRef(Reference reference) {
		
		referenceMapper.updateReference(reference);
		
	}

}
