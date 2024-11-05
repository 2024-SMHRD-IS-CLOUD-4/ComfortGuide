package com.smhrd.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class TripDAO {

	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();

	
	public List<domestic_trips> getTrips() {
		SqlSession session = factory.openSession(true);
		List<domestic_trips> result = session.selectList("ServiceMapper.getTrips");
		session.close();
		return result; 
	}
	
	public List<TourismStats> getAllTourism(){
		SqlSession session = factory.openSession(true);
		List<TourismStats> result = session.selectList("ServiceMapper.getAllTourism");
		session.close();
		return result;
	}
	
	public List<RegionalTourismGrowth> getAllTourismGrowth(){
		SqlSession session = factory.openSession(true);
		List<RegionalTourismGrowth> result = session.selectList("ServiceMapper.getAllTourismGrowth");
		session.close();
		return result;
	}
}
