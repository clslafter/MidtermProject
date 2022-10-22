package com.skilldistillery.destinations.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;
	

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPADestinations");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
		
	}
	

	@Test
	void test_user_entity_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	
	@Test
	void test_User_OTO_Address_association() {
		assertNotNull(user);
		assertEquals(1, user.getAddress().getId());
		assertEquals("123 Main", user.getAddress().getStreet());
		assertEquals("Parker", user.getAddress().getCity());
	}
	
	@Test
	void test_User_OTM_Destination_association() {
		assertNotNull(user);
		assertTrue(user.getDestinations().size() > 0);
		
	}
	@Test
	void test_User_OTM_DestinationImage_association() {
		assertNotNull(user);
		assertTrue(user.getImages().size() > 0);
		
	}
	@Test
	void test_User_OTM_DestinationComment_association() {
		assertNotNull(user);
		assertTrue(user.getDestinationComments().size() > 0);
		
	}
	@Test
	void test_User_OTM_ReviewComment_association() {
		assertNotNull(user);
		assertTrue(user.getReviewComments().size() > 0);
		
	}
	@Test
	void test_User_OTM_ReviewReaction_association() {
		User user2 = em.find(User.class, 2);
		assertNotNull(user2);
		assertTrue(user2.getReviewReactions().size() > 0);
		
	}
	@Test
	void test_User_OTM_Review_association() {
		assertNotNull(user);
		assertTrue(user.getReviews().size() > 0);
		
	}
	

}
