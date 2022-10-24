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
	
	Destination createNewDestination(Destination destination);
	
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
	
	
	


}
