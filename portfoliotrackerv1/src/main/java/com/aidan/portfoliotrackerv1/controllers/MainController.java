package com.aidan.portfoliotrackerv1.controllers;

import java.util.ArrayList;
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
	
	private String v2BaseURL = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/";

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
    	

			Map QuotesBase = restTemplate.getForObject(this.v2BaseURL + "quotes/latest?" + "id=" + apiId + "&" + apiKey, HashMap.class );//api call using the apiId to call data for correct currency
			Map data = (Map) QuotesBase.get("data");	//from returned json data  grab data table
			Map t = (Map) data.get(Integer.toString(apiId));	//using apidId grab the id from returned json data allowing access to all needed information
			

			//gets meta data urls
			Map MetaDataBase = restTemplate.getForObject(this.v2BaseURL + "info?" + "id=" + apiId + "&" + apiKey, HashMap.class );	//api call using the apiId to call data for correct currency
			Map metadata = (Map) MetaDataBase.get("data");	//from returned json data  grab data table
			Map mdt = (Map) metadata.get(Integer.toString(apiId));	//using apidId grab the id from returned json data allowing access to all needed information
			Map MetaDataUrls = (Map) mdt.get("urls");	//in returned json data grab table 'data'
			
			//get websites
			List MetaDataWebsite = (List) MetaDataUrls.get("website");//in returned json data grab table 'websites'

			//gets explorers
			List MetaDataExplorer = (List) MetaDataUrls.get("explorer");//in returned json data grab table 'explorer'
			
			//get message boards
			List MetaDataMessageBoard = (List) MetaDataUrls.get("message_board");//in returned json data grab table 'message_board'
			
			//get chats
			List MetaDataChat = (List) MetaDataUrls.get("chat");//in returned json data grab table 'chat'
			
			if( userId != null) {
				
				
			//get user data
			User u = userService.findUserById(userId);

			List<Watchlist> watchlist = watchlistService.findUsersInWatchlistByWatcherId(userId);
			
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
			model.addAttribute("user", u);
			model.addAttribute("watchlist", watchlist);

			}
        	String i = "Guest";	//when no user is signed this will be used instead of user.firstname
        	model.addAttribute("noUser", i);
			model.addAttribute("currencyMD", mdt);
			model.addAttribute("CMDExplorer", MetaDataExplorer);
			model.addAttribute("CMDWebsite", MetaDataWebsite);
			model.addAttribute("CMDMessageBoard", MetaDataMessageBoard);
			model.addAttribute("CMDChat", MetaDataChat);
		
			model.addAttribute("currency", t);
			
			model.addAttribute("watching", watching.getApiId());
			System.out.println(watching.getApiId());

			
			return "ShowCurrency.jsp";
    	
	}
	
	//get currency by symbol **BROKE**
	@GetMapping("/search")
	public String search(@RequestParam("symbol") String symbol) {
			Map QuotesBase = restTemplate.getForObject(this.v2BaseURL + "quotes/latest?" + "symbol=" + symbol + "&" + apiKey, HashMap.class );
			System.out.println("Printing QuotesBase==");
			System.out.println(QuotesBase);
			
			Map data = (Map) QuotesBase.get("data");
			System.out.println("Printing DATA==");
			System.out.println(data);
			//stops printing
			//error says arrList cannot be cast to Map
			Map t = (Map) data.get(symbol.toUpperCase());//error:"class java.util.ArrayList cannot be cast to class java.util.Map (java.util.ArrayList and java.util.Map are in module java.base of loader 'bootstrap')java.lang.ClassCastException: class java.util.ArrayList cannot be cast to class java.util.Map (java.util.ArrayList and java.util.Map are in module java.base of loader 'bootstrap')"
			System.out.println("Printing T==");
			System.out.println(t);
			
			int apiId = (int) t.get("id");
			System.out.println("Printing apiId==");
			System.out.println(apiId);
			
			return "redirect:/info/" + apiId;
		
	}
	
    //ADD TO WATCHLIST **WORKING** \\
	@PostMapping("/info/{apiId}/add_to_watchlist")
	public String addToWatchlist(@ModelAttribute("thisWatchlist")Watchlist watchlist, HttpSession session) {
		Long userId = userSessionId(session);
		if(userId == null) {
    		return "redirect:/";
    	}else {
		watchlistService.createWatchlist(watchlist);	//add currency to watchlist
		return "redirect:/info/{apiId}";
    	}
	}
	
    //REMOVE from watchlist **WORKING**
	@RequestMapping(value="/{id}/remove_from_watchlist", method=RequestMethod.DELETE)
	public String Delete(@PathVariable("id")Long id ) {
		System.out.println("******DELETING FROM WATCHLIST*******");
		Watchlist watchlist = watchlistService.findWatchlistById(id); //grab the watlist by its id
//		Long id = watchlist.getId();
		int apiId = watchlist.getApiId(); //get the apiId from the watchlist
		watchlistService.deleteWatchlist(id);	//delete currency from watchlist by id
		
		return "redirect:/info/" + apiId; //return to currency's info page by apiId
	}
	
	//ADD POSITION THROUGH INFO PAGE
    @PostMapping("/info/{apiId}/create_position")
    public String createPosition(@Valid @ModelAttribute("position")Position position, BindingResult result, HttpSession session, RedirectAttributes flashAttrib) {
    	Long userId = userSessionId(session);
		if(userId == null) {
    		return "redirect:/";
    	}else {
	    	if(result.hasErrors()) {
	    		flashAttrib.addFlashAttribute("createError", "Position size can not be a null value.");	//if there was an error  
	    		return "redirect:/info/{apiId}";
	    	}else {
	    		positionService.createPosition(position);	//creates position
	    		return "redirect:/dashboard";
	    	}
    	}
    }
    
    //edit position page **WORKING**
	@GetMapping("/position/{id}/edit")
	public String editPosition(@PathVariable("id")Long id, Model model, HttpSession session) {
	Long userId = userSessionId(session);
    if(userId == null) {
    	return "redirect:/";
    }else {
    	Position position = positionService.findPositionById(id);		//grab position by position's id
    	User user = positionService.findPositionById(id).getOwner();	//grab position by id then get the owner
    	var apiId = positionService.findPositionById(id).getApiId();	//grab the position by id then get it's stored apiId
    			
    	Map QuotesBase = restTemplate.getForObject(this.baseURL + "quotes/latest?" + "id=" + apiId + "&" + apiKey, HashMap.class );	//api call using the apiId to call data for correct currency
		Map data = (Map) QuotesBase.get("data");	//from returned json data  grab data table
		Map t = (Map) data.get(Integer.toString(apiId));	//using apidId grab the id from returned json data allowing access to all needed information
    			
    	model.addAttribute("position", position);
    	model.addAttribute("user", user);
    	model.addAttribute("currency", t);
    	}
    	return "EditPosition.jsp";
	}
	
	//update position **WORKING** 
	@RequestMapping(value="position/{id}/update", method=RequestMethod.PUT)
	public String update(@Valid @ModelAttribute("position")Position position, BindingResult result, @PathVariable("id")Long id, Model model, RedirectAttributes flashAttrib) {
		var apiId = positionService.findPositionById(id).getApiId();	//find position by id then grab that position's apiId
		if(result.hasErrors()) {	//if returned form has errors
			flashAttrib.addFlashAttribute("updateError", "Error: Updated positon size can not be null value.");	//using flash attribute assign the error to 'updateError'
			User user = positionService.findPositionById(id).getOwner();
			
			Map QuotesBase = restTemplate.getForObject(this.baseURL + "quotes/latest?" + "id=" + apiId + "&" + apiKey, HashMap.class );	//api call using the apiId to call data for correct currency
			Map data = (Map) QuotesBase.get("data");	//from returned json data  grab data table
			Map t = (Map) data.get(Integer.toString(apiId));	//using apidId grab the id from returned json data allowing access to all needed information

	    	model.addAttribute("position", position);
	    	model.addAttribute("user", user);
	    	model.addAttribute("currency", t);

	    	return "redirect:/position/{id}/edit";
		}else {
			positionService.updatePosition(position, apiId);	//update position by apiId
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
        if(userId != null) {
        	User u = userService.findUserById(userId);
        	model.addAttribute("user", u);
        	return "top200.jsp";
        }
        	
        	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);
        	model.addAttribute("currencies", base.getData());
        	String i = "Guest";
        	model.addAttribute("noUser", i);
        	return "top200.jsp";
        }
    
    //Risk Calculator page
    @GetMapping("/risk_calculator")
    public String RiskCalculator(HttpSession session, Model model) {
    	Long userId = userSessionId(session); //if user is logged into the session it grabs users id
    	if(userId != null) { //check if user is not in session, if it is
        	User u = userService.findUserById(userId); //grabs user from session
        	model.addAttribute("user", u);	//pass user to  template
        	return "RiskCalculator.jsp";	//send to risk calculator page
    	}
    	String i = "Guest";
    	model.addAttribute("noUser", i);
    	return "RiskCalculator.jsp";
    }
    
    //calculation
    @PostMapping("/calculate")
    public String calculate(HttpSession sessionModel, @RequestParam("amountRisked") float amountRisked, @RequestParam("potentialProfit") float potentialProfit, @RequestParam("probability") float probability) {
    	float rrr = amountRisked / potentialProfit; //risk to reward ratio = the amount of money you are risking divided by the amount of money you stand to make
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
    
    
    //------------------account details------------------\\
    @GetMapping("/account_details")
    public String accountDetails(HttpSession session, Model model) {
    	Long userId = userSessionId(session);	//grab user from session
        if(userId == null) {	//check if user is in session
        	return "redirect:/";	//if user not in session, redirect to login page
        }else {		//if user IS in session
        	User u = userService.findUserById(userId);	

	    	
	    	List<Position> positions =	positionService.findPositionsByOwner(u);//  findAllPositions()

	    	List<Watchlist> watchlist = watchlistService.findWatchlistByWatcher(u); 	//findAllInWatchlist()
	    	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);
//	    	var d = base.getData().get("price");
//	    	int price = d.get("price");
	    	//check if anything is in position
			//positions
	    		var amountOfPositions = 0;
	    		model.addAttribute("amountOfPositions", amountOfPositions);
		    	if(u.getWatchlist().size() > 0) {	//if watchlist is greater than 0
		    	
		    	List apiIdsToGet = new ArrayList(); 	//create list variable to store apiIds

		    	String newApiIdList = "";	//create empty list to add api ids to
		    	
		    	//add positions apiIds to list
		    	for(var i=0; i<positions.size(); i++) { 	//loop through positions
		    		int apiId = positions.get(i).getApiId(); 	//grab api Id from the position
		    			if(!apiIdsToGet.contains(apiId) ) {
		    				apiIdsToGet.add(apiId);		//add api id to list
		    			}
		    	}
		    	//add watchlist apiIds to list
		    	
		    	for(var i=0; i<watchlist.size(); i++) { 	//loop through watchlist
		    		
		    		int apiId = watchlist.get(i).getApiId(); 	//grab api Id from the watchlist
		    			if(!apiIdsToGet.contains(apiId) ) {
		    				apiIdsToGet.add(apiId);		//add api id to list
		    			}
		    	}
		    	
		    	//creates comma separated list
		    	newApiIdList = apiIdsToGet.toString();	
		    	newApiIdList = newApiIdList.replace("[", "").replace("]", "").replace(" ", "");
		    	
		    	//api call
				Map QuotesBase = restTemplate.getForObject(this.v2BaseURL + "quotes/latest?" + "id=" + newApiIdList + "&" + apiKey, HashMap.class );	//api call
				Map data = (Map) QuotesBase.get("data");	//get data table in json data returned
				String[] finalIds = newApiIdList.split(",");
				List finalPosArrayList = new ArrayList();
				//account value
		    	var accountValue = 0;
		    	amountOfPositions = 0;
		    	System.out.println("accountValue:");
				System.out.println(accountValue);
		    	for(var i=0; i<positions.size(); i++) {
		    		amountOfPositions += 1;
		    		int apiId = positions.get(i).getApiId(); //get api id saved in the position
		    		Map coinId = (Map) data.get(Integer.toString(apiId)); //use api id to access currency's info
		    		Map	coinQuote = (Map) coinId.get("quote"); //get the quote section being returned in the json from the api call
		    		Map coinUsd = (Map) coinQuote.get("USD"); //access USD section
		    		Double coinPrice = (Double) coinUsd.get("price");	//save currency's current price

		    		accountValue += positions.get(i).getPositionSize() * coinPrice;	//add to account value
		    	}
				for( var i =0 ; i< finalIds.length ; i++) {
					finalPosArrayList.add((Map) data.get(finalIds[i]));
				}
				
				model.addAttribute("pcurrencies", finalPosArrayList);
		    	
			    	System.out.println("accountValue:");
					System.out.println(accountValue);
					model.addAttribute("accountValue", accountValue);
					model.addAttribute("amountOfPositions", amountOfPositions);
		    	}
		    		
	    	model.addAttribute("user", u);
	    	model.addAttribute("positions", positions);
	    	model.addAttribute("watchlist", watchlist);
	    	model.addAttribute("currencies", base.getData());
	    	
        	
        	return "AccountDetails.jsp";
        }
    }
}