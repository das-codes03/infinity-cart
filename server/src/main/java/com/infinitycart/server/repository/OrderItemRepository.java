package com.infinitycart.server.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;

import com.infinitycart.server.model.Cart;
import com.infinitycart.server.model.CartItem;
import com.infinitycart.server.model.Order;
import com.infinitycart.server.model.OrderItem;
import com.infinitycart.server.model.Product;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
	List<OrderItem> findAllByOrderOrderId(int orderId);
}
