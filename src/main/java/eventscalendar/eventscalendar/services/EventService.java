package eventscalendar.eventscalendar.services;

import eventscalendar.eventscalendar.models.Comment;
import eventscalendar.eventscalendar.models.Event;
import eventscalendar.eventscalendar.models.User;
import eventscalendar.eventscalendar.repositories.CommentRepository;
import eventscalendar.eventscalendar.repositories.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Iterator;
import java.util.List;
import java.util.Optional;

@Service
public class EventService {
	@Autowired
	private EventRepository eventRepository;
	@Autowired
	private CommentRepository commentRepository;



	
	public List<Event> findAllEvents(){
		return (List<Event>) eventRepository.findAll();
	}
	
	public Event findEventById(Long id) {
		Optional<Event> optionalEvent = eventRepository.findById(id);
		if(optionalEvent.isPresent()) {
			return optionalEvent.get();
		}
		else {
			return null;
		}
	}
	
	public List<Event> findAllByState(String state){
		return eventRepository.findByState(state);
	}
	
	public List<Event> findAllByOther(String state){
		return eventRepository.findByStateNot(state);
	}
	
	public Event createEvent(Event e) {
		return eventRepository.save(e);
	}
	
	public void joinEvent(Long id, User user) {
		Optional<Event> optionalEvent = eventRepository.findById(id);
		if(optionalEvent.isPresent()) {
			Event event = optionalEvent.get();
			List<User> attendees = event.getUsers();
			attendees.add(user);
			event.setUsers(attendees);
			eventRepository.save(event);
		}
		else {
			return;
		}
	}
	
	public void leaveEvent(Long id, User user) {
		Optional<Event> optionalEvent = eventRepository.findById(id);
		if(optionalEvent.isPresent()) {
			Event event = optionalEvent.get();
			List<User> attendees = event.getUsers();
			Iterator<User> i = attendees.iterator();
			while(i.hasNext()) {
				User u = i.next();
				System.out.println("Searching: " + user.getFirstName());
				System.out.println("Found: " + u.getFirstName());
				if(u == user) {
					i.remove();
				}
			}
			event.setUsers(attendees);
			eventRepository.save(event);
		}
		else {
			return;
		}
	}
	
	public void updateEvent(Long event_id, Event e) {
		Optional<Event> optionalEvent = eventRepository.findById(event_id);
		if(optionalEvent.isPresent()) {
			Event event = optionalEvent.get();
			event.setName(e.getName());
			event.setDate(e.getDateStr());
			event.setCity(e.getCity());
			event.setState(e.getState());
			eventRepository.save(event);
		}
		else {
			return;
		}
	}
	
	public void deleteEvent(Long id) {
		eventRepository.deleteById(id);
	}
	
	public void addComment(Long eventId, User user, Comment comment) {
		Optional<Event> optionalEvent = eventRepository.findById(eventId);
		if(optionalEvent.isPresent()) {
			Event event = optionalEvent.get();
			List<Comment> eventComments = event.getComments();
			eventComments.add(comment);
			event.setComments(eventComments);
			eventRepository.save(event);
			commentRepository.save(comment);
		}
	}
}
