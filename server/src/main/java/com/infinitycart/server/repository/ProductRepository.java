package com.infinitycart.server.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;

import com.infinitycart.server.model.Order;
import com.infinitycart.server.model.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {
	@Procedure(procedureName = "IncreaseProductCount")
	void addstock(int cartId, int quantity);
	
	List<Product> findAllBySellerSellerId(int sellerId);
}
