package eventscalendar.eventscalendar.repositories;

import eventscalendar.eventscalendar.models.Event;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EventRepository extends JpaRepository<Event, Long> {
	Event findByName(String name);
	List<Event> findByState(String state);
	List<Event> findByStateNot(String state);
}
