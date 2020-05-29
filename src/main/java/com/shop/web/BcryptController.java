package com.shop.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/bcrypt/*")
public class BcryptController {
	private static final Logger logger = LoggerFactory.getLogger(BcryptController.class);
	
	@Inject
	private BCryptPasswordEncoder crptPassEnc;
	
	@RequestMapping(value = "/passBcrypt" , method = RequestMethod.GET)
	public void encryptPasswordInfo(Model model)throws Exception {
		
		String ogi_pass = "1234";
		String enc_pass = crptPassEnc.encode(ogi_pass);
		String enc_pass2 = crptPassEnc.encode(ogi_pass);
		
		Thread.sleep(1000);
		
		model.addAttribute("ogi", ogi_pass);
		model.addAttribute("enc", enc_pass);
		model.addAttribute("enc2", enc_pass2);
		
		System.err.println(crptPassEnc.matches(ogi_pass, enc_pass));
		System.err.println(crptPassEnc.matches(ogi_pass, enc_pass2));
	}
}
