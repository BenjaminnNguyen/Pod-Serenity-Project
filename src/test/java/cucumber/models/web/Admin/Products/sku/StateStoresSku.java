package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class StateStoresSku {
    ProductVariantStores product_variant;

    public StateStoresSku(ProductVariantStores product_variant) {
        this.product_variant = product_variant;
    }
}
