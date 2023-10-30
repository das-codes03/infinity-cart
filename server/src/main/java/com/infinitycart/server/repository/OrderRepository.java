package com.infinitycart.server.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;

import com.infinitycart.server.model.Order;
import com.infinitycart.server.model.Product;

public interface OrderRepository extends JpaRepository<Order, Long> {
	List<Order> findAllByCustomerCustomerId(int customerId);
	@Procedure(procedureName = "PlaceOrder")
	void placeOrder(int cartId);
}
