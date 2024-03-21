package cucumber.models.web.buyer.Product;

import lombok.Data;

@Data
public class FavoriteProduct {
    public ProductVariantId favorite_product;

    public FavoriteProduct(ProductVariantId favorite_product) {
        this.favorite_product = favorite_product;
    }
}
