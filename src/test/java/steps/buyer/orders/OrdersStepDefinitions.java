package steps.buyer.orders;


import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.buyer.orders.HandleOrders;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerOrderDetailPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerOrderPage;
import cucumber.user_interface.beta.Buyer.sampleRequest.BuyerSampleRequestPage;
import cucumber.user_interface.beta.DashBoardForm;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderListPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderDetailPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.Keys;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class OrdersStepDefinitions {

    @And("Verify pre-order in tag All of order just create")
    public void verify_pre_order_in_all_order_just_create(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "store", Serenity.sessionVariableCalled("Onboard Name Company"));
        theActorInTheSpotlight().attemptsTo(
                Click.on(DashBoardForm.DASHBOARD_BUTTON),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your orders..."))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerOrderPage.DATE_IN_FIRST_ORDER), containsString(CommonHandle.setDate(infos.get(0).get("date"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.TAG_PRE_IN_FIRST_ORDER), containsString(infos.get(0).get("tag"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.STORE_IN_FIRST_ORDER), containsString(info.get("store"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.CREATE_IN_FIRST_ORDER), containsString(infos.get(0).get("creator"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.TOTAL_IN_FIRST_ORDER), containsString(infos.get(0).get("total")))
        );
        String idPre = BuyerOrderPage.ID_ORDER_IN_FIRST_ORDER.resolveFor(theActorInTheSpotlight()).getTextContent().trim();
        System.out.println("idPre" + idPre);
        Serenity.setSessionVariable("ID Pre-Order").to(idPre.substring(1));
        Serenity.recordReportData().asEvidence().withTitle("ID Pre-Order")
                .andContents(idPre);
    }

    @And("Verify pre-order in tab All of order {string}")
    public void verify_pre_order_in_all_order_just_create(String number, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "store", Serenity.sessionVariableCalled("Onboard Name Company"));
        theActorInTheSpotlight().attemptsTo(
                Click.on(DashBoardForm.DASHBOARD_BUTTON),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your orders..."))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerOrderPage.DATE_IN_FIRST_ORDER(number)), containsString(CommonHandle.setDate2(infos.get(0).get("date"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.TAG_PRE_IN_FIRST_ORDER(number)), containsString(infos.get(0).get("tag"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.STORE_IN_FIRST_ORDER(number)), containsString(info.get("store"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.CREATE_IN_FIRST_ORDER(number)), containsString(infos.get(0).get("creator"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.TOTAL_IN_FIRST_ORDER(number)), containsString(infos.get(0).get("total")))
        );
        String idPre = BuyerOrderPage.ID_ORDER_IN_FIRST_ORDER(number).resolveFor(theActorInTheSpotlight()).getTextContent().trim();
        System.out.println("idPre" + idPre);
        Serenity.setSessionVariable("ID Pre-Order").to(idPre.substring(1));
        Serenity.recordReportData().asEvidence().withTitle("ID Pre-Order")
                .andContents(idPre);
    }

    @And("Buyer go to Pre-order detail number {string}")
    public void go_to_detail_pre_order(String dt) {
        Target target = BuyerOrderPage.ID_ORDER_IN_FIRST_ORDER(dt);
        if (dt.isEmpty()) {
            target = BuyerOrderPage.ID_ORDER_IN_FIRST_ORDER;
        } else if (dt.contains("create by api")) {
            target = BuyerOrderPage.ID_ORDER_IN_FIRST_ORDER(Serenity.sessionVariableCalled("ID Pre-Order").toString());
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_MESSAGE)
        );
    }

    @And("Verify pre-order in tag Pre-order of order just create")
    public void verify_pre_order_in_pre_order_just_create(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "store", Serenity.sessionVariableCalled("Onboard Name Company"));

        theActorInTheSpotlight().attemptsTo(
                Click.on(BuyerOrderPage.TAB_SCREEN("Pre-order")),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your pre-orders..."))
        );

        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerOrderPage.DATE_FIRST_ORDER_PRE), containsString(CommonHandle.setDate(infos.get(0).get("date"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.TAG_PRE_FIRST_ORDER_PRE), containsString(infos.get(0).get("tag"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.STORE_IN_FIRST_ORDER_PRE), containsString(info.get("store"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.CREATE_IN_FIRST_ORDER_PRE), containsString(infos.get(0).get("creator"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.TOTAL_IN_FIRST_ORDER_PRE), containsString(infos.get(0).get("total")))
        );
    }

    @And("Verify order record in all tab of order just create")
    public void verify_order_record_order_just_create(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(DashBoardForm.DASHBOARD_BUTTON),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your orders..."))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerOrderPage.DATE_IN_FIRST_ORDER), containsString(CommonHandle.setDate(infos.get(0).get("date"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.TAG_PRE_IN_FIRST_ORDER), containsString(infos.get(0).get("tag"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.STORE_IN_FIRST_ORDER), containsString(infos.get(0).get("store"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.CREATE_IN_FIRST_ORDER), containsString(infos.get(0).get("creator"))),
                seeThat(CommonQuestions.targetText(BuyerOrderPage.TOTAL_IN_FIRST_ORDER), containsString(infos.get(0).get("total")))
        );
    }

    @And("Search Order in tab {string} with")
    public void searchOrder(String tab, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOrderPage.TAB_SCREEN(tab)),
                Click.on(BuyerOrderPage.TAB_SCREEN(tab)),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your orders...")),
                Check.whether(!infos.get(0).get("brand").equals(""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(BuyerOrderPage.BRAND_ft, infos.get(0).get("brand"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("brand")))
                        ),
                Check.whether(!infos.get(0).get("checkoutAfter").equals(""))
                        .andIfSo(
                                Enter.theValue(CommonHandle.setDate2(infos.get(0).get("checkoutAfter"), "MM/dd/yy")).into(BuyerOrderPage.CHECKOUT_AT_ft).thenHit(Keys.ENTER)
                        ),
                Check.whether(!infos.get(0).get("checkoutBefore").equals(""))
                        .andIfSo(
                                Enter.theValue(CommonHandle.setDate2(infos.get(0).get("checkoutBefore"), "MM/dd/yy")).into(BuyerOrderPage.CHECKOUT_BF_ft).thenHit(Keys.ENTER)
                        ),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your"))
        );
    }

    @And("{word} check no order found")
    public void check_no_order(String actor) {
        String num = (Serenity.hasASessionVariableCalled("ID Invoice") ? Serenity.sessionVariableCalled("ID Invoice").toString().substring(7) : "");
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(VendorOrderListPage.NO_ORDER_FOUND)).andIfSo(
                        Ensure.that(CommonQuestions.isControlDisplay(VendorOrderListPage.NO_ORDER_FOUND)).isTrue()
                ).otherwise(
                        Ensure.that(CommonQuestions.isControlUnDisplay(VendorOrderDetailPage.NUMBER(num))).isTrue()
                )
        );
    }

    @And("Buyer verify order in result")
    public void buyer_verify_order_in_result(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        HashMap<String, String> info = null;
        String idInvoice = null;
        if (infos.get(0).get("number").equals("")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            idInvoice = idInvoice.substring(7);
            info = CommonTask.setValue(infos.get(0), "number", infos.get(0).get("orderID"), idInvoice, "");
        }
        if (infos.get(0).get("number").contains("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(infos.get(0), "number", infos.get(0).get("orderID"), idInvoice, "create by admin");
        }
        if (infos.get(0).get("number").contains("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(infos.get(0), "number", infos.get(0).get("orderID"), idInvoice, "create by api");
        }

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOrderPage.ORDERED(idInvoice)),
                Ensure.that(BuyerOrderPage.ORDERED(idInvoice)).text().contains(CommonHandle.setDate2(info.get("ordered"), "MM/dd/yy")),
//                Ensure.that(BuyerOrderPage.NUMBER(idInvoice)).text().contains(idInvoice),
                Ensure.that(BuyerOrderPage.STORE(idInvoice)).text().contains(info.get("store")),
                Ensure.that(BuyerOrderPage.CREATOR(idInvoice)).text().contains(info.get("creator")),
                Ensure.that(BuyerOrderPage.PAYMENT(idInvoice)).text().contains(info.get("payment")),
                Ensure.that(BuyerOrderPage.FULFILLMENT(idInvoice)).text().contains(info.get("fulfillment")),
                Ensure.that(BuyerOrderPage.TOTAL(idInvoice)).text().contains(info.get("total"))
        );
    }

    @And("Check information in order detail")
    public void check_information_in_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerOrderDetailPage.ORDER_BUYER_NAME).text().contains(list.get(0).get("buyerName")),
                Ensure.that(BuyerOrderDetailPage.ORDER_STORE_NAME).text().contains(list.get(0).get("storeName")),
                Ensure.that(BuyerOrderDetailPage.ORDER_SPIPPING_ADDRESS).text().containsIgnoringCase(list.get(0).get("shippingAddress")),
                Ensure.that(BuyerOrderDetailPage.ORDER_VALUE).text().contains(list.get(0).get("orderValue")),
                Ensure.that(BuyerOrderDetailPage.ORDER_TOTAL).text().contains(list.get(0).get("total")),
                Ensure.that(BuyerOrderDetailPage.ORDER_PAYMENT_INFO).text().contains(list.get(0).get("payment")),
                Ensure.that(BuyerOrderDetailPage.ORDER_PAYMENT_STATUS).text().contains(list.get(0).get("status"))
        );
        if (list.get(0).containsKey("smallOrder")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.SMALL_ORDER_SURCHAGE), equalToIgnoringCase(list.get(0).get("smallOrder")))
            );
        }
        if (list.get(0).containsKey("discount")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.DISCOUNT_VALUE), equalToIgnoringCase(list.get(0).get("discount")))
            );
        }
        if (list.get(0).containsKey("specialDiscount")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.SPECIAL_DISCOUNT_VALUE), equalToIgnoringCase(list.get(0).get("specialDiscount")))
            );
        }
        if (list.get(0).containsKey("tax")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.TAX_VALUE), equalToIgnoringCase(list.get(0).get("tax")))
            );
        }
        if (list.get(0).containsKey("orderDate")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.ORDER_DATE_FIELD), containsString(CommonHandle.setDate2(list.get(0).get("orderDate"), "MM/dd/yy")))
            );
        }
    }

    @And("Check items in order detail")
    public void check_item_in_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String skuname = list.get(i).get("skuName").equals("random") ? Serenity.sessionVariableCalled("SKU inventory") : list.get(i).get("skuName");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerOrderDetailPage.BRAND_NAME(i + 1))
            );
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.BRAND_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("brandName"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.PRODUCT_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.SKU_NAME(i + 1)), containsString(skuname)),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.CASE_PRICE(i + 1)), equalToIgnoringCase(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.QUANTITY(i + 1)), equalToIgnoringCase(list.get(i).get("quantity"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.TOTAL(i + 1)), equalToIgnoringCase(list.get(i).get("total")))
            );
            if (list.get(i).containsKey("addCart")) {
                if (list.get(i).get("addCart").contains("This product is removed or no longer available in your region.")) {
                    theActorInTheSpotlight().attemptsTo(
                            MoveMouse.to(BuyerOrderDetailPage.ADD_TO_CART_BUTTON(skuname)),
                            Ensure.that(BuyerOrderDetailPage.TOOLTIP_ADD_TO_CART(list.get(i).get("addCart"))).isDisplayed()
                    );
                }
                if (list.get(i).get("addCart").contains("Currently out of stock")) {
                    theActorInTheSpotlight().attemptsTo(
                            MoveMouse.to(BuyerOrderDetailPage.ADD_TO_CART_BUTTON(skuname)),
                            Ensure.that(BuyerOrderDetailPage.TOOLTIP_ADD_TO_CART(list.get(i).get("addCart"))).isDisplayed()
                    );
                }
                if (list.get(i).get("addCart").equals("")) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerOrderDetailPage.ADD_TO_CART_BUTTON(skuname)).attribute("class").contains(list.get(i).get("addCart"))
                    );
                }
            }
            if (list.get(i).containsKey("fulfillStatus")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.FULFILLMENTSTATUS(i + 1)), equalToIgnoringCase(list.get(i).get("fulfillStatus")))
                );
            }
            if (list.get(i).containsKey("fulfilled") && !list.get(i).get("fulfilled").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.FULFILLED(i + 1)), equalToIgnoringCase(CommonHandle.setDate(list.get(i).get("fulfilled"), "MM/dd/yy")))
                );
            }
            if (list.get(i).containsKey("unitUPC")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.UNIT_UPC(i + 1)), equalToIgnoringCase(list.get(i).get("unitUPC")))
                );
            }
            if (list.get(i).containsKey("unitEAN")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.UNIT_EAN(i + 1)), equalToIgnoringCase(list.get(i).get("unitEAN")))
                );
            }
            if (list.get(i).containsKey("priceUnit")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.PRICE_PER_UNIT(i + 1)), equalToIgnoringCase(list.get(i).get("priceUnit")))
                );
            }
            if (list.get(i).containsKey("caseUnit")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.CASE_PER_UNIT(i + 1)), equalToIgnoringCase(list.get(i).get("caseUnit")))
                );
            }
            if (list.get(i).containsKey("eta")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.ETA(i + 1)), equalToIgnoringCase(CommonHandle.setDate2(list.get(i).get("eta"), "MM/dd/yy"))));
            }
        }
    }

    @And("Buyer check sub-invoice of order {string}")
    public void checkSubInvoice(String order, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        String invoice = null;
        for (Map<String, String> info : infos) {
            if (order.equals("")) {
                invoice = Serenity.sessionVariableCalled("ID Invoice").toString();
            }
            if (order.equals("create by admin")) {
                invoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin").toString();
            }
            if (order.equals("create by buyer")) {
                invoice = Serenity.sessionVariableCalled("ID Invoice").toString();
            }
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.SUB_INVOICE_NUM(invoice + info.get("sub"))), equalToIgnoringCase(invoice + info.get("sub"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.SUB_INVOICE_PAYMENT(invoice + info.get("sub"))), equalToIgnoringCase(info.get("payment"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.SUB_INVOICE_TOTAL(invoice + info.get("sub"))), equalToIgnoringCase(info.get("total")))
            );
            if (info.containsKey("fulfillmentStatus")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.FULFILLMENT_STATUS_LINEITEM(invoice + info.get("sub"))), containsString(info.get("fulfillmentStatus")))
                );
            }
        }

    }

    @And("Buyer check confirm information")
    public void buyer_check_confirm_information(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> expect : list) {
            if (expect.containsKey("eta")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.DYNAMIC_CONFIRM("ETA")).text().contains(CommonHandle.setDate2(expect.get("eta"), "MM/dd/yy"))
                );
            }
            if (expect.containsKey("carrier")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.DYNAMIC_CONFIRM("Carrier")).text().contains(expect.get("carrier"))
                );
            }
            if (expect.containsKey("tracking")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.DYNAMIC_CONFIRM("Tracking number")).text().contains(expect.get("tracking"))
                );
            }
            if (expect.containsKey("eta2")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.DYNAMIC_CONFIRM2("ETA")).text().contains(expect.get("eta2"))
                );
            }
            if (expect.containsKey("deliveryDate")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.DELIVERY_DATE).text().contains(CommonHandle.setDate(expect.get("deliveryDate"), "MM/dd/yy"))
