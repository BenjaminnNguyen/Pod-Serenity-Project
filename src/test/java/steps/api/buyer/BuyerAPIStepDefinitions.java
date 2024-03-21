package steps.api.buyer;

import io.cucumber.java.en.*;
import cucumber.models.web.buyer.Product.FavoriteProduct;
import cucumber.models.web.buyer.Product.ProductVariantId;
import cucumber.singleton.UrlAPI;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.buyer.BuyerAPI;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.*;

import static cucumber.tasks.api.buyer.BuyerAPI.getVariantRegionId;

public class BuyerAPIStepDefinitions {
    CommonRequest commonRequest = new CommonRequest();
    BuyerAPI buyerAPI = new BuyerAPI();

    @And("Clear cart to empty in cart before by API")
    public void clearCart() {
        String basePath = UrlAPI.GET_CART_ITEM;
        Response response = commonRequest.commonRequestNoBody(basePath, "GET");
        List<String> listId = buyerAPI.getIdCartToDelete(response);
        for (String id : listId) {
            String basePath2 = UrlAPI.DELETE_CART_ITEM();
            Map<String, Object> map = new HashMap<>();
            map.putIfAbsent("id", id);
            Response response1 = commonRequest.commonRequestWithParam(basePath2, map, "DELETE");
            System.out.println(response1.asString());

        }
    }

    @And("Add an item to cart by API")
    public void addCart(DataTable table) {
        String basePath = UrlAPI.BUYER_ADD_CART_ITEM;
        List<Map<String, String>> listItem = table.asMaps(String.class, String.class);

        Map<String, Object> item;
        List<Map<String, Object>> cart = new ArrayList<>();
        for (int i = 0; i < listItem.size(); i++) {
            item = new HashMap<>();
            String skuId = listItem.get(i).get("skuId");
            String productId = listItem.get(i).get("productId");
            if (listItem.get(i).get("skuId").isEmpty()) {
                skuId = Serenity.sessionVariableCalled("ID SKU Admin");
            }
            if (listItem.get(i).get("productId").isEmpty()) {
                productId = Serenity.sessionVariableCalled("ID Product Admin");
            }
            String variantRegionId = getVariantRegionId(productId, skuId);
            item.putIfAbsent("quantity", listItem.get(i).get("quantity"));
            item.putIfAbsent("variants_region_id", variantRegionId);
            cart.add(item);
        }
        Map<String, Object> cart_item = new HashMap<>();
        cart_item.putIfAbsent("cart_items", cart);
        Response response = commonRequest.commonRequestWithBody(basePath, cart_item, "POST");
        JsonPath jsonPath = response.jsonPath();
        Serenity.setSessionVariable("order_id").to(jsonPath.getMap("order").get("id"));
        System.out.println(response.asString());
        System.out.println(Serenity.sessionVariableCalled("order_id").toString());
    }

    @And("Add an item to cart by API 2")
    public void addCart2(DataTable table) {
        String basePath = UrlAPI.BUYER_ADD_CART_ITEM;
        List<Map<String, String>> listItem = table.asMaps(String.class, String.class);
        Map<String, Object> item = new HashMap<>();
        List<Map<String, Object>> cart = new ArrayList<>();
        for (int i = 0; i < listItem.size(); i++) {
            item = new HashMap<>();
            String skuId = listItem.get(i).get("skuId").toString();
            String productId = listItem.get(i).get("productId").toString();
            String skuName = listItem.get(i).get("skuName").toString();
            if (listItem.get(i).get("skuId").contains("random")) {
                skuId = Serenity.sessionVariableCalled("ID SKU Admin");
            }
            if (listItem.get(i).get("skuName").contains("random")) {
                skuId = Serenity.sessionVariableCalled("itemCode" + skuName);
            }
            if (listItem.get(i).get("productId").isEmpty()) {
                productId = Serenity.sessionVariableCalled("ID Product Admin");
            }
            String variantRegionId = getVariantRegionId(productId, skuId);
            item.putIfAbsent("quantity", listItem.get(i).get("quantity"));
            item.putIfAbsent("variants_region_id", variantRegionId);
            cart.add(item);
        }
        Map<String, Object> cart_item = new HashMap<>();
        cart_item.putIfAbsent("cart_items", cart);
        Response response = commonRequest.commonRequestWithBody(basePath, cart_item, "POST");
        JsonPath jsonPath = response.jsonPath();
        Serenity.setSessionVariable("order_id").to(jsonPath.getMap("order").get("id"));
        System.out.println(response.asString());
        System.out.println(Serenity.sessionVariableCalled("order_id").toString());
    }

    @And("Checkout cart with payment by {string} by API")
    public void checkoutCart(String payment) {
        String basePath = UrlAPI.CHECK_OUT;
        Map<String, Object> order = new HashMap<>();
        order.putIfAbsent("order_id", Serenity.sessionVariableCalled("order_id").toString());
        order.putIfAbsent("payment_type", payment);

        Response response = commonRequest.commonRequestWithBody(basePath, order, "POST");
        JsonPath jsonPath = response.jsonPath();
        Serenity.setSessionVariable("new_order_id").to(jsonPath.get("new_order_id"));
        System.out.println(response.prettyPrint());
        System.out.println("Order ID = " + Serenity.sessionVariableCalled("order_id").toString());

        Response response1 = BuyerAPI.callBuyerOrderDetail(Serenity.sessionVariableCalled("order_id").toString());
        System.out.println(response1.asString());
        BuyerAPI.getOrderID(response1);
        BuyerAPI.getSubInvoice(response1);
    }

