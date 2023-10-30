package com.infinitycart.server.dto;


import java.sql.Timestamp;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.infinitycart.server.model.Customer;
import com.infinitycart.server.model.Seller;

import lombok.Data;

@Data
@JsonInclude(value = Include.NON_NULL)
public class TransactionDTO {
    private long transactionId;
    private String date;
    private Customer customer;
    private SellerDTO seller;
    private double amount;
}

