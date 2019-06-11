package eventscalendar.eventscalendar.services;


import eventscalendar.eventscalendar.models.User;
import eventscalendar.eventscalendar.repositories.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;

  	public User registerUser(User user) {
  		String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
  		user.setPassword(hashed);
  		return userRepository.save(user);
  	}
  	
  	public User findByEmail(String email) {
  		return userRepository.findByEmail(email);
  	}
  	
  	public User findById(Long id) {
  		Optional<User> optionalUser = userRepository.findById(id);
  		if(optionalUser.isPresent()) {
  			return optionalUser.get();
  		}
  		else {
  			return null;
  		}
  	}


  	public boolean authenticateUser(String email, String password) {
  		User user = userRepository.findByEmail(email);
  		if(user == null) {
  			return false;
  		}
  		else {

  			if(BCrypt.checkpw(password, user.getPassword())) {
  				return true;
  			}
  			else {
  				return false;
  			}
  		}
  	}
}
