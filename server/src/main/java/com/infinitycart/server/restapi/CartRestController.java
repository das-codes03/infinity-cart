package com.infinitycart.server.restapi;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.infinitycart.server.dto.CartDTO;
import com.infinitycart.server.dto.ProductDTO;
import com.infinitycart.server.service.CartService;
import com.infinitycart.server.service.ProductService;

@RestController
@RequestMapping(path = "/carts")
public class CartRestController {
	
	
	@Autowired
	public CartService cartService;
	
	@GetMapping("/hello")
	public String hello(Principal principal) {
        return principal.getName();
        
	}

	
	@GetMapping("/")
	public List<CartDTO> getCartsOfCustomer(@RequestParam(required = true) int customer_id ){
		return cartService.getCartsOfCustomer(customer_id);
	}
	
	@PostMapping("/addtocart")
	public void addToCart(@RequestParam(required = true) int product_id, @RequestParam(required = true) int cart_id,@RequestParam(defaultValue = "1") int quantity){
		cartService.addToCart(cart_id, product_id, quantity);
	}
	
	@PostMapping("/removefromcart")
	public void removeFromCart(@RequestParam(required = true) int product_id, @RequestParam(required = true) int cart_id,@RequestParam(defaultValue = "1") int quantity){
		cartService.removeFromCart(cart_id, product_id, quantity);
	}
}
