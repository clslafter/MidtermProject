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
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Destination {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String description;

	@Column(name = "website_url")
	private String websiteUrl;

	@Column(name = "create_date")
	private LocalDateTime createDate;

	@Column(name = "last_edited")
	private LocalDateTime lastEdited;

	@Column(name = "image_url")
	private String imageUrl;

	private boolean enabled;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@OneToOne
	@JoinColumn(name="address_id")
	private Address address;
	
	@ManyToMany(mappedBy="destinations")
	private List <Category> categories;
	
	@ManyToMany(mappedBy="destinations")
	private List <Feature> features;
	
	@OneToMany(mappedBy="destination")
	private List <DestinationImage> images;
	
	@OneToMany(mappedBy="destination")
	private List <Price> prices;
	
	//METHODS

	public Destination() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getWebsiteUrl() {
		return websiteUrl;
	}

	public void setWebsiteUrl(String websiteUrl) {
		this.websiteUrl = websiteUrl;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public LocalDateTime getLastEdited() {
		return lastEdited;
	}

	public void setLastEdited(LocalDateTime lastEdited) {
		this.lastEdited = lastEdited;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}
	
	public void addCategory(Category category) {
		if (categories == null)
			categories = new ArrayList<>();

		if (!categories.contains(category)) {
			categories.add(category);
			category.addDestination(this);
		}
	}

	public void removeCategory(Category category) {
		if (categories != null && categories.contains(category)) {
			categories.remove(category);
			category.removeDestination(this);
		}
	}
	

	public List<Feature> getFeatures() {
		return features;
	}

	public void setFeatures(List<Feature> features) {
		this.features = features;
	}
	
	public void addFeature(Feature feature) {
		if (features == null)
			features = new ArrayList<>();
		
		if (!features.contains(feature)) {
			features.add(feature);
			feature.addDestination(this);
		}
	}
	
	public void removeFeature(Feature feature) {
		if (features != null && features.contains(feature)) {
			features.remove(feature);
			feature.removeDestination(this);
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
			if (image.getDestination() != null) {
				image.getDestination().getImages().remove(image);
			}
			image.setDestination(this);
		}
	}
	
	public void removeDestinationImage(DestinationImage image) {
		if (images != null) {
			images.remove(image);
			image.setDestination(null);
		}
	}

	public List<Price> getPrices() {
		return prices;
	}

	public void setPrices(List<Price> prices) {
		this.prices = prices;
	}
	
	public void addPrice(Price price) {
		if (prices == null)
			prices = new ArrayList<>();
		if (!prices.contains(price)) {
			prices.add(price);
			if (price.getDestination() != null) {
				price.getDestination().getPrices().remove(price);
			}
			price.setDestination(this);
		}
	}
	
	public void removePrice(Price price) {
		if (prices != null) {
			prices.remove(price);
			price.setDestination(null);
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
		Destination other = (Destination) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Destination [id=" + id + ", name=" + name + ", description=" + description + ", websiteUrl="
				+ websiteUrl + ", createDate=" + createDate + ", lastEdited=" + lastEdited + ", imageUrl=" + imageUrl
				+ ", enabled=" + enabled + "]";
	}

}
