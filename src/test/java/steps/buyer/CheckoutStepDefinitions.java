package steps.buyer;

import cucumber.actions.Refesh;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.buyer.CheckoutCart;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.Utility;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Buyer.cart.CheckoutPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.JavaScript;
import net.serenitybdd.screenplay.questions.Text;
import net.serenitybdd.screenplay.targets.Target;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cucumber.singleton.GVs.URL_BETA;
import static cucumber.singleton.GVs.URL_LP;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.*;
import static org.hamcrest.CoreMatchers.containsString;

public class CheckoutStepDefinitions {
    @And("Check out cart {string} and {string} Invoice")
    public void check_out(String typePayment, String see, DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.checkOut(),
                CheckoutCart.placeOrder(typePayment)
        );
        Serenity.setSessionVariable("orderDate").to(Utility.getTimeNow("E, dd MMM yyyy, hh:mma"));
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.viewOrder()
        );
        // lấy mã ID Invoice từ order details
        String id = Text.of(CheckoutPage.ID_INVOICE).answeredBy(theActorInTheSpotlight());
        System.out.println("ID = " + id);
        Serenity.setSessionVariable("ID Invoice").to(id);
        // in ID ra report
//        Serenity.recordReportData().asEvidence().withTitle("ID Invoice").andContents(id);

        if (list.get(0).get("smallOrderSurchage").isEmpty() && list.get(0).get("logisticsSurchage").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(CheckoutPage.TOTAL_ORDER), containsString(list.get(0).get("total")))
            );
        } else
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(list.get(0).get("smallOrderSurchage").equals(""))
                            .andIfSo(Ensure.that(CheckoutPage.CART_SOS_ORDER).isNotDisplayed())
                            .otherwise(Ensure.that(CheckoutPage.CART_SOS_ORDER).text().contains(list.get(0).get("smallOrderSurchage"))),
                    Check.whether(list.get(0).get("logisticsSurchage").equals(""))
                            .andIfSo(Ensure.that(CheckoutPage.CART_LS_ORDER).isNotDisplayed())
                            .otherwise(Ensure.that(CheckoutPage.CART_LS_ORDER).text().contains(list.get(0).get("logisticsSurchage"))),
                    Check.whether(list.get(0).get("tax").equals(""))
                            .andIfSo(Ensure.that(CheckoutPage.CART_TAX_ORDER).isNotDisplayed())
                            .otherwise(Ensure.that(CheckoutPage.CART_TAX_ORDER).text().contains(list.get(0).get("tax"))),
                    Check.whether(list.get(0).get("total").equals(""))
                            .andIfSo(Ensure.that(CheckoutPage.TOTAL_ORDER).isNotDisplayed())
                            .otherwise(Ensure.that(CheckoutPage.TOTAL_ORDER).text().contains(list.get(0).get("total")))
            );
        theActorInTheSpotlight().attemptsTo(
                Check.whether(see.equals("see"))
                        .andIfSo(CheckoutCart.viewInvoice())
        );
    }

    @And("Verify price in cart Invoice")
    public void verify_price_in_cart_before(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(list.get(0).get("smallOrderSurchage").equals(""))
                        .andIfSo(Ensure.that(CheckoutPage.CART_SOS_INVOICE).isNotDisplayed())
                        .otherwise(Ensure.that(CheckoutPage.CART_SOS_INVOICE).text().contains(list.get(0).get("smallOrderSurchage"))),
                Check.whether(list.get(0).get("logisticsSurchage").equals(""))
                        .andIfSo(Ensure.that(CheckoutPage.CART_LS_INVOICE).isNotDisplayed())
                        .otherwise(Ensure.that(CheckoutPage.CART_LS_INVOICE).text().contains(list.get(0).get("logisticsSurchage"))),
                Check.whether(list.get(0).get("botteDeposit").equals(""))
//                        .andIfSo(Ensure.that(CheckoutPage.CART_TAX_INVOICE).isNotDisplayed())
                        .otherwise(Ensure.that(CheckoutPage.CART_TAX_INVOICE).text().contains(list.get(0).get("botteDeposit"))),
                Check.whether(list.get(0).get("total").equals(""))
                        .andIfSo(Ensure.that(CheckoutPage.TOTAL_INVOICE).isNotDisplayed())
                        .otherwise(Ensure.that(CheckoutPage.TOTAL_INVOICE).text().contains(list.get(0).get("total")))
        );
    }

    @And("{word} verify sub-invoice is created")
    public void verify_sub_invoice_is_created(String actor) {
        theActorCalled(actor).attemptsTo(
                CheckoutCart.viewInvoice()
        );
    }

    @And("Buyer view cart")
    public void buyer_view_cart() {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.viewCart()
        );
    }

    @And("Buyer check out cart")
    public void check_out_cart() {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.checkOut()
        );
    }

    @And("Buyer close popup")
    public void closePopUp() {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.closePopup()
        );
    }

    @And("Buyer place order cart {string}")
    public void buyer_place_order_cart(String typePayment) {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.placeOrder(typePayment)
        );
    }

    @And("Buyer view order after place order")
    public void buyer_view_order() {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.viewOrder()
        );
        // lấy mã ID Invoice từ order details
        Serenity.setSessionVariable("ID Invoice").to(Text.of(CheckoutPage.ID_INVOICE).answeredBy(theActorInTheSpotlight()));
        Serenity.setSessionVariable("ID Order Buyer").to(CommonHandle.getCurrentURL().split("orders/")[1]);
    }

    @And("Buyer view order after place order of sku has not inventory")
    public void buyer_view_order_not_inventory() {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.viewOrderNoInventory()
        );
    }

    @And("See invoice")
    public void see_invoice() {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.viewInvoice()
        );
    }

    @And("Buyer verify invoice {string}")
    public void buyer_verify_invoice_message(String message) {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.viewNoInvoice()
        );
    }

    @And("Buyer verify info in Invoice {string}")
    public void buyer_verify_info_in_invoice(String type, DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        if (type.equals("")) {
            type = Serenity.sessionVariableCalled("ID Invoice");
            type = type.substring(7);
        }
        if (type.contains("create by api")) {
            type = Serenity.sessionVariableCalled("ID Invoice");
        }
        if (type.contains("create by admin")) {
            type = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CheckoutPage.D_INFO_SUB_INVOICE("Order Date")).text().contains(CommonHandle.setDate2(expected.get(0).get("orderDate"), "MM/dd/yy")),
                Ensure.that(CheckoutPage.D_INFO_SUB_INVOICE("Invoice Number")).text().contains(type),
                Check.whether(expected.get(0).get("customerPO").equals(""))
                        .otherwise(Ensure.that(CheckoutPage.D_INFO_SUB_INVOICE("Customer PO")).text().contains(expected.get(0).get("customerPO"))),
                Check.whether(expected.get(0).get("deliveryDate").equals(""))
                        .otherwise(Ensure.that(CheckoutPage.D_INFO_SUB_INVOICE("Delivery Date")).text().contains(expected.get(0).get("deliveryDate"))),
                Check.whether(expected.get(0).get("department").equals(""))
                        .otherwise(Ensure.that(CheckoutPage.D_INFO_SUB_INVOICE("Department")).text().contains(expected.get(0).get("department"))),
                Check.whether(expected.get(0).get("deliverTo").equals(""))
                        .otherwise(Ensure.that(CheckoutPage.D_INFO_SUB_INVOICE("Deliver to")).text().contains(expected.get(0).get("deliverTo"))),
                Check.whether(expected.get(0).get("paymentMethod").equals(""))
                        .otherwise(Ensure.that(CheckoutPage.D_INFO_SUB_INVOICE("Payment Method")).text().contains(expected.get(0).get("paymentMethod")))
        );

    }

    @And("Buyer switch to parent page from invoice")
    public void buyer_close_sub_invoice() {
        theActorInTheSpotlight().attemptsTo(
                // Switch lại parent
                WindowTask.closeCurrentAndSwitchParentWindowByURL(URL_BETA + "buyers/orders", "invoices/buyers/orders")
        );
    }

    @And("Buyer check out cart {string} with receiving info")
    public void buyer_check_out_cart(String typePayment, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.checkOutWithInfoReceiving(typePayment, list.get(0))
        );
        Serenity.setSessionVariable("orderDate").to(Utility.getTimeNow("E, dd MMM yyyy, hh:mma"));
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.viewOrder()
        );
        // lấy mã ID Invoice từ order details
        String id = Text.of(CheckoutPage.ID_INVOICE).answeredBy(theActorInTheSpotlight());
        Serenity.setSessionVariable("ID Invoice").to(id);
        // in ID ra report
