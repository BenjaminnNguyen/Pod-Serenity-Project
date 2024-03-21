package cucumber.models.web.Admin.Products;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.nio.file.Path;
import java.util.List;

@Data
public class AdminCreateNewSKUModel {
    private String skuName;
    private String state;
    private String mainSKU;
    private String unitsCase;
    private String individualUnitUPC;
    private String individualUnitEANType;
    private String masterImage;
    private String caseUPC;
    private String unitUpcImage;
    private String caseUpcImage;
    private String storageShelfLife;
    private String storageCondition;
    private String retailShelfLife;
    private String retailCondition;
    private String pullThreshold;
    private String tempRequirementMin;
    private String tempRequirementMax;
    private String city;
    private String stateManufacture;
    private String ingredient;
    private String leadTime;
    private String description;
//    private NutritionLabel nutritionLabel;
    //    private List<String> qualities;
    private String expireDayThreshold;

    //    private List<RegionSpecificModel> regionSpecificModel;

}


