package com.infinitycart.server.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infinitycart.server.model.Product;
import com.infinitycart.server.model.Transaction;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
	 List<Transaction> findAllByCustomerCustomerId(int customer_id);
}
