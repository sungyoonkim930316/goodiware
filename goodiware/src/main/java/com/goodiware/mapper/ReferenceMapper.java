package com.goodiware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Reference;
import com.goodiware.vo.Refreply;

@Mapper
public interface ReferenceMapper {

	void insertReference(Reference reference);

	List<Reference> selectRefWithPaging(HashMap<String, Object> params);

	int selectRefCount(HashMap<String, Object> params);

	Reference selectRefByRefNo(int refNo);

	Reference selectUploadRefByRefNo(int refNo);

	void deleteReference(int refNo);
	
	void updateReference(Reference reference);

	List<Reference> selectReplyWithPagingByRefNo(HashMap<String, Object> params);

	int selectReplyCount(HashMap<String, Object> params);

	void insertReply(Refreply refreply);

	void updateReplyRno(int refno);

	void deleteReply(int refrno);

	void updateReply(Refreply refreply);

	Refreply selectRefreplyByRefrno(int refrno);

	void insertReReply(Refreply refreply);

	void updateSno(Refreply parent);



}
