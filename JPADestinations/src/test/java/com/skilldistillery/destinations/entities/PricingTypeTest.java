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

class PricingTypeTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private PricingType type;
	

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
		type = em.find(PricingType.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		type = null;
		
	}

	@Test
	void test_PricingType_entity_mapping() {
		assertNotNull(type);
		assertEquals("Free", type.getName());
	}

	@Test
	void test_PricingType_to_Price_mapping() {
		PricingType type4 = em.find(PricingType.class, 4);
		assertNotNull(type4);
		assertTrue(type4.getPrices().size() > 0);
	}
}
