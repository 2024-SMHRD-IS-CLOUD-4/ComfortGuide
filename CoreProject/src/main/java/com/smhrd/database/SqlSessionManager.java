package com.smhrd.database;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

// SqlSession 을 생성해주는 공장 클래스
public class SqlSessionManager {

	// SqlSession 이란?
	// -> DB와 관련한 작업(한 가지의 작업)
	// -> SqlSession 객체 : DB 연결, SQL 실행과 같은 DB에 관련된 한 가지 작업을 수행하는 객체를 의미
	public static SqlSessionFactory sqlSessionFactory;
	
	// mybatis-config.xml(설정 파일)에 작성되어 있는 값을 가지고 공장 생성
	// -> 클래스가 로딩되면 딱 한번만 실행하고 더 이상 실행 x
	
	// 서비스가 실행되기 전 딱 한번만 실행이 됨.
	static {
		
		// 1. 설정 파일 읽어오기
		String resource = "com/smhrd/database/mybatis-config.xml";
		try {
			
			// Reader 를 사용해서 정보 읽어오기, Factory 생성
			Reader reader =  Resources.getResourceAsReader(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	// 생성된 Factory 반환 메소드
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
	
}
