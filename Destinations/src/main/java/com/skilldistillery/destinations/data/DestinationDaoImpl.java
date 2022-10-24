package com.skilldistillery.destinations.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.destinations.entities.Address;
import com.skilldistillery.destinations.entities.Category;
import com.skilldistillery.destinations.entities.Currency;
import com.skilldistillery.destinations.entities.Destination;
import com.skilldistillery.destinations.entities.Feature;
import com.skilldistillery.destinations.entities.Price;
import com.skilldistillery.destinations.entities.PricingType;
import com.skilldistillery.destinations.entities.User;



@Service
@Transactional
public class DestinationDaoImpl implements DestinationDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Destination findDestinationById(int destinatonId) {
		Destination dest = em.find(Destination.class, destinatonId);
				
		dest.setCategories(findCategoriesByDestinationId(destinatonId));	
		dest.setFeatures(findFeaturesByDestinationId(destinatonId));	
		
		List<Price> prices = findPricesByDestinationId(destinatonId);
		
		dest.setPrices(prices);	
		
		for (Price price : prices) {
			price.setPricingType(findPricingTypeByPriceId(price.getId()));
			price.setCurrency(findCurrencyByPriceId(price.getId()));
		}
		
		
		return dest;
	}

	@Override
	public List<Destination> findAllDestinations() {
		String jpql = "SELECT d FROM Destination d";
		return em.createQuery(jpql, Destination.class).getResultList();
	}
	
	@Override
	public Destination createNewDestination(Destination destination) {
		em.persist(destination);
		return destination;
	}
	
	@Override
	public Address createDestinationAddress(Address address) {
		em.persist(address);
		return address;
	}
	
	@Override 
	public Address getAddressIdByDestinationId(int id) {
		String queryString = "SELECT a FROM Address a JOIN Destination d ON d.address.id = a.id WHERE d.id = :id";
		Address address = em.createQuery(queryString, Address.class).setParameter("id", id).getSingleResult();
		return address;
	}
	
	@Override
	public Address updateAddressInDestination(int addressId, Address address) {
		Address managed = em.find(Address.class, addressId);
		if (managed != null) {
			managed.setStreet(address.getStreet());
			managed.setCity(address.getCity());
			managed.setStateProvince(address.getStateProvince());
			managed.setZip(address.getZip());
			managed.setCountry(address.getCountry());
		}

		return managed;
	}

	@Override
	public List<Category> findCategoriesByDestinationId(int destinationId) {
		String queryString = "SELECT cat FROM Category cat JOIN cat.destinations dest WHERE dest.id = :id";
		List <Category> categories = em.createQuery(queryString, Category.class).setParameter("id", destinationId).getResultList();
		
		return categories;
	}

	@Override
	public List<Feature> findFeaturesByDestinationId(int destinationId) {
		String queryString = "SELECT feat FROM Feature feat JOIN feat.destinations dest WHERE dest.id = :id";
		List <Feature> features = em.createQuery(queryString, Feature.class).setParameter("id", destinationId).getResultList();
		
		return features;
	}

	@Override
	public List<Price> findPricesByDestinationId(int destinationId) {
		String queryString = "SELECT pr FROM Price pr JOIN pr.destination dest WHERE dest.id = :id";
		List <Price> prices = em.createQuery(queryString, Price.class).setParameter("id", destinationId).getResultList();
		
		return prices;
	}

	@Override
	public PricingType findPricingTypeByPriceId(int priceId) {
		String queryString = "SELECT pt FROM PricingType pt JOIN Price price ON price.pricingType.id = pt.id WHERE price.id = :id";
		PricingType pricingType = em.createQuery(queryString, PricingType.class).setParameter("id", priceId).getSingleResult();
		return pricingType;
	}

	@Override
	public Currency findCurrencyByPriceId(int priceId) {
		String queryString = "SELECT curr FROM Currency curr JOIN Price price ON price.currency.id = curr.id WHERE price.id = :id";
		Currency currency = em.createQuery(queryString, Currency.class).setParameter("id", priceId).getSingleResult();
		return currency;
	}
}
