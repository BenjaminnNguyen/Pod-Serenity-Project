package cucumber.models.web.Admin.Products;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class RegionSpecificModel {
    private String regionName;
    private String casePrice;
    private String msrpunit;
    private String availability ;
    private String arriving;
    private String category;
    private String inventoryCount;
    private String state;
//    private String startDate;
//    private String endDate;
}
