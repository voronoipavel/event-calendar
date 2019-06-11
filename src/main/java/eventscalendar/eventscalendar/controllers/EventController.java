package eventscalendar.eventscalendar.controllers;

import eventscalendar.eventscalendar.models.Comment;
import eventscalendar.eventscalendar.models.Event;
import eventscalendar.eventscalendar.models.User;
import eventscalendar.eventscalendar.services.EventService;
import eventscalendar.eventscalendar.services.UserService;
import eventscalendar.eventscalendar.validator.EventValidator;
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
public class EventController {
	@Autowired
	private EventService eventService;
	@Autowired
	private UserService userService;
	@Autowired
    private EventValidator eventValidator;

	private List<String> locations = Arrays.asList("Chui region", "Batken region", "Jalal-Abad region", "Issyk-Kul region", "Naryn region", "Osh region", "Talas region");


    @RequestMapping(value="/events", method=RequestMethod.POST)
    public String createEvent(@Valid @ModelAttribute("event") Event event, BindingResult result,
							  @RequestParam(value="date") String date, Model model, HttpSession session) {
    	System.out.println("dateeeeee: " + date);
    	event.setDate(date);
		eventValidator.validate(event, result);
		if(result.hasErrors()) {
			Long id = (Long) session.getAttribute("userId");
			User user = userService.findById(id);
			model.addAttribute("user", user);
			//List<String> locations = Arrays.asList("Chui region", "Batken region", "Jalal-Abad region", "Issyk-Kul region", "Naryn region", "Osh region", "Talas region");
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
			return "/users/homePage.jsp";
		}
		else {
			Long id = (Long) session.getAttribute("userId");
			User u = userService.findById(id);
			List<Event> userEvents = u.getEvents();
			userEvents.add(event);
			u.setEvents(userEvents);
			event.setHost(u);
			Event e = eventService.createEvent(event);
			System.out.println("New EVENT Created: " + e.getName());
			return "redirect:/home";
		}
    }
    
    @RequestMapping(value="/events/{id}")
    public String showEvent(@Valid @ModelAttribute("comment") Comment comment,
							@PathVariable("id") Long id, Model model, HttpSession session) {
    	Event event = eventService.findEventById(id);
    	model.addAttribute("event", event);
    	Long userId = (Long) session.getAttribute("userId");
    	model.addAttribute("thisUser", userId);
    	List<User> attendees = event.getUsers();
    	model.addAttribute("attendees", attendees);
    	return "/events/showEvent.jsp";
    }
    
    @RequestMapping(value="/events/join/{id}")
    public String joinEvent(@PathVariable("id") Long id, HttpSession session) {
    	Long userId = (Long) session.getAttribute("userId");
    	User u = userService.findById(userId);
    	eventService.joinEvent(id, u);
    	return "redirect:/home";
    }
    
    @RequestMapping(value="/events/cancel/{id}")
    public String cancelEvent(@PathVariable("id") Long id, HttpSession session) {
    	System.out.println("In CONTroller");
    	Long userId = (Long) session.getAttribute("userId");
    	User u = userService.findById(userId);
    	eventService.leaveEvent(id, u);
    	return "redirect:/home";
    }
    
    @RequestMapping(value="/events/{id}/edit")
    public String showEditPage(@PathVariable("id") Long id, Model model, HttpSession session) {
    	Long userId = (Long) session.getAttribute("userId");
    	Event e = eventService.findEventById(id);
    	User u = e.getHost();
    	Long hostId = u.getId();
    	if(userId.equals(hostId)) {
    		model.addAttribute("event", e);
    		//List<String> locations = Arrays.asList("Chui region", "Batken region", "Jalal-Abad region", "Issyk-Kul region", "Naryn region", "Osh region", "Talas region");
    		model.addAttribute("locations", locations);
    		String dateStr = e.getDateStr();
    		model.addAttribute("dateStr", dateStr);
    		return "/events/editEvent.jsp";
    	}
    	else {
    		System.out.println("user: " + userId);
    		System.out.println("host: " + hostId);
    		return "redirect:/home";
    	}
    }
    
    @RequestMapping(value="/events/{id}/edit", method=RequestMethod.PUT)
    public String editEvent(@RequestParam(value="date") String date,
							@PathVariable("id") Long id,
							@Valid @ModelAttribute("event") Event event, BindingResult result, Model model, HttpSession session) {
    	event.setDate(date);
		eventValidator.validate(event, result);
		if(result.hasErrors()) {
			System.out.println("Errors Found");
			Event e = eventService.findEventById(id);
    		//List<String> locations = Arrays.asList("Chui region", "Batken region", "Jalal-Abad region", "Issyk-Kul region", "Naryn region", "Osh region", "Talas region");
    		model.addAttribute("locations", locations);
    		String dateStr = e.getDateStr();
    		model.addAttribute("dateStr", dateStr);
			return "/events/editEvent.jsp";
		}
		else {
			eventService.updateEvent(id, event);
			return "redirect:/home";
		}
    }

    @RequestMapping(value="/comments/new/{event_id}", method=RequestMethod.POST)
    public String addComment(@PathVariable("event_id") Long event_id,
							 @Valid @ModelAttribute("comment") Comment comment, BindingResult result, Model model, HttpSession session) {
    	if(result.hasErrors()) {
    		System.out.println("Errors Found");
    		Event event = eventService.findEventById(event_id);
        	model.addAttribute("event", event);
        	Long userId = (Long) session.getAttribute("userId");
        	model.addAttribute("thisUser", userId);
        	List<User> attendees = event.getUsers();
        	model.addAttribute("attendees", attendees);
    		return "events/showEvent.jsp";
    	}
    	else {
    		Event e = eventService.findEventById(event_id);
    		Long userId = (Long) session.getAttribute("userId");
    		User u = userService.findById(userId);
    		comment.setEvent(e);
    		comment.setUser(u);
    		eventService.addComment(event_id, u, comment);
        	return "redirect:/events/" + event_id;
    	}
    }
    
    @RequestMapping(value="/events/{id}/delete")
    public String destroy(@PathVariable("id") Long id) {
    	eventService.deleteEvent(id);
    	return "redirect:/home";
    }
}





