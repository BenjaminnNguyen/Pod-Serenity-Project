package cucumber.user_interface.beta;

import net.serenitybdd.screenplay.targets.Target;

public class HomePageForm {
    // Header
    public static Target CART_IN_HEADER = Target.the("'Button Add to cart'")
            .locatedBy("//div[@class='cart']");

    public static Target CART_COUNTER_IN_HEADER = Target.the("'Label counter of cart'")
            .locatedBy("//div[contains(@class,'cart')]//div[@class='counter-items']/strong");

    public static Target TOTAL_IN_HEADER = Target.the("'Label total of cart'")
            .locatedBy("//div[@class='cart  active']/span[contains(@class,'caption')]");

    // DIALOG CART IN HEADER
    public static Target INFO_PRODUCT_IN_HEADER(String nameProduct, String type) {
        return Target.the("Info " + type + " of " + nameProduct)
                .locatedBy("//div[text()='" + nameProduct + "' and @class='" + type + "']");
    }

    public static Target DESCRIPTION_PRODUCT_IN_HEADER(String nameProduct, String type) {
        return Target.the("Case price of " + nameProduct)
                .locatedBy("//div[text()='" + nameProduct + "']/parent::div/following-sibling::div//span[@class='" + type + "']");
    }

    public static Target TOTAL_PRODUCT_IN_HEADER(String nameProduct, String type) {
        return Target.the("Total of " + nameProduct)
                .locatedBy("//div[text()='" + nameProduct + "']/parent::div/following-sibling::div//div[@class='" + type + "']");
    }

    public static Target REPORT_IN_HEADER(String title) {
        return Target.the("Report price of " + title)
                .locatedBy("//div[@class='cart-popper']//td[text()='" + title + "']/following-sibling::td");
    }

    //div[text()='Product exam1']/parent::div/following-sibling::div//span[@class='case-price']
    // Pop up
    public static Target CLOSE_POPUP_BUTTON = Target.the("'Button Close Popup'")
            .locatedBy("//div[contains(@class,'buyer-app-launching-banner')]//div[@class='close-btn']");

    // Search Bar
    public static final Target SEARCH_FIELD = Target.the("'Textbox Search'")
            .locatedBy("//div[@class='search-box']//input[contains(@placeholder,'Search')]");

    public static final Target SEARCH_BUTTON = Target.the("'Button Search'")
            .locatedBy("//div[@class='search-box']//i[contains(@class,'bx-search')]");

    public static final Target SORT_FILTER_PRODUCT_BUTTON = Target.the("Sort filter of product button")
            .locatedBy("//div[contains(@class,'sort')]//input");

    public static final Target SORT_FILTER_BRAND_BUTTON = Target.the("Sort filter of brand button")
            .locatedBy("//div[text()='Sort by']//following-sibling::div[contains(@class,'el-select')]");

    public static final Target PRODUCT_BUTTON = Target.the("'Product button in search bar'")
            .locatedBy("//div[@class='search']//input[@placeholder='Select']");

    public static final Target TYPE_SEARCH_PRODUCT = Target.the("'Product button in search bar'")
            .locatedBy("//div[@class='search-section__content']/a[1]");

    public static final Target TYPE_SEARCH_BRAND = Target.the("'Product button in search bar'")
            .locatedBy("//div[@class='search-section__content']/a[2]");

    public static Target TYPE_SEARCH(String type) {
        return Target.the("'Type Search in search bar'")
                .locatedBy("//div[@class='el-scrollbar']//span[text()='" + type + "']");
    }

    public static Target SIGN_IN_BUTTON = Target.the("'Button Sign in'")
            .locatedBy("//button/span[text()='Login']");

    public static Target DASHBOARD_BUTTON = Target.the("'Button Sign in'")
            .locatedBy("//div[@class='user-links']//span[normalize-space()='Dashboard']");

    public static Target ADDTOCART_BUTTON = Target.the("'Button Add to cart'")
            .locatedBy("//span[@data-tip='Add to cart']");

    public static Target PRODUCT_IN_CATALOG_LABEL(String nameProduct) {
        return Target.the("Product name " + nameProduct)
                .locatedBy("(//a[contains(text(),'" + nameProduct + "')])/ancestor::article");
    }

    public static Target PRODUCT_IN_CATALOG_LABEL(String product, String brand) {
        return Target.the("Product name " + product + " with brand " + brand)
                .locatedBy("//a[@*='" + brand + "']/parent::div/preceding-sibling::a[text()='" + product + "']");
    }

