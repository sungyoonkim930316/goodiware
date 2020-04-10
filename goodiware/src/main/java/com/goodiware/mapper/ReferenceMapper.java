package com.goodiware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Reference;

@Mapper
public interface ReferenceMapper {

	void insertReference(Reference reference);

	List<Reference> selectRefWithPaging(HashMap<String, Object> params);

	int selectRefCount(HashMap<String, Object> params);

	Reference selectRefByRefNo(int refNo);

	Reference selectUploadRefByRefNo(int refNo);

	void deleteReference(int refNo);
	
	void updateReference(Reference reference);


}
