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

class ReviewReactionTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ReviewReaction reaction;

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
		ReviewReactionId id = new ReviewReactionId(2, new ReviewId(1,1));

		reaction = em.find(ReviewReaction.class, id);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		reaction = null;

	}

	@Test
	void test_reaction_entity_mapping() {
		assertNotNull(reaction);
		assertEquals(2022, reaction.getReactionDate().getYear());
	}
	
	@Test
	void test_ReviewReaction_MTO_User_association() {
		assertNotNull(reaction);
		assertEquals("John", reaction.getUser().getFirstName());
		
		
	}
	@Test
	void test_ReviewReaction_MTO_Review_association() {
		assertNotNull(reaction);
		assertEquals("This is a Review: The Grand Canyon is great!", reaction.getReview().getComment());
		
	}
	

}
