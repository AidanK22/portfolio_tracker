package com.aidan.portfoliotrackerv1.controllers;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aidan.portfoliotrackerv1.classes.Base;
import com.aidan.portfoliotrackerv1.classes.PropertiesReader;
import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.models.User;
import com.aidan.portfoliotrackerv1.models.Watchlist;
import com.aidan.portfoliotrackerv1.repositories.WatchlistRepo;
import com.aidan.portfoliotrackerv1.services.PositionService;
import com.aidan.portfoliotrackerv1.services.WatchlistService;
import com.aidan.portfoliotrackerv1.services.UserService;
import com.aidan.portfoliotrackerv1.validator.UserValidator;

@Controller
public class UserController {
	@Autowired
	private final UserService userService;
	@Autowired
	private final PositionService positionService;
	@Autowired
	private final WatchlistService watchlistService;
	@Autowired
	private UserValidator userValidator;
    @Autowired
    private WatchlistRepo watchlistRepo;
    
    //api key
    private String apiKey = PropertiesReader.getProperty("API_KEY");	//api key
	//base URL
	private String baseURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/";	//base url used for all pai calls
	
	private String v2BaseURL = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/";	//base url for all api calls using version 2 
	@Autowired
	RestTemplate restTemplate;
	
    
    public UserController(UserService userService, WatchlistService watchlistService, PositionService positionService, UserValidator userValidator) {
        this.userService = userService;
        this.positionService = positionService;
        this.watchlistService = watchlistService;
        this.userValidator = userValidator;
    }
    

    // Method to check whether User is in Session or not
    public Long userSessionId(HttpSession session) {
    	if(session.getAttribute("userId") == null) {	//if user is in session is null
    		return null;	//return null
    	} else {	//else if the user in session is not null
    		return (Long)session.getAttribute("userId");	//get that user's id
    	}
    }
    
    //Login and Register User
    @GetMapping("/")
    public String index(@ModelAttribute("user") User user) {
    	Long id = (long) 1;
//    	System.out.println(watchlistRepo.findAllByWatcher(id));
    	return "LoginRegister.jsp";
    }
    
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
    	userValidator.validate(user, result);
        // if result has errors, return the registration page (don't worry about validations just now)
    	if(result.hasErrors()) {
    		return "LoginRegister.jsp";
    	}
        // else, save the user in the database, save the user id in session, and redirect them to the /home route
    	User u = userService.registerUser(user);
    	session.setAttribute("userId", u.getId());
    	return "redirect:/dashboard";
    }
    
    @PostMapping("/login")
    public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session, RedirectAttributes flashAttrib) {
    	// if the user is authenticated, save their user id in session
    	boolean isAuthenticated = userService.authenticateUser(email, password);
    	if(isAuthenticated) {
    		User u = userService.findByEmail(email);
    		session.setAttribute("userId", u.getId());

    		return "redirect:/dashboard";
    	}else {        // else, add error messages and return the login page
    		flashAttrib.addFlashAttribute("loginError", "Invalid username or password. Try again.");
    		
    		return "redirect:/";
    	}

    }
