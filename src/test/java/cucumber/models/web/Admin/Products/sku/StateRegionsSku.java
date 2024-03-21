package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class StateRegionsSku {

    ProductVariantRegions product_variant;

    public StateRegionsSku(ProductVariantRegions product_variant) {
        this.product_variant = product_variant;
    }
}
