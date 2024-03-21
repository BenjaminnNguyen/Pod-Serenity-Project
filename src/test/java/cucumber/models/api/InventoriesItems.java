package cucumber.models.api;

import lombok.Data;

@Data
public class InventoriesItems {
    Integer id;
    String lot_code;
    Integer order_id;
    String order_number;
    Integer quantities;
    String comment;
    String state;
    Integer subtraction_category_id;
}
