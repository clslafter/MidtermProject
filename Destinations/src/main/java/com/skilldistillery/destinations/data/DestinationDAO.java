package com.skilldistillery.destinations.data;

import com.skilldistillery.destinations.entities.Destination;

public interface DestinationDAO {
	Destination findDestinationById(int destinatonId);

}
