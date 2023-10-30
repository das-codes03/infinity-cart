package com.infinitycart.server.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;

import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name = "product")
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "product_id")
	private long productId;
	
	@Column(name = "name")
	private String name;
	
	@Column(name = "mrp")
	private double mrp;
	
	@Column(name = "description")
	private String description;
	
	@Column(name = "quantity_available")
	private int availableQuantity;
	
	@JoinColumn(name = "seller_id")
	@ManyToOne
	private Seller seller;
	
	
}
