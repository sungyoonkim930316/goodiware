package com.goodiware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Message;


@Mapper
public interface MessageMapper {

	void insertMessage(Message message);

	int selectEmployeeNoById(String receiveid);

	List<Message> selectMessage(int empno);

	Message selectMessageContent(int mno);

	void insertOpenDate(int mno);


}
