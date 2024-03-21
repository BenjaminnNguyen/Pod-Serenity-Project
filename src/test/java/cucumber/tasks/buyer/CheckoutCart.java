package cucumber.tasks.buyer;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.SwitchToFrame;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Buyer.cart.CartPage;
import cucumber.user_interface.beta.Buyer.cart.CheckoutPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.User_Header;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.targets.Target;
import net.serenitybdd.screenplay.ui.Link;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.awt.*;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class CheckoutCart {

    public static Task viewCart() {
        return Task.where("View Cart",
                Click.on(HomePageForm.VIEW_CART_BUTTON),
                CommonWaitUntil.isVisible(CartPage.CHECKOUT_BUTTON)
        );
    }

    public static Task checkOut() {
        return Task.where("Check out",
                CommonWaitUntil.isVisible(CheckoutPage.CHECKOUT_BUTTON),
                // Wait recommment sos popup
                Check.whether(valueOf(HomePageForm.CLOSE_POPUP_ADD_TO_CART), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.CLOSE_POPUP_ADD_TO_CART).afterWaitingUntilEnabled()),
                Click.on(CheckoutPage.CHECKOUT_BUTTON),
                WindowTask.threadSleep(500)
        );
    }

    public static Task closePopup() {
        return Task.where("Check out",
                Check.whether(CommonQuestions.isControlDisplay(CommonBuyerPage.CLOSE_POPUP_BTN)).andIfSo(
                        Click.on(CommonBuyerPage.CLOSE_POPUP_BTN)
                )

        );
    }

    public static Task placeOrder(String typePayment) {
        return Task.where("Place Order",
                CommonWaitUntil.isClickable(CheckoutPage.PAYMENT_METHOD_DROPDOWN),
                CommonTask.chooseItemInDropdown1(CheckoutPage.PAYMENT_METHOD_DROPDOWN, CheckoutPage.PAYMENT_METHOD_ITEM(typePayment)),
                CommonWaitUntil.isClickable(CheckoutPage.PLACEORDER_BUTTON),
                Click.on(CheckoutPage.PLACEORDER_BUTTON)
        );
    }

    public static Task viewOrder() {
        return Task.where("View order after checkout",
                CommonWaitUntil.isVisible(CheckoutPage.VIEW_ORDER),
                Click.on(CheckoutPage.VIEW_ORDER),
                CommonWaitUntil.isVisible(CheckoutPage.ID_INVOICE)
        );
    }

    public static Task viewOrderNoInventory() {
        return Task.where("View order after checkout with sku has not inventory",
                CommonWaitUntil.isVisible(CheckoutPage.VIEW_ORDER),
                Click.on(CheckoutPage.VIEW_ORDER),
                CommonWaitUntil.isVisible(CheckoutPage.UH_OH_LABEL)
        );
    }

    public static Task viewInvoice() {
        return Task.where("View invoice from order",
                CommonWaitUntil.isVisible(CheckoutPage.ID_INVOICE),
                Click.on(CheckoutPage.INVOICE_BUTTON),
                CommonWaitUntil.isVisible(CheckoutPage.SUB_INVOICE_BUTTON),
                Click.on(CheckoutPage.SUB_INVOICE_BUTTON),
                WindowTask.threadSleep(5000),
                WindowTask.switchToChildWindowsByTitle("Sub invoice #"),
                CommonWaitUntil.isVisible(CheckoutPage.TOTAL_INVOICE)
        );
    }

    public static Task viewNoInvoice() {
        return Task.where("View no invoice from order with PD item",
                CommonWaitUntil.isVisible(CheckoutPage.ID_INVOICE),
                Click.on(CheckoutPage.INVOICE_BUTTON),
                CommonWaitUntil.isVisible(CheckoutPage.NO_INVOICE_BUTTON)
        );
    }

    public static Task checkOutWithInfoReceiving(String paymentType, Map<String, String> info) {
        return Task.where("Check out with fill info receiving",
                CommonWaitUntil.isVisible(CheckoutPage.CHECKOUT_BUTTON),
                Click.on(CheckoutPage.CHECKOUT_BUTTON),
                WindowTask.threadSleep(500),
                Check.whether(info.get("customStore").equals(""))
                        .otherwise(Enter.theValue(info.get("customStore")).into(CheckoutPage.ORDER_SPEC_STORE_NAME_TEXTBOX)),
                Check.whether(info.get("customerPO").equals(""))
                        .otherwise(Enter.theValue(info.get("customerPO")).into(CheckoutPage.CUSTOMER_PO_TEXTBOX)),
                Check.whether(info.get("department").equals(""))
                        .otherwise(Enter.theValue(info.get("department")).into(CheckoutPage.DEPARTMENT_TEXTBOX)),
                Check.whether(info.get("specialNote").equals(""))
                        .otherwise(Enter.theValue(info.get("specialNote")).into(CheckoutPage.SPECIAL_NOTE_TEXTAREA)),
                CommonWaitUntil.isClickable(CheckoutPage.PLACEORDER_BUTTON),
                CommonTask.chooseItemInDropdown1(CheckoutPage.PAYMENT_METHOD_DROPDOWN, CheckoutPage.PAYMENT_METHOD_ITEM(paymentType)),
                Click.on(CheckoutPage.PLACEORDER_BUTTON)
        );
    }

