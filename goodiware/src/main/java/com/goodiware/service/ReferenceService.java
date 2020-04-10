package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import com.goodiware.vo.Department;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Position;
import com.goodiware.vo.Reference;

public interface ReferenceService {

	void insertRef(Reference reference);

	List<Reference> findRefWithPaging(HashMap<String, Object> params);

	int findRefCount(HashMap<String, Object> params);

	Reference findRefByRefNo(int refNo);

	Reference findUploadFileByRefNo(int refNo);

}
