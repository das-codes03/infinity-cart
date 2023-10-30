package com.infinitycart.server.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.infinitycart.server.dto.CartDTO;
import com.infinitycart.server.dto.CartItemDTO;
import com.infinitycart.server.dto.OrderDTO;
import com.infinitycart.server.dto.OrderItemDTO;
import com.infinitycart.server.dto.ProductDTO;
import com.infinitycart.server.model.CartItem;
import com.infinitycart.server.model.Order;
import com.infinitycart.server.model.OrderItem;
import com.infinitycart.server.model.Product;
import com.infinitycart.server.repository.OrderItemRepository;
import com.infinitycart.server.repository.OrderRepository;
import com.infinitycart.server.repository.ProductRepository;

@Service
public class OrderService {
	@Autowired
	private OrderRepository orderRepository;
	
	@Autowired
	private OrderItemRepository orderItemRepository;
	@Autowired
	private ProductService productService;

	public List<OrderDTO> getOrdersByCustomer(int customerId){
		return orderRepository.findAllByCustomerCustomerId(customerId).stream().map(order  -> convertEntityToDTO(order)).collect(Collectors.toList());
	}
	
	public void placeOrderFromCart(int cartId) {
		orderRepository.placeOrder(cartId);
	}
	public OrderItemDTO toOrderItemDTO(OrderItem orderItem) {
		OrderItemDTO oiDto = new OrderItemDTO();
		oiDto.setOrderId(orderItem.getOrder().getOrderId());
		String[] fields = {"name"};
		oiDto.setProduct(productService.convertEntityToDTO(orderItem.getProduct(), fields));
		oiDto.setQuantity(orderItem.getQuantity());
		
		return oiDto;
	}
	public OrderDTO convertEntityToDTO(Order order) {
	
		OrderDTO orderDto = new OrderDTO();
		orderDto.setOrderId(order.getOrderId());
		orderDto.setCustomer(order.getCustomer());
		orderDto.setTransaction(order.getTransaction());
		orderDto.setOrderItems(orderItemRepository.findAllByOrderOrderId(order.getOrderId()).stream().map(this::toOrderItemDTO).toList());
		
		return orderDto;
	}
}
	