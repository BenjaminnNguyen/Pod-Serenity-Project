package cucumber.tasks.api.admin.brand;

import cucumber.models.api.admin.BrandCommisstionAttributes;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminBrandAPI {
    CommonRequest commonRequest = new CommonRequest();

    public Response callDetailOfBrand(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAILS BRAND: ").andContents(response.prettyPrint());
        return response;
    }

    public String getState(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String state = jsonPath.get("state").toString();
        System.out.println("State of Product = " + state);
        Serenity.setSessionVariable("State of Product").to(state);
        return state;
    }
    public Response callChangeState(String id) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("id", id);
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_BRAND_CHANGE_STATE(id), map, "PUT");
        System.out.println(response.asString());
        return response;
    }
    public Response callDetailBrand(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_BRAND_DETAIL(id),  "GET");
        return response;
    }

    public Response callCreateBrand(Object map, String basePath) {
        Response response = commonRequest.commonRequestWithBody2(basePath, map, "POST");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE BRAND: ").andContents(response.prettyPrint());
        return response;
    }

    public void callDeleteBrand(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "DELETE");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE BRAND: ").andContents(response.prettyPrint());
    }

    public Response callChangeStateBrand(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE STATE BRAND: ").andContents(response.prettyPrint());
        return response;
    }

    public void callDeleteBrands(List<String> brands) {
        for (String s : brands) {
            Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_BRAND(s), "DELETE");
            System.out.println("RESPONSE DELETE BRAND " + response.prettyPrint());
//            Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE BRAND: ").andContents(response.prettyPrint());
        }
    }

    public Response callEditBrand(Map<String, Object> map, String basePath) {
        Response response = commonRequest.commonRequestWithBody(basePath, map, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT BRAND: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditBrand(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.DELETE_BRAND(id), map, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT BRAND: ").andContents(response.prettyPrint());
        return response;
    }

    public void getBrandID(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        System.out.println("ID of Brand = " + id);
        Serenity.setSessionVariable("ID of Brand").to(id);
    }

    public BrandCommisstionAttributes getBrandCommissionAttributes(Response response) {
        JsonPath jsonPath = response.jsonPath();

        return jsonPath.getObject("brand_commission_attributes", BrandCommisstionAttributes.class);
    }

    public Boolean checkInActive(Response response) {
        boolean check = false;
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("state").toString();
        if (id.contains("inactive"))
            check = true;
        return check;
    }

    public List<String> getListBrandId(Response response) {
        List<String> brand = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            brand.add(item.get("id").toString());
        }
        Serenity.setSessionVariable("List Id Brand API").to(brand);
        return brand;
    }

    public Response searchBrand(String name) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[search_term]", name);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.CREATE_BRAND, map, "GET");
        System.out.println("RESPONSE SEARCH BRAND: " + response.prettyPrint());
        return response;
    }

    public void callSetStorePricingBrand(Map<String, Object> map, String basePath) {
        Response response = commonRequest.commonRequestWithBody(basePath, map, "PUT");
        System.out.println("RESPONSE SET PRICING BRAND: " + response.prettyPrint());
//        Serenity.recordReportData().withTitle("RESPONSE SET STORE PRICING BRAND: ").andContents(response.prettyPrint());
    }

    public void callDeleteStorePricingBrand(Map<String, Object> map, String basePath) {
        Response response = commonRequest.commonRequestWithBody(basePath, map, "DELETE");
//        Serenity.recordReportData().withTitle("RESPONSE DELETE STORE PRICING BRAND: ").andContents(response.prettyPrint());
    }

    public void callSetCompanyPricingBrand(Map<String, Object> map, String basePath) {
        Response response = commonRequest.commonRequestWithBody(basePath, map, "PUT");
//        Serenity.recordReportData().withTitle("RESPONSE SET COMPANY PRICING BRAND: ").andContents(response.prettyPrint());
    }

    public void callDeleteCompanyPricingBrand(Map<String, Object> map, String basePath) {
        Response response = commonRequest.commonRequestWithBody(basePath, map, "DELETE");
//        Serenity.recordReportData().withTitle("RESPONSE DELETE COMPANY PRICING BRAND: ").andContents(response.prettyPrint());
    }

    public void callDeleteFixedPricingBrand(String brandId, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.EDIT_BRAND(brandId), map, "PUT");
//        Serenity.recordReportData().withTitle("RESPONSE DELETE FIXED PRICING BRAND: ").andContents(response.prettyPrint());
    }
    public void callSetFixedPricingBrand(String brandId, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.EDIT_BRAND(brandId), map, "PUT");
//        Serenity.recordReportData().withTitle("RESPONSE SET FIXED PRICING BRAND: ").andContents(response.prettyPrint());
    }

    public List<Integer> getBrandStoreCommissionId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<Integer> ids = new ArrayList<>();
        List<HashMap> brand_stores_commissions = jsonPath.get("brand_stores_commissions");
        for (HashMap item : brand_stores_commissions) {
            ids.add(Integer.parseInt(item.get("id").toString()));
        }
        Serenity.setSessionVariable("List Id Brand Store Commission API").to(ids);
        return ids;
    }
    public List<Integer> getBrandCompanyCommissionId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<Integer> ids = new ArrayList<>();
        List<HashMap> brand_stores_commissions = jsonPath.get("brand_buyer_company_commissions");
        for (HashMap item : brand_stores_commissions) {
            ids.add(Integer.parseInt(item.get("id").toString()));
        }
        Serenity.setSessionVariable("List Id Brand Company Commission API").to(ids);
        return ids;
    }

}
