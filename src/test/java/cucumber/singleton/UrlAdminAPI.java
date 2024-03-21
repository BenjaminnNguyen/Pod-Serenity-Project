package cucumber.singleton;

public class UrlAdminAPI {


    public static final String ADMIN = GVs.BETA + "admin_api/";


    public static final String SIGNIN = ADMIN + "admin_auth/sign_in.json";


    /**
     * Order - API
     */
    public static final String SEARCH_ORDER = ADMIN + "orders.json";
    public static final String SEARCH_GHOST_ORDER = ADMIN + "ghost_orders.json";

    public static final String CREATE_ORDER = ADMIN + "orders.json";
    public static final String CREATE_GHOST_ORDER = ADMIN + "ghost_orders.json";

    public static final String LINE_ITEM_ORDER = ADMIN + "detail/line_items";

    public static String DELETE_ORDER(String id) {
        return ADMIN + "orders/" + id + ".json";
    }


    public static String DELETE_GHOST_ORDER(String id) {
        return ADMIN + "ghost_orders/" + id + ".json";
    }


    public static String DELETE_SKU(String id) {
        return ADMIN + "product_variants/" + id + ".json";
    }

    public static String DELETE_PRODUCT(String id) {
        return ADMIN + "products/" + id + ".json";
    }

    public static String DETAIL_PRODUCT(String id) {
        return ADMIN + "products/" + id + ".json";
    }

    public static String STATE_PRODUCT(String id) {
        return ADMIN + "products/" + id + "/state.json";
    }

    public static final String CREATE_PRODUCT = ADMIN + "products.json";

    public static String CREATE_SKU(String id) {
        return ADMIN + "products/" + id + "/product_variants.json";
    }

    public static String PRODUCT_CATEGORY(String id) {
        return ADMIN + "product_categories/" + id + ".json";
    }


    public static String SEARCH_PROMO = ADMIN + "promotions.json/";
    public static String SEARCH_PROMO_SUBMISSION = ADMIN + "promotion_submissions.json";

    public static String CREATE_PROMO = ADMIN + "promotions.json/";

    public static String DELETE_PROMO(String id) {
        return ADMIN + "promotions/" + id + ".json";
    }

    public static String DELETE_PROMO_SUBMISSION(String id) {
        return ADMIN + "promotion_submissions/" + id + ".json";
    }

    /**
     * Order - In Process - API
     */

    public static final String CREATE_IN_PROCESS_ORDER = ADMIN + "in_process_orders.json";

    public static final String SEARCH_IN_PROCESS_ORDER = ADMIN + "in_process_orders.json";

    public static String DETAIL_IN_PROCESS_ORDER(String id) {
        return ADMIN + "in_process_orders/" + id + ".json";
    }

    /**
     * Drop Summary - API
     */

    public static final String SEARCH_SUB_INVOICE_DROP = ADMIN + "summary/drops/sub_invoices.json";

    public static final String CREATE_DROP = ADMIN + "summary/drops.json";
    public static final String ASSIGN_PO_DROP = ADMIN + "summary/drops/assign_purchase_orders.json";



    /**
     * Admin - Sub invoice
     */
    public static final String CREATE_SUB_INVOICE = ADMIN + "sub_invoices.json";

    public static String SUB_INVOICE(String id) {
        return ADMIN + "sub_invoices/" + id + ".json";
    }

    /**
     * Admin - Brand
     */
    public static final String CREATE_BRAND = ADMIN + "brands.json";
    public static final String BRAND_STORE_PRICING = ADMIN + "commissions/brand_stores.json";
    public static final String BRAND_COMPANY_PRICING = ADMIN + "commissions/brand_buyer_companies.json";

    public static String DELETE_BRAND(String id) {
        return ADMIN + "brands/" + id + ".json";
    }

    public static String EDIT_BRAND(String id) {
        return ADMIN + "brands/" + id + ".json";
    }

    public static String STATE_BRAND(String id) {
        return ADMIN + "brands/" + id + "/state.json";
    }

    /**
     * Admin - Brand Referral
     */
    public static final String SEARCH_BRAND_REFERRAL = ADMIN + "referral_brand_forms.json";

    public static String BRAND_REFERRAL(String id) {
        return ADMIN + "referral_brand_forms/" + id + ".json";
    }

    public static String PRODUCT_VARIANT(String id) {
        return ADMIN + "product_variants/" + id + ".json";
    }

    public static final String ADMIN_PROP65 = ADMIN + "chemical_prop_forms.json";
    public static final String CREATE_ANNOUNCEMENTS = ADMIN + "announcements.json";

