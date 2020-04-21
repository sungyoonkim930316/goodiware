package com.goodiware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Reply;

@Mapper
public interface BoardReplyMapper {

	void insertReply(Reply reply);

	List<Reply> selectReplyListByBno(int bNo);

	void deleteReply(int rno);

	void updateReply(Reply reply);

}
