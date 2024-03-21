package cucumber.tasks.api.buyer;

import cucumber.models.web.buyer.Product.FavoriteProduct;
import cucumber.singleton.UrlAPI;
import cucumber.tasks.api.CommonRequest;
import io.cucumber.java.it.Ma;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BuyerAPI {

    static CommonRequest commonRequest = new CommonRequest();

    public Response getCart(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "GET");
        return response;
    }

    public static List<String> getIdCartToDelete(Response response) {
        List<String> listId = new ArrayList<String>();
        JsonPath jsonPath = response.jsonPath();
        HashMap order = jsonPath.get("order");
        List<HashMap> lineItemsAttributes = (List<HashMap>) order.get("line_items_attributes");

        for (HashMap item : lineItemsAttributes) {
            listId.add(item.get("id").toString());
        }
        return listId;
    }

    public static String getVariantRegionId(String productId, String variantId) {
        Response response = commonRequest.commonRequestNoBody(UrlAPI.BUYER_GET_PRODUCT(productId), "GET");
        System.out.println("RESPONSE GET VARIANT REGION" + response.prettyPrint());
        JsonPath jsonPath = response.jsonPath();

        HashMap variants = jsonPath.get("variants");
        HashMap variant = (HashMap) variants.get(variantId);

        String variantRegionId = variant.get("variants_region_id").toString();
        return variantRegionId;
    }

    public static Response callBuyerOrderDetail(String orderID) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAPI.GET_ORDER(orderID), "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE BUYER ORDER DETAIL ").andContents(response.prettyPrint());
        return response;
    }

    public static String getOrderID(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String orderNumber = jsonPath.get("number");
        Serenity.setSessionVariable("ID Invoice").to(orderNumber);
        Serenity.setSessionVariable("Number Order API").to(orderNumber);
        Serenity.setSessionVariable("ID Order").to(orderNumber);
        return orderNumber;
    }

    public static String getSubInvoice(Response response) {
        String subInvoice = null;
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> sub_invoices = jsonPath.get("sub_invoices");
        if (sub_invoices.size() != 0) {
            subInvoice = sub_invoices.get(0).get("number").toString();
        }
        Serenity.setSessionVariable("Sub-invoice ID create by admin").to(subInvoice);
        return subInvoice;
    }

    /**
     * Favorite API
     */

    public Response callFavoriteProduct(FavoriteProduct favoriteProduct) {
        String basePath = UrlAPI.FAVORITE_PRODUCT;
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody2(basePath, favoriteProduct, "POST");
        System.out.println("RESPONSE FAVORITE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE FAVORITE: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callFavoriteProductHead(FavoriteProduct favoriteProduct) {
        String basePath = UrlAPI.HEAD_BUYER_FAVORITE_PRODUCT;
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody2(basePath, favoriteProduct, "POST");
        System.out.println("RESPONSE FAVORITE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE FAVORITE: ").andContents(response.prettyPrint());
        return response;
    }

    public void callRemoveAllFavorite(String buyer) {
        List<String> ids = Serenity.sessionVariableCalled("Buyer Favorite list");
        for (String id : ids) {
            String basePath = UrlAPI.REMOVE_FAVORITE(id);
            if (buyer.contains("head buyer"))
                basePath = UrlAPI.HEAD_BUYER_REMOVE_FAVORITE(id);
            CommonRequest commonRequest = new CommonRequest();
            Response response = commonRequest.commonRequestNoBody(basePath, "DELETE");
        }
    }

    public Response callGetIDFavorite() {
        String basePath = UrlAPI.FAVORITE_PRODUCT;
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(basePath, "GET");
        System.out.println("RESPONSE FAVORITE ID" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE FAVORITE ID: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetIDFavoriteHeadBuyer() {
        String basePath = UrlAPI.HEAD_BUYER_FAVORITE_PRODUCT;
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(basePath, "GET");
        System.out.println("RESPONSE FAVORITE ID" + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE FAVORITE ID: ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getFavoriteId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> ids = new ArrayList<>();
        List<Map<String, Object>> results = jsonPath.get("results");
        for (Map<String, Object> map : results) {
            ids.add(map.get("favorite_product_id").toString());
        }
        Serenity.setSessionVariable("Buyer Favorite list").to(ids);
        return ids;
    }

    public Response callGetSaveLater() {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAPI.SAVE_LATER, "GET");
        System.out.println("RESPONSE SAVE ITEMS " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SAVE ITEMS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteSaveLater(String id) {
        String basePath = UrlAPI.SAVE_LATER;
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAPI.SAVE_LATER(id), "DELETE");
        System.out.println("RESPONSE DELETE SAVE ITEMS " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE SAVE ITEMS ").andContents(response.prettyPrint());
        return response;
    }

    public Response calSaveLater(Map<String, Object> map) {
        String basePath = UrlAPI.SAVE_LATER;
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody(UrlAPI.SAVE_LATER, map, "POST");
        System.out.println("RESPONSE SAVE LATER ITEMS " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SAVE LATER ITEMS ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getSaveItemsId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> ids = new ArrayList<>();
        List<Map<String, Object>> results = jsonPath.get("results");
        for (Map<String, Object> map : results) {
            ids.add(map.get("id").toString());
        }
        Serenity.setSessionVariable("Buyer save item list").to(ids);
        return ids;
    }

}