    public static String DELETE_ANNOUNCEMENTS(String id) {
        return ADMIN + "announcements/" + id + ".json";
    }

    public static final String ADMIN_AUTHORIZED_SKU = ADMIN + "multiple/product_variants.json";

    public static final String ADMIN_PRODUCT = ADMIN + "products/";
    public static final String ADMIN_PRODUCT_CHANGE_STATE = ADMIN_PRODUCT + "%s/state.json";

    public static String ADMIN_PRODUCT_CHANGE_STATE(String id) {
        return String.format(ADMIN_PRODUCT_CHANGE_STATE, id);
    }

    public static String PRODUCT_DETAILS(String id) {
        return ADMIN_PRODUCT + id + ".json";
    }

    public static final String ADMIN_PRODUCT_VARIANT = ADMIN + "product_variants/";

    public static String ADMIN_PRODUCT_VARIANT_CHANGE_STATE(String id) {
        return ADMIN_PRODUCT_VARIANT + id + ".json";
    }

    //Admin - Brand
    public static final String ADMIN_BRAND = ADMIN + "brands/";

    public static String ADMIN_BRAND_DETAIL(String id) {
        return ADMIN_BRAND + id + ".json";
    }

    public static String ADMIN_BRAND_CHANGE_STATE(String id) {
        return ADMIN_BRAND + id + "/state.json";
    }

    public static String ADMIN_DELETE_INBOUND_INVENTORY(String id) {
        return ADMIN + "inbound_inventories/" + id + ".json";
    }

    //Admin - Order
    public static String GET_LINE_ITEM_ORDER(String id) {
        return ADMIN + "detail/line_items?order_id=" + id;
    }

    public static String UPDATE_LINE_ITEM_ORDER(String id) {
        return ADMIN + "orders/" + id + ".json";
    }

    public static String DETAIL_ORDER(String id) {
        return ADMIN + "orders/" + id + ".json";
    }


    //Admin - Purchase Order
    public static final String PURCHASE_ORDER = ADMIN + "purchase_orders.json";

    public static String PURCHASE_ORDER(String id) {
        return ADMIN + "purchase_orders/" + id + ".json";
    }

    /**
     * Admin - Inventory
     */

    public static String ADMIN_INVENTORY(String id) {
        return ADMIN + "inventories/" + id + ".json";
    }

    public static String ADMIN_INVENTORY_ITEMS(String id) {
        return ADMIN + "inventory_items/" + id + ".json";
    }

    public static final String ADMIN_GET_INVENTORY = ADMIN + "inventories.json";

    public static final String ADMIN_GET_INBOUND_INVENTORY = ADMIN + "inbound_inventories.json";

    public static final String ADMIN_CREATE_INVENTORY = ADMIN + "inventories.json";

    public static String ADMIN_INVENTORY_SUBTRACTION(String id) {
        return ADMIN + "inventories/" + id + "/inventory_items.json";
    }


    public static String ADMIN_DELETE_INVENTORY(String id) {
        return ADMIN + "inventories/" + id + ".json";
    }

    public static String ADMIN_INBOUND_INVENTORY(String id) {
        return ADMIN + "inbound_inventories/" + id + ".json";
    }

    /**
     * Admin - Withdrawal
     */

    public static final String ADMIN_GET_WITHDRAWAL = ADMIN + "withdraw_inventories.json";

    public static final String ADMIN_APPROVE_WITHDRAWAL(String id) {
        return ADMIN + "withdraw_inventories/" + id + "/approved.json";
    }

    public static final String ADMIN_COMPLETE_WITHDRAWAL(String id) {
        return ADMIN + "withdraw_inventories/" + id + "/completed.json";
    }

    /**
     * Admin - Dispose donate request
     */

    public static final String ADMIN_GET_INVENTORY_REQUEST = ADMIN + "inventory_requests.json";

    public static String ADMIN_GET_INVENTORY_REQUEST(String id) {
        return ADMIN + "inventory_requests/" + id + ".json";
    }

    public static String ADMIN_CANCEL_INVENTORY_REQUEST(String id) {
        return ADMIN + "inventory_requests/" + id + "/canceled.json";
    }

    public static String ADMIN_APPROVED_INVENTORY_REQUEST(String id) {
        return ADMIN + "inventory_requests/" + id + "/approved.json";
    }

    public static String ADMIN_COMPLETED_INVENTORY_REQUEST(String id) {
        return ADMIN + "inventory_requests/" + id + "/completed.json";
    }