    @And("Add item to pre-order by API")
    public void add_item_to_pre_order_by_API(DataTable table) {
        String basePath = UrlAPI.BUYER_PRE_ORDER;
        List<Map<String, String>> listItem = table.asMaps(String.class, String.class);

        Map<String, Object> item;
        List<Map<String, Object>> line_items_attributes = new ArrayList<>();
        for (int i = 0; i < listItem.size(); i++) {
            item = new HashMap<>();
            String skuId = listItem.get(i).get("skuId");
            if (listItem.get(i).get("skuId").isEmpty()) {
                skuId = Serenity.sessionVariableCalled("ID SKU Admin");
            }
            String variantRegionId = getVariantRegionId(listItem.get(i).get("productId"), skuId);
            item.putIfAbsent("quantity", Integer.parseInt(listItem.get(i).get("quantity")));
            item.putIfAbsent("variants_region_id", variantRegionId);
            line_items_attributes.add(item);

        }
        Map<String, Object> line_items_attributes1 = new HashMap<>();
        line_items_attributes1.putIfAbsent("line_items_attributes", line_items_attributes);

        Map<String, Object> order = new HashMap<>();
        order.putIfAbsent("order", line_items_attributes1);

        Response response = commonRequest.commonRequestWithBody(basePath, order, "POST");
        JsonPath jsonPath = response.jsonPath();
        System.out.println("RESPONSE PRE-ORDER = " + response.prettyPrint());
        Serenity.setSessionVariable("ID Pre-Order").to(jsonPath.get("number"));
    }

    @And("Buyer add receiving info by API")
    public void buyer_add_receiving_info_by_api(DataTable table) {
        List<Map<String, String>> listItem = table.asMaps(String.class, String.class);
        String basePath = UrlAPI.GET_CART_ITEM;

        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("buyer_special_note", listItem.get(0).get("buyerSpecialNote"));
        map.putIfAbsent("custom_store_name", listItem.get(0).get("customStoreName"));
        map.putIfAbsent("customer_po", listItem.get(0).get("customerPO"));
        map.putIfAbsent("department", listItem.get(0).get("department"));

        Map<String, Object> order = new HashMap<>();
        order.putIfAbsent("id", Serenity.sessionVariableCalled("order_id"));
        order.putIfAbsent("order", map);

        Response response = commonRequest.commonRequestWithBody(basePath, order, "PUT");
        JsonPath jsonPath = response.jsonPath();
        Serenity.setSessionVariable("order_id").to(jsonPath.getMap("order").get("id"));
        System.out.println(response.asString());
        System.out.println(Serenity.sessionVariableCalled("order_id").toString());
    }


    /**
     * API Favorite
     */

    @And("Buyer set favorite product {string} by API")
    public void set_favorite_product__by_api(String idProduct) {
        if (idProduct.contains("create by api"))
            idProduct = Serenity.sessionVariableCalled("ID SKU Admin");
        ProductVariantId product_variant_id = new ProductVariantId(Integer.parseInt(idProduct));
        FavoriteProduct favorite_product = new FavoriteProduct(product_variant_id);
        buyerAPI.callFavoriteProduct(favorite_product);
    }

    @And("Head Buyer set favorite product {string} by API")
    public void head_set_favorite_product__by_api(String idProduct) {
        if (idProduct.contains("create by api"))
            idProduct = Serenity.sessionVariableCalled("ID SKU Admin");
        ProductVariantId product_variant_id = new ProductVariantId(Integer.parseInt(idProduct));
        FavoriteProduct favorite_product = new FavoriteProduct(product_variant_id);
        buyerAPI.callFavoriteProductHead(favorite_product);
    }

    @And("Buyer clear favorite product list by API")
    public void remove_favorite_product_by_api() {
        buyerAPI.callRemoveAllFavorite("buyer");
    }

    @And("Head Buyer clear favorite product list by API")
    public void head_remove_favorite_product_by_api() {
        buyerAPI.callRemoveAllFavorite("head buyer");
    }

    @And("Buyer get favorite product list by API")
    public void get_favorite_product_list_by_api() {
        Response response = buyerAPI.callGetIDFavorite();
        buyerAPI.getFavoriteId(response);
    }

    @And("Head Buyer get favorite product list by API")
    public void head_buyer_get_favorite_product_list_by_api() {
        Response response = buyerAPI.callGetIDFavoriteHeadBuyer();
        buyerAPI.getFavoriteId(response);
    }

    /***
     * Save for later
     */

    @And("Buyer delete all save later cart by API")
    public void delete_save_later_by_api() {
        Response response = buyerAPI.callGetSaveLater();
        List<String> ids = buyerAPI.getSaveItemsId(response);
        for (String id : ids) {
            buyerAPI.callDeleteSaveLater(id);
        }
    }

//    @And("Buyer save later items by API")
//    public void save_later_by_api(DataTable table) {
//        List<Map<String, String>> listItem = table.asMaps(String.class, String.class);
//        Map<String, Object> map = new HashMap<>();
//        for (Map<String, String> mpa : listItem) {
//            String id = mpa.get("skuId").toString();
//            id = mpa.get("skuName").contains("random") ? Serenity.sessionVariableCalled("itemCode" + mpa.get("skuName")) : id;
//            map.put("line_item_id", id);
//            Response response = buyerAPI.calSaveLater(map);
//        }
//    }
}
