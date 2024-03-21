package cucumber.models.api;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateInventory {
    int product_variant_id;
    int quantity;
    String lot_code;
    int warehouse_id;
    String receive_date;
    String expiry_date;
    String comment;
//    public String inventory_images_attributes;
}
