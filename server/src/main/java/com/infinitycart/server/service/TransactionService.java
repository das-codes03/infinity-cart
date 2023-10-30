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
import com.infinitycart.server.dto.TransactionDTO;
import com.infinitycart.server.model.Product;
import com.infinitycart.server.model.Seller;
import com.infinitycart.server.model.Transaction;
import com.infinitycart.server.repository.ProductRepository;
import com.infinitycart.server.repository.SellerRepository;
import com.infinitycart.server.repository.TransactionRepository;

@Service
public class TransactionService {
	@Autowired
	private TransactionRepository transactionRepository;
	
	@Autowired
	private SellerService sellerService;

	public List<TransactionDTO> getTransactionsByCustomer(int id){
		return transactionRepository.findAllByCustomerCustomerId(id).stream().map(transaction  -> convertEntityToDTO(transaction)).collect(Collectors.toList());
	}
	public List<TransactionDTO> getTransactionsToSeller(int id){
		return transactionRepository.findAllByCustomerCustomerId(id).stream().map(transaction  -> convertEntityToDTO(transaction)).collect(Collectors.toList());
	}
	
	public TransactionDTO convertEntityToDTO(Transaction transaction) {
		
		TransactionDTO transactionDTO = new TransactionDTO();
		transactionDTO.setTransactionId(transaction.getTransactionId());
		
		
		transactionDTO.setCustomer(transaction.getCustomer());
		
		transactionDTO.setAmount(transaction.getAmount());
		String[] fields = {"name"};
		transactionDTO.setSeller(sellerService.convertEntityToDTO(transaction.getSeller(), fields));
		transactionDTO.setDate(transaction.getDate().toString());
		
		return transactionDTO;
	}
}
	