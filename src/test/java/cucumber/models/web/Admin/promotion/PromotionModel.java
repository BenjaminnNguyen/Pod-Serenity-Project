package cucumber.models.web.Admin.promotion;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PromotionModel {

     String type;
     String name;
     String description;
     String starts_at;
     String expires_at;
     String id;
     String vendor_visible;
     String usage_limit;
     String case_limit;
     String buy_in;
     String minimum_num_case;
     String promo_action_type;
     Object sku_expiry_date;
     ShortDatePromoAttrAttributesModel short_date_promo_attr_attributes;
//     ArrayList<Integer> region_ids;
//     PromotionAction promotion_action;
     ArrayList<PromotionRulesAttributeModel> promotion_rules_attributes;
     List<PromotionActionAttributes> promotion_actions_attributes;
     String inventory_id;
     String lot_code;

     public PromotionModel(String type, String name, String description, String starts_at, String expires_at, String id, String vendor_visible, String usage_limit, String case_limit, String buy_in, String minimum_num_case, String promo_action_type, Object sku_expiry_date, ShortDatePromoAttrAttributesModel short_date_promo_attr_attributes, ArrayList<PromotionRulesAttributeModel> promotion_rules_attributes, List<PromotionActionAttributes> promotion_actions_attributes) {
          this.type = type;
          this.name = name;
          this.description = description;
          this.starts_at = starts_at;
          this.expires_at = expires_at;
          this.id = id;
          this.vendor_visible = vendor_visible;
          this.usage_limit = usage_limit;
          this.case_limit = case_limit;
          this.buy_in = buy_in;
          this.minimum_num_case = minimum_num_case;
          this.promo_action_type = promo_action_type;
          this.sku_expiry_date = sku_expiry_date;
          this.short_date_promo_attr_attributes = short_date_promo_attr_attributes;
          this.promotion_rules_attributes = promotion_rules_attributes;
          this.promotion_actions_attributes = promotion_actions_attributes;
     }
}
