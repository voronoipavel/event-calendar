package eventscalendar.eventscalendar.repositories;

import eventscalendar.eventscalendar.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
	User findByEmail(String email);
}
