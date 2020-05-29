package com.shop.persistence;

import java.util.List;
import java.util.Map;

import com.shop.domain.FAQVO;
import com.shop.util.Criteria;

public interface Ad_FAQDAO {
	
	public List<FAQVO> faqList(Criteria cri)throws Exception;
	
	public int totalFAQ()throws Exception;
	
	public List<Map<String,Integer>> replyCount()throws Exception;
	
	public FAQVO readFAQ(int num)throws Exception;
	
	public List<FAQVO> readReply(int num)throws Exception;
	
	public void write_reply(FAQVO vo)throws Exception;

	public void write_re_reply(FAQVO vo)throws Exception;
	
	public void add_re_step(FAQVO vo)throws Exception;
	
	public void admin_reply(int num)throws Exception;
	
	public void deleteFAQ(int num)throws Exception;

	public void deleteList(List<Integer> num)throws Exception;
	
	public void delReply(int faq_num)throws Exception;
	
	public void deleteReplyList(List<Integer> list)throws Exception;
}
