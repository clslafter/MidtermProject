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

class DestinationTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Destination destination;

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
		destination = em.find(Destination.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		destination = null;

	}

	@Test
	void test_Destination_entity_mapping() {
		assertNotNull(destination);
		assertEquals("Grand Canyon", destination.getName());
	}

	@Test
	void test_Destination_to_Category_mapping() {
		assertNotNull(destination);
		assertTrue(destination.getCategories().size() > 0);
	}

	@Test
	void test_Destination_to_Image_mapping() {
		assertNotNull(destination);
		assertTrue(destination.getImages().size() > 0);
	}

	@Test
	void test_Destination_to_Price_mapping() {
		assertNotNull(destination);
		Destination destination2 = em.find(Destination.class, 2);
		assertTrue(destination2.getPrices().size() > 0);
	}
	
	@Test
	void test_Destination_to_DestinationComment_mapping() {
		assertNotNull(destination);
		assertTrue(destination.getDestinationComments().size() > 0);
	}
	
	@Test
	void test_Destination_to_Review_mapping() {
		assertNotNull(destination);
		assertTrue(destination.getReviews().size() > 0);
	}
	
	@Test
	void test_Destination_to_User_entity_mapping() {
		assertNotNull(destination);
		assertEquals("Dire", destination.getUser().getFirstName());
	}
	
	@Test
	void test_Destination_to_Address_entity_mapping() {
		assertNotNull(destination);
		assertEquals("Grand Canyon", destination.getAddress().getCity());
	}
	
	@Test
	void test_Destination_to_Feature_mapping() {
		assertNotNull(destination);
		assertTrue(destination.getFeatures().size() > 0);
	}

}
