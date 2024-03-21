package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class ProductVariantCompanies {
    String state;
    List<CompanyAttribuites> buyer_companies_variants_regions_attributes;

    public ProductVariantCompanies(String state, List<CompanyAttribuites> buyer_companies_variants_regions_attributes){
        this.state = state;
        this.buyer_companies_variants_regions_attributes = buyer_companies_variants_regions_attributes;
    }
}
