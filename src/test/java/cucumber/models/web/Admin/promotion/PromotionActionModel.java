package cucumber.models.web.Admin.promotion;

import lombok.Data;

@Data
public class PromotionActionModel {

    public int id;
    public String type;
    public PercentageAttributesModel percentage_attributes;
}
