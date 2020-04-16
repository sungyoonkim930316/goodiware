package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.BoardMapper;
import com.goodiware.vo.Board;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public void writeBoard(Board board) {
		
		boardMapper.insertBoard(board);
		
		
	}

	@Override
	public Board findBoardByBNo(int bNo) {
		
		return boardMapper.selectBoardByBno(bNo);

	}

	@Override
	public List<Board> findBoardWithPaging(HashMap<String, Object> params) {
		
		return boardMapper.selectBoardWithPaging(params);
		
	}

	@Override
	public int findBoardCount(HashMap<String, Object> params) {
		
		return boardMapper.selectBoardCount(params);
		
	}

	@Override
	public void deleteBoard(int bNo) {
		
		boardMapper.deleteBoard(bNo);
		
	}

	@Override
	public void updateBoard(Board board) {
		
		boardMapper.updateBoard(board);
		
	}



}
