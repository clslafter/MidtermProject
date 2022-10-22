package com.skilldistillery.destinations.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Review review;

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
		ReviewId id = new ReviewId(1,1);
		
		review = em.find(Review.class, id);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		review = null;

	}

	@Test
	void test_review_entity_mapping() {
		assertNotNull(review);
		assertEquals("This is a Review: The Grand Canyon is great!", review.getComment());
	}
	
	@Test
	void test_Review_OTM_ReviewComment_association() {
		assertNotNull(review);
		assertTrue(review.getReviewComments().size() > 0);
		
	}
	@Test
	void test_Review_OTM_ReviewReaction_association() {
		assertNotNull(review);
		assertTrue(review.getReviewReactions().size() > 0);
		
	}
	@Test
	void test_Review_MTO_Destination_association() {
		assertNotNull(review);
		assertEquals("Grand Canyon", review.getDestination().getName());
		
	}
	@Test
	void test_Review_MTO_User_association() {
		assertNotNull(review);
		assertEquals(1, review.getUser().getId());
		assertEquals("Dire", review.getUser().getFirstName());
		
	}

}
