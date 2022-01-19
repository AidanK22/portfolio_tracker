package com.aidan.portfoliotrackerv1.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.aidan.portfoliotrackerv1.models.User;
import com.aidan.portfoliotrackerv1.repositories.UserRepo;

@Component
public class UserValidator implements Validator{
	
	@Autowired
    private UserRepo userRepo;

    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;

        if (!user.getPasswordConfirmation().equals(user.getPassword())) {
            errors.rejectValue("passwordConfirmation", "Match");
        }

        if (this.userRepo.findByEmail(user.getEmail()) != null) {
            errors.rejectValue("email", "Special");
        }
    }
	
}
