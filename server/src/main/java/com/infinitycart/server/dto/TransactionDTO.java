package com.infinitycart.server.dto;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.infinitycart.server.model.Customer;

import lombok.Data;

@Data
@JsonInclude(value = Include.NON_NULL)
public class TransactionDTO {
    private long transactionId;
    private Timestamp date;
    private Customer customer;
    private double amount;
}

