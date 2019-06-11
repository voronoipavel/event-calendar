package eventscalendar.eventscalendar.controllers;

import eventscalendar.eventscalendar.models.Event;
import eventscalendar.eventscalendar.models.User;
import eventscalendar.eventscalendar.services.EventService;
import eventscalendar.eventscalendar.services.UserService;
import eventscalendar.eventscalendar.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
    private UserValidator userValidator;
	@Autowired
    private EventService eventService;

	private List<String> locations = Arrays.asList("Chui region", "Batken region", "Jalal-Abad region", "Issyk-Kul region", "Naryn region", "Osh region", "Talas region");
    
    @RequestMapping("/")
	public String registerForm(@ModelAttribute("user") User user, Model model) {
    	//List<String> locations = Arrays.asList("01", "02", "03", "04", "05", "06", "07");
    	model.addAttribute("locations", locations);
		return "/users/logReg.jsp";
	}

	@RequestMapping(value="/registration", method=RequestMethod.POST)
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, Model model, HttpSession session) {
		userValidator.validate(user, result);
		if(result.hasErrors()) {
			System.out.println("Errors Found");
			//List<String> locations = Arrays.asList("01", "02", "03", "04", "05", "06", "07");
	    	model.addAttribute("locations", locations);
			return "/users/logReg.jsp";
		}
		else {
			User u = userService.registerUser(user);
			System.out.println("New USER Created: " + user.getEmail());
			session.setAttribute("userId", u.getId());
			return "redirect:/home";
		}
    }
	@PostMapping
	@RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginUser(@ModelAttribute("user") User user, BindingResult errors,
							@RequestParam("email") String email,
							@RequestParam("password") String password, Model model, HttpSession session) {
		boolean verify = userService.authenticateUser(email, password);
		if(!verify) {
			model.addAttribute("error", "Invalid Credentials. Try again");
			//List<String> locations = Arrays.asList("01", "02", "03", "04", "05", "06", "07");
	    	model.addAttribute("locations", locations);
			return "/users/logReg.jsp";
		}
		else {
			User getUser = userService.findByEmail(email);
			session.setAttribute("userId", getUser.getId());
			return "redirect:/home";
		}
    }
	
	@RequestMapping("/home")
    public String home(@ModelAttribute("event") Event event, HttpSession session, Model model) {
		Long id = (Long) session.getAttribute("userId");
		if(id == null) {
			return "redirect:/";
		}
		else {
			User user = userService.findById(id);
			model.addAttribute("user", user);
			//List<String> locations = Arrays.asList("01", "02", "03", "04", "05", "06", "07");
	    	model.addAttribute("locations", locations);
	    	String state = user.getState();
	    	List<Event> local = eventService.findAllByState(state);
	    	model.addAttribute("local", local);
	    	List<Event> events = eventService.findAllByOther(state);
	    	model.addAttribute("events", events);
	    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	    	Calendar today = Calendar.getInstance();
	    	today.setTime(new Date());
	    	today.add(Calendar.HOUR_OF_DAY, 24);
			String dateStr = df.format(today.getTime());
	    	model.addAttribute("dateStr", dateStr);
			return "users/homePage.jsp";
		}
    }
	
	@RequestMapping("/logout")
    public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
    }
}
