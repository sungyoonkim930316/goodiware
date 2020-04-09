package com.goodiware.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Message;


@Mapper
public interface MessageMapper {

	void insertMessage(Message message);


}
