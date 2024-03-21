package cucumber.models.web.Admin.brand.createbrand;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BrandModel {
    String name;
    String description;
    String micro_description;
    ArrayList<Object> brands_tags_attributes;
    String city;
    int address_state_id;
    int vendor_company_id;

    public BrandModel(String name, String description, String micro_description, String city, int address_state_id, int vendor_company_id) {
        this.name = name;
        this.description = description;
        this.micro_description = micro_description;
        this.city = city;
        this.address_state_id = address_state_id;
        this.vendor_company_id = vendor_company_id;
    }

}
