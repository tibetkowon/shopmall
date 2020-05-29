package com.shop.persistence;

import java.util.HashMap;
import java.util.List;

import com.shop.domain.FAQVO;

public interface FAQDAO {

	public void write_faq(FAQVO vo)throws Exception;
	
	public List<FAQVO> faq_list()throws Exception;
	
	public FAQVO faq_read(int faq_num)throws Exception;
	
	public List<FAQVO> reply_list(int faq_num)throws Exception;
	
	public void write_reply(FAQVO vo)throws Exception;
	
	public void add_re_step(FAQVO vo)throws Exception;

	public void write_re_reply(FAQVO vo)throws Exception;

	public void del_reply(int faq_num)throws Exception;

	public void del_faq(int faq_num)throws Exception;
	
	public void modify_reply(FAQVO vo)throws Exception;
	
	public void modify_faq(FAQVO vo)throws Exception;
	
	public List<HashMap<String,Integer>> count_reply()throws Exception;
	
	
}
