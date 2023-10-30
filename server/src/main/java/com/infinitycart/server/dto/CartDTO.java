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
public class CartDTO {
    private long cartId;
    private Customer customer;
    private List<CartItemDTO> cartItems;
}

