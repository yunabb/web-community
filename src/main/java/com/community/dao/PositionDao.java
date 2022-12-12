package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Department;
import com.community.vo.Position;

public class PositionDao {
	
	@SuppressWarnings("unchecked")
	public List<Position> getAllPositions() {
		return (List<Position>) SqlMapper.selectList("positions.getAllPositions");
	}
	
	public Position getPositionByNo(int no) {
		return (Position) SqlMapper.selectOne("positions.getPositionByNo", no);
	}

}