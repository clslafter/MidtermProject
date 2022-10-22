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

class DestinationCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private DestinationComment comment;
	

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
		comment = em.find(DestinationComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
		
	}

	@Test
	void test_DestinationComment_entity_mapping() {
		assertNotNull(comment);
		assertEquals("This is a Destination Comment:  Blah from user 2", comment.getComment());
	}
	
	@Test
	void test_DestinationComment_MTO_User_assocation() {
		assertNotNull(comment);
		assertEquals("Normal", comment.getUser().getFirstName());
	}
	@Test
	void test_DestinationComment_MTO_Destination_assocation() {
		assertNotNull(comment);
		assertEquals("Grand Canyon", comment.getDestination().getName());
	}
	@Test
	void test_DestinationComment_MTO_DestinationComment_assocation() {
		DestinationComment comment2 = em.find(DestinationComment.class, 2);
		assertNotNull(comment2);
		assertEquals("This is a Destination Comment:  Blah from user 2", comment2.getDestinationComment().getComment());
		
	}
	@Test
	void test_DestinationComment_OMT_DestinationComment_assocation() {
		assertNotNull(comment);
		assertTrue(comment.getDestinationComments().size() > 0);
		
	}

}
