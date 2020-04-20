package com.goodiware.service;

import java.util.List;

import com.goodiware.vo.Reply;

public interface BoardReplyService {

	void writeReply(Reply reply);

	List<Reply> getReplyListByBno(int bNo);

	void deleteReply(int rno);

}
