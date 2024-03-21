package cucumber.models.api.admin.orders;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class GhostOrderAttributes {
    List<LineItemsAttributes> line_items_attributes;

    List<GhostLineItemsAttributes> ghost_line_items_attributes;
    String buyer_id;
    String payment_type;
    String street1;
    String city;
    String address_state_id;
    String zip;
    String number;
    String street;
    String customer_po;

    public GhostOrderAttributes(List<LineItemsAttributes> line_items_attributes, List<GhostLineItemsAttributes> ghost_line_items_attributes, String buyer_id, String payment_type, String street1, String city, String address_state_id, String zip, String number, String street, String customerPO) {
        this.line_items_attributes = line_items_attributes;
        this.ghost_line_items_attributes = ghost_line_items_attributes;
        this.buyer_id = buyer_id;
        this.payment_type = payment_type;
        this.street1 = street1;
        this.city = city;
        this.address_state_id = address_state_id;
        this.zip = zip;
        this.number = number;
        this.street = street;
        this.customer_po = customerPO;
    }
}
