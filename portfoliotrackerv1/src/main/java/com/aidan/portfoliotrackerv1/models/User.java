package com.aidan.portfoliotrackerv1.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;


@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Size(min=1, message="First name must be longer than 1 characters.")
	private String firstName;
	
	@Size(min=1, message="Last name must be longer than 1 characters.")
	private String lastName;
	
	@Email
	@NotBlank( message="Email must be valid.")
	private String email;
	
	@Size(min=5, message="Password must be longer than 5 characters.")
	private String password;
	
	@Transient
	private String passwordConfirmation;
	
	@Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
    
    // >>Relationship<< \\
    
    //position relationship
    @OneToMany(mappedBy = "owner", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Position> positions;
    
    //watchlist relationship
    @OneToMany(mappedBy = "watcher", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Watchlist> watchlist;
    // >>constructor<< \\
    public User() {
    	
    }
    
	/*
	 * public FirstName(String firstName) { this.firstName = firstName;
	 * 
	 * }
	 */
    
    // >>Getters & Setters<< \\

	//-------------------------------------
	//Position getter & setter
	public List<Position> getPositions() {
		return positions;
	}
	public void setPositions(List<Position> positions) {
		this.positions = positions;
	}
	//---------------------------------------
	//-------------------------------------
	//Watchlist getter & setter


	public List<Watchlist> getWatchlist() {
		return watchlist;
	}
	public void setWatchList(List<Watchlist> watchlist) {
		this.watchlist = watchlist;
	}
	
	//---------------------------------------
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordConfirmation() {
		return passwordConfirmation;
	}

	public void setPasswordConfirmation(String passwordConfirmation) {
		this.passwordConfirmation = passwordConfirmation;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
    
}

