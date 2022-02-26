package com.aidan.portfoliotrackerv1.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aidan.portfoliotrackerv1.classes.Base;
import com.aidan.portfoliotrackerv1.classes.PropertiesReader;
import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.models.User;
import com.aidan.portfoliotrackerv1.models.Watchlist;
import com.aidan.portfoliotrackerv1.services.PositionService;
import com.aidan.portfoliotrackerv1.services.UserService;
import com.aidan.portfoliotrackerv1.services.WatchlistService;

@Controller
public class MainController {
	@Autowired
	private final UserService userService;
	@Autowired
	private final PositionService positionService;
	@Autowired
	private final WatchlistService watchlistService;
	
	//base api URL
	private String baseURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/";
	//api key
	private String apiKey = PropertiesReader.getProperty("API_KEY");
	
	@Autowired
	RestTemplate restTemplate;
	
	public MainController(UserService userService, WatchlistService watchlistService, PositionService positionService) {
		this.userService = userService;
        this.positionService = positionService;
        this.watchlistService = watchlistService;
	}
	
	// Method to check whether User is in Session or not
    public Long userSessionId(HttpSession session) {
    	if(session.getAttribute("userId") == null) {
    		return null;
    	} else {
    		return (Long)session.getAttribute("userId");
    	}
    }
    
	
	//get currency info page by id **WORKING**
	@GetMapping("/info/{apiId}")
	public String coinInfo(@ModelAttribute("thisWatchlist")Watchlist watching, @ModelAttribute("position")Position position, HttpSession session, Model model, @PathVariable("apiId") int apiId) {
		// get user from session, save them in the model and return the home page
    	Long userId = userSessionId(session);
    	if(userId == null) {
    		return "redirect:/";
    	}else {
    		System.out.println("printing apiId");
    		System.out.println(apiId);
    		System.out.println("************************************************************");
			Map QuotesBase = restTemplate.getForObject(this.baseURL + "quotes/latest?" + "id=" + apiId + "&" + apiKey, HashMap.class );
			Map data = (Map) QuotesBase.get("data");
			Map t = (Map) data.get(Integer.toString(apiId));

			
			User u = userService.findUserById(userId);
			System.out.println("after user u serv");
			System.out.println(u);
//			Integer k = (int) (long) userId;
//			System.out.println("inside if ");
			
			List<Watchlist> watchlist = watchlistService.findUsersInWatchlistByWatcherId(userId);
			System.out.println("after watchlist list query ");
			System.out.println(watchlist);
			
			System.out.println(watchlist);
			//watchlist.get(apiId)
			//get watchlists by user id, then get watchlists by apiId if == null then add
			//check every watching item, 
			if(watchlist.isEmpty() ) {
				var isInWatchlist = "no";
				model.addAttribute("isInWatchlist", isInWatchlist);
			}else {
				for( var i=0; i< watchlist.size(); i++) {
					
					int wApiId = watchlist.get(i).getApiId();
					if(wApiId == apiId) {		//check if api id is in said watchlist
						//is in watchlist
						Long WatchlistItemId = watchlist.get(i).getId();//watchlistService.findWatchlistById(watchlist.get(Long id));	//if apiId matches currently viewing coins apiId
						model.addAttribute("WatchlistItemId", WatchlistItemId);
						
						
					}
//					
				}
			}	
			
			model.addAttribute("currency", t);
			model.addAttribute("watchlist", watchlist);
			model.addAttribute("user", u);
			model.addAttribute("watching", watching.getApiId());
			System.out.println(watching.getApiId());

			
			return "ShowCurrency.jsp";
    	}
	}
	
	//get currency by symbol **WORKING**
	@GetMapping("/search")
	public String search(@RequestParam("symbol") String symbol) {
			Map QuotesBase = restTemplate.getForObject(this.baseURL + "quotes/latest?" + "symbol=" + symbol + "&" + apiKey, HashMap.class );
			Map data = (Map) QuotesBase.get("data");
			Map t = (Map) data.get(symbol.toUpperCase());
			int apiId = (int) t.get("id");
			
			return "redirect:/info/" + apiId;
		
	}
	
    //ADD TO WATCHLIST **WORKING** \\
	@PostMapping("/info/{apiId}/add_to_watchlist")
	public String addToWatchlist(@ModelAttribute("thisWatchlist")Watchlist watchlist ) {
		System.out.println(watchlist);
		watchlistService.createWatchlist(watchlist);
		System.out.println(watchlist);
		return "redirect:/info/{apiId}";
	}
	
    //REMOVE from watchlist **WORKING**
	@RequestMapping(value="/{id}/remove_from_watchlist", method=RequestMethod.DELETE)
	public String Delete(@PathVariable("id")Long id ) {
		System.out.println("******DELETING FROM WATCHLIST*******");
		Watchlist watchlist = watchlistService.findWatchlistById(id);
//		Long id = watchlist.getId();
		int apiId = watchlist.getApiId();
		watchlistService.deleteWatchlist(id);
		
		return "redirect:/info/" + apiId;
	}
	
