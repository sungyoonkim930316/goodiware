package com.goodiware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Reply;

@Mapper
public interface BoardReplyMapper {

	void insertReply(Reply reply);

	List<Reply> selectReplyListByBno(int bNo);

	void deleteReply(int rno);

	void updateReply(Reply reply);

	void updateSno(Reply parent);

	void updateReplyByGno(int gno);

	Reply selectReplyByRno(int rno);

	void insertReReply(Reply reply);

	List<Reply> selectReplyWithPagingByBno(HashMap<String, Object> params);

	int selectReplyCount(HashMap<String, Object> params);

}
