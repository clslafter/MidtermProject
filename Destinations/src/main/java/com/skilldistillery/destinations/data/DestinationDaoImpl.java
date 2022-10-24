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
import com.skilldistillery.destinations.entities.DestinationImage;
import com.skilldistillery.destinations.entities.Feature;
import com.skilldistillery.destinations.entities.Price;
import com.skilldistillery.destinations.entities.PricingType;
import com.skilldistillery.destinations.entities.Review;
import com.skilldistillery.destinations.entities.ReviewComment;
import com.skilldistillery.destinations.entities.ReviewId;
import com.skilldistillery.destinations.entities.User;



@Service
@Transactional
public class DestinationDaoImpl implements DestinationDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Destination findDestinationById(int destinationId) {
		Destination dest = em.find(Destination.class, destinationId);
				
		dest.setCategories(findCategoriesByDestinationId(destinationId));	
		dest.setFeatures(findFeaturesByDestinationId(destinationId));	
		
		List<Price> prices = findPricesByDestinationId(destinationId);
		
		dest.setPrices(prices);	
		
		for (Price price : prices) {
			price.setPricingType(findPricingTypeByPriceId(price.getId()));
			price.setCurrency(findCurrencyByPriceId(price.getId()));
		}
		
		List <DestinationImage> images = findImagesByDestinationId(destinationId);
				
		dest.setImages(images);
		
		for (DestinationImage destImage : images) {
			destImage.setUser(findUserByDestinationImageId(destImage.getId()));
		}
		
		dest.setUser(findUserByDestinationId(destinationId));	
		 
		List <Review> reviews = findReviewsByDestinationId(destinationId);
	
		dest.setReviews(reviews);
		

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

	@Override
	public List<DestinationImage> findImagesByDestinationId(int destinationId) {
		String queryString = "SELECT di FROM DestinationImage di JOIN di.destination dest WHERE dest.id = :id";
		List <DestinationImage> images = em.createQuery(queryString, DestinationImage.class).setParameter("id", destinationId).getResultList();
		
		return images;
	}

	@Override
	public User findUserByDestinationImageId(int destinationImageId) {
		String queryString = "SELECT user FROM User user JOIN DestinationImage di ON di.user.id = user.id WHERE di.id = :id";
		User user = em.createQuery(queryString, User.class).setParameter("id", destinationImageId).getSingleResult();
		return user;
	}

	@Override
	public User findUserByDestinationId(int destinationId) {
		String queryString = "SELECT user FROM User user JOIN Destination dest ON dest.user.id = user.id WHERE dest.id = :id";
		User user = em.createQuery(queryString, User.class).setParameter("id", destinationId).getSingleResult();
		return user;
	}

	@Override
	public List<Review> findReviewsByDestinationId(int destinationId) {
		String queryString = "SELECT rev FROM Review rev JOIN rev.destination dest WHERE dest.id = :id ORDER BY rev.reviewDate DESC";
		List <Review> reviews = em.createQuery(queryString, Review.class).setParameter("id", destinationId).getResultList();
		
		for (Review review : reviews) {
			String queryString2 = "SELECT rev FROM Review rev JOIN FETCH rev.reviewComments WHERE rev.id = :id";
			
			
			em.createQuery(queryString2, Review.class).setParameter("id", review.getId()).getResultList();
		}
		
		return reviews;
		
	}

	

}
