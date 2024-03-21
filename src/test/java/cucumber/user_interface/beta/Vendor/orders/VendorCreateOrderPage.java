package cucumber.user_interface.beta.Vendor.orders;

import net.serenitybdd.screenplay.targets.Target;

public class VendorCreateOrderPage {

    public static Target CREATE_ORDER_BUTTON = Target.the("Create order button")
            .locatedBy("//div[@class='page__actions']//div[text()='Create order']");

    public static Target ADD_STORE_TEXTBOX = Target.the("Add store textbox")
            .locatedBy("//label[text()='Add stores']/following-sibling::div//input");

    /**
     * Select SKUs popup
     */
    public static Target TEXTBOX_IN_SELECT_SKU_POPUP = Target.the("Select sku in popup")
            .locatedBy("//label[text()='Search']/following-sibling::div//input");

    public static Target SELECTED_SKU_BUTTON = Target.the("Selected sku button in popup")
            .locatedBy("//div[@role='dialog']//button//span[contains(text(),'Add')]");

    public static Target SKU_IN_SELECT_SKU_POPUP(String sku) {
        return Target.the("SKU " + sku + " in Select sku popup")
                .locatedBy("//div[contains(@class,'sku__name') and text()='" + sku + "']");
    }

    public static Target BRAND_IN_SELECT_SKU_POPUP(String sku) {
        return Target.the("Brand of SKU " + sku + " in Select sku popup")
                .locatedBy("//div[contains(@class,'sku__name') and text()='" + sku + "']/preceding-sibling::div[contains(@class,'sku__brand')]");
    }

    public static Target PRODUCT_IN_SELECT_SKU_POPUP(String sku) {
        return Target.the("Product of SKU " + sku + " in Select sku popup")
                .locatedBy("//div[contains(@class,'sku__name') and text()='" + sku + "']/preceding-sibling::div[contains(@class,'sku__product')]");
    }

    public static Target UPC_IN_SELECT_SKU_POPUP(String sku) {
        return Target.the("UPC of SKU " + sku + " in Select sku popup")
                .locatedBy("//div[contains(@class,'sku__name') and text()='" + sku + "']/ancestor::div/following-sibling::div[contains(@class,'sku__upc')]");
    }

    public static Target SKU_ID_IN_SELECT_SKU_POPUP(String sku) {
        return Target.the("ID of SKU " + sku + " in Select sku popup")
                .locatedBy(" //div[contains(@class,'sku__name') and text()='" + sku + "']/ancestor::div/following-sibling::div[contains(@class,'sku__id')]/div");
    }

    public static Target SKU_ADDED_IMAGE(int i) {
        return Target.the("SKU added in create order")
                .locatedBy("//div[@class='lot'][" + i + "]//div[@class='lot__image']/div");
    }

    public static Target SKU_ADDED_INFO(String class_, int i) {
        return Target.the("SKU added in create order")
                .locatedBy("//div[@class='lot'][" + i + "]//div[contains(@class,'" + class_ + "')]");
    }

    public static Target STORE_ADDED_INFO(String store) {
        return Target.the("SKU added in create order")
                .locatedBy("//span[@class='el-select__tags-text'][normalize-space()='" + store + "']/following-sibling::i");
    }

    public static Target SKU_POPUP_ADDED(String sku) {
        return Target.the("SKU added in create order")
                .locatedBy("//div[@class='sku__name pf-ellipsis'][normalize-space()='" + sku + "']/ancestor::div[@class='sku sku--excluded']");
    }

    /**
     * Line item
     */

