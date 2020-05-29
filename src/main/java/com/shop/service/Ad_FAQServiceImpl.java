package com.shop.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.domain.FAQVO;
import com.shop.persistence.Ad_FAQDAO;
import com.shop.util.Criteria;

@Service
public class Ad_FAQServiceImpl implements Ad_FAQService {
	
	@Autowired
	private Ad_FAQDAO dao;

	@Override
	public List<FAQVO> faqList(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.faqList(cri);
	}

	@Override
	public int totalFAQ() throws Exception {
		// TODO Auto-generated method stub
		return dao.totalFAQ();
	}

	@Override
	public List<Map<String, Integer>> replyCount() throws Exception {
		// TODO Auto-generated method stub
		return dao.replyCount();
	}

	@Override
	public FAQVO readFAQ(int num) throws Exception {
		// TODO Auto-generated method stub
		return dao.readFAQ(num);
	}

	@Override
	public List<FAQVO> readReply(int num) throws Exception {
		// TODO Auto-generated method stub
		return dao.readReply(num);
	}

	@Override
	@Transactional
	public void write_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.write_reply(vo);
		dao.admin_reply(vo.getFaq_num());
	}

	@Override
	@Transactional
	public void write_re_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.add_re_step(vo);
		dao.write_re_reply(vo);
	}

	@Override
	public void deleteFAQ(int num) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteFAQ(num);
	}

	@Override
	public void deleteList(List<Integer> num) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteList(num);
	}

	@Override
	public void delReply(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		dao.delReply(faq_num);
	}

	@Override
	public void deleteReplyList(List<Integer> list) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteReplyList(list);
	}
}
