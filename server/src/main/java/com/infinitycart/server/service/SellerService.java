package com.infinitycart.server.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.infinitycart.server.dto.ProductDTO;
import com.infinitycart.server.dto.SellerDTO;
import com.infinitycart.server.model.Product;
import com.infinitycart.server.model.Seller;
import com.infinitycart.server.repository.ProductRepository;
import com.infinitycart.server.repository.SellerRepository;

@Service
public class SellerService {
	@Autowired
	private SellerRepository sellerRepository;
	

	public List<SellerDTO> getSellers(String[] fields){
		return sellerRepository.findAll().stream().map(seller  -> convertEntityToDTO(seller, fields)).collect(Collectors.toList());
	}
	
	public Seller getSellerById(long id){
		return sellerRepository.findById(id).get();
	}
	
	public SellerDTO convertEntityToDTO(Seller seller, String[] f) {
		List<String> fields = (f!=null ? Arrays.asList(f) : new ArrayList<>());
		SellerDTO sellerDto = new SellerDTO();
		sellerDto.setId(seller.getSellerId());
		
		if(fields.contains("name")) {
			sellerDto.setName(seller.getName());
		}
		if(fields.contains("address")) {
			sellerDto.setAddress(seller.getAddress());
		}
		if(fields.contains("phone")) {
			sellerDto.setPhone(seller.getPhone());
		}
		
		return sellerDto;
	}
}
	