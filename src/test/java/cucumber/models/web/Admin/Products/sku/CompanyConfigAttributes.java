package cucumber.models.web.Admin.Products.sku;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CompanyConfigAttributes {
    int id;
    String variants_region_id;
    String start_date;
    String end_date;
}
