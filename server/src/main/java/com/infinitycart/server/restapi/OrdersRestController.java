package com.infinitycart.server.restapi;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.infinitycart.server.dto.OrderDTO;
import com.infinitycart.server.dto.ProductDTO;
import com.infinitycart.server.dto.TransactionDTO;
import com.infinitycart.server.service.OrderService;
import com.infinitycart.server.service.ProductService;
import com.infinitycart.server.service.TransactionService;

@RestController
@RequestMapping(path = "/orders")
public class OrdersRestController {
	
	
	@Autowired
	public OrderService orderService;

	
	@GetMapping("/")
	public List<OrderDTO> getOrdersByCustomer(@RequestParam(required = true) int customer_id ){
		return orderService.getOrdersByCustomer(customer_id);
	}
	
	
	@PostMapping("/place")
	public void placeOrderFromCart(@RequestParam(required = true) int cart_id ){
		orderService.placeOrderFromCart(cart_id);
	}

}
