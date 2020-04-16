package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import com.goodiware.vo.Board;



public interface BoardService {

	void writeBoard(Board board);

	Board findBoardByBNo(int bNo);

	List<Board> findBoardWithPaging(HashMap<String, Object> params);

	int findBoardCount(HashMap<String, Object> params);

	void deleteBoard(int bNo);

	void updateBoard(Board board);
	
	
}
