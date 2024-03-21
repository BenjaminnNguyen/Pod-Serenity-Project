package cucumber.user_interface.beta.Buyer.cart;

import net.serenitybdd.screenplay.targets.Target;

public class CheckoutPage {

    public static Target ID_INVOICE = Target.the("Id invoice")
            .locatedBy("//h1");
    public static Target CHECKOUT_BUTTON = Target.the("Button Checkout")
            .locatedBy("//button[@title='Checkout']");
    public static Target PLACEORDER_BUTTON = Target.the("Button Place Order")
            .locatedBy("//button[contains(@class,'check-out')]");
    public static Target PAYMENT_METHOD_DROPDOWN = Target.the("Dropdown payment method")
            .locatedBy("//input[@autocomplete='new-password']");

    public static Target PLACEORDER_BUTTON_DISABLE = Target.the("Button Place Order is disable")
            .locatedBy("//button[contains(@class,'check-out') and contains(@class,'is-disabled')]");

    public static Target UH_OH_LABEL = Target.the("Uh Oh label")
            .locatedBy("//span[text()='Uh-oh...']");

    public static Target PAYMENT_METHOD_ITEM(String typePayment) {
        return Target.the("Dropdown item payment method")
                .locatedBy("//span[text()='" + typePayment + "']");
    }

    public static Target VIEW_ORDER = Target.the("Button view order")
            .locatedBy("//button/span[text()='View order']");

    public static Target TITLE_POPUP_THANKYOU_ORDER = Target.the("Title popup thank you order")
            .locatedBy("//div[text()='Thank you for your order!']");

    public static Target CONTINUE_SHOPPING = Target.the("Button Continue shopping")
            .locatedBy("//button/span[text()='Continue shopping']");

    public static Target DESCRIPTION_POPUP_THANKYOU_ORDER = Target.the("Description in popup thank you order")
            .locatedBy("//div[@class='notice']");
    public static Target INVOICE_BUTTON = Target.the("Button invoice button")
            .locatedBy("//button//span[text()='Invoice']");
    public static Target SUB_INVOICE_BUTTON = Target.the("Button sub invoice button")
            .locatedBy("//a//span[contains(text(),'Sub-invoice')]");
    public static Target CART_SOS_ORDER = Target.the("Small order surchage in Order")
            .locatedBy("//dd[contains(@class,'order-surcharge')]/div");
    public static Target CART_LS_ORDER = Target.the("Logistics surcharge in Order")
            .locatedBy("//dd[contains(@class,'logistics-surcharge')]/div");
    public static Target CART_TAX_ORDER = Target.the("Tax in Order")
            .locatedBy("//dd[contains(@class,'order-total-state-fee')]/div");
    public static Target TOTAL_ORDER = Target.the("Total in Order")
            .locatedBy("//div[contains(@class,'total')]");
    public static Target PROMOTION_ORDER = Target.the("Promotion in Order")
            .locatedBy("//dd[contains(@class,'order-promotion')]/div");

    public static Target NO_INVOICE_BUTTON = Target.the("Button sub invoice button")
            .locatedBy("//*[text()='No invoices have been created for this order.']");

    /**
     * Sub invoice page
     */
    public static Target CART_SOS_INVOICE = Target.the("Small order surchage in Invoice")
            .locatedBy("//td[contains(@class,'invoice-small-order-surcharge')]");
    public static Target CART_LS_INVOICE = Target.the("Logistics surcharge in Invoice")
            .locatedBy("//td[contains(@class,'invoice-logistics-surcharge')]");
    public static Target CART_TAX_INVOICE = Target.the("Bottle Deposit in Invoice")
            .locatedBy("//td[contains(@class,'tr invoice-total-tax')]");
    public static Target TOTAL_INVOICE = Target.the("Total in Invoice")
            .locatedBy("//td[contains(@class,'final-total-payment')]");
    public static Target PROMOTION_INVOICE = Target.the("Promotion in Invoice")
            .locatedBy("//td[contains(@class,'invoice-total-promotion')]");

