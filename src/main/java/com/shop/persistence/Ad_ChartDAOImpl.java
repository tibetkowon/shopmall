package com.shop.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.DateSearchDTO;

@Repository
public class Ad_ChartDAOImpl implements Ad_ChartDAO{

	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/Ad_chartMapper";

	@Override
	public List<Map<String, Object>> prt_cateChart() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".prt_cateChart");
	}

	@Override
	public List<Map<String, Object>> cateChart(int prt_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".cateChart" , prt_code);
	}

	@Override
	public List<Map<String, Object>> multi_cateChart(List<Integer> codes) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(codes.toString());
		return session.selectList(namespace + ".multi_cateChart",codes);
	}

	@Override
	public List<Map<String, Object>> getAllRank() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".getAllRank");
	}

	@Override
	public List<Map<String, Object>> getCateRank(int cate_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".getCateRank", cate_code);
	}

	@Override
	public List<Map<String, Object>> getPrtRank(int prt_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".getPrtRank", prt_code);
	}

	@Override
	public List<Map<String, Object>> searchPeriodSales(DateSearchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".searchPeriodSales", dto);
	}

	@Override
	public List<Map<String,Object>> searchTop10(DateSearchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".searchTop10", dto);
	}

	@Override
	public List<Map<String,Object>> searchPrtSales(DateSearchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".searchPrtSales", dto);
	}

	@Override
	public List<Map<String, Object>> searchCateSales(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".searchCateSales", map);
	}

	@Override
	public List<Map<String, Object>> user_create(DateSearchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".user_create", dto);
	}

	@Override
	public List<Map<String, Object>> order_count(DateSearchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".order_count", dto);
	}
}
