package cucumber.tasks.api.admin;

import cucumber.models.web.Admin.promotion.*;
import cucumber.singleton.UrlAPI;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PromoAdminAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchPromo(String promoName) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[product_variant_name]", promoName);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_PROMO, map, "GET");
//        System.out.println("RESPONSE SEARCH PROMO " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH PROMO: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchPromoByProductName(String promoName) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[product_name]", promoName);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_PROMO, map, "GET");
//        System.out.println("RESPONSE SEARCH PROMO " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH PROMO: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchPromoByStoreName(String store) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[store_id]", store);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_PROMO, map, "GET");
//        System.out.println("RESPONSE SEARCH PROMO " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH PROMO: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchPromoByName(String Name) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[name]", Name);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_PROMO, map, "GET");
        System.out.println("RESPONSE SEARCH PROMO " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH PROMO: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchPromoSubmissionByName(String Name) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[name]", Name);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_PROMO_SUBMISSION, map, "GET");
        System.out.println("RESPONSE SEARCH SUBMISSION PROMO " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH SUBMISSION PROMO: ").andContents(response.prettyPrint());
        return response;
    }

    public void callDeletePromo(List<String> listId) {
        for (String id : listId) {
            Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_PROMO(id), "DELETE");
            System.out.println("RESPONSE DELETE PROMO " + response.prettyPrint());
            Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE PROMO: ").andContents(response.prettyPrint());
        }
    }

    public void callDeletePromoSubmission(List<String> listId) {
        for (String id : listId) {
            Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_PROMO_SUBMISSION(id), "DELETE");
            System.out.println("RESPONSE DELETE PROMO " + response.prettyPrint());
            Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE PROMO: ").andContents(response.prettyPrint());
        }
    }

    public Response callCreatePromo(Object map) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.CREATE_PROMO, map, "POST");
