package cucumber.models.web.Admin.Products;

import lombok.Data;

@Data
public class SearchProduct {
    String term;
    String productState;
    String brandName;
    String vendorCompany;
    String productType;
    String packageSize;
    String sampleable;
    String availableIn;
    String tags;
}
