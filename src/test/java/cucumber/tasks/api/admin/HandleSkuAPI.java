package cucumber.tasks.api.admin;

import cucumber.models.web.Admin.Products.sku.*;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleSkuAPI {

    public Response activeCompanySpecific() {
        CommonRequest commonRequest = new CommonRequest();
        String variant_id = Serenity.sessionVariableCalled("Variant ID").toString();
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.PRODUCT_VARIANT(variant_id), getCompanySpecific(), "PUT");
        System.out.println("RESPONSE ACTIVE COMPANY SPECIFIC " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE ACTIVE COMPANY SPECIFIC ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDetailSKU(String variant_id) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.PRODUCT_VARIANT(variant_id), "GET");
//        System.out.println("RESPONSE DETAIL SKU " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAIL SKU ").andContents(response.prettyPrint());
        return response;
    }

    public static Response callEditSKUTags(String id, Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.PRODUCT_VARIANT(id), map, "PUT");
//        System.out.println("RESPONSE UPDATE SKU TAGS" + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE SKU TAGS: ").andContents(response.prettyPrint());
        return response;
    }

    public static Response callEditSKU(String id, Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.PRODUCT_VARIANT(id), map, "PUT");
        System.out.println("RESPONSE UPDATE SKU" + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE SKU : ").andContents(response.prettyPrint());
        return response;
    }

    public StateCompanySku getCompanySpecific() {
        CompanyAttribuites companyAttribuite = Serenity.sessionVariableCalled("Company attributes");
        List<CompanyAttribuites> companyAttribuites = new ArrayList<>();
        companyAttribuites.add(companyAttribuite);
        ProductVariantCompanies productVariantCompany = new ProductVariantCompanies("active", companyAttribuites);
        StateCompanySku stateCompanySku = new StateCompanySku(productVariantCompany);
        return stateCompanySku;
    }

    public Response changeRegionsSpecific(String variant_id, String statusSKU) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.PRODUCT_VARIANT(variant_id), getRegionsSpecific(statusSKU), "PUT");
        System.out.println("RESPONSE ACTIVE REGIONS SPECIFIC " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE ACTIVE REGIONS SPECIFIC ").andContents(response.prettyPrint());
        return response;
    }

    public StateRegionsSku getRegionsSpecific(String status) {
        List<VariantRegionAttributes> variantRegionAttributesList = Serenity.sessionVariableCalled("List regions attributes");
        ProductVariantRegions productVariantRegions = new ProductVariantRegions(variantRegionAttributesList);
        if (!status.equals("")) {
            productVariantRegions = new ProductVariantRegions(status, variantRegionAttributesList);
        }

        StateRegionsSku stateRegionsSku = new StateRegionsSku(productVariantRegions);
        return stateRegionsSku;
    }

    public static Response addProp65(Boolean containChemical, String firstName, String lastName, String email, int skuId, int vendorCompanyId) {
        CommonRequest commonRequest = new CommonRequest();
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("contain_chemical", containChemical);
        map.putIfAbsent("email", email);
        map.putIfAbsent("first_name", firstName);
        map.putIfAbsent("last_name", lastName);
        map.putIfAbsent("product_variant_id", skuId);
        map.putIfAbsent("vendor_company_id", vendorCompanyId);
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.ADMIN_PROP65, map, "POST");
//        System.out.println("RESPONSE ADD PROP65 " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE ADD PROP65 ").andContents(response.prettyPrint());
        return response;
    }

    public String getIdStoreAttribute(String sku, String store) {
        String stores_variants_regions_attributes_config_id = null;
        JsonPath jsonPath = callDetailSKU(sku).jsonPath();
        List<Map<String, Object>> storeAttr = jsonPath.getList("stores_variants_regions_attributes");
        for (Map<String, Object> map : storeAttr) {
            if (map.get("store_id").toString().equals(store)) {
                String id = map.get("id").toString();
                Map<String, Object> stores_variants_regions_attributes_config = (Map<String, Object>) map.get("variants_regions_config_attributes");
                stores_variants_regions_attributes_config_id = stores_variants_regions_attributes_config.get("id").toString();
                Serenity.setSessionVariable("stores_variants_regions_attributes_config" + id).to(stores_variants_regions_attributes_config_id);
                Serenity.setSessionVariable("stores_variants_regions_attributes_id" + sku).to(id);
            }
        }
        return stores_variants_regions_attributes_config_id;
    }

    public String getIdBuyerAttribute(String sku, String buyerId, String region) {
        String buyer_variants_regions_attributes_config_id = null;
        JsonPath jsonPath = callDetailSKU(sku).jsonPath();
        List<Map<String, Object>> buyerAttr = jsonPath.getList("buyer_companies_variants_regions_attributes");
        for (Map<String, Object> map : buyerAttr) {
            if (map.get("buyer_company_id").toString().equals(buyerId) && map.get("region_id").toString().equals(region)) {
                String id = map.get("id").toString();
                Map<String, Object> buyer_variants_regions_attributes_config = (Map<String, Object>) map.get("variants_regions_config_attributes");
                buyer_variants_regions_attributes_config_id = buyer_variants_regions_attributes_config.get("id").toString();
                Serenity.setSessionVariable("buyer_variants_regions_attributes_config" + id).to(buyer_variants_regions_attributes_config_id);
                Serenity.setSessionVariable("buyer_variants_regions_attributes_id" + sku).to(id);
            }

        }
        return buyer_variants_regions_attributes_config_id;
    }

}
