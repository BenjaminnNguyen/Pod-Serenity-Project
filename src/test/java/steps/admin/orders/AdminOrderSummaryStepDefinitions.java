package steps.admin.orders;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.orders.HandleOrders;
import cucumber.tasks.admin.orders.HandleOrdersSummary;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.orders.CreateNewOrderPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.admin.orders.SummaryOrderPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class AdminOrderSummaryStepDefinitions {
    @And("Admin search the orders in summary by info")
    public void search_the_order_by_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        String idInvoice = null;
        if (infos.get(0).get("orderNumber").isEmpty()) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            idInvoice = idInvoice.substring(7);
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "");
        }
        if (infos.get(0).get("orderNumber").contains("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by admin");
        }
        if (infos.get(0).get("orderNumber").contains("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by api");
        }

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleOrdersSummary.checkByInfo(info)
        );
    }

    @And("Admin check Order summary")
    public void checkOrderSummary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        if (!list.get(0).get("routeName").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SummaryOrderPage.DYNAMIC_TARGET("route-name")),
                    Ensure.that(SummaryOrderPage.DYNAMIC_TARGET("route-name")).text().contains(list.get(0).get("routeName"))
            );
        }
        if (!list.get(0).get("status").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SummaryOrderPage.DYNAMIC_TARGET2("status-tag")),
                    Ensure.that(SummaryOrderPage.DYNAMIC_TARGET2("status-tag")).text().contains(list.get(0).get("status"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(SummaryOrderPage.DYNAMIC_TARGET("region")),
                Ensure.that(SummaryOrderPage.DYNAMIC_TARGET("region")).text().contains(list.get(0).get("region")),
                Ensure.that(SummaryOrderPage.DYNAMIC_TARGET("date")).text().contains(CommonHandle.setDate(list.get(0).get("date"), "M/d")),
                Ensure.that(SummaryOrderPage.DYNAMIC_TARGET2("store-tag store")).text().contains(list.get(0).get("store")),
                Ensure.that(SummaryOrderPage.DYNAMIC_TARGET("buyer")).text().contains(list.get(0).get("buyer")),
                Ensure.that(SummaryOrderPage.DYNAMIC_TARGET("city")).text().contains(list.get(0).get("city")),
                Ensure.that(SummaryOrderPage.DYNAMIC_TARGET("address-state")).text().contains(list.get(0).get("addressState"))
        );
        if (!list.get(0).get("fulfillmentDate").isEmpty() && !list.get(0).get("dayToFulfill").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SummaryOrderPage.FULFILLMENT_DATE), containsString(CommonHandle.setDate(list.get(0).get("fulfillmentDate"), "M/d"))),
                    seeThat(CommonQuestions.targetText(SummaryOrderPage.DAYS_TO_FULFILL), containsString(list.get(0).get("dayToFulfill")))
            );
        }
        if (list.get(0).containsKey("buyerPayment")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SummaryOrderPage.BUYER_PAYMENT).text().contains(list.get(0).get("buyerPayment"))
            );
        }
        if (!list.get(0).get("smallOrder").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SummaryOrderPage.SMALL_ORDER_SURCHARGE), equalToIgnoringCase(list.get(0).get("smallOrder")))
            );
        }
        if (list.get(0).containsKey("logistic")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SummaryOrderPage.LOGISTIC_SURCHARGE), equalToIgnoringCase(list.get(0).get("logistic")))
            );
        }
        if (list.get(0).containsKey("customerPO")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SummaryOrderPage.CUSTOMER_PO), equalToIgnoringCase(list.get(0).get("customerPO")))
            );
        }
        if (list.get(0).containsKey("notification")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SummaryOrderPage.NOTIFICATION_BADGE), equalToIgnoringCase(list.get(0).get("notification")))
            );
        }
    }

    @And("Admin check express invoice in Order summary")
    public void checkInvoiceOrderSummary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("po").equals("No")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(SummaryOrderPage.PO_ID(i + 1)),
                        Ensure.that(SummaryOrderPage.PO_ID(i + 1)).text().contains("Create PO")
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(SummaryOrderPage.PO_ID(i + 1)),
                        Ensure.that(SummaryOrderPage.PO_ID(i + 1)).text().contains(Serenity.sessionVariableCalled("Id Sub-invoice LP").toString())
                );
            if (list.get(i).containsKey("totalDelivery")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.TOTAL_DELIVERY(i + 1)).text().contains(list.get(i).get("totalDelivery")),
                        Ensure.that(SummaryOrderPage.TOTAL_PAYMENT(i + 1)).text().contains(list.get(i).get("totalPayment")),
                        Ensure.that(SummaryOrderPage.TOTAL_SERVICE(i + 1)).text().contains(list.get(i).get("totalService")),
                        Ensure.that(SummaryOrderPage.TOTAL_WEIGHT(i + 1)).text().contains(list.get(i).get("totalWeight"))
                );
            }
            if (list.get(i).containsKey("eta")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.ETA(i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("eta"), "MM/dd/yy"))
                );
            }

            if (list.get(i).containsKey("sub")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.SUB_INVOICE).text().contains(Serenity.sessionVariableCalled("ID Order").toString() + list.get(i).get("sub"))
                );
            }
            if (list.get(i).containsKey("fulfillmentStatus")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.FULFILLMENT_STATUS(i + 1)).text().contains(list.get(i).get("fulfillmentStatus"))
                );
            }
            if (list.get(i).containsKey("markFulfill")) {
                if (list.get(i).get("markFulfill").equals("Yes")) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(SummaryOrderPage.MARK_FULFILL_BUTTON(i + 1)).isDisplayed()
                    );
                } else {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(SummaryOrderPage.MARK_FULFILL_BUTTON(i + 1)).isNotDisplayed()
                    );
                }
            }
        }
    }

    @And("Admin check express invoice by subinvoice {string} in Order summary")
    public void check_express_invoice_by_subinvoice(String subInvoice, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        String orderID = null;
        if (subInvoice.equals("create by api")) {
            orderID = Serenity.sessionVariableCalled("ID Order");
        }
        for (Map<String, String> info : infos) {
            if (info.get("po").equals("No")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(SummaryOrderPage.PO_ID(orderID + info.get("index"))),
                        Ensure.that(SummaryOrderPage.PO_ID(orderID + info.get("index"))).text().contains("Create PO")
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(SummaryOrderPage.PO_ID(orderID + info.get("index"))),
                        Ensure.that(SummaryOrderPage.PO_ID(orderID + info.get("index"))).text().contains(Serenity.sessionVariableCalled("Id Sub-invoice LP").toString())
                );

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SummaryOrderPage.TOTAL_DELIVERY(orderID + info.get("index"))).text().contains(info.get("totalDelivery")),
                    Ensure.that(SummaryOrderPage.TOTAL_PAYMENT(orderID + info.get("index"))).text().contains(info.get("totalPayment")),
                    Ensure.that(SummaryOrderPage.TOTAL_SERVICE(orderID + info.get("index"))).text().contains(info.get("totalService")),
                    Ensure.that(SummaryOrderPage.TOTAL_WEIGHT(orderID + info.get("index"))).text().contains(info.get("totalWeight")),
                    Ensure.that(SummaryOrderPage.ETA(orderID + info.get("index"))).text().contains(CommonHandle.setDate2(info.get("eta"), "MM/dd/yy"))
            );
            if (info.containsKey("fulfillmentStatus")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.FULFILLMENT_STATUS(orderID + info.get("index"))).text().contains(info.get("fulfillmentStatus"))
                );
            }
        }

    }

    @And("Admin check invoice detail of order {string} in Order summary")
    public void checkItemInvoiceOfOrderInOrderSummary(String orderID, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (orderID.equals("create by api")) {
            orderID = Serenity.sessionVariableCalled("ID Order");
        }

        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.openExpandOrder(),
                    WindowTask.threadSleep(2000)
            );
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SummaryOrderPage.INVOICE_PRODUCT(orderID + item.get("sub"), item.get("sku"))).text().contains(item.get("product")),
                    Ensure.that(SummaryOrderPage.INVOICE_SKU(orderID + item.get("sub"), item.get("sku"))).text().contains(item.get("sku")),
                    Ensure.that(SummaryOrderPage.INVOICE_BRAND(orderID + item.get("sub"), item.get("sku"))).text().contains(item.get("brand")),
                    Ensure.that(SummaryOrderPage.INVOICE_TMP(orderID + item.get("sub"), item.get("sku"))).text().contains(item.get("tmp")),
                    Ensure.that(SummaryOrderPage.INVOICE_QUANTITY(orderID + item.get("sub"), item.get("sku"))).text().contains(item.get("quantity")),
                    Check.whether(item.get("delivery").equals(""))
                            .otherwise(Ensure.that(SummaryOrderPage.INVOICE_DELIVERY(orderID + item.get("sub"), item.get("sku"), item.get("delivery"))).text().contains(item.get("delivery"))),
                    Check.whether(item.get("fulfillment").equals(""))
                            .otherwise(Ensure.that(SummaryOrderPage.INVOICE_FULFILLMENT_DATE(orderID + item.get("sub"), item.get("sku"))).attribute("value").contains(CommonHandle.setDate2(item.get("fulfillment"), "M/d")))
            );
            if (item.containsKey("endQuantity") && !item.get("endQuantity").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(SummaryOrderPage.INVOICE_END_QUANTITY(orderID + item.get("sub"), item.get("sku"))), containsString(item.get("endQuantity")))
                );
            }
            if (item.containsKey("fulfilledCheck")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.INVOICE_FULFILLED_CHECKBOXED(orderID + item.get("sub"), item.get("sku"))).isDisplayed()
                );
            }
            if (item.get("warehouse").equals("Direct")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.INVOICE_QUANTITY_DIRECT(orderID + item.get("sub"), item.get("sku"))).text().contains(item.get("warehouse"))
                );
            } else if (!item.get("warehouse").equals("Direct")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.INVOICE_WAREHOUSE(orderID + item.get("sub"), item.get("sku"))).text().contains(item.get("warehouse"))
                );
            }

        }
    }

    @And("Admin check invoice detail in Order summary")
    public void checkItemInvoiceOrderSummary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.openExpandOrder(),
                    WindowTask.threadSleep(2000)
            );
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SummaryOrderPage.INVOICE_PRODUCT(i + 1)),
                    Ensure.that(SummaryOrderPage.INVOICE_PRODUCT(i + 1)).text().contains(list.get(i).get("product")),
                    Ensure.that(SummaryOrderPage.INVOICE_SKU(i + 1)).text().contains(list.get(i).get("sku")),
                    Ensure.that(SummaryOrderPage.INVOICE_BRAND(i + 1)).text().contains(list.get(i).get("brand")),
                    Ensure.that(SummaryOrderPage.INVOICE_TMP(i + 1)).text().contains(list.get(i).get("tmp")),
                    Check.whether(list.get(i).get("quantity").isEmpty())
                            .otherwise(Ensure.that(SummaryOrderPage.INVOICE_QUANTITY(i + 1)).text().contains(list.get(i).get("quantity"))),
                    Check.whether(list.get(i).get("warehouse").isEmpty())
                            .otherwise(Ensure.that(SummaryOrderPage.INVOICE_WAREHOUSE(i + 1)).text().contains(list.get(i).get("warehouse"))),
                    Check.whether(list.get(i).get("fulfillment").isEmpty())
                            .otherwise(Ensure.that(SummaryOrderPage.INVOICE_FULFILLMENT_DATE(i + 1)).attribute("value").contains(CommonHandle.setDate2(list.get(i).get("fulfillment"), "M/d - eee")))
            );
            if (list.get(i).containsKey("endQuantity") && !list.get(i).get("endQuantity").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(SummaryOrderPage.INVOICE_END_QUANTITY(i + 1)), containsString(list.get(i).get("endQuantity")))
                );
            }
            if (!list.get(i).get("delivery").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(SummaryOrderPage.INVOICE_DELIVERY(list.get(i).get("delivery"), i + 1)).isDisplayed()
                );
            }
        }
    }

    @And("Admin verify delivery detail in Order summary")
    public void admin_verify_delivey_detail_in_order_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                CommonWaitUntil.isVisible(SummaryOrderPage.DELIVERY_CHOOSE_BUTTON),
                Click.on(SummaryOrderPage.DELIVERY_CHOOSE_BUTTON),
                CommonWaitUntil.isVisible(SummaryOrderPage.CREATE_DELIVERY_POPUP),
                Ensure.that(SummaryOrderPage.DELIVERY_POPUP_TITLE).text().contains(infos.get(0).get("sku")),
                Ensure.that(SummaryOrderPage.DELIVERY_POPUP_TYPE_LABEL).text().contains(infos.get(0).get("type")),
                Ensure.that(SummaryOrderPage.DELIVERY_POPUP_COMMENT_LABEL).text().contains(infos.get(0).get("comment")),
                Click.on(SummaryOrderPage.DELIVERY_POPUP_CLOSE_BUTTON)
        );
    }

    @And("Admin verify popup export items in Order summary")
    public void admin_verify_popup_export_items(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Export items")),
                CommonWaitUntil.isVisible(SummaryOrderPage.ITEM_EXPORT_SKU(list.get(0).get("sku")))
        );
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SummaryOrderPage.ITEM_EXPORT_SKU(item.get("sku"))).isDisplayed(),
                    Ensure.that(SummaryOrderPage.ITEM_EXPORT_PRICE(item.get("sku"))).text().contains(item.get("price")),
                    Ensure.that(SummaryOrderPage.ITEM_EXPORT_QUANTITY(item.get("sku"))).text().contains(item.get("quantity")),
                    Ensure.that(SummaryOrderPage.ITEM_EXPORT_TOTAL(item.get("sku"))).text().contains(item.get("total")),
                    Ensure.that(CommonAdminForm.DYNAMIC_BUTTON("Packing slip")).isDisplayed(),
                    Ensure.that(CommonAdminForm.DYNAMIC_BUTTON("DOCX")).isDisplayed(),
                    Ensure.that(CommonAdminForm.DYNAMIC_BUTTON("PDF")).isDisplayed()
            );
        }
        // verify checkbox export poup
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(SummaryOrderPage.EXPORT_INVOICE_CHECKBOX).isDisplayed(),
                Ensure.that(SummaryOrderPage.ITEM_EXPORT_SKU_CHECKBOX(list.get(0).get("sku"))).isDisplayed(),
                Ensure.that(SummaryOrderPage.EXPORT_SELECT_ALL_CHECKBOX).isDisplayed()
        );
    }

    @And("Admin verify packing slip in export items of Order summary")
    public void admin_verify_packing_slip_export_items(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Packing slip")),
                WindowTask.switchToChildWindowsByTitle("Order — " + Serenity.setSessionVariable("ID Order")),
                // Verify
                Ensure.that(SummaryOrderPage.PACKING_SLIP_STORE).text().contains(list.get(0).get("store")),
                Ensure.that(SummaryOrderPage.PACKING_SLIP_BUYER).text().contains(list.get(0).get("buyer")),
                Ensure.that(SummaryOrderPage.PACKING_SLIP_ORDER_BUYER).text().contains(CommonHandle.setDate2(list.get(0).get("order"), "MM/dd/yy")),
                Ensure.that(SummaryOrderPage.PACKING_SLIP_ADDRESS).text().contains(list.get(0).get("address"))
        );
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SummaryOrderPage.PACKING_SLIP_BRAND(item.get("sku"))).text().contains(item.get("brand")),
                    Ensure.that(SummaryOrderPage.PACKING_SLIP_PRODUCT(item.get("sku"))).text().contains(item.get("product")),
                    Ensure.that(SummaryOrderPage.PACKING_SLIP_SKU(item.get("sku"))).text().contains(item.get("sku")),
                    Ensure.that(SummaryOrderPage.PACKING_SLIP_STORE_CONDITION(item.get("sku"))).text().contains(item.get("storageCondition")),
                    Ensure.that(SummaryOrderPage.PACKING_SLIP_UPC(item.get("sku"))).text().contains(item.get("upc")),
                    Ensure.that(SummaryOrderPage.PACKING_SLIP_CASE_UPC(item.get("sku"))).text().contains(item.get("caseUpc")),
                    Ensure.that(SummaryOrderPage.PACKING_SLIP_CASE_UNITS(item.get("sku"))).text().contains(item.get("caseUnit")),
                    Ensure.that(SummaryOrderPage.PACKING_SLIP_QUANTITY(item.get("sku"))).text().contains(item.get("quantity"))
            );
        }
    }

    @And("Admin verify popup purchase order in order summary")
    public void verify_popup_purcharse_order_in_order_summary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                // Open purchase order popup
                CommonWaitUntil.isVisible(SummaryOrderPage.PO_POPUP_BUTTON),
                Click.on(SummaryOrderPage.PO_POPUP_BUTTON),
                WindowTask.threadSleep(3000),
                CommonWaitUntil.isVisible(AllOrdersForm.D_TEXTBOX("Driver")),
                // Verify
                Ensure.that(AllOrdersForm.D_TEXTBOX1("logistics_company_id")).attribute("value").contains(list.get(0).get("driver")),
                Ensure.that(AllOrdersForm.D_TEXTBOX1("fulfillment_date")).attribute("value").contains(CommonHandle.setDate2(list.get(0).get("fulfillmentDate"), "MM/dd/yy")),
                Ensure.that(AllOrdersForm.D_TEXTBOX1("fulfillment_state")).attribute("value").contains(list.get(0).get("fulfillmentState")),
                Ensure.that(AllOrdersForm.D_TEXTBOX1("admin_note")).attribute("value").contains(list.get(0).get("adminNote")),
                Ensure.that(AllOrdersForm.D_TEXTBOX1("logistics_partner_note")).attribute("value").contains(list.get(0).get("lpNote"))
        );
        if (list.get(0).containsKey("proof")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllOrdersForm.PROOF_UPLOADED).text().contains(list.get(0).get("proof") + "_" + Serenity.sessionVariableCalled("Id Sub-invoice LP") + ".jpg")
            );
        }
        theActorInTheSpotlight().attemptsTo(
                // Close popup
                Click.on(SummaryOrderPage.PO_POPUP_BUTTON_CLOSE)
        );


    }

    @And("Admin verify note in order summary")
    public void admin_verify_note_in_order_summary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(list.get(0).get("deliveryDay").equals(""))
                        .otherwise(Ensure.that(SummaryOrderPage.POSSIBLE_DELIVERY_DAY_LABEL).text().contains(list.get(0).get("deliveryDay"))),
                Check.whether(list.get(0).get("preferredDay").equals(""))
                        .otherwise(Ensure.that(SummaryOrderPage.PREFERRED_WEEKDAY_LABEL).text().contains(list.get(0).get("preferredDay"))),
                Check.whether(list.get(0).get("receivingNote").equals(""))
                        .otherwise(Ensure.that(SummaryOrderPage.RECEIVING_NOTE_LABEL).text().contains(list.get(0).get("receivingNote"))),
                Check.whether(list.get(0).get("directReceivingNote").equals(""))
                        .otherwise(Ensure.that(SummaryOrderPage.DIRECT_RECEIVING_NOTE_LABEL).text().contains(list.get(0).get("directReceivingNote"))),
                Check.whether(list.get(0).get("adminNote").equals(""))
                        .otherwise(Ensure.that(SummaryOrderPage.ADMIN_NOTE_LABEL).attribute("value").contains(list.get(0).get("adminNote"))),
                Check.whether(list.get(0).get("buyerNote").equals(""))
                        .otherwise(Ensure.that(SummaryOrderPage.BUYER_NOTE_LABEL).text().contains(list.get(0).get("buyerNote")))
        );
    }

    @And("Admin verify popup delivery stamp in order summary")
    public void verify_popup_delivery_method_in_order_summary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                // xem popup Create Deliverable
                Click.on(SummaryOrderPage.DELIVERY_STAMP_BUTTON),
                Ensure.that(SummaryOrderPage.DELIVERABLE_TYPE).text().contains(list.get(0).get("type")),
                Ensure.that(SummaryOrderPage.DELIVERABLE_DATE).text().contains(CommonHandle.setDate2(list.get(0).get("deliveryDate"), "MM/dd/yy")),
                Ensure.that(SummaryOrderPage.DELIVERABLE_COMMENT).text().contains(list.get(0).get("comment"))
        );
        if (list.get(0).get("type").equals("Ship direct to stores")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SummaryOrderPage.DELIVERABLE_CARRIER).text().contains(list.get(0).get("carrier")),
                    Ensure.that(SummaryOrderPage.DELIVERABLE_TRACKING_NUMBER).text().contains(list.get(0).get("trackingNumber"))
            );
        }
        if (list.get(0).get("type").equals("Self deliver to store")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SummaryOrderPage.DELIVERABLE_ETA).text().contains(list.get(0).get("eta")),
                    Ensure.that(SummaryOrderPage.DELIVERABLE_PROOF).text().contains(list.get(0).get("proof"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                // close popup Create Deliverable
                Click.on(SummaryOrderPage.DELIVERABLE_CLOSE_BUTTON)
        );
    }

    @And("Admin delete delivery stamp {string} in order summary")
    public void verify_delete_delivery_method_in_order_summary(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(SummaryOrderPage.DELIVERY_STAMP_BUTTON),
                Click.on(SummaryOrderPage.DELIVERY_STAMP_BUTTON),
                HandleOrdersSummary.deleteDeliverable(type)
        );
    }

    @And("Admin verify popup shippo stamp in order summary")
    public void verify_popup_shippo_method_in_order_summary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(SummaryOrderPage.SHIPPO_STAMP_NAME).text().contains(list.get(0).get("name")),
