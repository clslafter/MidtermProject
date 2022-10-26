package com.skilldistillery.destinations.data;

import java.time.LocalDateTime;
import java.util.ArrayList;
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
import com.skilldistillery.destinations.entities.ReviewId;
import com.skilldistillery.destinations.entities.User;

@Service
@Transactional
public class DestinationDaoImpl implements DestinationDAO {

	@PersistenceContext
	private EntityManager em;

//	@Override 
//	public Destination findDestinationById2(int id) {
//		String queryString = "SELECT d FROM Destination d "
//				+ "JOIN d.categories "
//				+ "JOIN d.features "
//				+ "JOIN d.images "
//				+ "JOIN d.prices "
//				+ "JOIN d.destinationComments "
//				+ "JOIN d.reviews "
//				+ "WHERE d.id = :id";
//		System.out.println(id);
//		Destination destination = em.createQuery(queryString, Destination.class).setParameter("id", id).getSingleResult();
//		return destination;
//		
//	}

	/***************** CRUD *******************/

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

		List<DestinationImage> images = findImagesByDestinationId(destinationId);

		dest.setImages(images);

		for (DestinationImage destImage : images) {
			destImage.setUser(findUserByDestinationImageId(destImage.getId()));
		}

		dest.setUser(findUserByDestinationId(destinationId));

		List<Review> reviews = findReviewsByDestinationId(destinationId);

		dest.setReviews(reviews);

