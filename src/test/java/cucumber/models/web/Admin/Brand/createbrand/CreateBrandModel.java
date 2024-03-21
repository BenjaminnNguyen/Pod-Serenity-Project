package cucumber.models.web.Admin.brand.createbrand;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CreateBrandModel {
    cucumber.models.web.Admin.brand.createbrand.BrandModel brand;

    public CreateBrandModel(cucumber.models.web.Admin.brand.createbrand.BrandModel brand) {
        this.brand = brand;
    }
}





