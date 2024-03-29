package com.infinitycart.server.model;

import java.sql.Timestamp;
import java.util.Date;

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
@Table(name = "transaction")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "transaction_id")
    private int transactionId;

    @Column(name = "date")
    private Date date;

    @JoinColumn(name = "customer_id")
    @ManyToOne
    private Customer customer;
    
    @JoinColumn(name = "seller_id")
    @ManyToOne
    private Seller seller;

    @Column(name = "amount")
    private double amount;
}
