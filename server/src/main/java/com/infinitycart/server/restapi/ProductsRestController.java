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

import com.infinitycart.server.dto.ProductDTO;
import com.infinitycart.server.service.ProductService;

@RestController
@RequestMapping(path = "/products")
public class ProductsRestController {
	
	
	@Autowired
	public ProductService productService;
	
	@GetMapping("/hello")
	public String hello(Principal principal) {
        return principal.getName();
        
	}

	
	@GetMapping("/")
	public List<ProductDTO> getProducts(@RequestParam(required = false) String[] fields ){
		return productService.getProducts(fields);
	}

	@GetMapping("/{productId}")
	public ProductDTO getProduct(@PathVariable int productId, @RequestParam(required = false) String[] fields ){
		return productService.getProductById(productId,fields);
	}
	
	@PostMapping("/")
	public void addProduct(@RequestBody Map<String, Object> payload, @RequestParam(required = true) int seller_id ){
		productService.addProduct(payload, seller_id);
	}
	

	@PostMapping("/{productId}/addstock")
	public void addStock(@PathVariable int productId, @RequestParam(required = true) int quantity ){
		productService.addStock(productId, quantity);
	}
}
