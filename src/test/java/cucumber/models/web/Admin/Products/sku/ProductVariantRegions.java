package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class ProductVariantRegions {
    String state;
    List<VariantRegionAttributes> variants_regions_attributes;

    public ProductVariantRegions(String state, List<VariantRegionAttributes> variants_regions_attributes){
        this.state = state;
        this.variants_regions_attributes = variants_regions_attributes;
    }

    public ProductVariantRegions(List<VariantRegionAttributes> variants_regions_attributes){
        this.state = null;
        this.variants_regions_attributes = variants_regions_attributes;
    }
}
