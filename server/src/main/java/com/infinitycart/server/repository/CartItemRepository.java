package com.infinitycart.server.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;

import com.infinitycart.server.model.Cart;
import com.infinitycart.server.model.CartItem;
import com.infinitycart.server.model.Order;
import com.infinitycart.server.model.Product;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
	List<CartItem> findAllByCartCartId(int cartId);
	CartItem findByCart_CartIdAndProduct_productId(int cart_id, int product_id);
}
