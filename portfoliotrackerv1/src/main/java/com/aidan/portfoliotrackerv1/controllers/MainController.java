package com.aidan.portfoliotrackerv1.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

import com.aidan.portfoliotrackerv1.classes.Base;

@Controller
public class MainController {
	
	private String baseURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/";
	
	@Autowired
	RestTemplate restTemplate;
	
	
	//get currency info
	@GetMapping("/info/{apiId}")
	public String coinInfo(HttpSession session, Model model, @PathVariable("apiId") int apiId) {
		Base base = restTemplate.getForObject(this.baseURL + "/quotes/latest?" + "id=" + apiId + "&" + "CMC_PRO_API_KEY=04c49eb4-f4d9-4a7a-8817-174f06e95b72", Base.class );
				model.addAttribute("currencies", base.getData());
		return "ShowCurrency.jsp";
	}
	
}
 