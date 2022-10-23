package com.skilldistillery.destinations.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.destinations.entities.Address;
import com.skilldistillery.destinations.entities.User;

@Service
@Transactional
public class UserDaoImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public User findUserById(int userId) {
		return em.find(User.class, userId);
	}

	@Override
	public List<User> findAllUsers() {
		String jpql = "SELECT u FROM User u";
		return em.createQuery(jpql, User.class).getResultList();
	}

	@Override
	public User getUserByUserNameAndPassword(String userName, String password) {
		User user = null;
		System.out.println(userName);
		String queryString = "SELECT u from User u WHERE u.username = :userName";
		user = em.createQuery(queryString, User.class).setParameter("userName", userName).getSingleResult();

		if (user.getPassword().equals(password)) {
			return user;
		} else {
			return null;
		}
	}

	@Override
	public User createUserAccount(User user) {
		em.persist(user);
		return user;
	}

	@Override
	public Address createUserAddress(Address address) {
		em.persist(address);
		return address;
	}

	@Override
	public User updateUserAccount(int id, User user) {
		User managed = em.find(User.class, id);
		if (managed != null) {
			managed.setFirstName(user.getFirstName());
			managed.setLastName(user.getLastName());
			managed.setEmail(user.getEmail());
			managed.setUsername(user.getUsername());
			managed.setPassword(user.getPassword());
		}

		return managed;
	}
	
	@Override 
	public Address getAddressIdByUserId(int id) {
		
		String queryString = "SELECT a FROM Address a JOIN User u ON u.address.id = a.id WHERE u.id = :id";
		Address address = em.createQuery(queryString, Address.class).setParameter("id", id).getSingleResult();
	
		return address;
	}

	@Override
	public Address updateAddressInUserAccount(int addressId, Address address) {
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
}
