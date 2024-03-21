package cucumber.models.web.Admin.Products.sku;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreConfigAttributes {
    public int id;
    public int variants_region_id;
    public String start_date;
    public String end_date;
}
