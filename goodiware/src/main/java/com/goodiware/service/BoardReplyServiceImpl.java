package com.goodiware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.BoardReplyMapper;
import com.goodiware.vo.Reply;

@Service("boardReplyService")
public class BoardReplyServiceImpl implements BoardReplyService {

	@Autowired
	BoardReplyMapper boardReplyMapper;
	
	@Override
	public void writeReply(Reply reply) {
		boardReplyMapper.insertReply(reply);
	}

	@Override
	public List<Reply> getReplyListByBno(int bNo) {

		return boardReplyMapper.selectReplyListByBno(bNo);
	}

	@Override
	public void deleteReply(int rno) {

		boardReplyMapper.deleteReply(rno);
	}

}