//                Ensure.that(SummaryOrderPage.SHIPPO_STAMP_NUMBER).text().contains(list.get(0).get("number")),
                // xem popup shippo
                Click.on(SummaryOrderPage.SHIPPO_STAMP_BUTTON),
                CommonWaitUntil.isVisible(SummaryOrderPage.SHIPPO_STAMP_ADDRESS_FROM),
                Ensure.that(SummaryOrderPage.SHIPPO_STAMP_ADDRESS_FROM).text().contains(list.get(0).get("addressTo")),
                Ensure.that(SummaryOrderPage.SHIPPO_STAMP_ADDRESS_TO).text().contains(list.get(0).get("addressFrom")),
                // close popup shippo
                Click.on(SummaryOrderPage.PO_POPUP_BUTTON_CLOSE)
        );
    }

    @And("Admin expand order summary")
    public void admin_expand_order_summary() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.expandOrderSummary()
        );
    }

    @And("Admin verify no warehouse of delivery in order summary")
    public void verify_no_warehouse_of_delivery_in_order_summary() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(SummaryOrderPage.DELIVERY_CHOOSE_BUTTON),
                Click.on(SummaryOrderPage.DELIVERY_CHOOSE_BUTTON),
                CommonWaitUntil.isVisible(SummaryOrderPage.DELIVERY_POPUP),
                CommonTask.chooseItemInDropdown1(SummaryOrderPage.DELIVERY_METHOD_DROPDOWN, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Pod Consignment")),
                CommonWaitUntil.isVisible(SummaryOrderPage.DELIVERY_ALERT),
                Ensure.that(SummaryOrderPage.DELIVERY_ALERT).text().contains("There is no warehouse with sufficient inventory level to confirm this line item")
        );
    }

    @And("Admin create purchase order {string} in order summary")
    public void admin_create_purchase_order_in_order_summary(String order, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        if (order.equals("create by api")) {
            subInvoice = Serenity.sessionVariableCalled("ID Order").toString() + list.get(0).get("sub");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.goToPopupCreatePurchaseOrder(subInvoice),
                HandleOrders.addPurchaseOrder(list.get(0)),
                HandleOrdersSummary.createPurchaseOrder("Create")
        );
    }

    @And("Admin edit purchase order {string} in order summary")
    public void admin_edit_purchase_order_in_order_summary(String order, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        if (order.equals("create by api")) {
            subInvoice = Serenity.sessionVariableCalled("ID Order").toString() + list.get(0).get("sub");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.goToPopupEditPurchaseOrder(subInvoice),
                HandleOrders.addPurchaseOrder(list.get(0)),
                HandleOrdersSummary.createPurchaseOrder("Update")
        );
    }

    @And("Admin get purchase order {string} of order {string} ID in order summary")
    public void admin_get_purchase_order_ID_in_order_summary(String sub, String order) {
        String subinvoice = null;
        if (order.equals("create by api")) {
            subinvoice = Serenity.sessionVariableCalled("ID Order").toString() + sub;
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(SummaryOrderPage.PO_ID(subinvoice))
        );
        String num = SummaryOrderPage.PO_ID(subinvoice).resolveFor(theActorInTheSpotlight()).getText().toString();
        Serenity.setSessionVariable("Id Sub-invoice LP").to(num);
    }

    @And("Admin verify fulfillment date can not edit")
    public void admin_verify_fulfillment_date_can_not_edit() {
        theActorInTheSpotlight().attemptsTo(
                // Verify fulfillment Date can not delete
                MoveMouse.to(SummaryOrderPage.INVOICE_FULFILLMENT_DATE(1)),
                CommonWaitUntil.isVisible(SummaryOrderPage.INVOICE_FULFILLMENT_DATE_ICON_CLOSE(1)),
                Click.on(SummaryOrderPage.INVOICE_FULFILLMENT_DATE_ICON_CLOSE(1)),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Validation failed: Fulfillment date an fulfilled item can't be updated")),
                CommonWaitUntil.isNotVisible(
                        CommonAdminForm.D_MESSAGE_POPUP("Validation failed: Fulfillment date an fulfilled item can't be updated"))
        );
    }

    @And("Admin remove fulfillment of line item order {string} in order summary")
    public void admin_remove_fulfillment_of_line_item_in_oder_summary(String orderID, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        if (orderID.equals("create by api")) {
            orderID = Serenity.sessionVariableCalled("ID Order");
        }
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrdersSummary.removeFulfilled(orderID + item.get("sub"), item.get("sku"))
            );
        }
    }

    @And("Admin fulfill line item of order {string} in order summary")
    public void admin_fulfillment_line_item_of_order_in_oder_summary(String orderID, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        if (orderID.equals("create by api")) {
            orderID = Serenity.sessionVariableCalled("ID Order");
        }
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrdersSummary.fulfilledLineItem(orderID + item.get("sub"), item.get("sku"))
            );
        }

    }

    @And("Admin fulfill all line item of order in order summary")
    public void admin_fulfillment_all_line_item_in_oder_summary() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.fulfilledAllLineItem()
        );
    }

    @And("Admin go to add line item in order summary")
    public void admin_add_line_item_in_order_summary() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.goToEditLineItem()
        );
    }

    @And("Admin check line item non invoice in Order summary")
    public void checkLineItemNonInvoiceInOrderSummary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SummaryOrderPage.NON_INVOICE_PRODUCT(i + 1)).text().contains(list.get(i).get("product")),
                    Ensure.that(SummaryOrderPage.NON_INVOICE_SKU(i + 1)).text().contains(list.get(i).get("sku")),
                    Ensure.that(SummaryOrderPage.NON_INVOICE_BRAND(i + 1)).text().contains(list.get(i).get("brand")),
                    Ensure.that(SummaryOrderPage.NON_INVOICE_TMP(i + 1)).text().contains(list.get(i).get("tmp")),
                    Ensure.that(SummaryOrderPage.NON_INVOICE_QUANTITY(i + 1)).text().contains(list.get(i).get("quantity")),
                    Ensure.that(SummaryOrderPage.NON_INVOICE_END_QUANTITY(i + 1)).text().contains(list.get(i).get("endQuantity")),
                    Check.whether(list.get(i).get("delivery").isEmpty())
                            .otherwise(Ensure.that(SummaryOrderPage.NON_INVOICE_DELIVERY(i + 1, list.get(i).get("delivery"))).text().contains(list.get(i).get("delivery"))),
                    Ensure.that(SummaryOrderPage.NON_INVOICE_WAREHOUSE(i + 1)).text().contains(list.get(i).get("warehouse"))
            );
        }
    }

    @And("Admin edit line item in order summary")
    public void admin_update_line_items_in_order_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.editLineItemInOrderDetail(infos.get(0))
        );
    }

    @And("Admin {string} quantity line item in order summary")
    public void admin_update_line_in_order_summary(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.updateQuantityInOrderDetail(type)
        );
    }

    @And("Admin verify can not add line item {string} to order summary")
    public void add_line_item_out_of_stock(String skuName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isClickable(CreateNewOrderPage.ADD_LINE_BUTTON),
                Click.on(CreateNewOrderPage.ADD_LINE_BUTTON),
                CommonWaitUntil.isVisible(CreateNewOrderPage.POPUP_SELECT_ITEM),
                Enter.theValue(skuName).into(CreateNewOrderPage.SEARCH_ITEM),
                WindowTask.threadSleep(1000),
                Ensure.that(CreateNewOrderPage.ITEM_RESULT).isNotDisplayed(),
                Click.on(CreateNewOrderPage.POPUP_SELECT_ITEM_CLOSE_BUTTON)
        );
    }

    @And("Admin fulfill by mark as fulfilled in order summary")
    public void admin_fulfill_by_mark_as_fulfilled_in_order_summary() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.fulfillByMarkAsFulfilled()
        );
    }

    @And("Admin create {string} sub-invoice with Suffix ={string} in order summary")
    public void admin_create_sub_invoice_in_order_summary(String type, String suffix, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.chooseSkuToCreateSubInvoice(item.get("skuName"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.createSubInvoice(type, suffix)
        );
        // get ID sub-invoice
        String idSubInvoice = Text.of(SummaryOrderPage.SUB_INOVICE_IN_RESULT).answeredBy(theActorInTheSpotlight()).toString();
        System.out.println("id sub-invoice " + idSubInvoice);
        Serenity.setSessionVariable("Id Sub-Invoice").to(idSubInvoice);
    }

    @And("Admin remove line item in order detail in order summary")
    public void admin_remove_line_items_in_order_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.removeLineItemInOrderDetail(infos.get(0))
        );
    }

    @And("Admin verify search field after choose filter in order summary")
    public void admin_verify_search_field_after_choose_filter(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")).attribute("value").contains(infos.get(0).get("orderNumber")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("custom_store_name")).attribute("value").contains(infos.get(0).get("orderSpecific")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("store_ids")).text().contains(infos.get(0).get("store")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).attribute("value").contains(infos.get(0).get("buyer")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id")).attribute("value").contains(infos.get(0).get("vendorCompany")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id")).attribute("value").contains(infos.get(0).get("brand")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("product_variant_ids")).text().contains(infos.get(0).get("sku")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("upc")).attribute("value").contains(infos.get(0).get("upc")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id")).attribute("value").contains(infos.get(0).get("buyerCompany")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("fulfillment_states")).text().contains(infos.get(0).get("fulfillment")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_payment_state")).attribute("value").contains(infos.get(0).get("buyerPayment")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id")).attribute("value").contains(infos.get(0).get("region")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("route_id")).text().contains(infos.get(0).get("route")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_manager_id")).attribute("value").contains(infos.get(0).get("managed")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("lack_pod")).attribute("value").contains(infos.get(0).get("pod")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("lack_tracking")).attribute("value").contains(infos.get(0).get("tracking")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("startDate"), "MM/dd/yy")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("endDate"), "MM/dd/yy")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("temperature_name")).attribute("value").contains(infos.get(0).get("temp")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("has_out_of_stock_items")).attribute("value").contains(infos.get(0).get("oos")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("type")).attribute("value").contains(infos.get(0).get("orderType")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("express_progress")).attribute("value").contains(infos.get(0).get("exProcess")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("only_spring_po")).attribute("value").contains(infos.get(0).get("edi")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("per_page")).attribute("value").contains(infos.get(0).get("perPage"))
        );
    }

    /**
     * Export order
     */
    @And("Admin export order summary")
    public void export_order_summary() {
        String fileName = "order-details-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        Serenity.setSessionVariable("Filename Order List CSV").to(fileName);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersSummary.exportOrderSummaryCSV(fileName)
        );
    }

}