//        Serenity.recordReportData().asEvidence().withTitle("ID Invoice").andContents(id);
    }

//    @And("Buyer open new shipping address popup")
//    public void buyer_open_new_shipping_address() {
//        theActorInTheSpotlight().attemptsTo(
//                CheckoutCart.goToShippingAddress()
//        );
//    }

//    @And("Buyer edit shipping address")
//    public void buyer_edit_shipping_address(DataTable dt) {
//        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
//        theActorInTheSpotlight().attemptsTo(
//                CheckoutCart.editShippingAddress(infos.get(0)),
//                CheckoutCart.updateShippingAddressSuccess()
//        );
//    }

//    @And("Buyer verify info default of new shipping address popup")
//    public void buyer_verify_info_default_of_new_shipping_address(DataTable dt) {
//        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
//        theActorInTheSpotlight().attemptsTo(
//                Ensure.that(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Name")).attribute("value").contains(infos.get(0).get("name")),
//                Ensure.that(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Street")).attribute("value").contains(infos.get(0).get("street")),
//                Ensure.that(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("City")).attribute("value").contains(infos.get(0).get("city")),
//                Ensure.that(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("State")).attribute("value").contains(infos.get(0).get("state")),
//                Ensure.that(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Zip code")).attribute("value").contains(infos.get(0).get("zip")),
//                Ensure.that(CheckoutPage.D_TEXTBOX_NEW_SHIPPING_ADDRESS("Phone number")).attribute("value").contains(infos.get(0).get("phone"))
//        );
//    }

    @And("Buyer verify popup New Credit Cart in Place Order page")
    public void buyer_verify_popup_new_credit_cart_in_place_order_page() {
        theActorInTheSpotlight().attemptsTo(
                CommonTask.chooseItemInDropdown3(CheckoutPage.PAYMENT_METHOD_DROPDOWN, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3("Pay via credit card")),
                CommonWaitUntil.isVisible(CheckoutPage.NEW_CREDIT_CARD_POPUP),
                Ensure.that(CheckoutPage.NEW_CREDIT_CARD_POPUP).isDisplayed()
        );
    }

    @And("Buyer verify default of payment method in Place Order page is {string}")
    public void buyer_verify_default_of_payment_method_in_place_order_page(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CheckoutPage.PAYMENT_METHOD_DROPDOWN),
                Ensure.that(CheckoutPage.PAYMENT_NOTICE_MESSAGE).text().contains(message)
        );
    }

    @And("Buyer verify field empty of popup New Credit Cart in Place Order page")
    public void buyer_verify_field_empty_of_popup_new_credit_cart_in_place_order_page() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                WindowTask.threadSleep(1000),
                Ensure.that(CheckoutPage.MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP("Name on card")).text().contains("This field cannot be blank"),
                Ensure.that(CheckoutPage.MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP("Address line 1")).text().contains("This field cannot be blank"),
                Ensure.that(CheckoutPage.MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP("Card number")).text().contains("This field cannot be blank"),
                Ensure.that(CheckoutPage.MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP("Expiration date")).text().contains("This field cannot be blank"),
                Ensure.that(CheckoutPage.MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP("City")).text().contains("This field cannot be blank"),
                Ensure.that(CheckoutPage.MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP("CVC")).text().contains("This field cannot be blank"),
                Ensure.that(CheckoutPage.MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP("State")).text().contains("This field cannot be blank"),
                Ensure.that(CheckoutPage.MESSAGE_ERROR_NEW_CREDIT_CARD_POPUP("Zip")).text().contains("This field cannot be blank")
        );
    }

    @And("Buyer create New Credit Cart")
    public void buyer_create_new_credit_cart(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.createNewCreditCard(infos.get(0))
        );
    }

    @And("Buyer create New Credit Cart success")
    public void buyer_create_new_credit_cart_success() {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.createNewCreditCardSuccess()
        );
    }

    @And("Buyer verify delivery in Check out page")
    public void buyer_verify_delivery_in_place_order_page(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CheckoutPage.SET_DELIVERY_MESSAGE),
                Check.whether(expected.get(0).get("cutoffMessage").equals(""))
                        .otherwise(Ensure.that(CheckoutPage.CUT_OFF_LABEL).text().contains("Cutoff"),
                                Ensure.that(CheckoutPage.CUT_OFF_MESSAGE).text().contains(expected.get(0).get("cutoffMessage"))),
                Ensure.that(CheckoutPage.SET_DELIVERY_MESSAGE).text().contains(expected.get(0).get("setDeliveryDay"))
        );
    }

    @And("Buyer go to Claims and Inquiry Form in Checkout page")
    public void buyer_go_to_claim_and_inquiry_form_in_checkout_page() {
        theActorInTheSpotlight().attemptsTo(
                CheckoutCart.goToClaimAndInquiryPage()
        );
    }

    @And("Buyer verify popup thank you for order")
    public void buyer_verify_popup_thank_you_for_order() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CheckoutPage.VIEW_ORDER),
                Ensure.that(CheckoutPage.TITLE_POPUP_THANKYOU_ORDER).isDisplayed(),
                Ensure.that(CheckoutPage.CONTINUE_SHOPPING).isDisplayed(),
                Ensure.that(CheckoutPage.DESCRIPTION_POPUP_THANKYOU_ORDER).text().contains("For order additions, please place a new order. Estimated delivery times can be found in your dashboard.")
        );
    }

    @And("Buyer verify message place order fail {string}")
    public void buyer_verify_message_place_order_fail(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_ANY_TEXT(message)),
                Ensure.that(CommonBuyerPage.DYNAMIC_ANY_TEXT(message)).isDisplayed()
        );
    }

    @And("Buyer verify place order is disable")
    public void buyer_verify_place_order_button_is_disalbe() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CheckoutPage.PLACEORDER_BUTTON_DISABLE),
                Ensure.that(CheckoutPage.PLACEORDER_BUTTON_DISABLE).isDisplayed()
        );
    }
}
