package com.infinitycart.server.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.infinitycart.server.dto.CartDTO;
import com.infinitycart.server.dto.CartItemDTO;
import com.infinitycart.server.dto.OrderDTO;
import com.infinitycart.server.dto.ProductDTO;
import com.infinitycart.server.model.Cart;
import com.infinitycart.server.model.CartItem;
import com.infinitycart.server.model.Order;
import com.infinitycart.server.model.Product;
import com.infinitycart.server.repository.CartItemRepository;
import com.infinitycart.server.repository.CartRepository;
import com.infinitycart.server.repository.OrderRepository;
import com.infinitycart.server.repository.ProductRepository;

@Service
public class CartService {
	@Autowired
	private CartRepository cartRepository;
	@Autowired
	private OrderRepository orderRepository;
	
	@Autowired
	private CartItemRepository cartItemRepository;
	
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	private ProductService productService;
	
//	private Order sellerService;

	public List<CartDTO> getCartsOfCustomer(int customerId){
		return cartRepository.findAllByCustomerCustomerId(customerId).stream().map(cart  -> convertEntityToDTO(cart)).collect(Collectors.toList());
	}
	
	public void addToCart(int cartId, int productId, int quantity) {
		var cartItem = cartItemRepository.findByCart_CartIdAndProduct_productId(cartId, productId);
		if(cartItem != null) {
			cartItem.setQuantity(cartItem.getQuantity() + quantity);
		}else {
			cartItem = new CartItem(productRepository.findById((long)productId).get(),cartRepository.findById((long)cartId).get(), quantity);
		}
		cartItemRepository.save(cartItem);
	}
	
	public void removeFromCart(int cartId, int productId, int quantity) {
		var cartItem = cartItemRepository.findByCart_CartIdAndProduct_productId(cartId, productId);
		if(cartItem != null) {
			cartItem.setQuantity(cartItem.getQuantity() - quantity);
			if(cartItem.getQuantity() <= 0) {
				cartItemRepository.delete(cartItem);
			}else {
				cartItemRepository.save(cartItem);
			}
		}
		
	}
	
	public void placeOrderFromCart(int cartId) {
		orderRepository.placeOrder(cartId);
	}
	
	public CartItemDTO toCartItemDTO(CartItem cartItem) {
		CartItemDTO ciDto = new CartItemDTO();
		ciDto.setCartId(cartItem.getCart().getCartId());
		String[] fields = {"name"};
		ciDto.setProduct(productService.convertEntityToDTO(cartItem.getProduct(), fields));
		ciDto.setQuantity(cartItem.getQuantity());
		return ciDto;
	}
	
	public CartDTO convertEntityToDTO(Cart cart) {
	
		CartDTO cartDto = new CartDTO();
		cartDto.setCartId(cart.getCartId());
		cartDto.setCustomer(cart.getCustomer());		
		cartDto.setCartItems((cartItemRepository.findAllByCartCartId(cart.getCartId()).stream().map(e->toCartItemDTO(e))).collect(Collectors.toList()));
		return cartDto;
	}
}
	