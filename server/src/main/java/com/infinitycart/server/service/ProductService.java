package com.infinitycart.server.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.infinitycart.server.dto.ProductDTO;
import com.infinitycart.server.model.Product;
import com.infinitycart.server.repository.ProductRepository;

@Service
public class ProductService {
	@Autowired
	private ProductRepository productRepository;
	@Autowired
	private SellerService sellerService;

	public List<ProductDTO> getProducts(String[] fields){
		return productRepository.findAll().stream().map(product  -> convertEntityToDTO(product, fields)).collect(Collectors.toList());
	}
	
	public void addProduct(Map<String, Object> payload, int sellerId) {
		Product p = new Product();
		p.setDescription((String)payload.get("description"));
		p.setMrp((double)payload.get("mrp"));
		p.setAvailableQuantity((int)payload.get("availableQuantity"));
		p.setName((String)payload.get("name"));
		p.setSeller(sellerService.getSellerById(sellerId));
		productRepository.save(p);
	}
	
	public void addStock(int productId, int quantity) {
		productRepository.addstock(productId, quantity);
	}

	public ProductDTO getProductById(long productId, String[] fields){
		Product found = productRepository.findById(productId).get();
		if(found == null) return null;
		return convertEntityToDTO(found, fields);
	}
	
	public ProductDTO convertEntityToDTO(Product product, String[] f) {
		List<String> fields = (f!=null ? Arrays.asList(f) : new ArrayList<>());
		ProductDTO productDto = new ProductDTO();
		productDto.setId(product.getProductId());
		
		if(fields.contains("name")) {
			productDto.setName(product.getName());
		}
		if(fields.contains("description")) {
			productDto.setDescription(product.getDescription());
		}
		if(fields.contains("seller")) {
			String[] sellerFields = {"name"};
			productDto.setSeller(sellerService.convertEntityToDTO(product.getSeller(), sellerFields));
		}
		
		return productDto;
	}
}
	