    public static Target SKU_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Sku in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//div[text()='" + sku + "']");
    }

    //Favorite
    public static Target SKU_FAVORITE(String store, String sku) {
        return Target.the("Sku in multi order")
                .locatedBy("//div[normalize-space()='" + store + "']/following-sibling::div//div[contains(text(),'" + sku + "')]/ancestor::div[@class='cart__item']//i[@class='bx bx-heart icon']");
    }

    public static Target SKU_FAVORITE_INFO(String class_, int i) {
        return Target.the("SKU added in favorite")
                .locatedBy("//strong[normalize-space()='Your Favorite SKUs']/../following-sibling::div//div[@class='lot'][" + i + "]//div[contains(@class,'" + class_ + "')]");
    }

    public static Target SKU_FAVORITE_ADD_BTN(String sku) {
        return Target.the("SKU added in favorite")
                .locatedBy("//strong[normalize-space()='Your Favorite SKUs']/../following-sibling::div//div[contains(text(),'" + sku + "')]/ancestor::div[@class='lot']//button");
    }

    public static Target SKU_FAVORITE_IMAGE(int i) {
        return Target.the("SKU added in favorite")
                .locatedBy("//strong[normalize-space()='Your Favorite SKUs']/../following-sibling::div//div[@class='lot'][" + i + "]//div[@class='lot__image']/div");
    }

    public static Target BRAND_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Brand in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/preceding-sibling::div[@class='brand']");
    }

    public static Target PRODUCT_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Product in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/preceding-sibling::div[@class='product']//a");
    }

    public static Target SKU_ID_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Sku id in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/following-sibling::div[contains(@class,'variant__id')]");
    }

    public static Target UPC_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("UPC in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/following-sibling::div[contains(@class,'upc')]/strong");
    }

    public static Target UNIT_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Unit in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/ancestor::div[@class='item__preview']/following-sibling::div[@class='item__info']//div[contains(@class,'unit')]");
    }

    public static Target PRICE_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Price in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/ancestor::div[@class='item__preview']/following-sibling::div[@class='item__info']//div[contains(@class,'case')]/span[@class='current']");
    }

    public static Target OLD_PRICE_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Old price in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/ancestor::div[@class='item__preview']/following-sibling::div[@class='item__info']//div[contains(@class,'case')]/span[@class='old']");
    }

    public static Target AMOUNT_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Amount in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/ancestor::div[@class='item__preview']/following-sibling::div//input");
    }

    public static Target DELETE_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Delete in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/ancestor::div[@class='item__preview']/following-sibling::div//button");
    }

    public static Target ERROR_IN_MULTI_ORDER(String buyer, String sku) {
        return Target.the("Error in multi order")
                .locatedBy("//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//descendant::div[text()='" + sku + "']/ancestor::div[@class='item__preview']/following-sibling::div//div[@class='warning-text']");
    }


    /**
     * Cart summary
     */

    public static Target VALUE_CART_SUMMARY(String buyer) {
        return Target.the("Value in cart summary")
                .locatedBy("(//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//div//dt[text()='Order Value']//following-sibling::dd/div[@class='value'])[1]");
    }

    public static Target PROMOTION_CART_SUMMARY(String buyer) {
        return Target.the("Promotion in cart summary")
                .locatedBy("(//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//div//dt[text()='Promotion']//following-sibling::dd/div[@class='value'])[1]");
    }

    public static Target ITEM_SUBTOTAL_CART_SUMMARY(String buyer) {
        return Target.the("Promotion in cart summary")
                .locatedBy("(//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//div//dt[text()='Items Subtotal']//following-sibling::dd)[1]");
    }

    public static Target SOS_CART_SUMMARY(String buyer) {
        return Target.the("Sos in cart summary")
                .locatedBy("(//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//dd[contains(@class,'order-surcharge')]/div)[1]");
    }

    public static Target SPECIAL_DISCOUNT_CART_SUMMARY(String buyer) {
        return Target.the("Sos in cart summary")
                .locatedBy("(//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//dd[contains(@class,'special-discount')]/div)[1]");
    }

    public static Target TAX_CART_SUMMARY(String buyer) {
        return Target.the("Taxes in cart summary")
                .locatedBy("(//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//dd[contains(@class,'state-fee')]/div)[1]");
    }

    public static Target TOTAL_CART_SUMMARY(String buyer) {
        return Target.the("Total in cart summary")
                .locatedBy("(//div[text()='" + buyer + "']//ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='total'])[1]");
    }


    /**
     * Change buyer
     */

    public static Target CHANGE_BUYER_TEXTBOX(String store) {
        return Target.the("Change buyer textbox")
                .locatedBy("//div[text()='" + store + "']//following-sibling::div//div[@class='cart__summary']//label[text()='Buyer']/following-sibling::div//input");
    }

    public static Target CUSTOMER_PO_TEXTBOX(String store) {
        return Target.the("Customer PO textbox")
                .locatedBy("//div[text()='" + store + "']//following-sibling::div//div[@class='cart__summary']//label[@for='customer_po']/following-sibling::div//input");
    }

    public static Target CREATE_ORDER_BTN(String store) {
        return Target.the("CREATE_ORDER_BTN")
                .locatedBy("//div[text()='" + store + "']//following-sibling::div//div[@class='cart__summary']//button//span[contains(text(),'Create order')]");
    }

    /**
     * Popup - Thank you for your order
     */

    public static Target ORDER_SUCCESS_POPUP_TITLE = Target.the("Order success popup title")
            .locatedBy("//div[@role='dialog']//div[@class='page__dialog-title']");


}