	//ADD POSITION THROUGH INFO PAGE
    //add position
    @PostMapping("/info/{apiId}/create_position")
    public String createPosition(@Valid @ModelAttribute("position")Position position, BindingResult result, RedirectAttributes flashAttrib) {
    	if(result.hasErrors()) {
    		flashAttrib.addFlashAttribute("createError", "Position size can not be a null value.");
    		return "redirect:/info/{apiId}";
    	}else {
    		positionService.createPosition(position);
    		return "redirect:/dashboard";
    	}
    }
    //edit position page **WORKING**
	@GetMapping("/position/{id}/edit")
	public String editPosition(@PathVariable("id")Long id, Model model, HttpSession session) {
	Long userId = userSessionId(session);
    if(userId == null) {
    	return "redirect:/";
    }else {
    	Position position = positionService.findPositionById(id);
    	User user = positionService.findPositionById(id).getOwner();
    	var apiId = positionService.findPositionById(id).getApiId();
    			
    	Map QuotesBase = restTemplate.getForObject(this.baseURL + "quotes/latest?" + "id=" + apiId + "&" + apiKey, HashMap.class );
		Map data = (Map) QuotesBase.get("data");
		Map t = (Map) data.get(Integer.toString(apiId));	
    			
    	model.addAttribute("position", position);
    	model.addAttribute("user", user);
    	model.addAttribute("currency", t);
    	}
    	return "EditPosition.jsp";
	}
	
	//update position **FIX** when updating position size, it isnt allowing decimals 

	@RequestMapping(value="position/{id}/update", method=RequestMethod.PUT)
	public String update(@Valid @ModelAttribute("position")Position position, BindingResult result, @PathVariable("id")Long id, Model model, RedirectAttributes flashAttrib) {
		var apiId = positionService.findPositionById(id).getApiId();
		if(result.hasErrors()) {
			flashAttrib.addFlashAttribute("updateError", "Error: Updated positon size can not be null value.");
			User user = positionService.findPositionById(id).getOwner();
			
			Map QuotesBase = restTemplate.getForObject(this.baseURL + "quotes/latest?" + "id=" + apiId + "&" + apiKey, HashMap.class );
			Map data = (Map) QuotesBase.get("data");
			Map t = (Map) data.get(Integer.toString(apiId));

	    	model.addAttribute("position", position);
	    	model.addAttribute("user", user);
	    	model.addAttribute("currency", t);

	    	return "redirect:/position/{id}/edit";
		}else {
			positionService.updatePosition(position, apiId);
			return "redirect:/position/{id}/edit";
		}
	}
    //remove position
	@RequestMapping(value="/position/{id}/delete", method=RequestMethod.DELETE)
	public String DeletePosition(@PathVariable("id")Long id) {
		
		positionService.deletePositionById(id);
		
		return "redirect:/dashboard";
	}
    //top 200 page **WORKING**
    @GetMapping("/top200")
    public String top200(HttpSession session, Model model) {
    	// get user from session, save them in the model and return the home page
        Long userId = userSessionId(session);
        if(userId == null) {
        	return "redirect:/";
        }else {
        	User u = userService.findUserById(userId);
        	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);
        	model.addAttribute("user", u);
        	model.addAttribute("currencies", base.getData());
        	return "top200.jsp";
        }
    }
    
    //Risk Calculator page
    @GetMapping("/risk_calculator")
    public String RiskCalculator(HttpSession session, Model model) {
    	Long userId = userSessionId(session);
        if(userId == null) {
        	return "redirect:/";
        }else {
        	User u = userService.findUserById(userId);
        	model.addAttribute("user", u);
        	return "RiskCalculator.jsp";
        }
    	
    }
    
    //calculation
    @PostMapping("/calculate")
    public String calculate(HttpSession sessionModel, @RequestParam("amountRisked") float amountRisked, @RequestParam("potentialProfit") float potentialProfit, @RequestParam("probability") float probability) {
    	float rrr = amountRisked / potentialProfit;
    	float eo = ((potentialProfit * probability)-(amountRisked*(100-probability)))/10;
    	System.out.println(eo);
    	System.out.println(rrr);
    	sessionModel.setAttribute("eo", eo);
    	sessionModel.setAttribute("rrr", rrr);
    	sessionModel.setAttribute("aRisked", amountRisked);
    	sessionModel.setAttribute("pProfit", potentialProfit);
    	sessionModel.setAttribute("prob", probability);
    	return "redirect:/risk_calculator";
    }
    
//  //get currency by symbol **WORKING**
//  	@GetMapping("/search")
//  	public String search(@RequestParam("symbol") String symbol) {
//  			Map QuotesBase = restTemplate.getForObject(this.baseURL + "quotes/latest?" + "symbol=" + symbol + "&" + apiKey, HashMap.class );
//  			Map data = (Map) QuotesBase.get("data");
//  			Map t = (Map) data.get(symbol.toUpperCase());
//  			int apiId = (int) t.get("id");
//  			
//  			return "redirect:/info/" + apiId;
//  		
//  	}
}