package com.shop.web;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.shop.persistence.UserDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
public class DataSourceTest {

	// root-context.xml 에서 spring-jdbc 라이브러리를 이용한 설정및 Bean 객체 생성및 주입작업 테스트

	@Inject
	private UserDAO dao;

	/*
	 * DI(Dependency injection) : 의존주입 DataSource ds = dataSource; 스프링 시스템에서 제공.
	 */

	@Test
	public void testLogin() throws Exception {

	
	
	dao.check_id("user1");
	}
}
