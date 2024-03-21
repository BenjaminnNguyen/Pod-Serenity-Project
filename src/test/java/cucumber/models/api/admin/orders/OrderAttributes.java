package cucumber.models.api.admin.orders;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class OrderAttributes {
    List<LineItemsAttributes> line_items_attributes;
    String buyer_id;
    String customer_po;
    String admin_note;
    String payment_type;
    String num_of_delay;
    String attn;
    String street1;
    String city;
    String address_state_id;
    String zip;
    Boolean has_surcharge;
    String department;
    String address_state_code;
    String address_state_name;

    public OrderAttributes(List<LineItemsAttributes> line_items_attributes, String buyer_id, String customer_po, String admin_note, String payment_type, String num_of_delay, String attn,
                           String street1, String city, String address_state_id, String zip, Boolean has_surcharge, String department,
                           String address_state_code, String address_state_name) {
        this.line_items_attributes = line_items_attributes;
        this.buyer_id = buyer_id;
        this.customer_po = customer_po;
        this.admin_note = admin_note;
        this.payment_type = payment_type;
        this.num_of_delay = num_of_delay;
        this.attn = attn;
        this.street1 = street1;
        this.city = city;
        this.address_state_id = address_state_id;
        this.address_state_name = address_state_name;
        this.address_state_code = address_state_code;
        this.department = department;
        this.zip = zip;
        this.has_surcharge = has_surcharge;

    }
}
