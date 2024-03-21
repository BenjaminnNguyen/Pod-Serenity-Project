package cucumber.models.api;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class VariantRegionAttributes {
    public int id;
    public int region_id;
    public int product_variant_id;
    public int case_price_cents;
    public int msrp_cents;
    public String availability;
    public String state;
}
