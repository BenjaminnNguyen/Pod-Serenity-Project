package cucumber.models.web.buyer.Product;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProductVariantId {

    public int product_variant_id;

    public ProductVariantId(int product_variant_id) {
        this.product_variant_id = product_variant_id;
    }
}