    public static Target ADD_TO_CART_TOOLTIP_BY_PRODUCT(String nameProduct) {
        return Target.the("Add to cart tooltip by " + nameProduct)
                .locatedBy("//a[normalize-space(text())='" + nameProduct + "']/parent::div/following-sibling::div//div[@class='add-to-cart has-tooltip']");
    }

    public static Target ADD_TO_CART_TOOLTIP_BY_PRODUCT(String product, String brand) {
        return Target.the("Add to cart tooltip by " + product)
                .locatedBy("//a[@*='" + brand + "']/ancestor::div/preceding-sibling::a[text()='" + product + "']/parent::div/following-sibling::div/div[contains(@class,'add-to-cart has-tooltip')]");
    }

    public static Target ADD_TO_CART_TOOLTIP_BY_PRODUCT2(String nameProduct) {
        return Target.the("Add to cart tooltip by " + nameProduct)
                .locatedBy("//a[contains(text(),'" + nameProduct + "')]/parent::div/following-sibling::div//div[contains(@class,'add-to-cart has-tooltip')]");
    }

    public static Target ADD_TO_CART_BY_SKU(String sku) {
        return Target.the("Add to cart tooltip by " + sku)
                .locatedBy("//span[contains(text(),'" + sku + "')]");
    }

    public static Target ADD_TO_CART_TOOLTIP_BY_SKU(String sku) {
        return Target.the("Add to cart tooltip by " + sku)
                .locatedBy("//*[contains(text(),'" + sku + "')]/ancestor::div[@class='metas__favorites']/following-sibling::div//*[contains(@class,'add-to-cart')]");
    }

    public static Target HEART_ANIMATED(String nameProduct) {
        return Target.the("Heart animated")
                .locatedBy("//a[contains(text(),'" + nameProduct + "')]/parent::div/following-sibling::div//div[@class='heart animated']");
    }

    public static Target CONFIRM_REMOVE = Target.the("Confirm remove favorite")
            .locatedBy("//button//span[contains(text(),'OK')]");
    // POPUP ADD TO CART
    public static Target AMOUNT_FIELD = Target.the("'Textbox amount")
            .locatedBy("//input[@name='cart_items[0][quantity]']");

    public static Target ADDTOCART_IN_POPUP_BUTTON = Target.the("'Button Add to cart in popup'")
            .locatedBy("//button[text()='Add to cart']");

    public static Target NEVER_SHOW_AGAIN = Target.the("NEVER_SHOW_AGAIN")
            .locatedBy("//span[text()='Never show this again']");

    public static Target BUTTON_CLOSE_POPUP_CONVERT = Target.the("Convert popup button close")
            .locatedBy("//div[text()='Convert online traffic to wholesale orders.']/following-sibling::div//span");

    public static Target POPUP_DIALOG = Target.the("popup dialog")
            .locatedBy("//div[@role='dialog']");
    public static Target CLOSE_POPUP = Target.the("NEVER_SHOW_AGAIN")
            .located(net.serenitybdd.core.annotations.findby.By.cssSelector("button.el-dialog__headerbtn"));

    public static Target I_ACCEPT = Target.the("I ACCEPT button")
            .located(net.serenitybdd.core.annotations.findby.By.xpath("//span[contains(text(),'I accept')]"));

    public static Target QUANTITY_POPUP_ADDTOCART(String skuName) {
        return Target.the("Quantity of " + skuName + " in popup add to cart")
                .locatedBy("//div[contains(text(),'" + skuName + "')]//ancestor::div/following-sibling::div[@class='quantity']//input");
    }

    public static Target QUANTITY_POPUP_ADDTOCART1(String skuName) {
        return Target.the("Quantity of " + skuName + " in popup add to cart")
                .locatedBy("//div[text()='" + skuName + "']//ancestor::div/following-sibling::div[@class='quantity']//input");
    }

    public static Target SKU_ON_POPUP_ADD_CART(String type, String skuName, String class_) {
        return Target.the("Info of " + skuName + " in popup add to cart")
                .locatedBy("//h2[normalize-space()='" + type + "']/parent::div/following-sibling::div[@class='skus']//div[@class='info-variant__name'][contains(text(),'" + skuName + "')]/parent::div[@class='preview']/div[@class='" + class_ + "']");
    }

    public static Target IMAGE_SKU_ON_POPUP_ADD_CART(String type, String skuName) {
        return Target.the("Info of " + skuName + " in popup add to cart")
                .locatedBy("//h2[normalize-space()='" + type + "']/parent::div/following-sibling::div[@class='skus']//div[@class='info-variant__name'][contains(text(),'" + skuName + "')]/parent::div[@class='preview']/preceding-sibling::div/div");
    }

