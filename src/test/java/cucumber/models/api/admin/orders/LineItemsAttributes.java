package cucumber.models.api.admin.orders;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LineItemsAttributes {
    /**
     * Line item of create order
     */
    String variants_region_id;
    String product_variant_id;
    String quantity;
    boolean fulfilled;
    String fulfillment_date;

    public LineItemsAttributes(String variants_region_id, String product_variant_id, String quantity, boolean fulfilled, String fulfillment_date) {
        this.variants_region_id = variants_region_id;
        this.product_variant_id = product_variant_id;
        this.quantity = quantity;
        this.fulfilled = fulfilled;
        this.fulfillment_date = fulfillment_date;
    }
}
