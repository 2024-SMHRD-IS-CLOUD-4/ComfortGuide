package com.smhrd.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;

public class ServiceAreaDAO {

	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();

	
	public int insertServiceArea(tb_service_area sa) {
		SqlSession session = factory.openSession(true);
		int result = session.insert("ServiceMapper.insertServiceArea", sa);
		session.close();
		return result;
	}
	
	public List<tb_service_area> existServiceArea(String sa_name) {
		SqlSession session = factory.openSession(true);
		List<tb_service_area> result = session.selectList("ServiceMapper.existServiceArea", sa_name);
		session.close();
		return result;
				
	}
	
	public int insertDetails(tb_details d) {
		SqlSession session = factory.openSession(true);
		int result = session.insert("ServiceMapper.insertDetails", d);
		session.close();
		return result;
	}
	
	public List<tb_details> existDetails(String sa_name){
		SqlSession session = factory.openSession(true);
		List<tb_details> result = session.selectList("ServiceMapper.existDetails", sa_name);
		session.close();
		return result;
	}

	public List<tb_service_area> getServiceArea() {
		SqlSession session = factory.openSession(true);
		List<tb_service_area> result = session.selectList("ServiceMapper.getServiceArea");
		session.close();
		return result;	
	}
	
	public int insertAdmin(tb_admin a) {
		SqlSession session = factory.openSession(true);
		int result = session.insert("ServiceMapper.insertAdmin",a);
		session.close();
		return result;	
	}
	
	public tb_admin login(tb_admin a) {
		SqlSession session = factory.openSession(true);
		tb_admin result = session.selectOne("ServiceMapper.login",a);
		session.close();
		return result;
	}
	
	public boolean existAdminId(String id) {
	    SqlSession session = factory.openSession(true);
	    try {
	        Integer count = session.selectOne("ServiceMapper.existAdminId", id);
	        System.out.println("아이디 존재 여부: " + (count != null && count > 0));
	        return count != null && count > 0; // count가 1 이상이면 true 반환
	    } finally {
	        session.close();
	    }
	}


	
	public List<String> getAddrByRegion(String region) {
		SqlSession session = factory.openSession(true);
		List<String> result = session.selectList("ServiceMapper.getAddrByRegion",region); 
		session.close();
		return result;
	}
	
	public tb_service_area getServiceAreaBySaName(String sa_name) {
		SqlSession session = factory.openSession(true);
		tb_service_area result = session.selectOne("ServiceMapper.getServiceAreaBySaName", sa_name);
		session.close();
		return result;
	}
	
	public tb_details getFacility(String sa_name) {
		SqlSession session = factory.openSession(true);
		tb_details result = session.selectOne("ServiceMapper.getFacility",sa_name); 
		session.close();
		return result;
	}
	
	public List<tb_suggestion> getSuggestion(String sa_name){
		SqlSession session = factory.openSession(true);
		List<tb_suggestion> result = session.selectList("ServiceMapper.getSuggestion",sa_name); 
		session.close();
		return result;
	}
	
	public int insertSuggestion(tb_suggestion suggestion) {
	    SqlSession session = factory.openSession();
	    try {
	        session.insert("ServiceMapper.insertSuggestion", suggestion); 
	        tb_suggestion insertedId = session.selectOne("ServiceMapper.getInsertedSuggestionId");
	        session.commit(); // 트랜잭션 커밋
	        int result = (int)insertedId.getSuggestion_idx();
	        return result;
	    } catch (Exception e) {
	        session.rollback(); // 에러 발생 시 롤백
	        throw e;
	    } finally {
	        session.close();
	    }
	}


	
	public tb_suggestion getSuggestionByIdx(Integer a) {
		SqlSession session = factory.openSession(true);
		tb_suggestion result = session.selectOne("ServiceMapper.getSuggestionByIdx",(int)a); 
		session.close();
		return result;
	}
	
	public int updateProfile(tb_admin a) {
		SqlSession session = factory.openSession(true);
		int result = session.update("ServiceMapper.updateProfile",a);
		session.close();
		return result;
	}


}
