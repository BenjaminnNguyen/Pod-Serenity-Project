package cucumber.tasks.api.admin.products;

import cucumber.models.api.Tax.*;
import cucumber.singleton.UrlAPI;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductAdminAPI {

    static CommonRequest commonRequest = new CommonRequest();

    public Response callCreateProduct(JSONObject body, String basePath) {
        Response response = CommonRequest.callCommonApiTest(body, basePath);
//        System.out.println("RESPONSE CREATE PRODUCT " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public void getIDProduct(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        System.out.println("id = " + id);
        Serenity.setSessionVariable("ID Product Admin").to(id);
        Serenity.recordReportData().asEvidence().withTitle("ID Product Admin")
                .andContents(id);
    }

    public void getIDProduct(String name, Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        String name_ = jsonPath.get("name").toString();
        if (name.contains(name)) {
            Serenity.setSessionVariable("ID Product Admin" + name).to(id);
        }
    }

    public Response callDeleteSKU(String idSKU) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_SKU(idSKU), "DELETE");
//        System.out.println("RESPONSE DELETE SKU " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE SKU: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteProduct(String product) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_PRODUCT(product), "DELETE");
//        System.out.println("RESPONSE DELETE PRODUCT " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public Response searchProduct(String name) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[search_term]", name);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.CREATE_PRODUCT, map, "GET");
//        getIdProduct(response);
//        System.out.println("RESPONSE SEARCH PRODUCT: " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDetailProduct(String productID) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DETAIL_PRODUCT(productID), "GET");
//        System.out.println("RESPONSE DETAIL PRODUCT " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAIL PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public Response changeStateProduct(String productID) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.STATE_PRODUCT(productID), "PUT");
//        System.out.println("RESPONSE CHANGE STATE PRODUCT " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE STATE PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public String getState(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String state = jsonPath.get("state").toString();
        System.out.println("State of Product = " + state);
        Serenity.setSessionVariable("State of Product").to(state);
        return state;
    }

    public List<String> getIdProduct(Response response) {
        List<String> product = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            product.add(item.get("id").toString());
        }
        Serenity.setSessionVariable("ID Product API").to(product);
        return product;
    }

    public List<String> getIdProductActive(Response response) {
        List<String> product = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            if (item.get("state").equals("active"))
                product.add(item.get("id").toString());
        }
        Serenity.setSessionVariable("ID Product API").to(product);
        return product;
    }

    public void callDeleteProduct(List<String> products) {
        for (String s : products) {
            Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_PRODUCT(s), "DELETE");
            System.out.println("RESPONSE DELETE PRODUCT " + response.prettyPrint());
            Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE PRODUCT: ").andContents(response.prettyPrint());
        }
//        return response;
    }

    public Response callGetRecommendationByBuyerId(String id) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[buyer_id]", id);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_RECOMMENDATION, map, "GET");
        List<Map<String, String>> result = response.jsonPath().getList("results");
        List<String> ids = new ArrayList<>();
        for (Map<String, String> idd : result) {
            ids.add(String.valueOf(idd.get("id")));
        }
        Serenity.setSessionVariable("List id Recommendation").to(ids);
        System.out.println("RESPONSE PRODUCT RECOMMENDATION" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE PRODUCT RECOMMENDATION: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetRecommendationByHeadBuyerId(String id) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("q[head_buyer_id]", id);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_RECOMMENDATION, map, "GET");
        List<Map<String, String>> result = response.jsonPath().getList("results");
        List<String> ids = new ArrayList<>();
        for (Map<String, String> idd : result) {
            ids.add(String.valueOf(idd.get("id")));
        }
        Serenity.setSessionVariable("List id Recommendation").to(ids);
        System.out.println("RESPONSE PRODUCT RECOMMENDATION" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE PRODUCT RECOMMENDATION: ").andContents(response.prettyPrint());
        return response;
    }

    public String getIdRecommended(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        System.out.println("Id of Recommended Product = " + id);
        Serenity.setSessionVariable("Id of Recommended Product api").to(id);
        return id;
    }

    public void callDeleteProductRecommendation(List<String> products) {
        for (String s : products) {
            Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_RECOMMENDATION(s), "DELETE");
            System.out.println("RESPONSE DELETE PRODUCT RECOMMENDATION " + response.prettyPrint());
            Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE RECOMMENDATION: ").andContents(response.prettyPrint());
        }