//    public static Task goToShippingAddress() {
//        return Task.where("Go to shipping address",
//                CommonWaitUntil.isVisible(CheckoutPage.EDIT_SHIPPING_ADDRESS_BUTTON),
//                Click.on(CheckoutPage.EDIT_SHIPPING_ADDRESS_BUTTON),
//                // Wait New Shipping Address popup
//                CommonWaitUntil.isVisible(CheckoutPage.NEW_SHIPPING_ADDRESS_POPUP)
//        );
//    }

//    public static Task editShippingAddress(Map<String, String> info) {
//        return Task.where("Edit shipping address",
//                Check.whether(info.get("name").equals(""))
//                        .otherwise(Enter.theValue(info.get("name")).into(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Name"))),
//                Check.whether(info.get("street").equals(""))
//                        .otherwise(Enter.theValue(info.get("street")).into(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Street"))),
//                Check.whether(info.get("apt").equals(""))
//                        .otherwise(Enter.theValue(info.get("apt")).into(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Apt, Suite, etc."))),
//                Check.whether(info.get("attn").equals(""))
//                        .otherwise(Enter.theValue(info.get("attn")).into(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Attn"))),
//                Check.whether(info.get("city").equals(""))
//                        .otherwise(Enter.theValue(info.get("city")).into(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("City"))),
//                Check.whether(info.get("state").equals(""))
//                        .otherwise(
//                                CommonTask.chooseItemInDropdown2(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("State"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("state")))
//                        ),
//                Check.whether(info.get("zip").equals(""))
//                        .otherwise(Enter.theValue(info.get("zip")).into(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Zip code"))),
//                Check.whether(info.get("phone").equals(""))
//                        .otherwise(Enter.theValue(info.get("phone")).into(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Phone number")))
//        );
//    }

//    public static Task updateShippingAddressSuccess() {
//        return Task.where("Update New Shipping Address success",
//                Click.on(CheckoutPage.UPDATE_NEW_SHIPPING_ADDRESS),
//                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
//                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP("Shipping address is successfully updated.")),
//                Click.on(CommonBuyerPage.ICON_CIRCLE_DELETE)
//        );
//    }

    public static Task createNewCreditCard(Map<String, String> info) {
        return Task.where("Create new credit card",
                CommonWaitUntil.isVisible(CheckoutPage.TEXTBOX_NEW_CREDIT_CARD_POPUP("Name on card")),
                Enter.theValue(info.get("name")).into(CheckoutPage.TEXTBOX_NEW_CREDIT_CARD_POPUP("Name on card")),
                Enter.theValue(info.get("address")).into(CheckoutPage.TEXTBOX_NEW_CREDIT_CARD_POPUP("Address line 1")),
                SwitchToFrame.withTarget(CheckoutPage.CARD_NUMBER_FRAME),
                Enter.keyValues(info.get("card")).into(CheckoutPage.CARD_NUMBER_TEXTBOX),
                Switch.toParentFrame(),
                SwitchToFrame.withTarget(CheckoutPage.EXPIRATION_FRAME),
                Enter.theValue(info.get("expiryDate")).into(CheckoutPage.EXPIRATION_TEXTBOX),
                Switch.toParentFrame(),
                Enter.theValue(info.get("city")).into(CheckoutPage.TEXTBOX_NEW_CREDIT_CARD_POPUP("City")),
                SwitchToFrame.withTarget(CheckoutPage.CVC_FRAME),
                Enter.theValue(info.get("cvc")).into(CheckoutPage.CVC_TEXTBOX),
                Switch.toParentFrame(),
                CommonTask.chooseItemInDropdown3(CheckoutPage.TEXTBOX_NEW_CREDIT_CARD_POPUP("State"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("state"))),
                Enter.theValue(info.get("zip")).into(CheckoutPage.TEXTBOX_NEW_CREDIT_CARD_POPUP("Zip"))
        );
    }

    public static Task createNewCreditCardSuccess() {
        return Task.where("Create new credit card success",
                CommonWaitUntil.isClickable(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_MESSAGE),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.D_MESSAGE_POPUP("Updated successfully."))
        );
    }

    public static Task goToClaimAndInquiryPage() {
        return Task.where("Go to claim and inquiry page",
                CommonWaitUntil.isClickable(CheckoutPage.CLAIM_AND_INQUIRY_LINK),
                Click.on(CheckoutPage.CLAIM_AND_INQUIRY_LINK),
                WindowTask.switchToChildWindowsByTitle("Claims & Inquiry Form - Pod Foods | Online Distribution Platform for Emerging Brands"),
                Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.I_ACCEPT),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                Click.on(HomePageForm.CLOSE_POPUP),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        )
        );
    }
}
