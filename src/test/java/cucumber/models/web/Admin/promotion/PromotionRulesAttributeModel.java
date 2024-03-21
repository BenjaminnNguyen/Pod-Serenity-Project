package cucumber.models.web.Admin.promotion;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.ArrayList;

@Data
@AllArgsConstructor
public class PromotionRulesAttributeModel {

    Integer id;
    String type;
    ArrayList<Integer> product_variant_ids;
    ArrayList<Integer> store_ids;
    ArrayList<Integer> excluded_store_ids;
    ArrayList<Integer> buyer_company_ids;
    ArrayList<Integer> excluded_buyer_company_ids;
    ArrayList<Integer> region_ids;


}
