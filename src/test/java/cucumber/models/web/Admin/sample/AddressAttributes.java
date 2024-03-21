package cucumber.models.web.Admin.sample;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AddressAttributes {
    String address_state_code;

    public AddressAttributes(String address_state_code, String address_state_name, String address_state_id, String street1, String city, String zip) {
        this.address_state_code = address_state_code;
        this.address_state_name = address_state_name;
        this.address_state_id = address_state_id;
        this.street1 = street1;
        this.city = city;
        this.zip = zip;
    }

    public AddressAttributes(String address_state_id, String street1, String street2, String city, String zip) {
        this.address_state_id = address_state_id;
        this.street1 = street1;
        this.street2 = street2;
        this.city = city;
        this.zip = zip;
    }

    String address_state_name;
    String address_state_id;
    String street1;
    String city;
    String zip;
    String attn;
    String full_name;
    String lat;
    String lng;
    String phone_number;
    String street2;


}
