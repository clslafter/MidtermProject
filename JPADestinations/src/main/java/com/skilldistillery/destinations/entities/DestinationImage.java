package com.skilldistillery.destinations.entities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="destination_image")
public class DestinationImage {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="image_url")
	private String imageUrl;
	
	private String caption;
	
	@Column(name="image_date")
	private LocalDateTime imageDate;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="destination_id")
	private Destination destination;
	
	//METHODS
	
	public DestinationImage() {}

	@Transient
	public String getImageDateFormatted() {
		return imageDate.format(DateTimeFormatter.ofPattern("MMM d yyyy hh:mm a"));
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public LocalDateTime getImageDate() {
		return imageDate;
	}

	public void setImageDate(LocalDateTime imageDate) {
		this.imageDate = imageDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Destination getDestination() {
		return destination;
	}

	public void setDestination(Destination destination) {
		this.destination = destination;
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
		DestinationImage other = (DestinationImage) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "DestinationImage [id=" + id + ", imageUrl=" + imageUrl + ", caption=" + caption + ", imageDate="
				+ imageDate + "]";
	}
	
	

}
