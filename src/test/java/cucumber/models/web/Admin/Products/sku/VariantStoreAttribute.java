package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class VariantStoreAttribute {
    public int id;
    public int region_id;
    public int store_id;
    public int product_variant_id;
    public int case_price_cents;
    public int msrp_cents;
    public String availability;
    public String state;
    public String inventory_receiving_date;
    public StoreConfigAttributes variants_regions_config_attributes;

    public VariantStoreAttribute(int id, int region_id, int store_id, int product_variant_id, int case_price_cents, int msrp_cents, String availability, String state, String inventory_receiving_date, StoreConfigAttributes variants_regions_config_attributes) {
        this.id = id;
        this.region_id = region_id;
        this.store_id = store_id;
        this.product_variant_id = product_variant_id;
        this.case_price_cents = case_price_cents;
        this.msrp_cents = msrp_cents;
        this.availability = availability;
        this.state = state;
        this.inventory_receiving_date = inventory_receiving_date;
        this.variants_regions_config_attributes = variants_regions_config_attributes;
    }
}
