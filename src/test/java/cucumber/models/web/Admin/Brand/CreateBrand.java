package cucumber.models.web.Admin.brand;

import lombok.Data;

@Data
public class CreateBrand {
    String name;
    String description;
    String microDescriptions;
    String city;
    String state;
    String vendorCompany;
    String tags;

}
