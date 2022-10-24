package com.skilldistillery.destinations.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.destinations.entities.Address;
import com.skilldistillery.destinations.entities.Category;
import com.skilldistillery.destinations.entities.Destination;
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
}
