package eventscalendar.eventscalendar.services;

import eventscalendar.eventscalendar.models.Comment;
import eventscalendar.eventscalendar.repositories.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {
	@Autowired
	private CommentRepository commentRepository;
	
	public Comment createComment(Comment comment) {
		return commentRepository.save(comment);
	}
}
