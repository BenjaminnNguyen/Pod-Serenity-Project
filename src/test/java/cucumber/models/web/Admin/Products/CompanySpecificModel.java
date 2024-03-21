package cucumber.models.web.Admin.Products;

import lombok.Data;

@Data
public class CompanySpecificModel {
    private String buyerCompany;
    private String region;
    private String msrpUnit;
    private String casePrice ;
    private String availability ;
    private String inventoryArrivingAt ;
    private String category ;
    private String startDate ;
    private String endDate ;
}
