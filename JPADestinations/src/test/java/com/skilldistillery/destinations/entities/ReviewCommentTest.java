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

class ReviewCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ReviewComment comment;
	

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
		comment = em.find(ReviewComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
		
	}

	@Test
	void test_ReviewComment_entity_mapping() {
		assertNotNull(comment);
		assertEquals("This is a Review Comment - Thanks for the review of the Grand Canyon.  I can't wait to go there.", comment.getComment());
	}
	
	@Test
	void test_ReviewComment_MTO_User_assocation(){
		assertNotNull(comment);
		assertEquals("Normal", comment.getUser().getFirstName());
	}
	
	@Test
	void test_ReviewComment_MTO_ReviewComment_assocation(){
		ReviewComment comment2 = em.find(ReviewComment.class, 2);
		assertNotNull(comment2);
		assertEquals("This is a Review Comment - Thanks for the review of the Grand Canyon.  I can't wait to go there.", comment2.getReviewComment().getComment());
	}
	
	@Test
	void test_ReviewComment_OTM_ReviewComment_assocation(){
		assertNotNull(comment);
		assertTrue(comment.getReviewComments().size() > 0);
	}
	
	@Test
	void test_ReviewComment_MTO_Review_assocation(){
		assertNotNull(comment);
		assertEquals("This is a Review: The Grand Canyon is great!", comment.getReview().getComment());
	}
}
