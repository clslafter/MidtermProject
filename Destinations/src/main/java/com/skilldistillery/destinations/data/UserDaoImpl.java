package com.skilldistillery.destinations.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.destinations.entities.Destination;
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

}
