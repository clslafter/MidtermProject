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

class FeatureTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Feature feature;
	

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
		feature = em.find(Feature.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		feature = null;
		
	}

	@Test
	void test_Feature_entity_mapping() {
		assertNotNull(feature);
		assertEquals("Handicapped Parking", feature.getName());
	}
	
	@Test
	void test_Feature_to_Destination_mapping() {
		assertNotNull(feature);
		assertTrue(feature.getDestinations().size() > 0);
	}

}
