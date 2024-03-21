package cucumber.models.web.Admin.promotion;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PromotionActionAttributes {

    Integer id;
    String type;

    Boolean stacked;

    Integer min_qty;
    PercentageAttributesModel percentage_attributes;
    FixRateAttributeModel fix_rate_attributes;

    public PromotionActionAttributes(Integer id, String type, PercentageAttributesModel percentage_attributes) {
        this.id = id;
        this.type = type;
        this.stacked = false;
        this.percentage_attributes = percentage_attributes;

    }

    public PromotionActionAttributes(Integer id, String type, FixRateAttributeModel fix_rate_attributes) {
        this.id = id;
        this.type = type;
        this.stacked = false;
        this.fix_rate_attributes = fix_rate_attributes;
    }

    // with stack deal
    public PromotionActionAttributes(Integer id, String type, String min_qty, PercentageAttributesModel percentage_attributes) {
        this.id = id;
        this.type = type;
        this.stacked = true;
        this.min_qty = Integer.valueOf(min_qty);
        this.percentage_attributes = percentage_attributes;
    }

    public PromotionActionAttributes(Integer id, String type, String min_qty, FixRateAttributeModel fix_rate_attributes) {
        this.id = id;
        this.type = type;
        this.stacked = true;
        this.min_qty = Integer.valueOf(min_qty);
        this.fix_rate_attributes = fix_rate_attributes;
    }
}
