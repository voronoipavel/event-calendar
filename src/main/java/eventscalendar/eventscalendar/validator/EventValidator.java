package eventscalendar.eventscalendar.validator;


import eventscalendar.eventscalendar.models.Event;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.util.Date;


@Component
public class EventValidator implements Validator {
	@Override
	public boolean supports(Class<?> clazz) {
		return Event.class.equals(clazz);
	}
	
	@Override
	public void validate(Object target, Errors errors) {
		Event event = (Event) target;
		Date today = new Date();
		System.out.println("today date: " + today);
		System.out.println("event date: " + event.getDate());
		if(!event.getDate().after(today)) {
			errors.rejectValue("date", "Future");
		}
	}
}
