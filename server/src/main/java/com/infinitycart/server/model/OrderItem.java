package com.infinitycart.server.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name = "order_item")
@IdClass(OrderItemId.class)
public class OrderItem {
    @Id
    @JoinColumn(name = "order_id")
    @ManyToOne
    private Order order;

    @Id
    @JoinColumn(name = "product_id")
    @ManyToOne
    private Product product;

    @Column(name = "quantity")
    private int quantity;
}

@Data
class OrderItemId implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Order order;
    private Product product;
}
