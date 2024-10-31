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
}
