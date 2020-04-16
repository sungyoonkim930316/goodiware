package com.goodiware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Board;
import com.goodiware.vo.Reference;


@Mapper
public interface BoardMapper {

	void insertBoard(Board board);

	int selectBoardCount(HashMap<String, Object> params);

	List<Board> selectBoardWithPaging(HashMap<String, Object> params);

	Board selectBoardByBno(int bNo);

	void deleteBoard(int bNo);

	void updateBoard(Board board);




	


}