    public static Target QUANTITY_SKU_ON_POPUP_ADD_CART(String type, String skuName) {
        return Target.the("Info of " + skuName + " in popup add to cart")
                .locatedBy("//h2[normalize-space()='" + type + "']/parent::div/following-sibling::div[@class='skus']//div[@class='info-variant__name'][contains(text(),'" + skuName + "')]/ancestor::div[@class='sku']//div[@class='quantity']//input");
    }

    public static Target SKU_ON_POPUP_ADD_CART_MOV(String type, String skuName, String class_) {
        return Target.the("Info of " + skuName + " in popup add to cart")
                .locatedBy("//h2[normalize-space()='" + type + "']/parent::div/following-sibling::div/div[@class='skus']//div[@class='info-variant__name'][contains(text(),'" + skuName + "')]/parent::div[@class='preview']/div[@class='" + class_ + "']");
    }

    public static Target IMAGE_SKU_ON_POPUP_ADD_CART_MOV(String type, String skuName) {
        return Target.the("Info of " + skuName + " in popup add to cart")
                .locatedBy("//h2[normalize-space()='" + type + "']/parent::div/following-sibling::div/div[@class='skus']//div[@class='info-variant__name'][contains(text(),'" + skuName + "')]/parent::div[@class='preview']/preceding-sibling::div/div");
    }

    public static Target QUANTITY_SKU_ON_POPUP_ADD_CART_MOV(String type, String skuName) {
        return Target.the("Info of " + skuName + " in popup add to cart")
                .locatedBy("//h2[normalize-space()='" + type + "']/parent::div/following-sibling::div/div[@class='skus']//div[@class='info-variant__name'][contains(text(),'" + skuName + "')]/ancestor::div[@class='sku']//div[@class='quantity']//input");
    }

    public static Target ADDTOCART_BUTTON_IN_POPUP = Target.the("Add to cart button")
            .locatedBy("//button/span[text()='Add to cart']");

    public static Target ADD_TO_CART_BUTTON_IN_POPUP = Target.the("Add to cart button")
            .locatedBy("//span[text()='Add to cart']//ancestor::button |//span[text()='Update cart']//ancestor::button");

    public static Target UPDATECART_BUTTON_IN_POPUP = Target.the("Update cart button")
            .locatedBy("//button/span[text()='Update cart']");

    public static Target QUANTITY_POPUP_UPDATECART(String skuName) {
        return Target.the("Quantity of " + skuName + " in popup update to cart minimum order")
                .locatedBy("//div[@class='infinite-fetcher']//div[text()='" + skuName + "']//ancestor::div/following-sibling::div[@class='quantity']//input");
    }

    public static Target MESSAGE_OUT_STOCK_OF_SKU(String skuName) {
        return Target.the("Message out of stock of sku " + skuName)
                .locatedBy("//div[contains(text(),'" + skuName + "')]/following-sibling::div[@class='cartable not-available']");
    }

    public static Target ADD_TO_CART_DISABLE = Target.the("Button add to cart disable")
            .locatedBy("//button[@disabled='disabled']/span[text()='Add to cart']");
    /**
     * Pre-order in Popup Add to cart
     */

    public static Target PRE_ORDER_LINK = Target.the("Pre-order link")
            .locatedBy("//a[text()='Pre-order now >']");

    public static Target PRE_ORDER_BUTTON = Target.the("Pre Order button")
            .locatedBy("//button/span[text()='Pre Order']");

    public static Target PRE_ORDER_SENT_MESSAGE = Target.the("Popup Pre-Order message")
            .locatedBy("//p[text()='Preorder has been sent!']");

    public static Target CLOSE_POPUP_ADD_TO_CART = Target.the("Button close popup add to cart")
            .locatedBy("//div[@aria-label='dialog']//i[contains(@class,'el-icon-close')]");

    /**
     * Popup confirm SKUs short-dated
     */
    public static Target CONFIRM_POPUP = Target.the("Popup confirm SKUs short-dated")
            .locatedBy("//div[@class='el-message-box']//p[contains(text(),'SKUs with short-dated')]");

    public static Target UNDERSTAND_BUTTON = Target.the("Button understand SKUs short-dated")
            .locatedBy("//button//span[contains(text(),'I understand')]");
    /**
     * CART BEFORE CHECKIN
     */
    public static Target CART_ORDER_BEFORE = Target.the("Order value in cart before checkin")
            .locatedBy("//dd[@class='cart__order-value']");

