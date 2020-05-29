package com.shop.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.domain.LoginDTO;
import com.shop.domain.UserVO;
import com.shop.service.EmailService;
import com.shop.service.UserService;
import com.shop.util.SessionListener;

@Controller
@RequestMapping("/user/*")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	@Inject
	UserService service;
	@Inject
	EmailService e_service;
	// 가입화면
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void register() throws Exception {
		logger.info("가입화면");
	}

	// 가입 작업
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String registerPost(UserVO vo, RedirectAttributes rttr) throws Exception {
		logger.info("회원가입");
		vo.setUser_detailaddr(vo.getUser_detailaddr() + vo.getExtraAddress());
		service.register(vo);

		rttr.addFlashAttribute("msg", "join_success");

		return "redirect:/user/login";
	}

	// 로그인 화면
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() throws Exception {
		logger.info("로그인 화면");
	}
	
	//로그인 작업
	@RequestMapping(value = "/loginPOST", method = RequestMethod.POST)
	public String loginPost(LoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
		SessionListener listener =  SessionListener.getInstance();
		logger.info((String)session.getAttribute("dest"));
		logger.info("로그인 작업");
		UserVO vo = service.login(dto);
		String url = "";

		if (vo == null) {
			url = "/user/login";
			rttr.addFlashAttribute("msg", "log_fail");
		} else {
			if(listener.isUsing(dto.getId())) {
				url = "/user/login";
				rttr.addFlashAttribute("msg", "log_used");				
			}else {
				listener.setSession(session, dto.getId());
			session.setAttribute("userVO", vo);
			Object dest = session.getAttribute("dest"); // 원래 요쳥한 정보사용
		    url = (dest != null ? (String) dest : "/");
		    session.removeAttribute("dest");
			}
		}
		return "redirect:" + url;
	}

	// 로그 아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) throws Exception {
		logger.info("로그아웃");
		session.invalidate();
		rttr.addFlashAttribute("msg", "log_out");
		return "redirect:/";
	}

	//수정 화면
	@RequestMapping(value = "/modify/{user_id}", method = RequestMethod.GET)
	public String modifyForm(@PathVariable("user_id") String user_id, Model model) throws Exception {
		logger.info(user_id + " 수정화면");
		model.addAttribute("userVO", service.readUser(user_id));
		return "/user/modify";
	}

	//수정 작업
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String Modify(UserVO vo, RedirectAttributes rttr) throws Exception {
		logger.info(vo.getUser_id() + " 수정 작업");
		vo.setUser_detailaddr(vo.getUser_detailaddr() + vo.getExtraAddress());

		service.modify(vo);
		rttr.addFlashAttribute("msg", "user_update");
		return "redirect:/";
	}
	
	//비밀번호 변경 화면
	@RequestMapping(value = "/pw_modify", method = RequestMethod.GET)
	public void pw_modify() throws Exception {
		logger.info("비밀번호 변경 화면");
	}
	
	//회원 탈퇴 화면
	@RequestMapping(value = "/userDelete", method = RequestMethod.GET)
	public void user_delete() throws Exception{
		logger.info("탈퇴화면");
	};
	
	//아이디 찾기
	@RequestMapping(value = "/find_id", method = RequestMethod.GET)
	public void find_id()throws Exception{
		logger.info("ID찾기 화면");
	}
	//아이디 찾기
	@RequestMapping(value = "/find_pw", method = RequestMethod.GET)
	public void find_pw()throws Exception{
		logger.info("pw찾기 화면");
	}
	
	//아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "/check_id/{user_id}", method = RequestMethod.GET)
	public ResponseEntity<Integer> check_id(@PathVariable("user_id") String user_id) throws Exception {
		logger.info(user_id + " 중복체크");
		ResponseEntity<Integer> entity = null;

		try {
			entity = new ResponseEntity<Integer>(service.check_id(user_id), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	//이메일 인증
	@ResponseBody
	@RequestMapping(value = "/mailCheck", method = RequestMethod.POST)
	public ResponseEntity<String> check_email(String email) throws Exception {
		logger.info(email + "메일 인증");
		ResponseEntity<String> entity = null;
		try {

			entity = new ResponseEntity<String>(e_service.mailAuth(email), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	// 비밀번호 변경
	@ResponseBody
	@RequestMapping(value = "/pw_modify", method = RequestMethod.POST)
	public ResponseEntity<Integer> pw_modify(String now_pw, String change_pw, String user_id,HttpSession session) throws Exception {
		logger.info(user_id +" 비밀번호 변경");
		ResponseEntity<Integer> entity = null;
		try {
			int answer = service.pw_modify(now_pw, change_pw, user_id);
			if (answer == 1) {
				session.invalidate();
			}
			entity = new ResponseEntity<Integer>(answer, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public ResponseEntity<Integer> userDelete(LoginDTO dto ,HttpSession session)throws Exception{
		logger.info("회원탈퇴" + dto.toString());
		ResponseEntity<Integer> entity = null;
		
		try {
			entity = new ResponseEntity<Integer>(service.delete(dto),HttpStatus.OK);
			session.invalidate();
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/find_id", method = RequestMethod.POST)
	public ResponseEntity<Integer> find_id(UserVO vo)throws Exception{
		logger.info("아이디 찾기" + vo.toString());
		
		ResponseEntity<Integer> entity = null;
		
		try {
			List<String> ids = service.find_id(vo);
			if(!ids.isEmpty()) {
				e_service.find_id(vo.getUser_email(), ids);
				entity = new ResponseEntity<Integer>(1,HttpStatus.OK);								
			} else {
				entity = new ResponseEntity<Integer>(0,HttpStatus.OK);				
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	@ResponseBody
	@RequestMapping(value = "/find_pw", method = RequestMethod.POST)
	public ResponseEntity<Integer> find_pw(UserVO vo)throws Exception{
		logger.info("비밀번호 찾기");
		
		ResponseEntity<Integer> entity = null;
		
		try {
			String pw = service.find_pw(vo);
			logger.info(pw);
			if(pw != "") {
				e_service.find_pw(vo.getUser_email(), pw);
				entity = new ResponseEntity<Integer>(1,HttpStatus.OK);								
			} else {
				entity = new ResponseEntity<Integer>(0,HttpStatus.OK);				
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
}