    /**
     * Admin - Sample request
     */

    public static final String ADMIN_SAMPLE_REQUEST = ADMIN + "sample_requests.json";
    public static final String ADMIN_MULTIPLE_SAMPLE_REQUEST = ADMIN + "multiple/sample_requests.json";

    public static String SAMPLE_REQUESTS(String id) {
        return ADMIN + "sample_requests/" + id + ".json";
    }


    /**
     * Admin - Recommendations
     */

    public static final String ADMIN_RECOMMENDATION = ADMIN + "buyers_recommended_products.json";

    public static String ADMIN_RECOMMENDATION(String id) {
        return ADMIN + "buyers_recommended_products/" + id + ".json";
    }

    public static String ADMIN_GET_DETAIL_WITHDRAWAL(String id) {
        return ADMIN + "withdraw_inventories/" + id + ".json";
    }

    public static String ADMIN_DELETE_WITHDRAWAL(String id) {
        return ADMIN + "withdraw_inventories/" + id + ".json";
    }

    /**
     * Admin - Master
     */
    public static final String ADMIN_GENERAL = ADMIN + "admin_settings.json";


    /**
     * Store - API
     */
    public static final String SEARCH_STORE = ADMIN + "stores.json";

    public static String STORE(String id) {
        return ADMIN + "stores/" + id + ".json";
    }

    public static String STORE_TOGGLE_STATE(String id) {
        return ADMIN + "stores/" + id + "/toggle_state.json";
    }

    /**
     * Store Type - API
     */
    public static final String STORE_TYPE = ADMIN + "store_types.json";

    public static String STORE_TYPE(String id) {
        return ADMIN + "store_types/" + id + ".json";
    }

    /**
     * Admin - Vendor Company
     */
    public static final String ADMIN_VENDOR_COMPANY = ADMIN + "vendor_companies.json";

    public static String ADMIN_UPDATE_VENDOR_COMPANY(String id) {
        return ADMIN + "vendor_companies/" + id + ".json";
    }

    /**
     * Admin - All Vendor
     */
    public static final String ADMIN_ALL_VENDOR = ADMIN + "vendors.json";

    public static String ADMIN_ALL_VENDOR(String id) {
        return ADMIN + "vendors/" + id + ".json";
    }

    /**
     * Admin - Vendor - Success form
     */
    public static final String ADMIN_STORE_LIST_ITEMS = ADMIN + "store_list_items.json";

    public static String ADMIN_STORE_LIST_ITEMS(String id) {
        return ADMIN + "store_list_items/" + id + ".json";
    }

    public static final String ADMIN_SPECIAL_BUYER_COMPANY = ADMIN + "special_regional_buyer_companies.json";

    public static String ADMIN_SPECIAL_BUYER_COMPANY(String id) {
        return ADMIN + "special_regional_buyer_companies/" + id + ".json";
    }


    /**
     * Admin - Claims
     */

    public static final String SEARCH_CLAIM = ADMIN + "claims.json";

    public static String DELETE_CLAIM(String id) {
        return ADMIN + "claims/" + id + ".json";
    }

    /**
     * Admin - Vendor Claims
     */

    public static final String SEARCH_VENDOR_CLAIM = ADMIN + "vendor_claims.json";

    public static String DELETE_VENDOR_CLAIM(String id) {
        return ADMIN + "vendor_claims/" + id + ".json";
    }

    /**
     * Admin - Tags
     */

    public static final String ADMIN_TAGS = ADMIN + "tags.json";

    public static String DELETE_TAGS(String id) {
        return ADMIN + "tags/" + id + ".json";
    }

    public static String TAG_RELATE(String endPoint) {
        return ADMIN + endPoint + ".json";
    }

    /**
     * Admin - Product Qualities
     */

    public static final String ADMIN_PRODUCT_QUALITIES = ADMIN + "product_qualities.json";

    public static String DELETE_PRODUCT_QUALITIES(String id) {
        return ADMIN + "product_qualities/" + id + ".json";
    }

    /**
     * Admin - Product Packing Size
     */

    public static final String ADMIN_PRODUCT_PACKAGE_SIZE = ADMIN + "package_sizes.json";

    public static String ADMIN_PRODUCT_PACKAGE_SIZE(String id) {
        return ADMIN + "package_sizes/" + id + ".json";
    }

    /**
     * Admin - Buyer Company
     */
    public static final String ADMIN_BUYER_COMPANY = ADMIN + "buyer_companies.json";

    public static String ADMIN_BUYER_COMPANY(String id) {
        return ADMIN + "buyer_companies/" + id + ".json";
    }

