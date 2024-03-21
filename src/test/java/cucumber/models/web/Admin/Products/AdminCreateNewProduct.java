package cucumber.models.web.Admin.Products;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class AdminCreateNewProduct {
    String brandName;
    String productName;
    String status;
    String allowRequestSamples;
    String vendorCompany;
    String additionalFee;
    String category;
    String type;
    Tags tags;

    String unitLength;
    String unitWidth;
    String unitHeight;
    String caseLength;
    String caseWidth;
    String caseHeight;
    String caseWeight;
    String packageSize;
    String unitSize;
    String casesPerPallet;
    String casesPerLayer;
    String layersPerFullPallet;

    String masterCartonsPerPallet;
    String casesPerMasterCarton;
    String masterCaseDimensionsLength;
    String masterCaseDimensionsWidth;
    String masterCaseDimensionsHeight;
    String masterCaseWeight;
    String microDescriptions;
    StateFees stateFees;


}

