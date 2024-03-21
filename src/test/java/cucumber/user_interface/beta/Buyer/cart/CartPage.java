package cucumber.user_interface.beta.Buyer.cart;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CartPage {
    public static Target CHECKOUT_BUTTON = Target.the("Button checkout")
            .locatedBy("//button//span[text()='Check out']");

    public static Target LIST_ITEM_IN_CART = Target.the("List item in cart")
            .locatedBy("//button//span[text()='Check out']");

    public static Target ITEM_CART_BRAND_NAME(int index) {
        return Target.the("Brand name of item: " + (index + 1))
                .locatedBy("(//div[contains(@class,'cart-line-item')]//a[contains(@class,'cart-line-item__brand pf-ellipsis')])[" + (index + 1) + "]");
    }

    public static Target ITEM_CART_PRODUCT_NAME(int index) {
        return Target.the("Product name of item: " + (index + 1))
                .locatedBy("(//div[contains(@class,'cart-line-item')]//a[contains(@class,'cart-line-item__product pf-ellipsis')])[" + (index + 1) + "]");
    }

    public static Target ITEM_CART_SKU_NAME(int index) {
        return Target.the("SKU name of item: " + (index + 1))
                .locatedBy("(//div[contains(@class,'cart-line-item')]//a[contains(@class,'cart-line-item__sku pf-ellipsis')])[" + (index + 1) + "]");
    }

    public static Target ITEM_CART_PRICE(int index) {
        return Target.the("SKU name of item: " + (index + 1))
                .locatedBy("(//div[contains(@class,'cart-line-item')]//div[@class='cart-line-item__case-price pf-nowrap'])[" + (index + 1) + "]");
    }

    public static Target ITEM_CART_QUANTITY(int index) {
        return Target.the("Quantity of item: " + (index + 1))
                .locatedBy("(//div[contains(@class,'cart-line-item')]//div[@class='cart-line-item__quantity']//input)[" + (index + 1) + "]");
    }

    public static Target ITEM_CART_QUANTITY(String sku) {
        return Target.the("Quantity of item: " + sku)
                .locatedBy("//a[normalize-space()='" + sku + "']/ancestor::div[contains(@class,'cart-line-item')]//input");
    }

    public static Target ITEM_CART_ITEM_TOTAL(int index) {
        return Target.the("Quantity of item: " + (index + 1))
                .locatedBy("(//div[contains(@class,'cart-line-item')]//div[@class='cart-line-item__total'])[" + (index + 1) + "]");
    }

    public static Target ITEM_CART_REMOVE_BUTTON(String sku) {
        return Target.the("Button remove line item ")
                .locatedBy("//*[contains(text(),'" + sku + "')]/ancestor::div/div[contains(@class,'quantity')]//button//span[text()='Delete']");
    }

    public static Target TOTAL_PRICE_OF_ITEM = Target.the("All Total price of items in cart").locatedBy("//div[@class='cart-line-item__total']");
    public static Target ORDER_VALUE = Target.the("Order value ").locatedBy("//dd[@class='cart__order-value']");
    public static Target ITEMS_SUBTOTAL = Target.the("Item subtotal ").locatedBy("//dd[@class='cart__items-subtotal']");
    public static Target SMALL_ORDER_SURCHARGE = Target.the("Small order surcharge ").locatedBy("//dd[@class='cart__sos']");
    public static Target LOGISTICS_SURCHARGE = Target.the("Logistics surcharge ").locatedBy("//dd[@class='cart__ls']");
    public static Target CART_TOTAL = Target.the("CART total ").locatedBy("//dd[@class='cart__total']");

    //MOQ Alert
    public static Target MOQ_ALERT = Target.the("MOQ Alert ")
            .locatedBy("//div[@class='page__dialog-title']");

    public static Target MOQ_ALERT_UPDATE_CART = Target.the("MOQ Alert update cart")
            .locatedBy("//div[@class='page__dialog-footer']/button");

    public static Target MOQ_ALERT_QUANTITY = Target.the("MOQ Alert quantity item add to cart ")
            .locatedBy("//div[@class='page__dialog-description']/strong");

    public static Target MOQ_ALERT_NOTICE = Target.the("MOQ Alert notice")
            .locatedBy("//div[@class='notice']");

    public static Target MOQ_ALERT_CLOSE = Target.the("Close MOQ Alert notice")
            .locatedBy("//i[@class='el-dialog__close el-icon el-icon-close']");

    public static Target MOQ_ALERT_CASE_MORE = Target.the("MOQ Alert number case more")
            .locatedBy("//div[@class='counter ml-1']/strong");

    public static Target MOQ_ALERT_CASE_MORE_POPUP_CART = Target.the("MOQ Alert number case more in popup cart")
            .locatedBy("//div[contains(@class,'counter')]/strong");


    public static Target MOQ_ALERT_QUANTITY_FIELD = Target.the("MOQ quantity field")
            .locatedBy("//div[@class='pf-block el-input-number el-input-number--small']//input[@role='spinbutton']");

    public static Target MOQ_ALERT_QUANTITY_FIELD(int i) {
        return Target.the("MOQ quantity field")
                .locatedBy("(//div[@class='pf-block el-input-number el-input-number--small']//input[@role='spinbutton'])[" + i + "]");
    }

    public static Target MOQ_ALERT_QUANTITY_FIELD(String sku) {
        return Target.the("MOQ quantity field")
                .locatedBy("//div[text()='" + sku + "']//ancestor::div[@class='sku']//input");
    }

    public static Target MOQ_ALERT_PRODUCT_NAME(int i) {
        return Target.the(" product name")
                .locatedBy("(//div[@class='product']/span)[" + i + "]");
    }

    public static Target MOQ_ALERT_SKU_NAME(int i) {
        return Target.the(" sku name")
                .locatedBy("(//div[@class='info-variant__name'])[" + i + "]");
    }

    public static Target MOQ_ALERT_UNIT_PER_CASE(int i) {
        return Target.the("Unit per case")
                .locatedBy("(//span[@class='case-unit'])[" + i + "]");
    }

    public static Target MOQ_ALERT_PRICE(int i) {
        return Target.the("Price")
                .locatedBy("(//div[@class='price']//span[@class='current'])[" + i + "]");
    }

    public static Target MOQ_ALERT_PRICE_OLD(int i) {
        return Target.the("Old price")
                .locatedBy("(//div[text()='MOQ Alert']/ancestor::div//div[@class='price']/span[@class='old'])[" + i + "]");
    }

    public static Target MOQ_ALERT_PRICE_NEW(int i) {
        return Target.the("New price")
                .locatedBy("(//div[text()='MOQ Alert']/ancestor::div//div[@class='price']/span[@class='current promoted'])[" + i + "]");
    }

    public static Target MOQ_ALERT_QUANTITY(int index) {
        return Target.the("Quantity of item: " + index + " add to cart ")
                .locatedBy("//div[@class='page__dialog-description']/strong");
    }

    // Cart detail
    public static Target MOQ_ALERT_CART_DETAIL = Target.the("MOQ Alert ")
            .locatedBy("//span[normalize-space()='MOQ Alert']");
    public static Target MOQ_ALERT_NOTCE_CART_DETAIL = Target.the("MOQ Alert ")
            .locatedBy("//div[@class='cart__group-alert-notice']");
    public static Target MOQ_CART_DETAIL = Target.the("MOQ Alert ")
            .locatedBy("//div[@class='cart-line-item__moq']/strong");

    public static Target MOV_ALERT_ADD_CART = Target.the("MOV Alert ")
            .locatedBy("//div[@class='notice']");

    public static Target MOV_ALERT_ADD_CART_DIRECT(String item) {
        return Target.the("MOV Alert ")
                .locatedBy("//h2[normalize-space()='" + item + "']//ancestor::div[@class='group']//div[@class='notice']");
    }

    public static Target MOV_ALERT_COUNTER_ADD_CART_DIRECT(String item) {
        return Target.the("MOV Alert ")
                .locatedBy("//h2[normalize-space()='" + item + "']//ancestor::div[@class='group']//div[contains(@class,'counter')]");
    }

    public static Target MOV_ALERT_ADD_CART_EXPRESS = Target.the("MOV Alert ")
            .locatedBy("//h2[normalize-space()='Pod Express Items']//ancestor::div[@class='group']//div[@class='notice']");
    public static Target MOV_ALERT_COUNTER_ADD_CART = Target.the("MOV Alert counter")
            .locatedBy("//div[contains(@class,'alert')]//div[contains(@class,'counter')]");

    public static Target CLOSE_MOV_ALERT_ADD_CART = Target.the("Close MOV Alert")
            .locatedBy("//div[@class='el-dialog page__dialog mov-alert-modal']//i[@class='el-dialog__close el-icon el-icon-close']");

    public static Target CLOSE_ALERT_ADD_CART = Target.the("Close Add cart popup")
            .locatedBy("//button[@aria-label='Close']//i[@class='el-dialog__close el-icon el-icon-close']");

    public static Target UPDATE_ALERT_ADD_CART = Target.the("Update Add cart popup")
            .locatedBy("//span[normalize-space()='Update cart']/parent::button");

    public static Target MOV_MOQ_ALERT_CART_DETAIL = Target.the("MOV MOQ Alert ")
            .locatedBy("//div[@class='cart__group-alert-notice']/span");

    public static Target PD_MOV_ALERT_CART_DETAIL = Target.the("MOV MOQ Alert PD item")
            .locatedBy("//h2[contains(text(),'Pod Direct Items')]//ancestor::div//div[contains(@class,'alert')]//span[contains(text(),'Please order more cases to reach SKU MOV.')]");


    public static Target MOV_MOQ_ALERT_CART_DETAIL(String sku) {
        return Target.the("MOQ Alert counter")
                .locatedBy("(//a[normalize-space()='" + sku + "']/ancestor::div[contains(@class, 'cart__group')]//div[@class='cart__group-alert-notice']/span)[last()]");
    }

    public static Target MOV_ALERT_CART_DETAIL_COUNTER = Target.the("MOV Alert counter ")
            .locatedBy("//div[@class='cart__group-alert-counter']");

    public static Target MOQ_ALERT_CART_DETAIL_COUNTER(String sku) {
        return Target.the("MOV Alert counter ")
                .locatedBy("//a[normalize-space()='" + sku + "']/ancestor::div[contains(@class, 'cart__group')]//div[@class='cart-line-item__moq']");
    }

    public static Target D_ALERT_CLOSE_BUTTON = Target.the("Alert message close button")
            .locatedBy("//div[@role='alert']//i[contains(@class,'el-icon-close')]");

    public static Target MESSAGE_ADD_TO_CART = Target.the("Message Item added to cart!")
            .located(By.xpath("//p[text()='Item added to cart!']"));

    public static Target MESSAGE_REMOVE_SOS = Target.the("Message remove sos")
            .located(By.xpath("//div[@class='sos__message']"));

    public static Target SKU_SIDE_BAR(String skuName) {
        return Target.the("Sku of side bar " + skuName)
                .locatedBy("//div[@class='catalog__sider']//a[text()='" + skuName + "']");
    }

    /**
     * Before checkout
     */

    public static Target ITEM_CART_QUANTITY_BY_SKUID(String skuID) {
        return Target.the("Quantity of item: " + skuID)
                .locatedBy("//span[contains(text(),'" + skuID + "')]/parent::div/following-sibling::div[contains(@class,'quantity')]//input");
    }

    public static Target INCREASE_BUTTON = Target.the("Increase button of quantity in before cart")
            .located(By.xpath("//span[@class='el-input-number__increase']"));

    public static Target DECREASE_BUTTON = Target.the("Decrease button of quantity in before cart")
            .located(By.xpath("//span[@class='el-input-number__decrease']"));

    /**
     * MOV Alert popup in popup cart
     */
    public static Target MOV_ALERT_QUANTITY_TEXTBOX(String sku) {
        return Target.the("Old price")
                .locatedBy("//div[contains(@class,'mov-alert')]//div[contains(text(),'" + sku + "')]/ancestor::div/div[@class='quantity']//input");
    }

    public static Target MOV_ALERT = Target.the("MOV Alert ")
            .locatedBy("//div[contains(@class,'mov-alert')]//div[@class='page__dialog-title']");

    public static Target MOV_ALERT_CASE_MORE_POPUP_CART = Target.the("MOV Alert number case more in popup cart")
            .locatedBy("//div[contains(@class,'counter')]/strong");

    /**
     * Cart Empty page
     */

    public static Target CART_EMPTY_TITLE = Target.the("Cart empty title")
            .locatedBy("//span[text()='Your cart is empty']");

    public static Target CART_EMPTY_DESCRIPTION = Target.the("Cart empty description")
            .locatedBy("//span[text()='Need to replenish your empty shelves? Want to delight your customers? Order the latest trending brands now!']");

    public static Target CART_EMPTY_START_SHOPPING_BUTTON = Target.the("Cart empty start shopping button")
            .locatedBy("//a[text()='Start Shopping']");

    public static Target PRICE_BEFORE_DISCOUNT_SKU = Target.the("PRICE_BEFORE_DISCOUNT_SKU")
            .locatedBy("//div[@class='cart-line-item__case-price pf-nowrap']");
    public static Target PRICE_DISCOUNT_IN_SKU = Target.the("PRICE_DISCOUNT_IN_SKU")
            .locatedBy("//div[@class='cart-line-item__case-price pf-nowrap']/strong");
    public static Target PRICE_DISCOUNT_TOTAL_IN_SKU = Target.the("PRICE_DISCOUNT_TOTAL_IN_SKU")
            .locatedBy("//div[@class='cart-line-item__total']");

    public static Target ORIGINAL_PRICE_DISCOUNT_TOTAL = Target.the("ORIGINAL_PRICE_DISCOUNT_TOTAL")
            .locatedBy("//div[@class='cart-line-item__original-total']");


    /**
     * Popup SOS recommend - popup
     */

    public static Target RECOMMEND_ITEM_POPUP = Target.the("Recommend item popup")
            .locatedBy("//div[@role='dialog']//div[contains(text(),'Add these items to save on the')]");

    public static Target RECOMMEND_ITEM_POPUP_CLOSE_BUTTON = Target.the("Recommend item popup close button")
            .locatedBy("//div[contains(text(),'Add these items to save on the')]//ancestor::div[contains(@class,'page__dialog-header')]/following-sibling::button[@aria-label='Close']");
    public static Target RECOMMEND_ITEM_POPUP_TITLE = Target.the("Recommend item popup title")
            .locatedBy("//div[@role='dialog']//div[@class='page__dialog-title' and contains(text(),'Add these items to save on the')]/span");

    public static Target RECOMMEND_ITEM_POPUP_REMAIN_MONEY = Target.the("Recommend item popup remain money")
            .locatedBy("//div[@role='dialog']//div[contains(@class,'remain-money')]//strong");

    public static Target RECOMMEND_ITEM_POPUP_MINIMUM_ORDER_VALUE = Target.the("Recommend item popup minimum order value")
            .locatedBy("//div[@role='dialog']//div[contains(@class,'minimum-order-value')]//strong");

    public static Target RECOMMEND_ITEM_POPUP_ITEM_SKU(String sku) {
        return Target.the("Recommend item popup sku " + sku)
                .locatedBy("//div[@role='dialog']//div[contains(@class,'caption')]//a[text()='" + sku + "']");
    }

    public static Target RECOMMEND_ITEM_POPUP_ITEM_PRODUCT(String sku) {
        return Target.the("Recommend item popup product of sku " + sku)
                .locatedBy("//div[@role='dialog']//a[text()='" + sku + "']/preceding-sibling::a");
    }

    public static Target RECOMMEND_ITEM_POPUP_ITEM_PRICE(String sku) {
        return Target.the("Recommend item popup price of sku " + sku)
                .locatedBy("//div[@role='dialog']//a[text()='" + sku + "']/ancestor::div/following-sibling::div/div[@class='case-price']/span");
    }

    public static Target RECOMMEND_ITEM_POPUP_ITEM_NEW_PRICE(String sku) {
        return Target.the("Recommend item popup new price of sku " + sku)
                .locatedBy("//div[@role='dialog']//a[text()='" + sku + "']/ancestor::div/following-sibling::div/div[contains(@class,'promotion-price')]/div[@class='current']");
    }

    public static Target RECOMMEND_ITEM_POPUP_ITEM_OLD_PRICE(String sku) {
        return Target.the("Recommend item popup old price of sku " + sku)
                .locatedBy("//div[@role='dialog']//a[text()='" + sku + "']/ancestor::div/following-sibling::div/div[contains(@class,'promotion-price')]/div[@class='old']");
    }

    public static Target RECOMMEND_ITEM_POPUP_ITEM_QUANTITY(String sku) {
        return Target.the("Recommend item popup quantity of sku " + sku)
                .locatedBy("//div[@role='dialog']//a[text()='" + sku + "']/ancestor::div/following-sibling::div[@class='quantity']//input");
    }

    /**
     * Popup SOS recommend - slide
     */

    public static Target RECOMMEND_ITEM_SLIDE = Target.the("Recommend item slide")
            .locatedBy("//div[contains(@class,'swiper-area')]");

    public static Target SLIDE_ACTIVE = Target.the("Recommend item slide")
            .locatedBy("//div[@class='swiper-slide swiper-slide-active']");
    public static Target SLIDE_NEXT = Target.the("Recommend item slide")
            .locatedBy("//div[@class='swiper-slide swiper-slide-next']");

    public static Target RECOMMEND_ITEM_SLIDE_ITEM_SKU(String sku) {
        return Target.the("Recommend item popup quantity of sku " + sku)
                .locatedBy("//div[contains(@class,'swiper-area')]//a[text()='" + sku + "']");
    }

    public static Target RECOMMEND_ITEM_SLIDE_ITEM_PRODUCT(String sku) {
        return Target.the("Recommend item popup quantity of sku " + sku)
                .locatedBy("//div[contains(@class,'swiper-area')]//a[text()='" + sku + "']/parent::div/preceding-sibling::a");
    }

    public static Target RECOMMEND_ITEM_SLIDE_ITEM_PRICE(String sku) {
        return Target.the("Recommend item popup price of sku " + sku)
                .locatedBy("//div[contains(@class,'swiper-area')]//a[text()='" + sku + "']/parent::div/following-sibling::div//span");
    }

    public static Target RECOMMEND_ITEM_SLIDE_ITEM_NEW_PRICE(String sku) {
        return Target.the("Recommend item popup new price of sku " + sku)
                .locatedBy("//div[contains(@class,'swiper-area')]//a[text()='" + sku + "']/parent::div/following-sibling::div//div[@class='current']");
    }

    public static Target RECOMMEND_ITEM_SLIDE_ITEM_OLD_PRICE(String sku) {
        return Target.the("Recommend item popup old price of sku " + sku)
                .locatedBy("//div[contains(@class,'swiper-area')]//a[text()='" + sku + "']/parent::div/following-sibling::div//div[@class='old']");
    }

    public static Target RECOMMEND_ITEM_SLIDE_ITEM_CASE(String sku) {
        return Target.the("Recommend item popup quantity of sku " + sku)
                .locatedBy("//div[contains(@class,'swiper-area')]//a[text()='" + sku + "']/parent::div/following-sibling::div[@class='moq']");
    }

    public static Target RECOMMEND_ITEM_SLIDE_PROMO(String sku, String promo) {
        return Target.the("Recommend item popup promo of sku " + sku)
                .locatedBy("//div[contains(@class,'swiper-area')]//a[text()='" + sku + "']/parent::div/following-sibling::div//div[@class='promotions-tag']//div[text()='" + promo + "']");
    }

    public static Target RECOMMEND_ITEM_SLIDE_PROMO1(String sku) {
        return Target.the("Recommend item popup promo of sku " + sku)
                .locatedBy("//div[contains(@class,'swiper-area')]//a[text()='" + sku + "']/parent::div/following-sibling::div//div[@class='promotions-tag']/span");
    }

    /**
     * Popup SOS recommend - slide - promotion popup
     */

    public static Target SLIDE_PROMO_TOOLTIP_SKU(String sku) {
        return Target.the("Sku of promotion tooltip in recommended slider")
                .locatedBy("//div[@x-placement]//span[contains(@class,'sku') and text()='" + sku + "']");
    }

    public static Target SLIDE_PROMO_TOOLTIP_PROMOTION_TYPE(String sku) {
        return Target.the("Promotion type of promotion tooltip in recommended slider")
                .locatedBy("//div[@x-placement]//span[contains(@class,'sku') and text()='" + sku + "']/following-sibling::span[contains(@class,'promotion-type')]");
    }

    public static Target SLIDE_PROMO_TOOLTIP_CURRENT_PRICE(String sku) {
        return Target.the("Current price of promotion tooltip in recommended slider")
                .locatedBy("//div[@x-placement]//span[contains(@class,'sku') and text()='" + sku + "']/parent::div/following-sibling::div//span[contains(@class,'current promoted')]");
    }

    public static Target SLIDE_PROMO_TOOLTIP_OLD_PRICE(String sku) {
        return Target.the("Old price of promotion tooltip in recommended slider")
                .locatedBy("//div[@x-placement]//span[contains(@class,'sku') and text()='" + sku + "']/parent::div/following-sibling::div//span[contains(@class,'old')]");
    }

    public static Target SLIDE_PROMO_TOOLTIP_EXPIRY_DATE(String sku) {
        return Target.the("Expiry date of promotion tooltip in recommended slider")
                .locatedBy("//div[@x-placement]//span[contains(@class,'sku') and text()='" + sku + "']/parent::div/following-sibling::div//strong[contains(@class,'value')]");

    }

    /**
     * Save for later in cart detail
     */

    public static Target SAVE_FOR_LATER_SKU(String sku) {
        return Target.the("Save for later sku " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]");
    }

    public static Target SAVE_FOR_LATER_PRODUCT(String sku) {
        return Target.the("Save for later product " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/preceding-sibling::a[contains(@class,'product')]");
    }

    public static Target SAVE_FOR_LATER_BRAND(String sku) {
        return Target.the("Save for later brand " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/preceding-sibling::a[contains(@class,'brand')]");
    }

    public static Target SAVE_FOR_LATER_PRICING(String sku) {
        return Target.the("Save for later pricing " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[contains(@class,'pricing')]//div[@class='content']");
    }

    public static Target SAVE_FOR_LATER_SKU_ID(String sku) {
        return Target.the("Save for later sku id " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/following-sibling::div/span[contains(@class,'code')]");
    }

    public static Target SAVE_FOR_LATER_DELETE_BUTTON(String sku) {
        return Target.the("Save for later delete " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[contains(@class,'actions')]//button/span[text()='Delete']");
    }

    public static Target SAVE_FOR_LATER_DELETE_FIND(String sku) {
        return Target.the("Save for later find similar product " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[contains(@class,'actions')]//button//a[text()='Find similar product']");
    }

    public static Target SAVE_FOR_LATER_MOVE_DISABLE(String sku) {
        return Target.the("Save for later move to cart disable " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[contains(@class,'move')]//button[contains(@class,'is-disabled')]");
    }

    public static Target SAVE_FOR_LATER_MOVE_CART(String sku) {
        return Target.the("Save for later move to cart " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[contains(@class,'move')]//button");
    }

    public static Target SAVE_FOR_LATER_BTN(String sku) {
        return Target.the("Save for later button of " + sku)
                .locatedBy("//a[contains(text(),'" + sku + "')]/ancestor::div[@class='cart-line-item']//div[@class='cart-line-item__quantity']//span[normalize-space()='Save for later']");
    }


    public static Target SAVE_FOR_LATER_NOT_AVAILABLE(String sku) {
        return Target.the("Save for later pricing " + sku)
                .locatedBy("//div[contains(@class,'saved-for-later')]//a[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[contains(@class,'pricing')]//div[text()='This item is no longer available']");
    }

}
