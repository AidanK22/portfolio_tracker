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
    	if(session.getAttribute("userId") == null) {	//check if there is an attribute attached to 'userId'
    		return null;	//if none return null
    	} else {
    		return (Long)session.getAttribute("userId");	//if there is return attribute 'userId'
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
			User u = userService.findUserById(userId);	//from id saved from session grab the users 

			List<Watchlist> watchlist = watchlistService.findUsersInWatchlistByWatcherId(userId);	//grabs the user's watchlist if it exists
			
			System.out.println(watchlist);
			//watchlist.get(apiId)
			//get watchlists by user id, then get watchlists by apiId if == null then add
			//check every watching item, 
			if(watchlist.isEmpty() ) {	//if the user's watchlist is empty
				var isInWatchlist = "no";	//sets a variable to no for an if check on the front side
				model.addAttribute("isInWatchlist", isInWatchlist);	//sends to front end template
			}else {
				for( var i=0; i< watchlist.size(); i++) {				//for each item in the user's watchlist...
					
					int wApiId = watchlist.get(i).getApiId();			//get watchlist's apiId
					if(wApiId == apiId) {								//check if api id is in said watchlist
						//is in watchlist
						Long WatchlistItemId = watchlist.get(i).getId();//watchlistService.findWatchlistById(watchlist.get(Long id));	//if apiId matches currently viewing coins apiId
						model.addAttribute("WatchlistItemId", WatchlistItemId);	//add watchlistItemId to template
						
						
					}
//					
				}
			}
			model.addAttribute("user", u);
			model.addAttribute("watchlist", watchlist);

			}
        	String i = "Guest";	//when no user is signed this will be used instead of user.firstname
        	model.addAttribute("noUser", i);	//assign i to 'noUser' to be referred to in the template
			model.addAttribute("currencyMD", mdt);	//adds meta data to template
			model.addAttribute("CMDExplorer", MetaDataExplorer);	//add meta data Explorer info
			model.addAttribute("CMDWebsite", MetaDataWebsite);		//add meta data website info
			model.addAttribute("CMDMessageBoard", MetaDataMessageBoard);	//add meta data messageBoard info
			model.addAttribute("CMDChat", MetaDataChat);		//add meta data chat to template
		
			model.addAttribute("currency", t);	//currency info from api call using apiId sent to template
			
			model.addAttribute("watching", watching.getApiId());	//if the currency is in the users watchlist itll be true and if not false, this is sent to template
			System.out.println(watching.getApiId());

			
			return "ShowCurrency.jsp";
    	
	}
	
	//get currency by symbol **BROKE**
	@GetMapping("/search")
	public String search(@RequestParam("symbol") String symbol) {
			Map QuotesBase = restTemplate.getForObject(this.v2BaseURL + "quotes/latest?" + "symbol=" + symbol + "&" + apiKey, HashMap.class );//api call by symbol
			System.out.println("Printing QuotesBase==");
			System.out.println(QuotesBase);
			
			Map data = (Map) QuotesBase.get("data");	//gets data table from api call and assigns it to 'data'
			System.out.println("Printing DATA==");
			System.out.println(data);
			//stops printing
			//error says arrList cannot be cast to Map
			Map t = (Map) data.get(symbol.toUpperCase());//error:"class java.util.ArrayList cannot be cast to class java.util.Map (java.util.ArrayList and java.util.Map are in module java.base of loader 'bootstrap')java.lang.ClassCastException: class java.util.ArrayList cannot be cast to class java.util.Map (java.util.ArrayList and java.util.Map are in module java.base of loader 'bootstrap')"
			System.out.println("Printing T==");
			System.out.println(t);
			
			int apiId = (int) t.get("id");	//after getting the currencies data and assigning it to 't' get the id and assign it to apiId
			System.out.println("Printing apiId==");
			System.out.println(apiId);
			
			return "redirect:/info/" + apiId;
		
	}
	
    //ADD TO WATCHLIST **WORKING** \\
	@PostMapping("/info/{apiId}/add_to_watchlist")
	public String addToWatchlist(@ModelAttribute("thisWatchlist")Watchlist watchlist, HttpSession session) {
		Long userId = userSessionId(session);	//grabs the user in session if there is one
		if(userId == null) {	//if  there is no user in session
    		return "redirect:/";	//redirect to root route or login page
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
    	Long userId = userSessionId(session);	//gets user in session if there is one
		if(userId == null) {	//if there is not a user in session
    		return "redirect:/";
    	}else {
	    	if(result.hasErrors()) {	//if user's input has errors
	    		flashAttrib.addFlashAttribute("createError", "Position size can not be a null value.");	//if there was an error  
	    		return "redirect:/info/{apiId}";
	    	}else {
	    		positionService.createPosition(position);	//creates position
	    		return "redirect:/dashboard";	//redirects to dashboard page
	    	}
    	}
    }
    
    //edit position page **WORKING**
	@GetMapping("/position/{id}/edit")
	public String editPosition(@PathVariable("id")Long id, Model model, HttpSession session) {
	Long userId = userSessionId(session);	//gets user in session if there is one
    if(userId == null) {	//if user is not in session
    	System.out.println("user is null in position edit");
    	return "redirect:/";	//redirect to login page
    }else {
    	Position position = positionService.findPositionById(id);		//grab position by position's id
    	User user = positionService.findPositionById(id).getOwner();	//grab position by id then get the owner
    	var apiId = positionService.findPositionById(id).getApiId();	//grab the position by id then get it's stored apiId
    			
    	Map QuotesBase = restTemplate.getForObject(this.baseURL + "quotes/latest?" + "id=" + apiId + "&" + apiKey, HashMap.class );	//api call using the apiId to call data for correct currency
		Map data = (Map) QuotesBase.get("data");	//from returned json data  grab data table
		Map t = (Map) data.get(Integer.toString(apiId));	//using apidId grab the id from returned json data allowing access to all needed information
    			
    	model.addAttribute("position", position);	//sends position's data to template
    	model.addAttribute("user", user);	//sends users data to template
    	model.addAttribute("currency", t);	//sends currency's data to template
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

	    	model.addAttribute("position", position);	//sends position's data to template
	    	model.addAttribute("user", user);	//sends users data to template
	    	model.addAttribute("currency", t);	//sends currency's data to template

	    	return "redirect:/position/{id}/edit";
		}else {
			positionService.updatePosition(position, apiId);	//update position by apiId
			return "redirect:/position/{id}/edit";
		}
	}
	
    //remove position
	@RequestMapping(value="/position/{id}/delete", method=RequestMethod.DELETE)
	public String DeletePosition(@PathVariable("id")Long id) {
		
		positionService.deletePositionById(id);	//deletes the position by the position's id
		
		
		return "redirect:/dashboard";
	}
	
    //top 200 page **WORKING**
    @GetMapping("/top200")
    public String top200(HttpSession session, Model model) {
    	// get user from session, save them in the model and return the home page
        Long userId = userSessionId(session);
        if(userId != null) {	//if user in session is not null
        	User u = userService.findUserById(userId);	//user service
        	model.addAttribute("user", u);	//=user passed to template
        	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);	//api call to recieve json data
	    	model.addAttribute("currencies", base.getData());	//from json get table 'data' send to template
        	System.out.println(base.getData());

	    	//        	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);
//        	
//        	Map data = (Map) base.getData();//trying to map each bin[0] and [1] to separate variables
//        	
////        	Map table1 = (Map) data.get();
//        	model.addAttribute("currencies", base.getData());
        	return "top200.jsp";
        }
        	
//        	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);
//        	
//        	Map data = (Map) base.getData();//trying to map each bin[0] and [1] to separate variables
//        	
////        	Map table1 = (Map) data.get();
//        	model.addAttribute("currencies", base.getData());
        	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);	//api call to recieve json data
    		model.addAttribute("currencies", base.getData());	//from json get table 'data' send to template
        	System.out.println(base.getData());
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
    	String i = "Guest";		//sets i to 'Guest"'
    	model.addAttribute("noUser", i);	//sets model template variable 'noUser' to i
    	return "RiskCalculator.jsp";
    }
    
    //calculation
    @PostMapping("/calculate")
    public String calculate(HttpSession sessionModel, @RequestParam("amountRisked") float amountRisked, @RequestParam("potentialProfit") float potentialProfit, @RequestParam("probability") float probability) {
    	float rrr = amountRisked / potentialProfit; //risk to reward ratio = the amount of money you are risking divided by the amount of money you stand to make
    	float eo = ((potentialProfit * probability)-(amountRisked*(100-probability)))/10;	//calculation for expect outcome
    	System.out.println(eo);
    	System.out.println(rrr);
    	sessionModel.setAttribute("eo", eo);	//the expected outcome sent to the template
    	sessionModel.setAttribute("rrr", rrr);	//risk to reward sent to template
    	sessionModel.setAttribute("aRisked", amountRisked);		//amount risked sent to template
    	sessionModel.setAttribute("pProfit", potentialProfit);		//potential profit  sent to template
    	sessionModel.setAttribute("prob", probability);	//probability of outcome sent to template
    	return "redirect:/risk_calculator";
    }
    
    
    //------------------account details------------------\\
    @GetMapping("/account_details/{userId}")
    public String accountDetails(HttpSession session, Model model) {
    	Long userId = userSessionId(session);	//grab user from session
        if(userId == null) {	//check if user is in session
        	System.out.println("user is null");
        	return "redirect:/";//needed to change it to this for some reason but it gave error when you try to load this page when not logged in instead of redirecting to login page>{return "LoginRegister.jsp";}	//if user not in session, redirect to login page
        }else {		//if user IS in session
        	User u = userService.findUserById(userId);	//gets the user id from session and finds that user attaching it to u

	    	
	    	List<Position> positions =	positionService.findPositionsByOwner(u);//  findAllPositions()

	    	List<Watchlist> watchlist = watchlistService.findWatchlistByWatcher(u); 	//findAllInWatchlist()
	    	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);
//	    	var d = base.getData().get("price");
//	    	int price = d.get("price");
	    	//check if anything is in position
			//positions
	    		var amountOfPositions = 0;
		    	var accountValue = 0;	//sets account value to default of 0
	    		model.addAttribute("amountOfPositions", amountOfPositions);	//sends amount of positions to template
	    		model.addAttribute("accountValue", accountValue);	//account value default value of 0 passed to template
	    		if(u.getWatchlist().size() > 0 || u.getPositions().size() > 0) {	//if watchlist is greater than 0
		    	
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
		    	newApiIdList = apiIdsToGet.toString();	//takes lists and adds it to a string
		    	newApiIdList = newApiIdList.replace("[", "").replace("]", "").replace(" ", "");	//then takes that string and removes the '[' , ']' and ' ' (spaces) 
		    	
		    	//api call
				Map QuotesBase = restTemplate.getForObject(this.v2BaseURL + "quotes/latest?" + "id=" + newApiIdList + "&" + apiKey, HashMap.class );	//api call
				Map data = (Map) QuotesBase.get("data");	//get data table in json data returned
				String[] finalIds = newApiIdList.split(",");
				List finalPosArrayList = new ArrayList();
				//account value

		    	amountOfPositions = 0;
		    	System.out.println("accountValue:");
				System.out.println(accountValue);
		    	for(var i=0; i<positions.size(); i++) {		//for each i in length of positions starting at index of 0, incrementing by 1
		    		amountOfPositions += 1;		//adds 1 to the amount of positions variable
		    		int apiId = positions.get(i).getApiId(); //get api id saved in the position
		    		Map coinId = (Map) data.get(Integer.toString(apiId)); //use api id to access currency's info
		    		Map	coinQuote = (Map) coinId.get("quote"); //get the quote section being returned in the json from the api call
		    		Map coinUsd = (Map) coinQuote.get("USD"); //access USD section
		    		Double coinPrice = (Double) coinUsd.get("price");	//save currency's current price

		    		accountValue += positions.get(i).getPositionSize() * coinPrice;	//add to account value
		    	}
				for( var i =0 ; i< finalIds.length ; i++) {		//for each i in the length of finalIds starting at index of 0, incrementing by 1 
					finalPosArrayList.add((Map) data.get(finalIds[i]));	//takes index of i in finalIds and add it to a new list finalPosArrayList
				}
				
				model.addAttribute("pcurrencies", finalPosArrayList);	//adds the users positions to template model
		    	
			    	System.out.println("accountValue:");
					System.out.println(accountValue);
					model.addAttribute("accountValue", accountValue);	//adds account value to model attribute sent to template
					model.addAttribute("amountOfPositions", amountOfPositions);	//add amount of positions to model attribute sent to template
		    	}
		    		
	    	model.addAttribute("user", u);	//add user to model attribute and is sent to template
	    	model.addAttribute("positions", positions);	//add positions to model attribute and sends to template
	    	model.addAttribute("watchlist", watchlist);		//add watchlist to model attribute and sends to template
	    	model.addAttribute("currencies", base.getData());	//gets the base info level for all currencies returned from api call 
	    	
        	
        	return "AccountDetails.jsp";
        }
    }
}