    public static Target CART_SOS_BEFORE = Target.the("Small order surchage in cart before checkin")
            .locatedBy("//dd[@class='cart__sos']");

    public static Target CART_LS_BEFORE = Target.the("Logistics surchage in cart before checkin")
            .locatedBy("//dd[@class='cart__ls']");

    public static Target CART_TOTAL_BEFORE = Target.the("Total in cart before checkin")
            .locatedBy("//dd[@class='cart__total']");

    public static Target CART_TAX_BEFORE = Target.the("Taxes in cart before checkin")
            .locatedBy("//dd[@class='cart__taxes']");
    public static Target CART_DISCOUNT_BEFORE = Target.the("Promotional Discount in cart before checkin")
            .locatedBy("//dd[@class='cart__discount']");

    public static Target CART_SPECIAL_DISCOUNT_BEFORE = Target.the("Pod Sponsor Promotional Discount in cart before checkin")
            .locatedBy("//dd[@class='cart__special-discount']");
    public static Target PRICE_BEFORE_DISCOUNT_SKU = Target.the("PRICE_BEFORE_DISCOUNT_SKU")
            .locatedBy("//div[@class='cart__item-case-price pf-nowrap']/em");
    public static Target PRICE_DISCOUNT_IN_SKU = Target.the("PRICE_DISCOUNT_IN_SKU")
            .locatedBy("//div[@class='cart__item-case-price pf-nowrap']/strong");
    public static Target PRICE_DISCOUNT_TOTAL_IN_SKU = Target.the("PRICE_DISCOUNT_TOTAL_IN_SKU")
            .locatedBy("//div[@class='cart__item-total']");
    public static Target ORIGINAL_PRICE_DISCOUNT_TOTAL = Target.the("PRICE_DISCOUNT_TOTAL_IN_SKU")
            .locatedBy("//div[@class='cart__item-original-total']");
    public static Target CART_REMOVE_BEFORE = Target.the("Button remove item in cart before checkin")
            .locatedBy("//button[contains(@class,'cart__item-remove')]");

    public static Target CART_REMOVE_BEFORE(String sku) {
        return Target.the("Button remove item of sku " + sku + " in cart before checkin")
                .locatedBy("//span[contains(text(),'" + sku + "')]/ancestor::div/div[contains(@class,'action')]/button");
    }

    public static Target CART_EMPTY_LABEL = Target.the("Label Your cart is currently empty.")
            .locatedBy("//p[text()='Your cart is currently empty.']");

    /**
     * Popup message
     */

    public static Target REMOVE_BUTTON_IN_POUP = Target.the("Button remove item in popup")
            .locatedBy("//button/span[contains(text(),'Remove')]");

    public static Target ITEM_REMOVED_FROM_CARD = Target.the("Item removed from cart! popup")
            .locatedBy("//p[text()='Item removed from cart!']");

    /**
     * Cart tab on right side
     */
    public static Target VIEW_CART_BUTTON = Target.the("Button view cart")
            .locatedBy("//span[normalize-space()='View cart']");

    public static Target ITEM_CART_BRAND_NAME(int index, String brand) {
        return Target.the("Brand name of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]/div[@class='cart__item-info']//a[contains(@class,'cart__item-brand pf-ellipsis')][text()='" + brand + "']");
    }

    public static Target ITEM_CART_BRAND_NAME2(int index) {
        return Target.the("Brand name of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]/div[@class='cart__item-info']//a[contains(@class,'cart__item-brand')]");
    }

    public static Target ITEM_CART_PRODUCT_NAME(int index, String product) {
        return Target.the("Product name of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]/div[@class='cart__item-info']//a[contains(@class,'cart__item-product pf-ellipsis')][contains(text(),'" + product + "')]");
    }

    public static Target ITEM_CART_SKU_NAME(int index, String sku) {
        return Target.the("SKU name of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]/div[@class='cart__item-info']//a[contains(@class,'cart__item-sku pf-ellipsis')][contains(text(),'" + sku + "')]");
    }

    public static Target ITEM_CART_PRICE(int index) {
        return Target.the("Price of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]/div[@class='cart__item-info']/div[@class='cart__item-case-price pf-nowrap']");
    }

    public static Target ITEM_CART_OLD_PRICE(int index) {
        return Target.the("Old Price of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]/div[@class='cart__item-info']/div[@class='cart__item-case-price pf-nowrap']");
    }