//        return response;
    }

    public Response callCreateRecommendation(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_RECOMMENDATION, map, "POST");
        System.out.println("RESPONSE CREATE RECOMMENDATION " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE RECOMMENDATION: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditRecommendation(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_RECOMMENDATION(id), map, "PUT");
        System.out.println("RESPONSE EDIT RECOMMENDATION " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT RECOMMENDATION: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callProductDetail(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.PRODUCT_DETAILS(id), "GET");
        System.out.println("RESPONSE PRODUCT DETAIL" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE PRODUCT DETAIL: ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getAllSkuId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> state = jsonPath.get("product_variants");
        List<String> ids = new ArrayList<>();
        for (Map<String, Object> id : state) {
            ids.add(id.get("id").toString());
        }
        return ids;
    }

    public String getIdSkuByName(Response response, String skuName) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> product_variants = jsonPath.get("product_variants");
        String skuID = null;
        for (HashMap product : product_variants) {
            if (product.get("name").equals(skuName)) {
                skuID = product.get("id").toString();
            }
        }
        return skuID;
    }

    public String getIdSkuByID(Response response, String skuID) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> product_variants = jsonPath.get("product_variants");
        String skuID1 = null;
        for (HashMap product : product_variants) {
            if (product.get("id").toString().equals(skuID)) {
                skuID1 = product.get("id").toString();
            }
        }
        return skuID1;
    }

    public Response callChangeMOQvalue(String productID, Map<String, Object> product) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.PRODUCT_DETAILS(productID), product, "PUT");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE MOQ VALUE ").andContents(response.prettyPrint());
        return response;
    }

    public Map<String, Object> setChangeMOQ(List<Map<String, Object>> infos) {
        Map<String, Object> product = new HashMap<>();
        List<Map<String, Object>> products_region_moqs_attributes = new ArrayList<>();
        for (Map<String, Object> item : infos) {
            Map<String, Object> info = new HashMap<>();
            info.putIfAbsent("id", item.get("id"));
            info.putIfAbsent("moq", item.get("moq"));
            info.putIfAbsent("product_id", item.get("product_id"));
            info.putIfAbsent("region_id", item.get("region_id"));

            products_region_moqs_attributes.add(info);
        }

        product.putIfAbsent("products_region_moqs_attributes", products_region_moqs_attributes);
        return product;
    }

    public List<Map<String, Object>> getRegionMOQ(Response response) {
        JsonPath json = response.jsonPath();
        List<Map<String, Object>> products_region_moqs_attributes = json.getList("products_region_moqs_attributes");
        Serenity.setSessionVariable("products_region_moqs_attributes").to(products_region_moqs_attributes);
        return products_region_moqs_attributes;
    }

    public static String getIdRegionMOQ(String productId, String regionId) {
        List<Map<String, Object>> products_region_moqs_attributes = Serenity.sessionVariableCalled("products_region_moqs_attributes");
        String id = "";
        for (Map<String, Object> map : products_region_moqs_attributes) {
            if (productId.equals(map.get("product_id").toString()) && regionId.equals(map.get("region_id").toString()))
                id = map.get("id").toString();
        }
        return id;
    }

    public Response callChangeStateSKU(String id, String state) {
        String basePath = UrlAdminAPI.ADMIN_PRODUCT_VARIANT_CHANGE_STATE(id);
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> mapState = new HashMap<>();
        mapState.putIfAbsent("state", state);
        map.putIfAbsent("product_variant", mapState);
        Response response = new CommonRequest().commonRequestWithBody(basePath, map, "PUT");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE STATE SKU ").andContents(response.prettyPrint());
        return response;
    }

    public Response callChangeRegionInfoSKU(String id, Map<String, Object> mapVariantsRegion) {
        String basePath = UrlAdminAPI.ADMIN_PRODUCT_VARIANT_CHANGE_STATE(id);
        Response response = commonRequest.commonRequestWithBody(basePath, mapVariantsRegion, "PUT");
        System.out.println("RESPONSE UPDATE SKU " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE SKU: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callChangeRegionMOQ(String productID, Map<String, Object> map) {
        String basePath = UrlAdminAPI.PRODUCT_DETAILS(productID);
        Response response = commonRequest.commonRequestWithBody(basePath, map, "PUT");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE REGION MOQ: ").andContents(response.prettyPrint());
        return response;
    }

    public static Map<String, Object> setChangeRegionMoqModel(String productId, List<Map<String, Object>> infos) {
        Map<String, Object> product = new HashMap<>();
        Map<String, Object> regionAttribute = new HashMap<>();
        List<Map<String, Object>> tempArray = new ArrayList<>();
        for (Map<String, Object> info : infos) {
            Map<String, Object> temp = new HashMap<>();
            String id = info.get("id").toString();
            if (info.get("id").toString().contains("create by api")) {
                id = getIdRegionMOQ(productId, info.get("region_id").toString());
            }
            temp.putIfAbsent("id", id);
            temp.putIfAbsent("product_id", productId);
            temp.putIfAbsent("region_id", info.get("region_id"));
            temp.putIfAbsent("moq", info.get("moq"));
//            temp.putIfAbsent("created_at", info.get("created_at"));
//            temp.putIfAbsent("updated_at", CommonHandle.setDate2(info.get("updated_at").toString(), "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));

            tempArray.add(temp);
        }
        regionAttribute.putIfAbsent("products_region_moqs_attributes", tempArray);
        product.putIfAbsent("product", regionAttribute);
        return product;
    }

    /**
     * Tax - API
     */

    public static AddTax setAddTaxModel(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        ArrayList<AddProductFeesAtribute> state_product_fees_attributes = new ArrayList<>();
        for (Map<String, String> info : infos) {
            AddProductFeesAtribute state_product_fees_attribute = new AddProductFeesAtribute(info.get("id"), info.get("value"));
            state_product_fees_attributes.add(state_product_fees_attribute);
        }

        AddFeesList list = new AddFeesList(state_product_fees_attributes);
        AddTax addTax = new AddTax(list);

        return addTax;
    }

    public static Response callAddTax(String id, AddTax addTax) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.DETAIL_PRODUCT(id), addTax, "PUT");
        System.out.println("RESPONSE ADD TAX" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE ADD TAX: ").andContents(response.prettyPrint());
        return response;
    }

    public static DeleteTax setDeleteTaxModel(List<String> taxList, String idProduct) {
        List<ProductFeesAttribute> state_product_fees_attributes = new ArrayList<>();
        for (String tax : taxList) {
            ProductFeesAttribute state_product_fees_attribute = new ProductFeesAttribute(tax, idProduct, true);
            state_product_fees_attributes.add(state_product_fees_attribute);
        }
        FeesList list = new FeesList(state_product_fees_attributes);
        DeleteTax deleteTax = new DeleteTax(list);
        return deleteTax;
    }

    public List<String> getListProductTax(Response response) {
        List<String> tax_list = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> stateProductFeesAttributes = jsonPath.get("state_product_fees_attributes");

        for (HashMap item : stateProductFeesAttributes) {
            tax_list.add(item.get("id").toString());
            System.out.println(item.get("id"));
        }
        return tax_list;
    }

    public static Response callDeleteTax(String idProduct, DeleteTax deleteTax) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.DETAIL_PRODUCT(idProduct), deleteTax, "PUT");
        System.out.println("RESPONSE DELETE TAX" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE TAX: ").andContents(response.prettyPrint());
        return response;
    }

    public static Response callEditProductCategory(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.PRODUCT_CATEGORY(id), map, "PUT");
        System.out.println("RESPONSE UPDATE CATEGORY" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE CATEGORY: ").andContents(response.prettyPrint());
        return response;
    }

    public static Response callEditProductTags(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.DETAIL_PRODUCT(id), map, "PUT");
        System.out.println("RESPONSE UPDATE TAGS" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE TAGS: ").andContents(response.prettyPrint());
        return response;
    }

    public static Response callEditProduct(String id, Map<String, String> map) {
        Response response = commonRequest.commonRequestWithParam2(UrlAdminAPI.DETAIL_PRODUCT(id), map, "PUT");
        System.out.println("RESPONSE UPDATE PRODUCT" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public static Response callEditSKU(String id, Map<String, String> map) {
        Response response = commonRequest.commonRequestWithParam2(UrlAdminAPI.DELETE_SKU(id), map, "PUT");
        System.out.println("RESPONSE UPDATE SKU" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE SKU: ").andContents(response.prettyPrint());
        return response;
    }

    public static Response callEditSKU2(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.DELETE_SKU(id), map, "PUT");
        System.out.println("RESPONSE UPDATE SKU" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE SKU: ").andContents(response.prettyPrint());
        return response;
    }

    public static List<Map<String, Object>> getListProductTags(Response response) {
        List<Map<String, Object>> tags = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        tags = jsonPath.get("tags_info");
        return tags;
    }

    public static List<Integer> getListQualities(Response response) {
        List<Integer> quality_ids = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        quality_ids = jsonPath.get("quality_ids");
        return quality_ids;
    }

}