    public static Target D_INFO_SUB_INVOICE(String title) {
        return Target.the(title + "of sub invoice")
                .locatedBy("//dt[text()='" + title + "']/following-sibling::dd//strong");
    }

    /**
     * Receiving in checkout
     */

    public static Target ORDER_SPEC_STORE_NAME_TEXTBOX = Target.the("Order specific store name textbox")
            .locatedBy("//span[text()='Order specific store name']/parent::label/following-sibling::div//input");
    public static Target CUSTOMER_PO_TEXTBOX = Target.the("Customer PO textbox")
            .locatedBy("//span[text()='Customer PO']/parent::label/following-sibling::div//input");
    public static Target DEPARTMENT_TEXTBOX = Target.the("Customer PO textbox")
            .locatedBy("//label[text()='Department']//following-sibling::div//input");
    public static Target SPECIAL_NOTE_TEXTAREA = Target.the("Customer PO textarea")
            .locatedBy("//label[text()='Special notes']//following-sibling::div//textarea");

    /**
     * Shipping Address
     */
//    public static Target EDIT_SHIPPING_ADDRESS_BUTTON = Target.the("Edit Shipping Address button")
//            .locatedBy("((//div[@class='checkout__section-content'])[1])//button");
//    public static Target NEW_SHIPPING_ADDRESS_POPUP = Target.the("New Shipping Address popup")
//            .locatedBy("//div[contains(@class,'el-dialog')]//span[text()='New Shipping Address']");
//
//    public static Target D_TEXTBOX_NEW_SHIPPING_ADDRESS(String title) {
//        return Target.the(title + "of textbox in New Shipping Address Popup")
//                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
//    }
//
//    public static Target UPDATE_NEW_SHIPPING_ADDRESS = Target.the("Update New Shipping Address button")
//            .locatedBy("//div[contains(@class,'el-dialog')]//button/span[text()='Update']");

    /**
     * New Credit Card
     */
    public static Target NEW_CREDIT_CARD_POPUP = Target.the("New credit card popup")
            .locatedBy("//div[@role='dialog']//span[text()='New Credit Card']");

    public static Target MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP(String title) {
        return Target.the("Message error new credit card popup")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div/div[contains(text(),'This field cannot be blank')]");
    }

    public static Target TEXTBOX_NEW_CREDIT_CARD_POPUP(String title) {
        return Target.the("Message error new credit card popup")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target CARD_NUMBER_TEXTBOX = Target.the("Card number textbox")
            .locatedBy("//div[@data-back-icon-name='cvc']/following-sibling::div//input");

    public static Target EXPIRATION_TEXTBOX = Target.the("Expiration textbox")
            .locatedBy("//input[@autocomplete='cc-exp']");

    public static Target CVC_TEXTBOX = Target.the("CVC textbox")
            .locatedBy("//input[@placeholder='CVC']");

    public static Target CARD_NUMBER_FRAME = Target.the("Frame of card number")
            .locatedBy("//iframe[@title='Secure card number input frame']");

    public static Target EXPIRATION_FRAME = Target.the("Frame of card number")
            .locatedBy("//iframe[@title='Secure expiration date input frame']");

    public static Target CVC_FRAME = Target.the("Frame of cvc number")
            .locatedBy("//iframe[@title='Secure CVC input frame']");

    /**
     * Payment method
     */
    public static Target PAYMENT_NOTICE_MESSAGE = Target.the("Payment notice")
            .locatedBy("//p[@class='payment-notice']");

    /**
     * Delivery
     */
    public static Target CUT_OFF_LABEL = Target.the("Cut off label")
            .locatedBy("//strong[text()='Cutoff']");

    public static Target CUT_OFF_MESSAGE = Target.the("Cut off message")
            .locatedBy("//p[@class='cutoff-notice']/span");

    public static Target SET_DELIVERY_MESSAGE = Target.the("Set delivery day message")
            .locatedBy("//p[@class='receiving-weekdays-notice']/span");

    /**
     * Claims and Inquiry Form
     */

    public static Target CLAIM_AND_INQUIRY_LINK = Target.the("Claim and inquiry link")
            .locatedBy("//a[@href='/claim']");
}
