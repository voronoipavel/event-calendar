package eventscalendar.eventscalendar.repositories;

import eventscalendar.eventscalendar.models.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<Comment, Long> {
	
}
