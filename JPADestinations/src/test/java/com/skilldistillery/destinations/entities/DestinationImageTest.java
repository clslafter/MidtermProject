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

class DestinationImageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private DestinationImage image;
	

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
		image = em.find(DestinationImage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		image = null;
		
	}

	@Test
	void test_DestinationImage_entity_mapping() {
		assertNotNull(image);
		assertEquals("This is the Grand Canyon", image.getCaption());
	}

}
