package com.infinitycart.server.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Data;

@Data
@JsonInclude(value = Include.NON_NULL)
public class ProductDTO {
    private long id;
    private String name;
    private String description;
    private SellerDTO seller;
}