    public static Target ITEM_CART_NEW_PRICE(int index) {
        return Target.the("New Price of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]/div[@class='cart__item-info']/div[@class='cart__item-case-price pf-nowrap']/strong");
    }

    public static Target ITEM_CART_QUANTITY(int index) {
        return Target.the("Quantity of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]/div[@class='cart__item-quantity asc']//input");
    }

    public static Target ITEM_CART_ITEM_TOTAL(int index) {
        return Target.the("Quantity of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]//div[@class='cart__item-total']");
    }

    public static Target ITEM_CART_MOQ(int index) {
        return Target.the("MOQ of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]//div[contains(@class,'cart__item-limit')]//span[@class='moq']/strong");
    }

    public static Target ITEM_CART_SKU_ID(int index) {
        return Target.the("Sku id of item: " + (index + 1))
                .locatedBy("//div[contains(@class,'cart__item')][" + (index + 1) + "]//span[contains(@class,'cart__item-order-code')]");
    }

    public static Target LIST_TOTAL_PRICE_OF_ITEM = Target.the("All Total price of items in cart").locatedBy("//div[@class='cart__item']//div[@class='cart__item-total']");

    public static Target ORDER_VALUE = Target.the("Order value ").locatedBy("//dd[@class='cart__order-value']");
    public static Target ITEMS_SUBTOTAL = Target.the("Item subtotal ").locatedBy("//dd[@class='cart__items-subtotal']");
    public static Target SMALL_ORDER_SURCHARGE = Target.the("Small order surcharge ").locatedBy("//dd[@class='cart__sos']");
    public static Target LOGISTICS_SURCHARGE = Target.the("Logistics surcharge ").locatedBy("//dd[@class='cart__ls']");
    public static Target CART_TOTAL = Target.the("CART total ").locatedBy("//dd[@class='cart__total']");

    public static Target SIGNIN_BUTTON_AFTER_DELETE_COOKIE = Target.the("'Button Sign in'")
            .locatedBy("(//a[text()='Login'])[1]");

    /**
     * MOV Alert in catalog
     */
    public static Target TITLE_MOV_ALERT_CATALOG = Target.the("Title in mov alert in catalog")
            .locatedBy("//div[@class='mov-alert-headup']//div[@class='title']");

    public static Target DESCRIPTION_MOV_ALERT_CATALOG = Target.the("Description in mov alert in catalog")
            .locatedBy("//div[@class='mov-alert-headup']//div[@class='description']");

    public static Target BRAND_MOV_ALERT_CATALOG = Target.the("Brand in mov alert in catalog")
            .locatedBy("//div[@class='mov-alert-headup']//div[contains(@class,'brand')]");

    public static Target CURRENT_MOV_ALERT_CATALOG = Target.the("Current in mov alert in catalog")
            .locatedBy("//div[@class='mov-alert-headup']//span[contains(@class,'current')]");

    public static Target TARGET_MOV_ALERT_CATALOG = Target.the("Target in mov alert in catalog")
            .locatedBy("//div[@class='mov-alert-headup']//span[contains(@class,'target')]");

    public static Target EXPLORE_BUTTON_MOV_ALERT_CATALOG = Target.the("Button Explore SKUs from this brand in mov alert in catalog")
            .locatedBy("//a[contains(text(),'Explore SKUs')]");

    public static Target VENDOR_COMPANY_HEADER = Target.the("Vendor company header")
            .locatedBy("//div[@class='vendor-company']//h1");

    public static Target ALERT = Target.the("alert")
            .locatedBy("//div[@role='alert']");

    public static Target DYNAMIC_CONTAIN_ANY_TEXT(String alert) {
        return Target.the("text " + alert)
                .locatedBy("//*[contains(text(),\"" + alert + "\")]");
    }

    /**
     * Privacy Policy
     */


    public static Target PRIVACY_POLICY_POPUP = Target.the("Privacy policy popup")
            .locatedBy("//div[@role='dialog']//div[text()='Privacy Policy']|//div[@role='dialog']//div[text()='Site Terms of Use']");

    public static Target PRIVACY_POLICY_READ = Target.the("Privacy policy popup")
            .locatedBy("//div[@role='dialog']//*[text()='I have read, understood and agree to the Privacy Policy.']");

    public static Target TERM_OF_USE = Target.the("Terms of Use popup")
            .locatedBy("//div[@role='dialog']//div[text()='Site Terms of Use']");

    public static Target TERM_OF_USE_READ = Target.the("Term of use read")
            .locatedBy("//div[@role='dialog']//*[text()='I have read, understood and agree to the Site Terms of Use.']");


}
