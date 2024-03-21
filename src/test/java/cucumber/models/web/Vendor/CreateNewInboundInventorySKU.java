package cucumber.models.web.Vendor;

import lombok.Data;

@Data
public class CreateNewInboundInventorySKU {
    public String sku_name;
    public String num_of_case;
    public String product_lot_code;
    public String expiry_date;

}
