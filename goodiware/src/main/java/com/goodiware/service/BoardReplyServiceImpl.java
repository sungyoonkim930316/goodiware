package com.goodiware.service;

import java.util.HashMap;
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
		
		System.out.println("gno : "+ reply.getRno());
		
		boardReplyMapper.updateReplyByGno(reply.getRno());
		
	}

	@Override
	public List<Reply> getReplyListByBno(int bNo) {

		return boardReplyMapper.selectReplyListByBno(bNo);
	}

	@Override
	public void deleteReply(int rno) {

		boardReplyMapper.deleteReply(rno);
	}

	@Override
	public void editReply(Reply reply) {

		boardReplyMapper.updateReply(reply);
	}

	@Override
	public void insertReReply(Reply reply) {

		Reply parent = boardReplyMapper.selectReplyByRno(reply.getRno());
		reply.setGno(parent.getGno());
		reply.setSno(parent.getSno()+1);
		reply.setDepth(1);
		
		boardReplyMapper.updateSno(parent);
		
		System.out.println("gno : " + reply.getGno());
		System.out.println("sno : " + reply.getSno());
		System.out.println("depth : " + reply.getDepth());
		
		boardReplyMapper.insertReReply(reply);
		
	}

	@Override
	public List<Reply> getReplyWithPagingByBno(HashMap<String, Object> params) {

		return boardReplyMapper.selectReplyWithPagingByBno(params);
	}

	@Override
	public int getReplyCount(HashMap<String, Object> params) {

		return boardReplyMapper.selectReplyCount(params);
	}

}
