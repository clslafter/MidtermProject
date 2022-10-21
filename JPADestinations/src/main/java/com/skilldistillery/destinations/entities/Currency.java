package com.skilldistillery.destinations.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Currency {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	
	@OneToMany(mappedBy="currency")
	private List <Price> prices;
	
	//METHODS

	public Currency() {
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
			if (price.getCurrency() != null) {
				price.getCurrency().getPrices().remove(price);
			}
			price.setCurrency(this);
		}
	}
	
	public void removePrice(Price price) {
		if (prices != null) {
			prices.remove(price);
			price.setCurrency(null);
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
		Currency other = (Currency) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Currency [id=" + id + ", name=" + name + "]";
	}

}
