package com.infinitycart.server.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infinitycart.server.model.Seller;

public interface SellerRepository extends JpaRepository<Seller, Long> {
}
