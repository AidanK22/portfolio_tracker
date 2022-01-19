package com.aidan.portfoliotrackerv1.controllers;

import java.util.List;

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
import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.models.User;
import com.aidan.portfoliotrackerv1.models.Watchlist;
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
    
	//base URL
	private String baseURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/";
	
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
    	if(session.getAttribute("userId") == null) {
    		return null;
    	} else {
    		return (Long)session.getAttribute("userId");
    	}
    }
    
    //Login and Register User
    @GetMapping("/")
    public String index(@ModelAttribute("user") User user) {
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
    
    //After Login and Registration bring user to dashboard
    @RequestMapping("/dashboard")
    public String home(HttpSession session, Model model) {
        // get user from session, save them in the model and return the home page
    	Long userId = userSessionId(session);
    	if(userId == null) {
    		return "redirect:/";
    	}else {
	    	User u = userService.findUserById(userId);
	    	List<Position> positions = positionService.findAllPositions();
	    	List<Watchlist> watchlist = watchlistService.findAllInWatchlist();
	    	Base base = restTemplate.getForObject(this.baseURL + "/listings/latest?start=1&limit=200&", Base.class);

	    	model.addAttribute("user", u);
	    	model.addAttribute("positions", positions);
	    	model.addAttribute("watchlist", watchlist);
	    	model.addAttribute("currencies", base.getData());
	    	return "dashboard.jsp";
    	}
    }
    
    //logout 
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        // invalidate session
    	session.invalidate();
    	return "redirect:/";
        // redirect to login page
    }
}
