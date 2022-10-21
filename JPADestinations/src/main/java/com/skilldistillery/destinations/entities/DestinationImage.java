package com.skilldistillery.destinations.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class DestinationImage {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="image_url")
	private String imageUrl;
	
	private String caption;
	
	@Column(name="image_date")
	private LocalDateTime imageDate;
	
	public DestinationImage() {}

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
