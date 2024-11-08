package com.smhrd.model;

import com.smhrd.database.SqlSessionManager;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

/**
 * 휴게소 이름을 통해 rest_stops_top_ranking 테이블에서 데이터 조회
 * 
 * @param saName 휴게소 이름
 * @return 조회된 get_sa_top_ranking 객체 또는 null (데이터가 없는 경우)
 */
public class sa_top_rankingDAO {

	SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();

	public List<sa_ranking> get_sa_top_ranking(String saName) {
	    SqlSession session = factory.openSession();
	    List<sa_ranking> result = null;

	    try {
	        System.out.println("Executing query with saName: " + saName);
	        result = session.selectList("ServiceMapper.sa_ranking", saName);
	        System.out.println("Query result: " + result);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }
	    return result;
	}

}
