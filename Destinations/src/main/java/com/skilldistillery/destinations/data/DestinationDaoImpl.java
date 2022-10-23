package com.skilldistillery.destinations.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.destinations.entities.Address;
import com.skilldistillery.destinations.entities.Destination;
import com.skilldistillery.destinations.entities.User;



@Service
@Transactional
public class DestinationDaoImpl implements DestinationDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Destination findDestinationById(int destinatonId) {
		return em.find(Destination.class, destinatonId);
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
}
