package com.shop.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.domain.FAQVO;
import com.shop.persistence.FAQDAO;

@Service
public class FAQServiceImpl implements FAQService {

	@Autowired
	private FAQDAO dao;

	@Override
	public void write_faq(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.write_faq(vo);
	}

	@Override
	public List<FAQVO> faq_list() throws Exception {
		// TODO Auto-generated method stub
		return dao.faq_list();
	}

	@Override
	public FAQVO faq_read(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		return dao.faq_read(faq_num);
	}

	@Override
	public List<FAQVO> reply_list(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		return dao.reply_list(faq_num);
	}

	@Override
	public void write_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.write_reply(vo);
	}

	@Override
	@Transactional
	public void write_re_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.add_re_step(vo);
		
		dao.write_re_reply(vo);
	}

	@Override
	public void del_reply(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		dao.del_reply(faq_num);
	}

	@Override
	public void del_faq(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		dao.del_faq(faq_num);
	}

	@Override
	public void modify_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.modify_reply(vo);
	}

	@Override
	public void modify_faq(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.modify_faq(vo);
	}

	@Override
	public List<HashMap<String,Integer>> count_reply() throws Exception {
		// TODO Auto-generated method stub
		return dao.count_reply();
	}
}
