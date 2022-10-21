package com.skilldistillery.destinations.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Category {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	
	@ManyToMany
	@JoinTable(name = "destination_category", 
		joinColumns = @JoinColumn(name = "category_id"), 
		inverseJoinColumns = @JoinColumn(name = "destination_id"))
	private List<Destination> destinations;
	
	//METHODS

	public Category() {
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

	@Override
	public int hashCode() {
		return Objects.hash(id);
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
			destination.addCategory(this);
		}
	}

	public void removeDestination(Destination destination) {
		if (destinations != null && destinations.contains(destination)) {
			destinations.remove(destination);
			destination.removeCategory(this);
		}
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Category other = (Category) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Category [id=" + id + ", name=" + name + "]";
	}

}
