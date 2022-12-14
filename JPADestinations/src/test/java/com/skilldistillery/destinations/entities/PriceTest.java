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

class PriceTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Price price;
	

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
		price = em.find(Price.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		price = null;
		
	}

	@Test
	void test_Price_entity_mapping() {
		assertNotNull(price);
		assertEquals(49.99, price.getAmount());
	}
	
	@Test
	void test_Price_to_PricingType_entity_mapping() {
		assertNotNull(price);
		assertEquals("Adult", price.getPricingType().getName());
	}
	
	@Test
	void test_Price_to_Currency_entity_mapping() {
		assertNotNull(price);
		assertEquals("USD", price.getCurrency().getName());
	}

	@Test
	void test_Price_to_Destination_entity_mapping() {
		assertNotNull(price);
		assertEquals("Elitch Gardens", price.getDestination().getName());
	}

	
}
