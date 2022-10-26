package com.skilldistillery.destinations.data;

import java.util.List;

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

public interface DestinationDAO {
	Destination findDestinationById(int destinatonId);
	
	List <Destination> findAllDestinations();
	
	Destination createNewDestination(Destination destination, Integer [] featureIds, int [] categoryIds);
	
	Address createDestinationAddress(Address address);
	
	public Address getAddressIdByDestinationId(int id);
	
	public Address updateAddressInDestination(int addressId, Address address);
	
	List <Category> findCategoriesByDestinationId(int destinationId);
	
	List <Feature> findFeaturesByDestinationId(int destinationId);
	
	List <Price> findPricesByDestinationId(int destinationId);
	
	PricingType findPricingTypeByPriceId(int priceId);
	
	Currency findCurrencyByPriceId(int priceId);
	
	List <DestinationImage> findImagesByDestinationId(int destinationId);
	
	User findUserByDestinationImageId(int destinationImageId);
	
	User findUserByDestinationId(int destinationId);
	

//	Then, find list of all reviews created for the destination ordered by review Date

	List <Review> findReviewsByDestinationId(int destinationId);
	
	public List<Feature> findAllFeatures();
	
//	Destination findDestinationById2(int id);
	
	List<Feature> findFeaturesByIdList(Destination destination, Integer[] ids);
	
	List<Category> findCategoriesByIdList(Destination destination, int[]ids);
	
	List<Category> findAllCategories();
	
	List<Price> findAllPrices();
	
	List<Currency> findAllCurrencies();
	
	List<PricingType> findAllPricingTypes();
	
	Destination updateDestination(int destinationId, Destination destination, Integer[] featureIds, Integer[] categoryIds, Integer priceId, Integer currencyId, Integer typeId, Double amount, String description);
	
	Destination disableDestination(int id);
	 
	Currency findCurrencyByCurrencyId(int id);
	
	PricingType findPricingTypeByPricingTypeId(int id);
	
	boolean removePriceById(int priceId, int destinationId);
	
	Review createNewReviewForDestination(int destinationId, Review review, int userId);
	
	Review findReviewByReviewId(ReviewId reviewId);
	
	ReviewComment createNewReviewCommentForReview(ReviewId reviewId, String reviewComment, int userId);
	
	Review updateReviewForDestination(int destinationId, int userId, Review review);
	
	ReviewComment updateReviewCommentForReview(ReviewId reviewId, ReviewComment reviewComment, int userId);
	
	boolean deleteReviewForDestination(int destinationId, int userId, Review review);
	
	boolean deleteReviewCommentForReview(ReviewId reviewId, ReviewComment reviewComment, int userId);
	
	Review findReviewByUserAndDestination(int userId, int destinationId);
	


}
