package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.MarketMapper;
import com.goodiware.vo.Board;

@Service("marketService")
public class MarketServiceImpl implements MarketService{

	@Autowired
	MarketMapper marketMapper;
	
	@Override
	public void writeBoard(Board board) {
		
		marketMapper.insertBoard(board);
		
		
	}

	@Override
	public Board findBoardByBNo(int bNo) {
		
		return marketMapper.selectBoardByBno(bNo);

	}

	@Override
	public List<Board> findBoardWithPaging(HashMap<String, Object> params) {
		
		return marketMapper.selectBoardWithPaging(params);
		
	}

	@Override
	public int findBoardCount(HashMap<String, Object> params) {
		
		return marketMapper.selectBoardCount(params);
		
	}

	@Override
	public void deleteBoard(int bNo) {
		
		marketMapper.deleteBoard(bNo);
		
	}

	@Override
	public void updateBoard(Board board) {
		
		marketMapper.updateBoard(board);
		
	}

	@Override
	public List<Board> findAllNotice() {
		
		return marketMapper.selectAllNotice();
	}



}
