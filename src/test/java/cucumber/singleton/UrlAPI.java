package cucumber.singleton;

public class UrlAPI {

    public static final String VENDOR = GVs.BETA + "vendor/";
    public static final String BUYER = GVs.BETA + "buyer/";
    public static final String HEAD_BUYER = GVs.BETA + "head_buyer/";

    /**
     * Vendor
     */
    public static final String CREATE_PRODUCT = VENDOR + "products.json";

    public static String CREATE_SKU(String id) {
        return VENDOR + "products/" + id + "/product_variants.json";
    }

    public static String DELETE_PRODUCT(String id) {
        return VENDOR + "products/" + id + "/deactivate.json";
    }

    public static final String SIGNIN_VENDOR = VENDOR + "vendor_auth/sign_in.json";
    public static final String BUYER_LOGIN = BUYER + "buyer_auth/sign_in.json";


    /**
     * Buyer
     */

    //Buyer - Product
    public static String BUYER_GET_PRODUCT(String id) {
        return BUYER + "products/" + id + ".json";
    }

    //Buyer - Cart
    public static String DELETE_CART_ITEM() {
        return BUYER + "cart_item.json";
    }

    public static final String BUYER_ADD_CART_ITEM = BUYER + "multiple/cart_item.json";
    public static final String GET_CART_ITEM = BUYER + "cart.json";
    public static final String CHECK_OUT = BUYER + "payment.json";

    //Buyer - Order
    public static String GET_ORDER(String id) {
        return BUYER + "orders/" + id + ".json";
    }

    //Buyer - Pre-Order
    public static final String BUYER_PRE_ORDER = BUYER + "pre_order/orders.json";
    //Buyer - Favorite
    public static final String FAVORITE_PRODUCT = BUYER + "favorite_products.json";
    public static final String HEAD_BUYER_FAVORITE_PRODUCT = HEAD_BUYER + "favorite_products.json";

    public static String REMOVE_FAVORITE(String id) {
        return BUYER + "favorite_products/" + id + ".json";
    }

    public static String HEAD_BUYER_REMOVE_FAVORITE(String id) {
        return HEAD_BUYER + "favorite_products/" + id + ".json";
    }

    public static final String SAVE_LATER = BUYER + "saved_line_items.json";

    public static final String SAVE_LATER(String id) {
        return BUYER + "saved_line_items/" + id + ".json";
    }
}