//                        Ensure.that(BuyerOrderDetailPage.DYNAMIC_CONFIRM("Delivery Date")).text().contains(CommonHandle.setDate(expect.get("deliveryDate"), "MM/dd/yy"))
                );
            }
            if (expect.containsKey("comment")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.DYNAMIC_CONFIRM("Comment")).text().contains(expect.get("comment"))
                );
            }
        }
    }

    @And("Add to cart sku {string} from Pre-order detail")
    public void addCartFromPreOrder(String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerSampleRequestPage.ADD_CART(sku)),
                Click.on(BuyerSampleRequestPage.ADD_CART(sku)),
                WindowTask.threadSleep(1000)
        );
    }

    @And("Check pre orders in tab")
    public void check_pre_order_in_dashboard_order(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("number").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.ORDERED(i + 1)), equalToIgnoringCase(CommonHandle.setDate(list.get(i).get("ordered"), "MM/dd/yy"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.NUMBER(i + 1)), equalToIgnoringCase(Serenity.sessionVariableCalled("ID Invoice").toString().substring(6))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.STORE(i + 1)), equalToIgnoringCase(list.get(i).get("store"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.CREATOR(i + 1)), equalToIgnoringCase(list.get(i).get("creator"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.PAYMENT(i + 1)), equalToIgnoringCase(list.get(i).get("payment"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.FULLFILLMENT(i + 1)), equalToIgnoringCase(list.get(i).get("fullfillment"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.TOTAL(i + 1)), equalToIgnoringCase(list.get(i).get("total")))
                );
            } else
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.ORDERED(i + 1)), equalToIgnoringCase(CommonHandle.setDate(list.get(i).get("ordered"), "MM/dd/yy"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.NUMBER(i + 1)), equalToIgnoringCase(list.get(i).get("number"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.STORE(i + 1)), equalToIgnoringCase(list.get(i).get("store"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.CREATOR(i + 1)), equalToIgnoringCase(list.get(i).get("creator"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.PAYMENT(i + 1)), equalToIgnoringCase(list.get(i).get("payment"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.FULLFILLMENT(i + 1)), equalToIgnoringCase(list.get(i).get("fullfillment"))),
                        seeThat(CommonQuestions.targetText(BuyerOrderPage.TOTAL(i + 1)), equalToIgnoringCase(list.get(i).get("total")))
                );
            if (list.get(i).containsKey("confirmed")) {
                theActorInTheSpotlight().should(
                        seeThat("Check have icon Confirmed ", CommonQuestions.isControlDisplay(BuyerOrderPage.CONFIRMED(i + 1)))
                );
            }
        }
    }

    @And("Buyer verify pre-order in result")
    public void verify_pre_order_in_result(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerOrderPage.DATE_FIRST_ORDER_PRE1),
                    Ensure.that(BuyerOrderPage.DATE_FIRST_ORDER_PRE1).text().contains(CommonHandle.setDate2(info.get("order"), "MM/dd/yy")),
                    Ensure.that(BuyerOrderPage.TAG_PRE_FIRST_ORDER_PRE1).text().contains(info.get("tag")),
                    Ensure.that(BuyerOrderPage.STORE_IN_FIRST_ORDER_PRE).text().contains(info.get("store")),
                    Check.whether(info.get("creator").isEmpty())
                            .otherwise(Ensure.that(BuyerOrderPage.CREATE_IN_FIRST_ORDER_PRE).text().contains(info.get("creator"))),
                    Check.whether(info.get("payment").isEmpty())
                            .otherwise(Ensure.that(BuyerOrderPage.PAYMENT_FIRST_ORDER).text().contains(info.get("payment"))),
                    Check.whether(info.get("fulfillment").isEmpty())
                            .otherwise(Ensure.that(BuyerOrderPage.FULFILLMENT_FIRST_ORDER).text().contains(info.get("fulfillment"))),
                    Ensure.that(BuyerOrderPage.TOTAL_IN_FIRST_ORDER_PRE).text().contains(info.get("total"))
            );
        }

        // get ID pre-order
        String id = Text.of(BuyerOrderPage.ID_FIRST_ORDER).answeredBy(theActorInTheSpotlight());
        Serenity.setSessionVariable("ID Pre Order").to(id);
    }

    @And("Verify no found pre-order {string} in tab result")
    public void verify_pre_order_in_result(String id) {
        if (id.equals("")) {
            id = Serenity.sessionVariableCalled("ID Pre Order");
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerOrderPage.ORDER_BY_ID(id)).isNotDisplayed()
        );
    }

    @And("Buyer verify customer info in pre-order detail")
    public void buyer_verify_info_in_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(BuyerOrderDetailPage.HIGHTLIGHT_PRE_ORDER)),
                seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.DATE_PRE_ORDER_HEADER), containsString(CommonHandle.setDate2("currentDate", "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.ORDER_BUYER_NAME), equalToIgnoringCase(list.get(0).get("buyerName"))),
                seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.ORDER_STORE_NAME), equalToIgnoringCase(list.get(0).get("storeName"))),
                seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.ORDER_BUYER_EMAIL), equalToIgnoringCase(list.get(0).get("buyerEmail"))),
                seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.ORDER_SPIPPING_ADDRESS), equalToIgnoringWhiteSpace(list.get(0).get("shippingAddress"))),
                seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.ORDER_TOTAL), equalToIgnoringCase(list.get(0).get("total")))
        );
    }

    @And("{word} back to Orders")
    public void buyer_back_to_orders(String actor) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.backToOrders()
        );
    }

    @And("Check items in pre order detail")
    public void check_item_in_pre_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String skuname = list.get(i).get("skuName").equals("random") ? Serenity.sessionVariableCalled("SKU inventory") : list.get(i).get("skuName");
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.BRAND_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("brandName"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.PRODUCT_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.SKU_NAME(i + 1)), equalToIgnoringCase(skuname)),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.CASE_PRICE_PRE(skuname)), containsString(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.QUANTITY_PRE(skuname)), containsString(list.get(i).get("quantity"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.TOTAL(i + 1)), containsString(list.get(i).get("total")))
            );
            if (list.get(i).containsKey("fulfillStatus")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.FULFILLMENTSTATUS(i + 1)), equalToIgnoringCase(list.get(i).get("fulfillStatus")))
                );
            }
            if (list.get(i).containsKey("fulfilled") && !list.get(i).get("fulfilled").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.FULFILLED(i + 1)), equalToIgnoringCase(CommonHandle.setDate(list.get(i).get("fulfilled"), "MM/dd/yy")))
                );
            }
            if (list.get(i).containsKey("unitUPC")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.UNIT_UPC(i + 1)), equalToIgnoringCase(list.get(i).get("unitUPC")))
                );
            }
            if (list.get(i).containsKey("unitEAN")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.UNIT_EAN(i + 1)), equalToIgnoringCase(list.get(i).get("unitEAN")))
                );
            }
            if (list.get(i).containsKey("priceUnit")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.PRICE_PER_UNIT(i + 1)), equalToIgnoringCase(list.get(i).get("priceUnit")))
                );
            }
            if (list.get(i).containsKey("caseUnit")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.CASE_PER_UNIT(i + 1)), equalToIgnoringCase(list.get(i).get("caseUnit")))
                );
            }
            if (list.get(i).containsKey("dateLaunchingSoon")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.LAUNCHING_SOON_DATE(i + 1)), containsString(CommonHandle.setDate2(list.get(i).get("dateLaunchingSoon"), "MM/dd/yy")))
                );
            }
            if (list.get(i).containsKey("statusTag")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerOrderDetailPage.STATUS_TAG(i + 1)), containsString(list.get(i).get("statusTag")))
                );
            }
            if (list.get(i).containsKey("addCart")) {
                if (list.get(i).get("addCart").contains("Launching soon") || list.get(i).get("addCart").contains("Currently out of stock.") || list.get(i).get("addCart").contains("Add 1 quantity to cart ")) {
                    theActorInTheSpotlight().attemptsTo(
                            MoveMouse.to(BuyerOrderDetailPage.ADD_TO_CART_BUTTON(skuname)),
                            CommonWaitUntil.isVisible(BuyerOrderDetailPage.TOOLTIP_ADD_TO_CART(list.get(i).get("addCart"))),
                            Ensure.that(BuyerOrderDetailPage.TOOLTIP_ADD_TO_CART(list.get(i).get("addCart"))).isDisplayed()
                    );
                }
            }
        }
    }

    @And("Buyer verify pre-order result in tab Pre-order")
    public void verify_pre_order_result_in_tab_pre_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerOrderPage.DATE_IN_FIRST_ORDER_PRE),
                    Ensure.that(BuyerOrderPage.DATE_IN_FIRST_ORDER_PRE).text().contains(CommonHandle.setDate2(info.get("order"), "MM/dd/yy")),
                    Ensure.that(BuyerOrderPage.TAG_FIRST_ORDER_PRE).text().contains(info.get("tag")),
                    Ensure.that(BuyerOrderPage.STORE_IN_FIRST_ORDER_PRE).text().contains(info.get("store")),
                    Ensure.that(BuyerOrderPage.CREATE_IN_FIRST_ORDER_PRE).text().contains(info.get("creator")),
                    Ensure.that(BuyerOrderPage.TOTAL_IN_FIRST_ORDER_PRE).text().contains(info.get("total"))
            );
        }

        // get ID pre-order
        String id = Text.of(BuyerOrderPage.ID_FIRST_ORDER).answeredBy(theActorInTheSpotlight());
        Serenity.setSessionVariable("ID Pre Order").to(id);
    }

    @And("Buyer check items in order detail have multi sub invoice")
    public void buyer_check_item_in_order_detail_have_multi_subinvoice(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String subInvoice = Serenity.hasASessionVariableCalled("Sub-invoice ID create by admin") ? Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + list.get(i).get("skuName") + list.get(i).get("sub")).toString() : "";
            String skuname = list.get(i).get("skuName").equals("random") ? Serenity.sessionVariableCalled("SKU inventory") : list.get(i).get("skuName");
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerOrderDetailPage.BRAND_NAME(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("brandName")),
                    Ensure.that(BuyerOrderDetailPage.PRODUCT_NAME(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("productName")),
                    Ensure.that(BuyerOrderDetailPage.SKU_NAME(subInvoice, list.get(i).get("index"))).text().contains(skuname),
                    Ensure.that(BuyerOrderDetailPage.UNIT_PER_CASE(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("unitPerCase")),
                    Ensure.that(BuyerOrderDetailPage.CASE_PRICE(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("casePrice")),
                    Ensure.that(BuyerOrderDetailPage.QUANTITY(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("quantity")),
                    Ensure.that(BuyerOrderDetailPage.TOTAL(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("total"))

            );
            if (list.get(i).containsKey("addCart")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.ADD_TO_CART_BUTTON(subInvoice, list.get(i).get("index"))).attribute("class").contains(list.get(i).get("addCart")));
            }
            if (list.get(i).containsKey("fulfillStatus")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.FULFILLMENT_STATUS(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("fulfillStatus")));
            }
            if (list.get(i).containsKey("fulfillmentDate")) {
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(list.get(i).get("fulfillmentDate").isEmpty())
                                .otherwise(
                                        Ensure.that(BuyerOrderDetailPage.FULFILLMENT_DATE(subInvoice, list.get(i).get("index"))).text().contains(CommonHandle.setDate2(list.get(i).get("fulfillmentDate"), "MM/dd/yy"))));
            }
            if (list.get(i).containsKey("unitUPC")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.UNIT_UPC(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("unitUPC")));
            }
            if (list.get(i).containsKey("unitEAN")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.UNIT_EAN(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("unitEAN")));
            }
            if (list.get(i).containsKey("priceUnit")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.PRICE_PER_UNIT(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("priceUnit")));
            }
            if (list.get(i).containsKey("caseUnit")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.CASE_PER_UNIT(subInvoice, list.get(i).get("index"))).text().contains(list.get(i).get("caseUnit")));
            }
            if (list.get(i).containsKey("eta")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderDetailPage.ETA(subInvoice, list.get(i).get("index"))).text().contains(CommonHandle.setDate2(list.get(i).get("eta"), "MM/dd/yy")));
            }
        }
    }

    @And("Buyer verify no result found in tab {string}")
    public void buyer_verify_no_result_found_in_tab(String title) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.goToTab(title),
                Ensure.that(BuyerOrderPage.NO_RESULT).isDisplayed()
        );
    }

    @And("Buyer navigate to {string} in order by sidebar")
    public void navigateTo(String page) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.goToPage(page)
        );
    }

    @And("Buyer verify no found order {string} in tab result")
    public void buyer_verify_order_in_result(String id) {
        if (id.equals("")) {
            id = Serenity.sessionVariableCalled("ID Order");
        }
        if (id.equals("create by api")) {
            id = Serenity.sessionVariableCalled("ID Order");
        }
        if (id.equals("create by admin")) {
            id = Serenity.sessionVariableCalled("ID Order");
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerOrderPage.ORDER_BY_ID(id)).isNotDisplayed()
        );
    }

    @And("Buyer search brand {string} in tab {string} then verify popup No Data")
    public void buyer_search_brand_then_verify_popup_no_data(String brand, String tab) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOrderPage.TAB_SCREEN(tab)),
                Click.on(BuyerOrderPage.TAB_SCREEN(tab)),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your orders...")),
                Enter.theValue(brand).into(BuyerOrderPage.BRAND_ft),
                CommonWaitUntil.isVisible(CommonBuyerPage.NO_DATA_DROPDOWN),
                Ensure.that(CommonBuyerPage.NO_DATA_DROPDOWN).isDisplayed(),
                Click.on(BuyerOrderPage.TAB_SCREEN(tab))
        );
    }

    @And("Buyer verify checkout {string} criteria")
    public void buyer_verify_checkout_criteria(String type) {
        Target target = BuyerOrderPage.CHECKOUT_AT_ft;
        if (type.equals("before")) {
            target = BuyerOrderPage.CHECKOUT_BF_ft;
        }
        // Verify default checkout datetimepicker
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(500),
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                CommonWaitUntil.isVisible(BuyerOrderPage.AVAILABLE_TODAY_DATE_TIME_PICKER),
                Ensure.that(BuyerOrderPage.AVAILABLE_TODAY_DATE_TIME_PICKER).isDisplayed(),
                Ensure.that(BuyerOrderPage.PREVIOUS_MONTH_BUTTON).isDisplayed(),
                Ensure.that(BuyerOrderPage.PREVIOUS_YEAR_BUTTON).isDisplayed(),
                Ensure.that(BuyerOrderPage.NEXT_MONTH_BUTTON).isDisplayed(),
                Ensure.that(BuyerOrderPage.NEXT_YEAR_BUTTON).isDisplayed()
        );
        // Verify button previous month
        LocalDate currentDate = LocalDate.now();
        theActorInTheSpotlight().attemptsTo(
                Click.on(BuyerOrderPage.PREVIOUS_MONTH_BUTTON),
                Ensure.that(BuyerOrderPage.MONTH_LABEL).text().isEqualToIgnoringCase(String.valueOf(currentDate.getMonth().minus(1))),
                Click.on(BuyerOrderPage.ORDERED_HEADER)
        );
        // Verify button next month
        currentDate = LocalDate.now();
        theActorInTheSpotlight().attemptsTo(
                Click.on(target),
                Click.on(BuyerOrderPage.NEXT_MONTH_BUTTON),
                Ensure.that(BuyerOrderPage.MONTH_LABEL).text().isEqualToIgnoringCase(String.valueOf(currentDate.getMonth().plus(1))),
                Click.on(BuyerOrderPage.ORDERED_HEADER)
        );
        // Verify button previous year
        currentDate = LocalDate.now();
        theActorInTheSpotlight().attemptsTo(
                Click.on(target),
                Click.on(BuyerOrderPage.PREVIOUS_YEAR_BUTTON),
                WindowTask.threadSleep(500),
                Ensure.that(BuyerOrderPage.YEAR_LABEL).text().isEqualToIgnoringCase("2022"),
                Click.on(BuyerOrderPage.ORDERED_HEADER)
        );
        // Verify button next year
        currentDate = LocalDate.now();
        theActorInTheSpotlight().attemptsTo(
                Click.on(target),
                Click.on(BuyerOrderPage.NEXT_YEAR_BUTTON),
                WindowTask.threadSleep(500),
                Ensure.that(BuyerOrderPage.YEAR_LABEL).text().isEqualToIgnoringCase("2024"),
                Click.on(BuyerOrderPage.ORDERED_HEADER)
        );
    }

    @And("Buyer redirection when click in line item")
    public void buyer_redirection_when_click_in_line_item() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(BuyerOrderDetailPage.PRODUCT_NAME(1))
        );
    }

    @And("Buyer add to cart of sku {string} in order detail")
    public void buyer_add_to_cart_of_sku_in_order_detail(String skuName) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(BuyerOrderDetailPage.ADD_TO_CART_BUTTON(skuName)),
                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP("Item added to cart!")),
                Click.on(CommonBuyerPage.ICON_CIRCLE_DELETE)
        );
    }

}
