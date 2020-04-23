package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import com.goodiware.vo.Reply;

public interface BoardReplyService {

	void writeReply(Reply reply);

	List<Reply> getReplyListByBno(int bNo);

	void deleteReply(int rno);

	void editReply(Reply reply);

	void insertReReply(Reply reply);

	List<Reply> getReplyWithPagingByBno(HashMap<String, Object> params);

	int getReplyCount(HashMap<String, Object> params);

}
