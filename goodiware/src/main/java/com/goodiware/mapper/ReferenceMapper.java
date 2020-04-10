package com.goodiware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Department;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Position;
import com.goodiware.vo.Reference;

@Mapper
public interface ReferenceMapper {

	void insertReference(Reference reference);


}