//        System.out.println("RESPONSE CREATE PROMO " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE PROMO: ").andContents(response.prettyPrint());
        return response;
    }

    public static ArrayList<PromotionRulesAttributeModel> setPromotionRulesAttributeModel(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        ArrayList<Integer> region_ids = new ArrayList<>();
        ArrayList<Integer> product_variant_ids = new ArrayList<>();
        ArrayList<Integer> excluded_buyer_company_ids = new ArrayList<>();
        ArrayList<Integer> buyer_company_ids = new ArrayList<>();
        ArrayList<Integer> excluded_store_ids = new ArrayList<>();
        ArrayList<Integer> store_ids = new ArrayList<>();
        ArrayList<PromotionRulesAttributeModel> promotionRulesAttributes = new ArrayList<>();

        for (Map<String, String> item : list) {
            if (!item.get("region_id").equals("")) {
                region_ids.add(Integer.valueOf(item.get("region_id")));
            }
            if (!item.get("idSKU").equals("")) {
                if (item.get("idSKU").equals("random")) {
                    product_variant_ids.add(Integer.valueOf(Serenity.sessionVariableCalled("ID SKU Admin")));
                } else
                    product_variant_ids.add(Integer.valueOf(item.get("idSKU")));
            }
            if (!item.get("store_ids").equals("")) {

                store_ids.add(Integer.valueOf(item.get("store_ids")));
            }

            if (!item.get("excluded_buyer_company_ids").equals("")) {
                excluded_buyer_company_ids.add(Integer.valueOf(item.get("excluded_buyer_company_ids")));
            }
            if (!item.get("buyer_company_ids").equals("")) {
                buyer_company_ids.add(Integer.valueOf(item.get("buyer_company_ids")));
            }
            if (!item.get("excluded_store_ids").equals("")) {
                excluded_store_ids.add(Integer.valueOf(item.get("excluded_store_ids")));
            }
        }

        if (region_ids.isEmpty()) {
            region_ids = null;
        }
        if (product_variant_ids.isEmpty()) {
            product_variant_ids = null;
        }
        if (store_ids.isEmpty()) {
            store_ids = null;
        }
        if (excluded_buyer_company_ids.isEmpty()) {
            excluded_buyer_company_ids = null;
        }
        if (buyer_company_ids.isEmpty()) {
            buyer_company_ids = null;
        }
        if (excluded_store_ids.isEmpty()) {
            excluded_store_ids = null;
        }

        PromotionRulesAttributeModel promotionRulesAttribute = new PromotionRulesAttributeModel(null, list.get(0).get("type"),
                product_variant_ids, store_ids, excluded_store_ids, buyer_company_ids, excluded_buyer_company_ids, region_ids);

        promotionRulesAttributes.add(promotionRulesAttribute);

        return promotionRulesAttributes;
    }

    public CreatePromotionModel setCreatePromotionModel(Map<String, String> info) {
        CreatePromotionModel createPromotionModel;
        List<PromotionActionAttributes> promotionActionAttributes = Serenity.sessionVariableCalled("Promotion Action Attributes");

        // model thể hiện SKU expiry date
        ShortDatePromoAttrAttributesModel shortDatePromoAttrAttributes = new ShortDatePromoAttrAttributesModel(CommonHandle.setDate2(info.get("skuExpireDate"), "yyyy-MM-dd"));
        ArrayList<PromotionRulesAttributeModel> promotion_rules_attributes = Serenity.sessionVariableCalled("Promotion Rules Attributes");
        PromotionModel promotion = new PromotionModel();
        if (info.containsKey("inventory_id")) {
            String inventory_id = info.get("inventory_id").contains("create by api") ? Serenity.sessionVariableCalled("Id Inventory api").toString() : info.get("inventory_id");
            String lot_code = info.get("lot_code").contains("create by api") ? Serenity.sessionVariableCalled("Lot code Inventory api").toString() : info.get("lot_code");
            promotion = new PromotionModel(info.get("type"), info.get("name"), info.get("description"), CommonHandle.setDate2(info.get("starts_at"), "yyyy-MM-dd"), CommonHandle.setDate2(info.get("expires_at"), "yyyy-MM-dd"),
                    info.get("id"), info.get("vendor_visible"), info.get("usage_limit"), info.get("case_limit"), info.get("buy_in"), info.get("minimum_num_case"), info.get("actionType"), null,
                    shortDatePromoAttrAttributes, promotion_rules_attributes, promotionActionAttributes, inventory_id, lot_code);
        } else {
            promotion = new PromotionModel(info.get("type"), info.get("name"), info.get("description"), CommonHandle.setDate2(info.get("starts_at"), "yyyy-MM-dd"), CommonHandle.setDate2(info.get("expires_at"), "yyyy-MM-dd"),
                    info.get("id"), info.get("vendor_visible"), info.get("usage_limit"), info.get("case_limit"), info.get("buy_in"), info.get("minimum_num_case"), info.get("actionType"), null,
                    shortDatePromoAttrAttributes, promotion_rules_attributes, promotionActionAttributes);
        }
        if (info.containsKey("overlap")) {
            createPromotionModel = new CreatePromotionModel(promotion, null, Boolean.parseBoolean(info.get("overlap")));
        } else
            createPromotionModel = new CreatePromotionModel(promotion, null, true);

        return createPromotionModel;
    }

    public List<String> getIdPromo(Response response) {
        List<String> idOrders = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            idOrders.add(item.get("id").toString());
        }
        Serenity.setSessionVariable("ID Promo API").to(idOrders);
        return idOrders;
    }

    public List<String> getIdPromoAfterCreate(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> idPromo = new ArrayList<>();
//        if (Serenity.hasASessionVariableCalled("ID Create Promo API")) {
//            idPromo = Serenity.sessionVariableCalled("ID Create Promo API");
//        }
        String id = jsonPath.getString("id");
        String name = jsonPath.getString("name");
        idPromo.add(id);
        Serenity.setSessionVariable("ID Create Promo API").to(idPromo);
        Serenity.setSessionVariable("ID Create Promo API" + name).to(id);
        return idPromo;
    }
}
