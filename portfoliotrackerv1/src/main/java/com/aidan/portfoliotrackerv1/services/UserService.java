package com.aidan.portfoliotrackerv1.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.aidan.portfoliotrackerv1.models.Position;
import com.aidan.portfoliotrackerv1.models.User;
import com.aidan.portfoliotrackerv1.repositories.UserRepo;

@Service
public class UserService {
	private final UserRepo userRepo;
	
	public UserService(UserRepo userRepo) {
		this.userRepo = userRepo;
	}
	
	// register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepo.save(user);
    }
    
    // find user by email
    public User findByEmail(String email) {
        return userRepo.findByEmail(email);
    }
    
    // find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepo.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    //update first name
    public User updateFirstName(User u, String firstName ) {
    	u.setFirstName(firstName);
    	return this.userRepo.save(u);
    }
    //update last name
    public User updateLastName(User u, String lastName) {
    	u.setLastName(lastName);
    	return this.userRepo.save(u);
    }
    //update users email
    public User updateEmail(User u, String email) {
    	u.setEmail(email);
    	return this.userRepo.save(u);
    }

    
    //authenticate edited email
	public boolean authenticateEmail(String email) {
		User user = userRepo.findByEmail(email);
		if(user == null) {
			return false;
		}else {
			return true;
		}
	}
    // authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepo.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    
}
