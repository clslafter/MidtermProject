package com.skilldistillery.destinations.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;



@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;

	private String password;

	private String email;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	private String role;

	private Boolean enabled;

	@Column(name = "created_date")
	private LocalDateTime createdDate;

	@Column(name = "image_url")
	private String imageUrl;

	private String bio;
	
	@OneToOne
	@JoinColumn(name="address_id")
	private Address address;
	
	@OneToMany(mappedBy="user")
	private List <Destination> destinations;
	
	@OneToMany(mappedBy="user")
	private List <DestinationImage> images;
	
	@OneToMany(mappedBy="user")
	private List <DestinationComment> destinationComments;
	
	@OneToMany(mappedBy="user")
	private List <ReviewComment> reviewComments;
	
	//METHODS

	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}
	
	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Destination> getDestinations() {
		return destinations;
	}

	public void setDestinations(List<Destination> destinations) {
		this.destinations = destinations;
	}

	public void addDestination(Destination destination) {
		if (destinations == null)
			destinations = new ArrayList<>();
		if (!destinations.contains(destination)) {
			destinations.add(destination);
			if (destination.getUser() != null) {
				destination.getUser().getDestinations().remove(destination);
			}
			destination.setUser(this);
		}
	}

	public void removeDestination(Destination destination) {
		if (destinations != null) {
			destinations.remove(destination);
			destination.setUser(null);
		}
	}
	
	public List<DestinationImage> getImages() {
		return images;
	}

	public void setImages(List<DestinationImage> images) {
		this.images = images;
	}
	
	public void addDestinationImage(DestinationImage image) {
		if (images == null)
			images = new ArrayList<>();
		if (!images.contains(image)) {
			images.add(image);
			if (image.getUser() != null) {
				image.getUser().getImages().remove(image);
			}
			image.setUser(this);
		}
	}
	
	public void removeDestinationImage(DestinationImage image) {
		if (images != null) {
			images.remove(image);
			image.setUser(null);
		}
	}

	public List<DestinationComment> getDestinationComments() {
		return destinationComments;
	}

	public void setDestinationComments(List<DestinationComment> destinationComments) {
		this.destinationComments = destinationComments;
	}

	public void addDestinationComment(DestinationComment destinationComment) {
		if (destinationComments == null)
			destinationComments = new ArrayList<>();
		if (!destinationComments.contains(destinationComment)) {
			destinationComments.add(destinationComment);
			if (destinationComment.getUser() != null) {
				destinationComment.getUser().getDestinationComments().remove(destinationComment);
			}
			destinationComment.setUser(this);
		}
	}

	public void removeDestinationComment(DestinationComment destinationComment) {
		if (destinationComments != null) {
			destinationComments.remove(destinationComment);
			destinationComment.setUser(null);
		}
	}
	
	public List<ReviewComment> getReviewComments() {
		return reviewComments;
	}

	public void setReviewComments(List<ReviewComment> reviewComments) {
		this.reviewComments = reviewComments;
	}
	
	public void addReviewComment(ReviewComment reviewComment) {
		if (reviewComments == null)
			reviewComments = new ArrayList<>();
		if (!reviewComments.contains(reviewComment)) {
			reviewComments.add(reviewComment);
			if (reviewComment.getUser() != null) {
				reviewComment.getUser().getReviewComments().remove(reviewComment);
			}
			reviewComment.setUser(this);
		}
	}
	
	public void removeReviewComment(ReviewComment reviewComment) {
		if (reviewComments != null) {
			reviewComments.remove(reviewComment);
			reviewComment.setUser(null);
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email
				+ ", firstName=" + firstName + ", lastName=" + lastName + ", role=" + role + ", enabled=" + enabled
				+ ", createdDate=" + createdDate + ", imageUrl=" + imageUrl + ", bio=" + bio + "]";
	}

}
