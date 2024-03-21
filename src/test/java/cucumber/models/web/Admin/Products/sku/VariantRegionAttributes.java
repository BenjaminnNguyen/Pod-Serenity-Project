package cucumber.models.web.Admin.Products.sku;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VariantRegionAttributes {
    int id;
    int region_id;
    int product_variant_id;
    int case_price_cents;
    int msrp_cents;
    String availability;
    String state;
    String inventory_receiving_date;
    String out_of_stock_reason;
}