    public static String ADMIN_BUYER_COMPANY_STATE(String id) {
        return ADMIN + "buyer_companies/" + id + "/state.json";
    }

    /**
     * Admin - Buyer Account - Head Buyer Account
     */
    public static final String ADMIN_HEAD_BUYER_ACCOUNT = ADMIN + "head_buyers.json";

    public static final String ADMIN_BUYER_ACCOUNT = ADMIN + "buyers.json";

    public static String ADMIN_BUYER_ACCOUNT(String id) {
        return ADMIN + "buyers/" + id + ".json";
    }

    public static String ADMIN_HEAD_BUYER_ACCOUNT(String id) {
        return ADMIN + "head_buyers/" + id + ".json";
    }

    public static String ADMIN_BUYER_ACCOUNT_STATE(String id) {
        return ADMIN + "buyers/" + id + "/state.json";
    }

    /**
     * Admin - Routes
     */
    public static final String ADMIN_ROUTE = ADMIN + "routes.json";

    public static String ADMIN_ROUTE(String id) {
        return ADMIN + "routes/" + id + ".json";
    }

    /**
     * Admin - Finance
     */

    public static final String ADMIN_CHANGE_CREDIT_LIMIT(String buyerCompanyId) {
        return ADMIN + "finance/buyer_companies/" + buyerCompanyId + ".json";
    }

    /**
     * Admin - Distribution center
     */

    public static final String DISTRIBUTION_CENTER = ADMIN + "warehouses.json";

    public static final String DISTRIBUTION_CENTER(String id) {
        return ADMIN + "warehouses/" + id + ".json";
    }

    /**
     * Admin - Route
     */

    /**
     * Admin - Vendor Statement
     */

    public static final String VENDOR_STATEMENT(String vendorStatementID) {
        return ADMIN + "vendor_statements/" + vendorStatementID + ".json";
    }

    public static final String VENDOR_STATEMENT_ADJUSTMENT(String vendorStatementID, String adjustmentID) {
        return ADMIN + "vendor_statements/" + vendorStatementID + "/adjustments/" + adjustmentID + ".json";
    }

    /**
     * Admin - LP
     */

    public static final String ADMIN_LP_COMPANY(String lpID) {
        return ADMIN + "logistics_companies/" + lpID + ".json";
    }

    public static final String ADMIN_LP_COMPANY() {
        return ADMIN + "logistics_companies.json";
    }

    public static final String ADMIN_LP() {
        return ADMIN + "logistics_partners.json";
    }

    public static final String ADMIN_LP_PARTNER(String lpID) {
        return ADMIN + "logistics_partners/" + lpID + ".json";
    }

    /**
     * Admin - Vendor Adjustment Types
     */

    public static final String VENDOR_ADJUSTMENT_TYPE = ADMIN + "adjustment_types.json";

    public static final String VENDOR_ADJUSTMENT_TYPE(String id) {
        return ADMIN + "adjustment_types/" + id + ".json";
    }

    /**
     * Admin - Store Adjustment Types
     */

    public static final String STORE_ADJUSTMENT_TYPE = ADMIN + "store_adjustment_types.json";

    public static final String STORE_ADJUSTMENT_TYPE(String id) {
        return ADMIN + "store_adjustment_types/" + id + ".json";
    }

    /**
     * Admin - Credit memo
     */

    public static final String CREDIT_MEMO_TYPE = ADMIN + "credit_memo_types.json";

    public static final String CREDIT_MEMO_TYPE(String id) {
        return ADMIN + "credit_memo_types/" + id + ".json";
    }


    /**
     * Admin - Fees
     */

    public static final String ADMIN_FEES = ADMIN + "state_fee_names.json";

    public static final String ADMIN_FEES(String id) {
        return ADMIN + "state_fee_names/" + id + ".json";
    }

    public static final String ADMIN_SMALL_ORDER_SURCHARGE(String id) {
        return ADMIN + "small_order_surcharge_structures/" + id + ".json";
    }

    /**
     * Admin - Filter Visibility
     */

    public static final String ADMIN_FILTER_VISIBILITIES(String id) {
        return ADMIN + "admin_filter_visibilities/" + id + ".json";
    }
    public static final String ADMIN_DELETE_FILTER_PRESET(String id) {
        return ADMIN + "admin_filter_presets/" + id + ".json";
    }

    public static final String ADMIN_FILTER_PRESET(String id) {
        return ADMIN + "admin_filter_presets.json?q[screen_id]=" + Integer.parseInt(id);
    }

}
