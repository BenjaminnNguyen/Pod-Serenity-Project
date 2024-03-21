package steps.admin.orders;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.financial.HandleVendorStatements;
import cucumber.tasks.admin.orders.HandleDropSummary;
import cucumber.tasks.admin.orders.HandleOrders;
import cucumber.tasks.admin.orders.HandleOrdersSummary;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.claims.AdminClaimsPage;
import cucumber.user_interface.admin.orders.DropSummaryPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminDropSummaryStepDefinitions {

    @And("Admin search the orders in drop summary by info")
    public void search_the_order_by_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        String idInvoice = null;
        if (infos.get(0).get("orderNumber").contains("create")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by api");
        }


        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleDropSummary.search(info)
        );
    }

    @And("Admin verify sub-invoices in drop summary")
    public void admin_verify_sub_invoices_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        String order = null;

        for (Map<String, String> info : infos) {
            order = Serenity.sessionVariableCalled("Number Order API" + info.get("index").toString());
            subInvoice = order + info.get("subInvoice");
            System.out.println("Sub invoice = " + subInvoice);

            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(DropSummaryPage.SUB_INVOICE_RESULT_SUB(subInvoice)),
                    Ensure.that(DropSummaryPage.REGION_RESULT_SUB(subInvoice)).text().contains(info.get("region")),
                    Check.whether(info.get("route").equals(""))
                            .otherwise(
                                    // verify route
                            ),
                    Ensure.that(DropSummaryPage.STORE_RESULT_SUB(subInvoice)).text().contains(info.get("store")),
                    Ensure.that(DropSummaryPage.ORDER_RESULT_SUB(subInvoice)).text().contains(order),
                    Ensure.that(DropSummaryPage.SUB_INVOICE_RESULT_SUB(subInvoice)).text().contains(info.get("subInvoice")),
                    Ensure.that(DropSummaryPage.SOS_RESULT_SUB(subInvoice)).text().contains(info.get("sos")),
                    Ensure.that(DropSummaryPage.FUEL_RESULT_SUB(subInvoice)).text().contains(info.get("fuel")),
                    Ensure.that(DropSummaryPage.TOTAL_PAYMENT_RESULT_SUB(subInvoice)).text().contains(info.get("totalPayment")),
                    Ensure.that(DropSummaryPage.TOTAL_ORDERED_RESULT_SUB(subInvoice)).text().contains(info.get("totalOrdered")),
                    Ensure.that(DropSummaryPage.VENDOR_FEE_RESULT_SUB(subInvoice)).text().contains(info.get("vendorFee")),
                    Ensure.that(DropSummaryPage.TOTAL_WEIGHT_RESULT_SUB(subInvoice)).text().contains(info.get("totalWeight")),
                    Check.whether(info.get("eta").equals(""))
                            .otherwise(
                                    Ensure.that(DropSummaryPage.ETA_RESULT_SUB(subInvoice)).text().contains(info.get("eta"))
                            )
            );
        }
    }

    @And("Admin select sub-invoices in drop summary")
    public void admin_select_sub_invoices_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        for (Map<String, String> info : infos) {
            subInvoice = Serenity.sessionVariableCalled("Number Order API" + info.get("index").toString()) + info.get("subInvoice");

            theActorInTheSpotlight().attemptsTo(
                    HandleDropSummary.selectSubInvoice(subInvoice)
            );
        }
    }

    @And("Admin verify popup create drop in drop summary")
    public void admin_verify_popup_create_drop(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.VALUE_IN_CREATE_ACTION_BAR("sub invoices selected")),
                Ensure.that(DropSummaryPage.VALUE_IN_CREATE_ACTION_BAR("sub invoices selected")).text().contains(infos.get(0).get("selected")),
                Ensure.that(DropSummaryPage.VALUE_IN_CREATE_ACTION_BAR("Total payment")).text().contains(infos.get(0).get("totalPayment")),
                Ensure.that(DropSummaryPage.VALUE_IN_CREATE_ACTION_BAR("Total ordered amount")).text().contains(infos.get(0).get("totalOrderedAmount")),
                Ensure.that(DropSummaryPage.VALUE_IN_CREATE_ACTION_BAR("Vendor service fee")).text().contains(infos.get(0).get("vendorServiceFee")),
                Ensure.that(DropSummaryPage.VALUE_IN_CREATE_ACTION_BAR("Total weight")).text().contains(infos.get(0).get("totalWeight"))
        );
    }

    @And("Admin clear selected in create drop action bar")
    public void admin_clear_selected_in_create_drop_action_bar() {
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.clearSelected()
        );
    }

    @And("Admin create drop in drop summary")
    public void admin_create_drop() {
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.createDrop()
        );
    }

    @And("Admin verify sub-invoices in create drop popup")
    public void admin_verify_sub_invoices_in_create_drop_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        String order = null;

        for (Map<String, String> info : infos) {
            order = Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString();
            subInvoice = Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString() + info.get("subInvoice");
            System.out.println("Sub invoice = " + subInvoice);

            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(DropSummaryPage.REGION_IN_CREATE_DROP_POPUP(subInvoice)),
                    Ensure.that(DropSummaryPage.REGION_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(info.get("region")),
                    Check.whether(info.get("route").equals(""))
                            .otherwise(
                                    // verify route
                            ),
                    Ensure.that(DropSummaryPage.STORE_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(info.get("store")),
                    Ensure.that(DropSummaryPage.ORDER_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(order),
                    Ensure.that(DropSummaryPage.SOS_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(info.get("sos")),
                    Ensure.that(DropSummaryPage.FUEL_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(info.get("fuel")),
                    Ensure.that(DropSummaryPage.TOTAL_PAYMENT_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(info.get("totalPayment")),
                    Ensure.that(DropSummaryPage.TOTAL_ORDERED_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(info.get("totalOrdered")),
                    Ensure.that(DropSummaryPage.VENDOR_FEE_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(info.get("vendorFee")),
                    Ensure.that(DropSummaryPage.TOTAL_WEIGHT_IN_CREATE_DROP_POPUP(subInvoice)).text().contains(info.get("totalWeight"))
            );
        }
    }

    @And("Admin verify summary in create drop popup")
    public void admin_verify_summary_in_create_drop_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.TOTAL_PAYMENT_SUMMARY_IN_POPUP(infos.get(0).get("store"))),
                Ensure.that(DropSummaryPage.TOTAL_PAYMENT_SUMMARY_IN_POPUP(infos.get(0).get("store"))).text().contains(infos.get(0).get("totalPayment")),
                Ensure.that(DropSummaryPage.TOTAL_ORDERED_SUMMARY_IN_POPUP(infos.get(0).get("store"))).text().contains(infos.get(0).get("totalOrdered")),
                Ensure.that(DropSummaryPage.VENDOR_FEE_SUMMARY_IN_POPUP(infos.get(0).get("store"))).text().contains(infos.get(0).get("vendorFee")),
                Ensure.that(DropSummaryPage.TOTAL_WEIGHT_SUMMARY_IN_POPUP(infos.get(0).get("store"))).text().contains(infos.get(0).get("totalWeight"))
        );
    }

    @And("Admin verify sos suggestions in create drop popup")
    public void admin_verify_sos_suggestions_in_create_drop_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.STORE_NAME_SOS_SUGGESTION),
                Ensure.that(DropSummaryPage.STORE_NAME_SOS_SUGGESTION).text().contains(infos.get(0).get("storeName")),
                Ensure.that(DropSummaryPage.DESCRIPTION_SOS_SUGGESTION).text().contains(infos.get(0).get("description"))
        );
    }

    @And("Admin apply sos suggestions of store in create drop popup")
    public void admin_apply_sos_suggestions_in_create_drop_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleDropSummary.applySOS(info.get("store")),
                    Check.whether(info.get("reason").equals(""))
                            .otherwise(HandleDropSummary.editReason(info.get("reason"), info.get("additionNote")))
            );
        }
    }

    @And("Admin reject sos suggestions of store {string} in create drop popup")
    public void admin_reject_sos_suggestions_in_create_drop_popup(String store) {
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.rejectSOS(store)
        );
    }

    @And("Admin edit sos surcharge in create drop popup")
    public void admin_edit_sos_surcharge_in_create_drop_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        String value = null;
        for (Map<String, String> info : infos) {
            subInvoice = Serenity.sessionVariableCalled("Number Order API" + info.get("index").toString()) + info.get("subInvoice");
            value = info.get("sosValue");
            theActorInTheSpotlight().attemptsTo(
                    HandleDropSummary.editSOS(subInvoice, value),
                    HandleDropSummary.editReason(info.get("reason"), info.get("additionNote"))
            );
        }
    }

    @And("Admin can not edit sos surcharge in create drop popup")
    public void admin_can_not_edit_sos_surcharge_in_create_drop_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        for (Map<String, String> info : infos) {
            subInvoice = Serenity.sessionVariableCalled("Number Order API" + info.get("index").toString()) + info.get("subInvoice");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isNotVisible(DropSummaryPage.SOS_IN_CREATE_DROP_POPUP1(subInvoice))
            );
        }
    }

    @And("Admin create PO in create drop popup")
    public void admin_create_po_in_create_drop_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.addPurchaseOrder(infos)
        );
    }

    @And("Admin use this info for all drops of store {string} in create drop popup")
    public void admin_copy_po_in_create_drop_popup(String store) {
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.copyPO(store)
        );
    }

    @And("Admin verify po after copy of store in create drop summary")
    public void admin_verify_po_in_create_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(DropSummaryPage.D_TEXTBOX_CREATE_PO(infos.get(0).get("store"), "Driver")).attribute("value").contains(infos.get(0).get("driver")),
                Ensure.that(DropSummaryPage.D_TEXTBOX_CREATE_PO(infos.get(0).get("store"), "Fulfillment date")).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("fulfillmentDate"), "MM/dd/yy")),
                Ensure.that(DropSummaryPage.D_TEXTBOX_CREATE_PO(infos.get(0).get("store"), "Fulfillment state")).attribute("value").contains(infos.get(0).get("fulfillmentState")),
                Ensure.that(DropSummaryPage.D_POD_NAME_CREATE_PO(infos.get(0).get("store"), infos.get(0).get("pod"))).text().contains(infos.get(0).get("pod")),
                Ensure.that(DropSummaryPage.D_TEXTBOX_CREATE_PO(infos.get(0).get("store"), "Admin note")).attribute("value").contains(infos.get(0).get("adminNote")),
                Ensure.that(DropSummaryPage.D_TEXTBOX_CREATE_PO(infos.get(0).get("store"), "LP note")).attribute("value").contains(infos.get(0).get("lpNote"))

        );


    }

    @And("Admin create drop in create drop popup")
    public void admin_create_drop_in_create_drop_popup() {
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.createDropInPopup()
        );
    }

    @And("Admin create drop with had PO in create drop popup")
    public void admin_create_drop_with_had_po_not_in_create_drop_popup() {
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.createDropHadPOInPopup()
        );
    }

    @And("Admin create drop in create drop popup then see message")
    public void admin_create_drop_then_see_message() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Some of selected sub-invoices are already associated with drops. Please refresh and start over"))
        );
    }

    @And("Admin verify drop in drop summary")
    public void admin_verify_drop_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            String poNumber = Serenity.sessionVariableCalled("Drop Number" + info.get("store"));
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(DropSummaryPage.CHECKBOX_IN_DROP_RESULT),
                    Scroll.to(DropSummaryPage.CHECKBOX_IN_DROP_RESULT),
                    Ensure.that(DropSummaryPage.SOS_IN_DROP_RESULT1(poNumber)).text().contains(info.get("sos")),
                    Ensure.that(DropSummaryPage.FUEL_IN_DROP_RESULT1(poNumber)).text().contains(info.get("fuel")),
                    Ensure.that(DropSummaryPage.TOTAL_PAYMENT_IN_DROP_RESULT1(poNumber)).text().contains(info.get("totalPayment")),
                    Ensure.that(DropSummaryPage.TOTAL_ORDERED_IN_DROP_RESULT1(poNumber)).text().contains(info.get("totalOrdered")),
                    Ensure.that(DropSummaryPage.VENDOR_FEE_IN_DROP_RESULT1(poNumber)).text().contains(info.get("vendorFee"))
            );
            if(info.containsKey("flowSpace")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(DropSummaryPage.FLOWSPACE_STATUS_IN_DROP_RESULT1(poNumber)).text().contains(info.get("sos"))
                );
            }
        }
    }

    @And("Admin verify history change sos of drop in drop summary")
    public void admin_verify_history_change_sos_of_drop_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.SOS_HELP_IN_DROP_RESULT),
                MoveMouse.to(DropSummaryPage.SOS_HELP_IN_DROP_RESULT),
                CommonWaitUntil.isVisible(DropSummaryPage.VALUE_IN_HISTORY_SOS(1))
        );
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(DropSummaryPage.VALUE_IN_HISTORY_SOS(i + 1)).text().contains(infos.get(i).get("value")),
                    Ensure.that(DropSummaryPage.UPDATED_BY_IN_HISTORY_SOS(i + 1)).text().contains(infos.get(i).get("updateBy")),
                    Ensure.that(DropSummaryPage.DATE_IN_HISTORY_SOS(i + 1)).text().contains(CommonHandle.setDate2(infos.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin go to detail drop {string} in drop summary")
    public void admin_go_to_detail_drop_in_drop_summary_with_id(String dropID) {
        if (dropID.equals("")) {
            dropID = Serenity.sessionVariableCalled("Drop ID").toString();
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.DROP_ID(dropID)),
                Click.on(DropSummaryPage.DROP_ID(dropID)).afterWaitingUntilEnabled()
        );
    }

    @And("Admin go to detail drop of store {string} in drop summary")
    public void admin_go_to_detail_drop_in_drop_summary(String store) {
        String dropID = Serenity.sessionVariableCalled("Drop Number" + store);

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.DROP_ID(dropID)),
                Click.on(DropSummaryPage.DROP_ID(dropID)).afterWaitingUntilEnabled()
        );
    }

    @And("Admin expand drop in drop summary")
    public void admin_expand_drop_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.expandDrop(infos)
        );
    }

    @And("Admin verify detail drop in drop summary")
    public void admin_verify_detail_drop_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String order = null;
        String subInvoice = null;

        for (Map<String, String> info : infos) {
            order = Serenity.sessionVariableCalled("Number Order API" + info.get("index").toString());
            subInvoice = order + info.get("subInvoice");
            System.out.println("Sub invoice = " + subInvoice);

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(DropSummaryPage.REGION_IN_DROP_RESULT(subInvoice)).text().contains(info.get("region")),
                    Check.whether(info.get("route").isEmpty())
                            .otherwise(
                                    // verify route
                            ),
                    Ensure.that(DropSummaryPage.STORE_IN_DROP_RESULT(subInvoice)).text().contains(info.get("store")),
                    Ensure.that(DropSummaryPage.ORDER_IN_DROP_RESULT(subInvoice)).text().contains(order),
                    Ensure.that(DropSummaryPage.SUB_INVOICE_IN_DROP_RESULT(subInvoice)).text().contains(info.get("subInvoice")),
                    Ensure.that(DropSummaryPage.SOS_IN_DROP_RESULT(subInvoice)).text().contains(info.get("sos")),
                    Ensure.that(DropSummaryPage.FUEL_IN_DROP_RESULT(subInvoice)).text().contains(info.get("fuel")),
                    Ensure.that(DropSummaryPage.TOTAL_PAYMENT_IN_DROP_RESULT(subInvoice)).text().contains(info.get("totalPayment")),
                    Ensure.that(DropSummaryPage.TOTAL_ORDERED_IN_DROP_RESULT(subInvoice)).text().contains(info.get("totalOrdered")),
                    Ensure.that(DropSummaryPage.VENDOR_FEE_IN_DROP_RESULT(subInvoice)).text().contains(info.get("vendorFee")),
                    Ensure.that(DropSummaryPage.TOTAL_WEIGHT_IN_DROP_RESULT(subInvoice)).text().contains(info.get("totalWeight")),
                    Check.whether(info.get("eta").isEmpty())
                            .otherwise(
                                    Ensure.that(DropSummaryPage.ETA_IN_DROP_RESULT(subInvoice)).text().contains(CommonHandle.setDate2(info.get("eta"), "MM/dd/yy"))
                            )
            );
        }
    }

    @And("Admin verify history change sos of drop detail")
    public void admin_verify_history_change_sos_of_drop_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        String order = null;

        for (int i = 0; i < infos.size(); i++) {
            order = Serenity.sessionVariableCalled("Number Order API" + infos.get(i).get("index")).toString();
            subInvoice = order + infos.get(i).get("sub");
            System.out.println("Sub invoice = " + subInvoice);

            theActorInTheSpotlight().attemptsTo(
                    MoveMouse.to(DropSummaryPage.SOS_HELP_IN_DROP_RESULT(subInvoice)),
                    WindowTask.threadSleep(1000),
                    CommonWaitUntil.isVisible(DropSummaryPage.VALUE_IN_HISTORY_SOS(1)),
                    Ensure.that(DropSummaryPage.VALUE_IN_HISTORY_SOS(1)).text().contains(infos.get(i).get("value")),
                    Check.whether(infos.get(i).get("reason").equals(""))
                            .otherwise(Ensure.that(DropSummaryPage.REASON_IN_HISTORY_SOS(1)).text().contains(infos.get(i).get("reason"))),
                    Check.whether(infos.get(i).get("note").equals(""))
                            .otherwise(Ensure.that(DropSummaryPage.NOTE_IN_HISTORY_SOS(1)).text().contains(infos.get(i).get("note"))),
                    Ensure.that(DropSummaryPage.UPDATED_BY_IN_HISTORY_SOS(1)).text().contains(infos.get(i).get("updateBy")),
                    Ensure.that(DropSummaryPage.DATE_IN_HISTORY_SOS(1)).text().contains(CommonHandle.setDate2(infos.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin go to add subinvoice to drop of store in drop detail")
    public void admin_go_to_add_subinvoice_in_drop_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        String dropID = Serenity.sessionVariableCalled("Drop Number" + infos.get(0).get("store"));
        String purchase = infos.get(0).get("purchase");

        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.goToAddSubInvoice(dropID, purchase)
        );

    }

    @And("Admin search the orders to add to drop")
    public void search_the_order_to_add_to_drop(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        String idInvoice = null;
        if (infos.get(0).get("orderNumber").contains("create")) {
            idInvoice = Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("index").toString());
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by api");
        }


        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilterInPopup(),
                CommonTaskAdmin.resetFilterInPopup(),
                HandleDropSummary.searchToAddDrop(info)
        );
    }

    @And("Admin verify sub-invoices in add to drop popup")
    public void admin_verify_sub_invoices_in_add_to_drop_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String subInvoice = null;
        String order = null;

        for (Map<String, String> info : infos) {
            order = Serenity.sessionVariableCalled("Number Order API" + info.get("index").toString());
            subInvoice = order + info.get("subInvoice");
            System.out.println("Sub invoice = " + subInvoice);

            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(DropSummaryPage.SUB_INVOICE_RESULT_SUB(subInvoice)),
                    Ensure.that(DropSummaryPage.REGION_RESULT_SUB(subInvoice)).text().contains(info.get("region")),
                    Ensure.that(DropSummaryPage.STORE_RESULT_SUB(subInvoice)).text().contains(info.get("store")),
                    Ensure.that(DropSummaryPage.ORDER_RESULT_SUB(subInvoice)).text().contains(order),
                    Ensure.that(DropSummaryPage.SUB_INVOICE_RESULT_SUB(subInvoice)).text().contains(info.get("subInvoice")),
                    Ensure.that(DropSummaryPage.SOS_RESULT_SUB(subInvoice)).text().contains(info.get("sos")),
                    Ensure.that(DropSummaryPage.FUEL_RESULT_SUB(subInvoice)).text().contains(info.get("fuel")),
                    Ensure.that(DropSummaryPage.TOTAL_PAYMENT_RESULT_SUB(subInvoice)).text().contains(info.get("totalPayment")),
                    Ensure.that(DropSummaryPage.VENDOR_FEE_RESULT_SUB(subInvoice)).text().contains(info.get("vendorFee")),
                    Ensure.that(DropSummaryPage.TOTAL_WEIGHT_RESULT_SUB(subInvoice)).text().contains(info.get("totalWeight"))
            );
        }
    }

    @And("Admin choose orders to add to drop")
    public void choose_order_to_add_to_drop(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        String idInvoice = null;
        String subInvoice = null;
        for (int i = 0; i < infos.size(); i++) {
            if (infos.get(i).get("orderNumber").contains("create")) {
                idInvoice = Serenity.sessionVariableCalled("Number Order API" + infos.get(i).get("index").toString());
            } else {
                idInvoice = infos.get(i).get("orderNumber");
            }
            subInvoice = idInvoice + infos.get(i).get("sub");

            theActorInTheSpotlight().attemptsTo(
                    HandleDropSummary.chooseOrderToAdd(subInvoice)
            );
        }
    }

    @And("Admin add order to drop success")
    public void admin_add_order_to_drop_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.addToDropSuccess()
        );
    }

    @And("Admin delete drop of store")
    public void admin_delete_drop(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.deleteDrop(infos)
        );
    }

    @And("Admin go to order from drop detail")
    public void admin_go_to_order_from_drop_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String order = Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("index")).toString();
        String subInvoice = order + infos.get(0).get("sub");

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.ORDER_IN_DROP_RESULT(subInvoice)),
                Click.on(DropSummaryPage.ORDER_IN_DROP_RESULT(subInvoice)),
                WindowTask.threadSleep(3000),
                WindowTask.switchToChildWindowsByTitle(order)
        );
    }

    @And("Admin switch back to drop")
    public void admin_switch_back_to_drop() {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.switchToChildWindowsByTitle("Drop summary")
        );
    }

    @And("Admin choose drop of store {string} in drop result")
    public void admin_choose_drop_in_drop_result(String store) {
        String dropID = Serenity.sessionVariableCalled("Drop Number" + store);

        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.chooseDrop(dropID)
        );
    }

    @And("Admin verify create purchase order in drop summary")
    public void admin_verify_create_purchase_order_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.SELECT_IN_CREATE_PO_ACTION_BAR),
                Ensure.that(DropSummaryPage.SELECT_IN_CREATE_PO_ACTION_BAR).text().contains(infos.get(0).get("selected")),
                Ensure.that(DropSummaryPage.TOTAL_PAYMENT_CREATE_PO_ACTION_BAR).text().contains(infos.get(0).get("totalPayment")),
                Ensure.that(DropSummaryPage.VENDOR_FEE_CREATE_PO_ACTION_BAR).text().contains(infos.get(0).get("vendorFee"))
        );
    }

    @And("Admin create purchase order in drop summary")
    public void admin_create_purchase_order_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleDropSummary.goToCreatePoPopup(),
                HandleOrders.addPurchaseOrder(infos.get(0)),
                HandleOrdersSummary.createPurchaseOrder("Create")

        );
    }

    @And("Admin delete subinvoice in drop")
    public void admin_delete_subinvoice_in_drop(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        String idInvoice = null;
        String subInvoice = null;
        for (int i = 0; i < infos.size(); i++) {
            if (infos.get(i).get("orderNumber").contains("create")) {
                idInvoice = Serenity.sessionVariableCalled("Number Order API" + infos.get(i).get("index").toString());
            } else {
                idInvoice = infos.get(i).get("orderNumber");
            }
            subInvoice = idInvoice + infos.get(i).get("sub");

            theActorInTheSpotlight().attemptsTo(
                    HandleDropSummary.deleteSubInDrop(subInvoice)
            );
        }
    }

    @And("Admin get number of drop in drop summary")
    public void admin_get_number_of_drop_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            // search drop theo store để lọc - expand drop để thấy store
            List<Map<String, String>> temp = new ArrayList<>();
            temp.add(info);
            theActorInTheSpotlight().attemptsTo(
                    HandleDropSummary.search(info),
                    HandleDropSummary.expandDrop(temp)
            );

            String number = Text.of(DropSummaryPage.GET_DROP_ID(info.get("store"), info.get("index"))).answeredBy(theActorInTheSpotlight()).toString();
            System.out.println("Drop Number " + info.get("store") + " = " + number);
            Serenity.setSessionVariable("Drop Number" + info.get("store")).to(number);
        }
    }

    @And("Admin verify drop not found in drop summary")
    public void admin_verify_drop_not_found(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(DropSummaryPage.GET_DROP_ID(infos.get(0).get("store"), infos.get(0).get("index")))
        );
    }

    @And("Admin verify sub invoice not found in drop of drop summary")
    public void admin_verify_sub_invoice_not_found_in_drop(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        String order = Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("index").toString());
        String subInvoice = order + infos.get(0).get("subInvoice");
        System.out.println("Sub invoice = " + subInvoice);

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(DropSummaryPage.SUB_INVOICE_RESULT_SUB(subInvoice))
        );
    }

    @And("Admin verify order not found in add to drop")
    public void admin_verify_order_not_found_in_add_to_drop() {
        // show 0 result found
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DropSummaryPage.TOTAL_RESULT_SHOW_FOUND)
        );
    }

    @And("Admin verify history of flowspace drop in drop summary")
    public void admin_verify_history_of_flowspace_drop_in_drop_summary(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(DropSummaryPage.CHECKBOX_IN_DROP_RESULT),
                    MoveMouse.to(DropSummaryPage.CHECKBOX_IN_DROP_RESULT)
//                    Ensure.that(DropSummaryPage.SOS_IN_DROP_RESULT1(poNumber)).text().contains(info.get("sos")),
            );

        }
    }

}
