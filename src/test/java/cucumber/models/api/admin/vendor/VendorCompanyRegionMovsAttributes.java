package cucumber.models.api.admin.vendor;

import lombok.Data;

@Data
public class VendorCompanyRegionMovsAttributes {
    /**
     * Model thay đổi limit của region MOV
     */
    String id;
    String region_id;
    String region_name;
    String region_type;
    String mov_cents;
    String mov_currency;
}
