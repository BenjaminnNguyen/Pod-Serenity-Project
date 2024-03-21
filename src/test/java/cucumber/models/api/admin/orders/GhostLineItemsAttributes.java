package cucumber.models.api.admin.orders;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GhostLineItemsAttributes {
    String variants_region_id;
    String quantity;

    public GhostLineItemsAttributes(String variants_region_id, String quantity) {
        this.variants_region_id = variants_region_id;
        this.quantity = quantity;
    }
}
