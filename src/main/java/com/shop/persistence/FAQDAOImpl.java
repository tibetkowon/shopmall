package com.shop.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.FAQVO;

@Repository
public class FAQDAOImpl implements FAQDAO {

	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/FAQMapper";

	@Override
	public void write_faq(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".write_faq", vo);
	}

	@Override
	public List<FAQVO> faq_list() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".faq_list");
	}

	@Override
	public FAQVO faq_read(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".faq_read", faq_num);
	}

	@Override
	public List<FAQVO> reply_list(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".reply_list", faq_num);
	}

	@Override
	public void write_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".write_reply", vo);
	}

	@Override
	public void add_re_step(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".add_re_step", vo);
	}

	@Override
	public void write_re_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".write_re_reply", vo);
	}

	@Override
	public void del_reply(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".del_reply", faq_num);
	}

	@Override
	public void del_faq(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".del_faq",faq_num);
	}

	@Override
	public void modify_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".modify_reply", vo);
	}

	@Override
	public void modify_faq(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".modify_faq", vo);
	}

	@Override
	public List<HashMap<String,Integer>> count_reply() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".count_reply");
	}
}
