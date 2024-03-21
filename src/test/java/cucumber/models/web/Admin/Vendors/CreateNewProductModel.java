package cucumber.models.web.Admin.Vendors;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateNewProductModel {
    String productName;
    String brandName;
    String productType;
    String category;
    String unitLength;
    String unitWidth;
    String unitHeight;
    String caseLength;
    String caseWidth;
    String caseHeight;
    String caseWeight;
    String packageSize;
    String unitSize;
    String unit;
    String casesPerPallet;
    String casesPerLayer;
    String allowSample;
    String layersPerFullPallet;
    String masterCartonsPerPallet;
    String casesPerMasterCarton;
    String masterCaseDimensionsLength;
    String masterCaseDimensionsWidth;
    String masterCaseDimensionsHeight;
    String masterCaseWeight;

}
