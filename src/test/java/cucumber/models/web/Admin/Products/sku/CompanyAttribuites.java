package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CompanyAttribuites {
    int id;
    int region_id;
    int buyer_company_id;
    int product_variant_id;
    int case_price_cents;
    int msrp_cents;
    String availability;
    String state;
    String inventory_receiving_date;
    CompanyConfigAttributes variants_regions_config_attributes;



    public CompanyAttribuites(int id, int region_id, int buyer_company_id, int product_variant_id, int case_price_cents, int msrp_cents, String availability,
                              String state, String inventory_receiving_date, CompanyConfigAttributes variants_regions_config_attributes) {
        this.id = id;
        this.region_id = region_id;
        this.buyer_company_id = buyer_company_id;
        this.product_variant_id = product_variant_id;
        this.case_price_cents = case_price_cents;
        this.msrp_cents = msrp_cents;
        this.availability = availability;
        this.state = state;
        this.inventory_receiving_date = inventory_receiving_date;
        this.variants_regions_config_attributes = variants_regions_config_attributes;
    }
}
