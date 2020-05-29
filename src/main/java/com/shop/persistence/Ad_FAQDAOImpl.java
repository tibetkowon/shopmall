package com.shop.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.FAQVO;
import com.shop.util.Criteria;

@Repository
public class Ad_FAQDAOImpl implements Ad_FAQDAO {

	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/Ad_FAQMapper";

	@Override
	public List<FAQVO> faqList(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".FAQList", cri);
	}

	@Override
	public int totalFAQ() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".totalFAQ");
	}

	@Override
	public List<Map<String, Integer>> replyCount() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".count_reply");
	}

	@Override
	public FAQVO readFAQ(int num) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".readFAQ", num);
	}

	@Override
	public List<FAQVO> readReply(int num) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".readReply", num);
	}

	@Override
	public void write_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".write_reply", vo);
	}

	@Override
	public void write_re_reply(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".write_re_reply", vo);
	}

	@Override
	public void add_re_step(FAQVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".add_re_step",vo );
	}

	@Override
	public void admin_reply(int num) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".admin_reply", num);
	}

	@Override
	public void deleteFAQ(int num) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".deleteFAQ", num);
	}

	@Override
	public void deleteList(List<Integer> num) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".deleteList", num);
	}

	@Override
	public void delReply(int faq_num) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".delReply",faq_num);
	}

	@Override
	public void deleteReplyList(List<Integer> list) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".deleteReplyList", list);
	}
}
