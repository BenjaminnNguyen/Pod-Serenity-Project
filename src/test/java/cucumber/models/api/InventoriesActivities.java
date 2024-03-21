package cucumber.models.api;

import lombok.Data;

@Data
public class InventoriesActivities {
    String activities_type;
    String create_at;
    String description;
    Integer id;
    Integer inventory_item_id;
    String lot_code;
    Integer order_id;
    String order_number;
    Integer quantities;
    String state;
}
