package cucumber.tasks.api.admin;

import cucumber.singleton.UrlAPI;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AuthorizedSKUsAPI {
    static CommonRequest commonRequest = new CommonRequest();

    public Response authorizeSKU(String SKU_id, String storeId) {
        Map<String, Object> store = new HashMap<>();
        store.putIfAbsent("store_id", storeId);
        List<Map<String, Object>> list_store = new ArrayList<>();
        list_store.add(store);
        Map<String, Object> stores_white_list = new HashMap<>();
        stores_white_list.putIfAbsent("stores_white_list_variants_attributes", list_store);

        if (SKU_id.isEmpty()) {
            SKU_id = Serenity.sessionVariableCalled("ID SKU Admin");
        }
        stores_white_list.putIfAbsent("id", SKU_id);
        List<Map<String, Object>> product_variant = new ArrayList<>();
        product_variant.add(stores_white_list);
        Map<String, Object> product_variants = new HashMap<>();
        product_variants.putIfAbsent("product_variants", product_variant);
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_AUTHORIZED_SKU, product_variants, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE AUTHORIZE SKU:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response authorizeSKUBuyer(String SKU_id, String buyerID) {
        Map<String, Object> buyer = new HashMap<>();
        buyer.putIfAbsent("buyer_id", buyerID);
        List<Map<String, Object>> list_buyer = new ArrayList<>();
        list_buyer.add(buyer);
        Map<String, Object> buyers_white_list_variants_attributes = new HashMap<>();
        buyers_white_list_variants_attributes.putIfAbsent("buyers_white_list_variants_attributes", list_buyer);
        if (SKU_id.isEmpty()) {
            SKU_id = Serenity.sessionVariableCalled("ID SKU Admin");
        }
        buyers_white_list_variants_attributes.putIfAbsent("id", SKU_id);
        List<Map<String, Object>> product_variant = new ArrayList<>();
        product_variant.add(buyers_white_list_variants_attributes);
        Map<String, Object> product_variants = new HashMap<>();
        product_variants.putIfAbsent("product_variants", product_variant);
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_AUTHORIZED_SKU, product_variants, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE AUTHORIZE SKU:  ").andContents(response.prettyPrint());
        return response;
    }
}
