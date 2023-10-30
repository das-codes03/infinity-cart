package com.infinitycart.server.dto;

import java.sql.Timestamp;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.infinitycart.server.model.Customer;
import com.infinitycart.server.model.Transaction;

import lombok.Data;

@Data
@JsonInclude(value = Include.NON_NULL)
public class OrderDTO {
    private long orderId;
    private Customer customer;
    private Transaction transaction;
    private List<OrderItemDTO> orderItems;
}