//    //new user dashboard
//    @RequestMapping("/new_user_dashboard")
//    public String newUserHome(Http session,Model model) {
//    	Long userId = userSessionId(session);
//    	if(userId == null) {
//    		return "redirect:/";
//    	}else {
//    		User u = userService.findUserById(userId);
//	    	List<Position> positions =	positionService.findPositionsByOwner(u);//  findAllPositions()
//    		List<Watchlist> watchlist = watchlistService.findWatchlistByWatcher(u); 	//findAllInWatchlist()
//	    	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);
//	    	model.addAttribute("user", u);
//	    	model.addAttribute("positions", positions);
//	    	model.addAttribute("watchlist", watchlist);
//	    	model.addAttribute("currencies", base.getData());
//    	}
//    }
    //After Login and Registration bring user to dashboard
    @RequestMapping("/dashboard")
    public String home(HttpSession session, Model model) {
        // get user from session, save them in the model and return the home page
    	Long userId = userSessionId(session);
    	if(userId == null) {	//if user is not in session
    		var accountValue = 0;	//default account value of 0
    		var amountOfPositions = 0;	//default amount of positions is 0
	    	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);	//api call to recieve json data
	    	model.addAttribute("currencies", base.getData());	//from json get table 'data' send to template
	    	model.addAttribute("accountValue", accountValue);	//send account value to template
			model.addAttribute("amountOfPositions", amountOfPositions);	//send amount of positions to template
        	String i = "Guest";	//assign string 'guest' to i
        	model.addAttribute("noUser", i);	//assign i to 'noUser' and sent to template
	    	return "dashboard.jsp";
    	}else {	//if user is in session
	    	User u = userService.findUserById(userId);	//find user by the id
	    	
	    	List<Position> positions =	positionService.findPositionsByOwner(u);//  findAllPositions()

	    	List<Watchlist> watchlist = watchlistService.findWatchlistByWatcher(u); 	//findAllInWatchlist()
	    	Base base = restTemplate.getForObject(this.baseURL + "listings/latest?start=1&limit=200&" + apiKey, Base.class);
//	    	var d = base.getData().get("price");
//	    	int price = d.get("price");
	    	//check if anything is in position
			//positions
	    		var amountOfPositions = 0;	//default amount of positions set to 0
	    		model.addAttribute("amountOfPositions", amountOfPositions);	//adds amount of positions default of 0 to template
		    	if(u.getWatchlist().size() > 0) {	//if the users watchlist size is greater than 0
		    	
		    	List apiIdsToGet = new ArrayList(); //creates a lit that will hold the api Id we are grabbing

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
		    			if(!apiIdsToGet.contains(apiId) ) {	//if apiIdsToGet does not contain apiId then..
		    				apiIdsToGet.add(apiId);		//add api id to list
		    			}
		    	}
		    	
		    	//creates comma separated list
		    	newApiIdList = apiIdsToGet.toString();	//sets aoiIdsToGet to a new list newApiIdList
		    	newApiIdList = newApiIdList.replace("[", "").replace("]", "").replace(" ", "");	//removes the '[',']' and ' ' from the string to be used in the api call
		    	
		    	//api call
				Map QuotesBase = restTemplate.getForObject(this.v2BaseURL + "quotes/latest?" + "id=" + newApiIdList + "&" + apiKey, HashMap.class );	//api call
				Map data = (Map) QuotesBase.get("data");	//get data table in json data returned
				String[] finalIds = newApiIdList.split(",");	//string finalIds stores the last string of ids needed to make the api call
				List finalPosArrayList = new ArrayList();	//the final list of positions
				//account value
		    	var accountValue = 0;	//default account value set to 0
		    	amountOfPositions = 0;	//default amount of positions is 0

		    	for(var i=0; i<positions.size(); i++) {	//for each position is positions
		    		amountOfPositions += 1;	//add 1 to the amount of positions
		    		int apiId = positions.get(i).getApiId();	//for that position grab it's apiId
		    		Map coinId = (Map) data.get(Integer.toString(apiId));	//using the previously grabbed apId grab the matching id from the returned json table
		    		Map	coinQuote = (Map) coinId.get("quote");	//grab table called 'data'
		    		Map coinUsd = (Map) coinQuote.get("USD");	//grab table called 'USD'
		    		Double coinPrice = (Double) coinUsd.get("price");	//create a double named coinPrice attaching it to the price returned from the json table

		    		accountValue += positions.get(i).getPositionSize() * coinPrice;	//for each positions multiply the price times the amount owned by the user
		    	}
				for( var i =0 ; i< finalIds.length ; i++) {	//for all the ids that are apart of the final list
					finalPosArrayList.add((Map) data.get(finalIds[i])); //add from json data the apiId used to access the json table for that specific currency
				}
				
				model.addAttribute("pcurrencies", finalPosArrayList);
		    	
					model.addAttribute("accountValue", accountValue);	//account value to template
					model.addAttribute("amountOfPositions", amountOfPositions);	//amount of positions to template
		    	}
		    		
	    	model.addAttribute("user", u);	//user to template
	    	model.addAttribute("positions", positions);	//user's positions to template
	    	model.addAttribute("watchlist", watchlist);	//user's wishlist to template
	    	model.addAttribute("currencies", base.getData());	//currency data to template
	    	
	    	
	    	return "dashboard.jsp";
    	}
    }
    
    //logout 
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        // invalidate session
    	session.invalidate();	//clears session
    	return "redirect:/"; //returns to login page
        // redirect to login page
    }
    
    
}
