package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class StateCompanySku {
    ProductVariantCompanies product_variant;

    public StateCompanySku(ProductVariantCompanies product_variant){
        this.product_variant = product_variant;
    }
}
