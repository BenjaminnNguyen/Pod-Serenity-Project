package cucumber.models.web.Admin.Products;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ProductDetail {
    String brandName;
    String productName;
    Boolean allowRequestSamples;
    String additionalFee ;
    String category;
    String type;
    String tags;

    String unitLWH;
    String caseLWH;
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
}
