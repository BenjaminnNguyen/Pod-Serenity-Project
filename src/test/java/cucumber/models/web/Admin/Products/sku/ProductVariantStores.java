package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class ProductVariantStores {
    public String state;
    public List<VariantStoreAttribute> stores_variants_regions_attributes;

    public ProductVariantStores(String state, List<VariantStoreAttribute> stores_variants_regions_attributes) {
        this.state = state;
        this.stores_variants_regions_attributes = stores_variants_regions_attributes;
    }
}