		return dest;
	}

	@Override
	public List<Destination> findAllDestinations() {
		String jpql = "SELECT d FROM Destination d";
		return em.createQuery(jpql, Destination.class).getResultList();
	}

	@Override
	public Destination createNewDestination(Destination destination, Integer[] featureIds, int[] categoryIds) {
		destination.setFeatures(findFeaturesByIdList(destination, featureIds));
		destination.setCategories(findCategoriesByIdList(destination, categoryIds));
		em.persist(destination);

		return destination;
	}

	@Override
	public Address createDestinationAddress(Address address) {
		em.persist(address);
		return address;
	}
	
	@Override 
	public Review createNewReviewForDestination(int destinationId, Review review, int userId) {
		Destination destination = findDestinationById(destinationId);
		User user = em.find(User.class, userId);
		
		ReviewId reviewId = new ReviewId(destinationId, userId);
		
		review.setUser(user);
		review.setDestination(destination);
		review.setEnabled(true);
		review.setReviewDate(LocalDateTime.now());
		review.setId(reviewId);
		
		if(review != null) {
			destination.addReview(review);
			
			em.persist(review);
		}
		
		return review;
	}
	
	@Override
	public Review updateReviewForDestination(int destinationId, int userId, Review review) {
		ReviewId reviewId = new ReviewId(destinationId, userId);
		
		Review managed = em.find(Review.class, reviewId);
		if(managed != null) {
			managed.setComment(review.getComment());
		}
		
		return managed;
	}
	
	@Override
	public boolean deleteReviewForDestination(int destinationId, int userId, Review review) {
		ReviewId reviewId = new ReviewId(destinationId, userId);
		Destination destination = findDestinationById(destinationId);
		
		Review deleted = em.find(Review.class, reviewId);
		if(deleted != null) {
			destination.removeReview(review);
			em.remove(deleted);
			return true;
		}
		
		return false;
	}
	
	@Override
	public Review findReviewByUserAndDestination(int userId, int destinationId) {
		Review review = null;
		String jpql = "SELECT r FROM Review r WHERE r.user.id = :userId "
					+ "AND r.destination.id = :destinationId";
		
		try {
			review = em.createQuery(jpql, Review.class).
					setParameter("userId", userId).
					setParameter("destinationId", destinationId).
					getSingleResult();
		} catch (Exception e) {
			System.err.println("Review Not Found");
		}
		
		return review;
		
	}

	@Override
	public Address getAddressIdByDestinationId(int id) {
		String queryString = "SELECT a FROM Address a JOIN Destination d ON d.address.id = a.id WHERE d.id = :id";
		Address address = em.createQuery(queryString, Address.class).setParameter("id", id).getSingleResult();
		return address;
	}

	@Override
	public Destination updateDestination(int destinationId, Destination destination, Integer[] featureIds,
			Integer[] categoryIds, Integer priceId, Integer currencyId, Integer typeId, Double amount,
			String description) {
		Destination managed = em.find(Destination.class, destinationId);
		if (managed != null) {
			managed.setName(destination.getName());
			managed.setDescription(destination.getDescription());
			managed.setWebsiteUrl(destination.getWebsiteUrl());
			managed.setLastEdited(LocalDateTime.now());
			managed.setImageUrl(destination.getImageUrl());
			
			if (currencyId != null) {
				Price price = new Price();
				price.setCurrency(findCurrencyByCurrencyId(currencyId));
				price.setPricingType(findPricingTypeByPricingTypeId(typeId));
				price.setAmount(amount);
				price.setDescription(description);

				managed.addPrice(price);

				em.persist(price);

			}

			List<Feature> existingFeatures = new ArrayList<>(managed.getFeatures());
			for (Feature f : existingFeatures) {
				managed.removeFeature(f);
			}
			if (featureIds != null) {
				for (Integer i : featureIds) {
					Feature f = em.find(Feature.class, i);
					if (f != null) {
						managed.addFeature(f);
					}
				}
			}

			List<Category> existingCategories = new ArrayList<>(managed.getCategories());
			for (Category c : existingCategories) {
				managed.removeCategory(c);
			}
			if (categoryIds != null) {
				for (Integer i : categoryIds) {
					if (i != null) {

						Category c = em.find(Category.class, i);
						if (c != null) {
							managed.addCategory(c);
						}
					}
				}
			}
			em.persist(managed);
			em.flush();

		}
		return managed;
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
	public Destination disableDestination(int id) {
		Destination disabled = em.find(Destination.class, id);
		if (disabled != null && disabled.isEnabled() == true) {
			disabled.setEnabled(false);
		}
		return disabled;
	}

	// Find Methods for Certain Id's

	@Override
	public List<Category> findCategoriesByDestinationId(int destinationId) {
		String queryString = "SELECT cat FROM Category cat JOIN cat.destinations dest WHERE dest.id = :id";
		List<Category> categories = em.createQuery(queryString, Category.class).setParameter("id", destinationId)
				.getResultList();

		return categories;
	}

	@Override
	public List<Feature> findFeaturesByDestinationId(int destinationId) {
		String queryString = "SELECT feat FROM Feature feat JOIN feat.destinations dest WHERE dest.id = :id";
		List<Feature> features = em.createQuery(queryString, Feature.class).setParameter("id", destinationId)
				.getResultList();

		return features;
	}

	@Override
	public List<Price> findPricesByDestinationId(int destinationId) {
		String queryString = "SELECT pr FROM Price pr JOIN pr.destination dest WHERE dest.id = :id";
		List<Price> prices = em.createQuery(queryString, Price.class).setParameter("id", destinationId).getResultList();

		return prices;
	}

	@Override
	public PricingType findPricingTypeByPriceId(int priceId) {
		String queryString = "SELECT pt FROM PricingType pt JOIN Price price ON price.pricingType.id = pt.id WHERE price.id = :id";
		PricingType pricingType = em.createQuery(queryString, PricingType.class).setParameter("id", priceId)
				.getSingleResult();
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
		List<DestinationImage> images = em.createQuery(queryString, DestinationImage.class)
				.setParameter("id", destinationId).getResultList();

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
		List<Review> reviews = em.createQuery(queryString, Review.class).setParameter("id", destinationId)
				.getResultList();

		for (Review review : reviews) {
			String queryString2 = "SELECT rev FROM Review rev JOIN FETCH rev.reviewComments WHERE rev.id = :id";

			em.createQuery(queryString2, Review.class).setParameter("id", review.getId()).getResultList();
		}

		return reviews;

	}

	@Override
	public List<Feature> findFeaturesByIdList(Destination destination, Integer[] ids) {
		List<Feature> features = new ArrayList<>();
		if (ids != null) {
			for (Integer i : ids) {
				Feature feat = em.find(Feature.class, i);
				feat.addDestination(destination);
				features.add(feat);
			}
		}
		return features;
	}

	@Override
	public List<Category> findCategoriesByIdList(Destination destination, int[] ids) {
		List<Category> categories = new ArrayList<>();
		if (ids != null) {
			for (Integer i : ids) {
				Category cat = em.find(Category.class, i);
				cat.addDestination(destination);
				categories.add(cat);
			}
		}
		return categories;
	}

	@Override
	public Currency findCurrencyByCurrencyId(int id) {
		return em.find(Currency.class, id);

	}

	@Override
	public PricingType findPricingTypeByPricingTypeId(int id) {
		return em.find(PricingType.class, id);

	}

	// Find All

	@Override
	public List<Feature> findAllFeatures() {
		String jpql = "SELECT f FROM Feature f";
		return em.createQuery(jpql, Feature.class).getResultList();
	}

	@Override
	public List<Category> findAllCategories() {
		String jpql = "SELECT c FROM Category c";
		return em.createQuery(jpql, Category.class).getResultList();
	}

	@Override
	public List<Price> findAllPrices() {
		String jpql = "SELECT p FROM Price p";
		return em.createQuery(jpql, Price.class).getResultList();
	}

	@Override
	public List<Currency> findAllCurrencies() {
		String jpql = "SELECT c FROM Currency c";
		return em.createQuery(jpql, Currency.class).getResultList();

	}

	@Override
	public List<PricingType> findAllPricingTypes() {
		String jpql = "SELECT pt FROM PricingType pt";
		return em.createQuery(jpql, PricingType.class).getResultList();
	}

	@Override
	public boolean removePriceById(int priceId, int destinationId) {
		Price price = em.find(Price.class, priceId);
		Destination destination = em.find(Destination.class, destinationId);

		if (destination != null && price != null) {
			destination.removePrice(price);
			em.remove(price);
			return true;
		}
		return false;
	}

}
