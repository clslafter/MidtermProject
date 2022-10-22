package com.skilldistillery.destinations.data;

import java.util.List;

import com.skilldistillery.destinations.entities.Destination;

public interface DestinationDAO {
	Destination findDestinationById(int destinatonId);
	List <Destination> findAllDestinations();

}
