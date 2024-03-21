package steps.api.admin.promotions;

import io.cucumber.java.en.*;
import cucumber.models.web.Admin.promotion.*;
import cucumber.tasks.api.admin.PromoAdminAPI;
import io.cucumber.datatable.DataTable;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class PromotionAPIStepDefinitions {

    PromoAdminAPI promoAdminAPI = new PromoAdminAPI();

    @And("Admin search promotion by skuName {string}")
    public void search_promotion_by_skuname(String skuName) {
        Response response = promoAdminAPI.callSearchPromo(skuName);
        promoAdminAPI.getIdPromo(response);
    }

    @And("Admin search promotion by product Name {string}")
    public void search_promotion_by_productName(String pr) {
        Response response = promoAdminAPI.callSearchPromoByProductName(pr);
        promoAdminAPI.getIdPromo(response);
    }
    @And("Admin search promotion by store {string}")
    public void search_promotion_by_store(String st) {
        Response response = promoAdminAPI.callSearchPromoByStoreName(st);
        promoAdminAPI.getIdPromo(response);
    }

    @And("Admin search promotion by Promotion Name {string}")
    public void search_promotion_by_name(String Name) {
        Response response = promoAdminAPI.callSearchPromoByName(Name);
        promoAdminAPI.getIdPromo(response);
    }

    @And("Admin search promotion vendor submission by Promotion Name {string}")
    public void search_promotion_submission_by_name(String Name) {
        Response response = promoAdminAPI.callSearchPromoSubmissionByName(Name);
        promoAdminAPI.getIdPromo(response);
    }

    @And("Admin delete promotion by skuName {string}")
    public void delete_promotion_by_skuname(String skuName) {
        List<String> listID = Serenity.sessionVariableCalled("ID Promo API");
        if (listID.size() > 0) {
            promoAdminAPI.callDeletePromo(listID);
        }
    }

    @And("Admin delete promotion submission by api name {string}")
    public void delete_promotion_submission_by_name(String skuName) {
        List<String> listID = Serenity.sessionVariableCalled("ID Promo API");
        if (listID.size() > 0) {
            promoAdminAPI.callDeletePromoSubmission(listID);
        }
    }

    @And("Admin create promotion by api with info")
    public void create_promotion(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);

        CreatePromotionModel createPromotionModel = promoAdminAPI.setCreatePromotionModel(list.get(0));
        Response response = promoAdminAPI.callCreatePromo(createPromotionModel);
        promoAdminAPI.getIdPromoAfterCreate(response);
    }

    @And("Admin add specific SKUs by API")
    public void add_specific_sku(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        ArrayList<Integer> region_ids = new ArrayList<>();
        for (Map<String, String> item : list) {
            region_ids.add(Integer.valueOf(item.get("id")));
        }
        Serenity.setSessionVariable("Specific SKUs").to(region_ids);
    }

    @And("Admin add region by API")
    public void add_region(DataTable dt) {
        ArrayList<PromotionRulesAttributeModel> promotionRulesAttributes = PromoAdminAPI.setPromotionRulesAttributeModel(dt);
        Serenity.setSessionVariable("Promotion Rules Attributes").to(promotionRulesAttributes);
    }

    @And("Admin add stack deal of promotion by API")
    public void add_stack_deal_of_promotion(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        List<PromotionActionAttributes> promotionActionAttributes = new ArrayList<>();
        for (Map<String, String> item : list) {
            // loại giảm giá Fix rate hay giảm Percentage
            PercentageAttributesModel percentageAttributes = new PercentageAttributesModel(null, item.get("chargeValue"));
            FixRateAttributeModel fixRateAttributeModel = new FixRateAttributeModel(null, item.get("chargeValue"));

            if (item.get("typeCharge").contains("PercentageAdjustment")) {
                // nếu không có stack deal
                if (item.get("stack").contains("false")) {
                    promotionActionAttributes.add(new PromotionActionAttributes(null, item.get("typeCharge"), percentageAttributes));
                } else { // nếu có stack deal thì phải thêm min qty
                    promotionActionAttributes.add(new PromotionActionAttributes(null, item.get("typeCharge"), item.get("minQty"), percentageAttributes));
                }
            } else {
                if (item.get("stack").contains("false")) {
                    promotionActionAttributes.add(new PromotionActionAttributes(null, item.get("typeCharge"), fixRateAttributeModel));
                } else {
                    promotionActionAttributes.add(new PromotionActionAttributes(null, item.get("typeCharge"), item.get("minQty"), fixRateAttributeModel));
                }
            }
        }
        Serenity.setSessionVariable("Promotion Action Attributes").to(promotionActionAttributes);
    }
}
