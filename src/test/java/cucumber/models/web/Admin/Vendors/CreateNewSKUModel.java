package cucumber.models.web.Admin.Vendors;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.nio.file.Path;
import java.util.List;

@Data
public class CreateNewSKUModel {
    String skuName;
    String unitsCase;
    String individualUnitUPC;
    String masterImage;
    String caseUPC;
    String unitUpcImage;
    String caseUpcImage;
    String storageShelfLife;
    String storageCondition;
    String retailShelfLife;
    String retailCondition;
    String tempRequirementMin;
    String tempRequirementMax;
    String city;
    String country;
    String stateManufacture;
    String ingredient;
    String leadTime;
    String description;
    String nutritionLabel;
}
