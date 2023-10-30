package com.infinitycart.server.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name = "cart_item")
@IdClass(CartItemId.class)
public class CartItem {
    @Id
    @JoinColumn(name = "product_id")
    @ManyToOne
    private Product product;

    @Id
    @JoinColumn(name = "cart_id")
    @OneToOne
    private Cart cart;

    @Column(name = "quantity")
    private int quantity;
}


@Data
class CartItemId implements Serializable {
    /**
     * 
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Product product;
    private Cart cart;
}
