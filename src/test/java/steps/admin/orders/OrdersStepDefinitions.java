package steps.admin.orders;

import cucumber.actions.GoBack;
import cucumber.constants.admin.AdminConstant;
import cucumber.tasks.admin.vendors.HandleVendorCompanies;
import cucumber.tasks.common.*;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import cucumber.user_interface.beta.TermServiceBrand;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.orders.HandleOrders;
import cucumber.tasks.api.CommonHandle;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.*;
import cucumber.user_interface.admin.setting.SettingAdminForm;
import cucumber.user_interface.admin.store.AllStoresPage;
import cucumber.user_interface.beta.Buyer.cart.CheckoutPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import net.serenitybdd.screenplay.targets.Target;
import org.json.JSONObject;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class OrdersStepDefinitions {

    OrderDetailPage orderDetailPage = new OrderDetailPage();

    @And("Search the orders by info then system show result")
    public void search_the_order() {
        String idInvoice = Serenity.sessionVariableCalled("ID Invoice");
        // lấy ID để search Orders
        idInvoice = idInvoice.substring(idInvoice.lastIndexOf("#") + 1).trim();
//        idInvoice = idInvoice.length() > 9 ? idInvoice.substring(7) : idInvoice;
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                HandleOrders.check(idInvoice),
                HandleOrders.seeDetail(idInvoice)
        );
    }

    @And("Admin search the orders {string}")
    public void search_the_order_by_ID(String id) {
        if (id.isEmpty()) {
            id = Serenity.sessionVariableCalled("ID Invoice").toString();
            id = id.substring(7);
        }
        if (id.contains("create by api")) {
            id = Serenity.sessionVariableCalled("ID Invoice");
        }
        if (id.contains("create by admin")) {
            id = Serenity.sessionVariableCalled("ID Order");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.check(id)
        );
    }

    @And("Admin search the orders by info")
    public void search_the_order_by_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), infos.get(0).get("orderNumber"), "");
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
        if (infos.get(0).get("orderNumber").contains("empty")) {
            idInvoice = "";
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "empty");
        }
        if (infos.get(0).get("orderNumber").equals("index")) {
            idInvoice = Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("index"));
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "index");
        }
        if (infos.get(0).get("orderNumber").equals("index_ghost")) {
            idInvoice = Serenity.sessionVariableCalled("Ghost Order Number API" + infos.get(0).get("index"));
            System.out.println("Ghost Order Number API " + idInvoice);
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "index_ghost");
        }
        // = not là không có id
        if (infos.get(0).get("orderNumber").equals("not")) {
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), "", "not");
        }

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleOrders.checkByInfo(info)
        );
    }

    @And("Admin verify sku textbox in search the orders")
    public void admin_verify_sku_textbox_in_search_the_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter()
        );
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Enter.theValue(info.get("searchValue")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_ids")),
                    WindowTask.threadSleep(1000),
                    CommonWaitUntil.isVisible(AllOrdersForm.BRAND_IN_SKU_POPUP_SEARCH(info.get("sku"))),
                    Ensure.that(AllOrdersForm.BRAND_IN_SKU_POPUP_SEARCH(info.get("sku"))).text().isEqualTo(info.get("brand")),
                    Ensure.that(AllOrdersForm.PRODUCT_IN_SKU_POPUP_SEARCH(info.get("sku"))).text().isEqualTo(info.get("product")),
                    Ensure.that(AllOrdersForm.SKU_IN_SKU_POPUP_SEARCH(info.get("sku"))).text().isEqualTo(info.get("sku")),
                    WindowTask.threadSleep(1000),
                    CommonTaskAdmin.resetFilter()
            );
        }
    }

    @And("{word} verify price in order details of Admin")
    public void verify_price_in_order_details_of_admin(String user, DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        theActorCalled(user).attemptsTo(
                CommonWaitUntil.isVisible(AllOrdersForm.SMALL_ORDER_SURCHARGE)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(AllOrdersForm.SMALL_ORDER_SURCHARGE), containsString(list.get(0).get("smallOrderSurchage"))),
                seeThat(CommonQuestions.targetText(AllOrdersForm.LOGISTICS_SURCHARGE), containsString(list.get(0).get("logisticsSurchage"))),
                seeThat(CommonQuestions.targetText(AllOrdersForm.TOTAL_PAYMENT), containsString(list.get(0).get("total")))
        );
    }

    @And("Verify price in order details")
    public void verify_price_in_order_details_of_admin(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        if (list.get(0).get("smallOrderSurcharge").isEmpty() && list.get(0).get("logisticsSurcharge").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrderDetailPage.ORDER_VALUE),
                    Ensure.that(OrderDetailPage.ORDER_VALUE).text().contains(list.get(0).get("orderValue")),
                    Ensure.that(OrderDetailPage.DISCOUNT_VALUE).text().contains(list.get(0).get("discount")),
                    Ensure.that(OrderDetailPage.TAXES_VALUE).text().contains(list.get(0).get("taxes")),
                    Ensure.that(OrderDetailPage.VENDOR_SERVICE_FEE).text().contains(list.get(0).get("vendorServiceFee")),
                    Ensure.that(OrderDetailPage.TOTAL_PAYMENT).text().contains(list.get(0).get("total"))
            );
        } else
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrderDetailPage.ORDER_VALUE),
                    Ensure.that(OrderDetailPage.ORDER_VALUE).text().contains(list.get(0).get("orderValue")),
                    Ensure.that(OrderDetailPage.DISCOUNT_VALUE).text().contains(list.get(0).get("discount")),
                    Ensure.that(OrderDetailPage.TAXES_VALUE).text().contains(list.get(0).get("taxes")),
                    Ensure.that(OrderDetailPage.SMALL_ORDER_SURCHARGE(list.get(0).get("smallOrderSurcharge"))).text().contains(list.get(0).get("smallOrderSurcharge")),
                    Check.whether(list.get(0).get("logisticsSurcharge").isEmpty())
                            .otherwise(Ensure.that(OrderDetailPage.LOGISTIC_SURCHARGE).text().contains(list.get(0).get("logisticsSurcharge"))),
                    Ensure.that(OrderDetailPage.VENDOR_SERVICE_FEE).text().contains(list.get(0).get("vendorServiceFee")),
                    Ensure.that(OrderDetailPage.TOTAL_PAYMENT).text().contains(list.get(0).get("total"))
            );
        if (list.get(0).containsKey("specialDiscount")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(OrderDetailPage.SPECIAL_DISCOUNT), containsString(list.get(0).get("specialDiscount")))
            );
        }
        if (list.get(0).containsKey("fuelSurcharge")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(OrderDetailPage.FUEL_SURCHARGE), containsString(list.get(0).get("fuelSurcharge")))
            );
        }
    }

    @And("Verify general information of order detail")
    public void checkGeneralInformation(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrderDetailPage.CUSTOM_PO_FIELD),
                Ensure.that(OrderDetailPage.CUSTOM_PO_FIELD).text().contains(list.get(0).get("customerPo")),
                Ensure.that(OrderDetailPage.DATE).text().contains(CommonHandle.setDate(list.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(OrderDetailPage.REGION_NAME).text().contains(list.get(0).get("region")),
                Ensure.that(OrderDetailPage.BUYER_NAME).text().contains(list.get(0).get("buyer")),
                Ensure.that(OrderDetailPage.STORE_NAME).text().contains(list.get(0).get("store")),
                Ensure.that(OrderDetailPage.CUSTOM_STORE_NAME).text().contains(list.get(0).get("customStore")),
                Ensure.that(OrderDetailPage.ADMIN_NOTE_FIELD).text().contains(list.get(0).get("adminNote")),
                Ensure.that(OrderDetailPage.BUYER_PAYMENT).text().contains(list.get(0).get("buyerPayment")),
                Ensure.that(OrderDetailPage.PAYMENT_TYPE).text().contains(list.get(0).get("paymentType")),
                Ensure.that(OrderDetailPage.VENDOR_PAYMENT).text().contains(list.get(0).get("vendorPayment")),
                Ensure.that(OrderDetailPage.FULFILLMENT).text().contains(list.get(0).get("fulfillment")),
                Check.whether(list.get(0).containsKey("approveToFulfill"))
                        .andIfSo(
                                Ensure.that(OrderDetailPage.APPROVE_TO_FULFILL_BUTTON).isDisplayed())
        );
        if (list.get(0).containsKey("financeApproval")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.FINANCE_APPROVAL).text().contains(list.get(0).get("financeApproval"))
            );
        }
        if (list.get(0).containsKey("financeApproveBy")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.FINANCE_APPROVAL_BY).text().contains(list.get(0).get("financeApproveBy"))
            );
        }
        if (list.get(0).containsKey("financeApproveAt")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.FINANCE_APPROVAL_AT).text().contains(CommonHandle.setDate2(list.get(0).get("financeApproveAt"), "MM/dd/yy"))
            );
        }
        if (list.get(0).containsKey("route")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.ROUTE).text().contains(list.get(0).get("route")));
        }
        if (list.get(0).containsKey("creator")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.CREATOR).text().contains(list.get(0).get("creator")));
        }
        if (list.get(0).containsKey("paymentDate")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.PAYMENT_DATE).text().contains(CommonHandle.setDate2(list.get(0).get("paymentDate"), "MM/dd/yy")));
        }

        if (list.get(0).containsKey("managedBy")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.MANAGED_BY).text().contains(list.get(0).get("managedBy")));
        }

        if (list.get(0).containsKey("launchedBy")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.LAUNCHED_BY).text().contains(list.get(0).get("launchedBy")));
        }

        if (list.get(0).containsKey("address")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.ADDRESS).text().contains(list.get(0).get("address")));
        }
    }

    @And("Admin create {string} sub-invoice with Suffix ={string}")
    public void admin_create_sub_invoice1(String type, String suffix, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        for (Map<String, String> item : list) {
            HashMap<String, String> info = new HashMap<>(item);
            if (item.get("skuName").equals("random")) {
                info = CommonTask.setValue(item, "skuName", item.get("skuName"), Serenity.sessionVariableCalled("SKU inventory").toString(), "random");
            }

            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.chooseSkuToCreateSubInvoice(info.get("skuName"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.createSubInvoice(type, suffix)
        );
        // get ID sub-invoice
        String idSubInvoice = Text.of(AllOrdersForm.ID_SUB_INVOICE).answeredBy(theActorInTheSpotlight()).toString();
        System.out.println("id sub-invoice " + idSubInvoice);
        Serenity.setSessionVariable("Id Sub-Invoice").to(idSubInvoice);
    }

    @And("Admin create {string} sub-invoice of SKU {string} with Suffix ={string} has already been taken")
    public void admin_create_sub_invoice_has_already_been_taken(String type, String skuName, String suffix) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.chooseSkuToCreateSubInvoice(skuName),
                HandleOrders.createSubInvoice(type, suffix),
                //Verify popup error
                Ensure.that(CommonAdminForm.D_MESSAGE_POPUP("Validation failed: Surfix has already been taken")).isDisplayed(),
                Click.on(OrderDetailPage.DIALOG_CLOSE_BUTTON)
        );
    }

    @And("Admin create {string} sub-invoice with Suffix ={string} error {string}")
    public void admin_create_sub_invoice_error(String type, String suffix, String error, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder());
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.chooseSkuToCreateSubInvoice(item.get("skuName"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.createSubInvoice(type, suffix),
                //Verify popup error
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP(error)),
                Ensure.that(CommonAdminForm.D_MESSAGE_POPUP(error)).isDisplayed(),
                Click.on(OrderDetailPage.DIALOG_CLOSE_BUTTON)
        );
    }

    @And("Admin choose non-invoice to create sub-invoice")
    public void admin_choose_non_invoice_to_create() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.chooseNoninvoice()
        );
    }

    @And("Verify price of {string} not display in vendor")
    public void verify_price_not_display_in_vendor(String type) {
        List<WebElementFacade> lsCartBefore = CheckoutPage.CART_SOS_INVOICE.resolveAllFor(theActorInTheSpotlight());
        theActorInTheSpotlight().attemptsTo(
                Check.whether(lsCartBefore.size() != 0)
                        .andIfSo(Ensure.that(CheckoutPage.CART_SOS_INVOICE).isNotDisplayed())
        );
    }

    @And("{word} create purchase order with info")
    public void add_purchase_order(String actor, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorCalled(actor).attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.goToPopupCreatePurchaseOrder(),
                HandleOrders.addPurchaseOrder(list.get(0)),
                HandleOrders.createPurchaseOrder("Create")
        );

        // lấy id sub-invoice để check LP
        String idSubInvoice = Text.of(AllOrdersForm.ID_SUB_INVOICE).answeredBy(theActorInTheSpotlight()).toString();
        System.out.println("Id Sub-invoice LP" + idSubInvoice);
        Serenity.setSessionVariable("Id Sub-invoice LP").to(idSubInvoice.substring(1));
    }

    @And("Admin edit purchase order of order {string} with info")
    public void edit_purchase_order(String order, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        if (order.equals("create by api")) {
            order = Serenity.sessionVariableCalled("ID Order");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.goToPopupEditPurchaseOrder(order + list.get(0).get("sub")),
                HandleOrders.addPurchaseOrder(list.get(0)),
                HandleOrders.createPurchaseOrder("Update")
        );

        // lấy id sub-invoice để check LP
        String idSubInvoice = Text.of(AllOrdersForm.ID_SUB_INVOICE).answeredBy(theActorInTheSpotlight()).toString();
        Serenity.setSessionVariable("Id Sub-invoice LP").to(idSubInvoice.substring(1));
    }

    @And("Admin verify fulfilment date of purchase order in order summary")
    public void verify_fulfillment_date_of_purchase_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.goToPopupCreatePurchaseOrder(),

                CommonTask.chooseItemInDropdownWithValueInput(AllOrdersForm.DRIVER_TEXTBOX, "Auto Ngoc LP Mix 01", AllOrdersForm.DYNAMIC_ITEM("Auto Ngoc LP Mix 01")),
                CommonWaitUntil.isVisible(AllOrdersForm.D_TEXTBOX("Fulfillment date")),
                CommonTask.chooseItemInDropdown(AllOrdersForm.D_TEXTBOX("Fulfillment state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Fulfilled")),
                Click.on(AllOrdersForm.CREATE_PO_BUTTON("Create")),
                // Verify
                CommonWaitUntil.isVisible(AllOrdersForm.FULFILMENT_DATE_ERROR_MESSAGE),
                Ensure.that(AllOrdersForm.FULFILMENT_DATE_ERROR_MESSAGE).text().contains("Please select fullfillment date")
        );
    }

    @And("Admin remove purchase order of order {string} of sub {string} with info")
    public void remove_purchase_order(String order, String sub) {
        if (order.equals("create by api")) {
            sub = Serenity.sessionVariableCalled("ID Order") + sub;
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.removePurchaseOrder(sub)
        );


    }

    @And("Set receiving weekdays {string}")
    public void setReceiving(String receiving) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.setReceiving(receiving)
        );
    }

    @And("Verify pod consignment and preferment warehouse is {string}")
    public void verify_pod_consignment(String preferWarehouse) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(OrderDetailPage.POD_CONSIGNMENT_BUTTON).isDisplayed(),
                Ensure.that(OrderDetailPage.DISTRIBUTE_CENTER).attribute("value").contains(preferWarehouse)
        );
    }

    @And("Admin verify pod consignment and preferment warehouse")
    public void admin_verify_pod_consignment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String sku = null;
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        for (int i = 0; i < infos.size(); i++) {
            sku = infos.get(i).get("sku");
            if (infos.get(i).get("sku").equals("random")) {
                sku = Serenity.sessionVariableCalled("SKU inventory");
            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrderDetailPage.POD_CONSIGNMENT_BUTTON(sku, infos.get(i).get("delivery"), infos.get(i).get("index"))),
                    Ensure.that(OrderDetailPage.POD_CONSIGNMENT_BUTTON(sku, infos.get(i).get("delivery"), infos.get(i).get("index"))).isDisplayed(),
                    Check.whether(infos.get(i).get("preferWarehouse").isEmpty())
                            .otherwise(Ensure.that(OrderDetailPage.DISTRIBUTE_CENTER(sku, i + 1)).attribute("value").contains(infos.get(i).get("preferWarehouse")))
            );
        }
    }

    @And("Admin verify not set distribution center in order detail")
    public void verify_pod_not_set_distribution_center(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String sku = null;
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        for (int i = 0; i < infos.size(); i++) {
            sku = infos.get(i).get("sku");
            if (infos.get(i).get("sku").equals("random")) {
                sku = Serenity.sessionVariableCalled("SKU inventory");
            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isNotVisible(OrderDetailPage.POD_CONSIGNMENT_BUTTON(sku, infos.get(i).get("delivery"), infos.get(i).get("index")))
            );
        }
    }


    @And("Admin verify pod consignment deliverable not set")
    public void verify_pod_consignment_deliverable_not_set() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(OrderDetailPage.DELIVERABLE_NOT_SET))
        );
    }

    @And("Admin edit pod consignment of line item")
    public void edit_pod_consignment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.editPodConsignment(infos.get(0))
        );
    }

    @And("Admin verify deliverable detail of line item")
    public void verify_deliverable_detail_of_line_item(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(OrderDetailPage.POP_CONSIGNMENT_SETTED(infos.get(0).get("sku"))),
                CommonWaitUntil.isVisible(OrderDetailPage.POP_CONSIGNMENT_REMOVE_BUTTON),
                Ensure.that(OrderDetailPage.DELIVERY_METHOD_DROPDOWN).attribute("value").contains(infos.get(0).get("deliveryMethod")),
                Ensure.that(OrderDetailPage.POP_CONSIGNMENT_COMMENT_TEXTAREA).attribute("value").contains(infos.get(0).get("comment"))
        );
    }

    @And("Admin fulfill all line items")
    public void admin_fulfill_all_line_items(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> temp = CommonTask.setValue(info, "skuName", info.get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.fulfillOrder(temp)
            );
        }
    }

    @And("Admin fulfill all line items created by buyer")
    public void admin_fulfill_all_line_items_created_by_buyer(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.fulfillOrder(info)
            );
        }
    }

    @And("Admin verify result order in all order")
    public void verify_result_order_in_all_order(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String idInvoice = null;
        // check empty do tạo order từ multiple order không lấy được order number
        HashMap<String, String> info = new HashMap<>();
        if (expected.get(0).get("order").equals("empty")) {
            idInvoice = "";
            info = CommonTask.setValue(expected.get(0), "order", expected.get(0).get("order"), idInvoice, "empty");
        } else if (expected.get(0).get("order").equals("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            info = CommonTask.setValue(expected.get(0), "order", expected.get(0).get("order"), idInvoice.substring(7), "random");
            info = CommonTask.setValue(info, "order", info.get("order"), idInvoice.toString(), "create by api");
        } else if (expected.get(0).get("order").equals("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(expected.get(0), "order", expected.get(0).get("order"), idInvoice.toString(), "create by admin");
        } else if (expected.get(0).get("order").equals("create by buyer")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            info = CommonTask.setValue(expected.get(0), "order", expected.get(0).get("order"), idInvoice.substring(7), "create by buyer");
        } else if (expected.get(0).get("order").equals("index")) {
            idInvoice = Serenity.sessionVariableCalled("Number Order API" + expected.get(0).get("index"));
            info = CommonTask.setValue(expected.get(0), "order", expected.get(0).get("order"), idInvoice.substring(7), "index");
        }

        theActorInTheSpotlight().attemptsTo(
                Check.whether(info.get("order").equals("empty"))
                        .otherwise(Ensure.that(AllOrdersForm.ORDER_RESULT).text().contains(info.get("order"))),
                Ensure.that(AllOrdersForm.CHECKOUT_RESULT).text().contains(CommonHandle.setDate(expected.get(0).get("checkout"), "MM/dd/yy")),
                Ensure.that(AllOrdersForm.BUYER_RESULT).attribute("data-original-text").contains(expected.get(0).get("buyer")),
                Ensure.that(AllOrdersForm.STORE_RESULT).text().contains(expected.get(0).get("store")),
                Ensure.that(AllOrdersForm.REGION_RESULT).text().contains(expected.get(0).get("region")),
                Ensure.that(AllOrdersForm.TOTAL_RESULT).text().contains(expected.get(0).get("total")),
                Ensure.that(AllOrdersForm.VENDOR_FEE_RESULT).text().contains(expected.get(0).get("vendorFee")),
                Ensure.that(AllOrdersForm.BUYER_PAYMENT_RESULT).text().contains(expected.get(0).get("buyerPayment")),
                Ensure.that(AllOrdersForm.FULFILLMENT_RESULT).text().contains(expected.get(0).get("fulfillment")),
                Ensure.that(AllOrdersForm.VENDOR_PAYMENT_RESULT).text().contains(expected.get(0).get("vendorPayment"))
        );
        if (info.containsKey("financePending")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllOrdersForm.PENDING_FINANCE_APPROVAL).isDisplayed()
            );
        }
        if (info.containsKey("creator")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllOrdersForm.CREATOR_RESULT).text().contains(info.get("creator"))
            );
        }
        if (info.containsKey("customerPO")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllOrdersForm.CUSTOMER_PO_RESULT).text().contains(info.get("customerPO"))
            );
        }
    }

    @And("Admin go to detail after search")
    public void admin_go_to_detail_after_search() {
        String idInvoice = Serenity.sessionVariableCalled("ID Invoice");
        // lấy ID để search Orders
        idInvoice = idInvoice.substring(7);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.seeDetail(idInvoice)
        );
    }

    @And("Admin go to order detail number {string}")
    public void admin_go_to_detail_after_search(String number) {
        String idInvoice = number;
        if (number.equals("")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice").toString();
            idInvoice = idInvoice.substring(7);
        }
        if (number.contains("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
        }
        if (number.contains("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
        }
        if (number.contains("index")) {
            idInvoice = Serenity.sessionVariableCalled("Number Order API" + number.substring(number.length() - 1));
        }
        // lấy ID để search Orders
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.seeDetail(idInvoice)
        );
    }

    @And("Admin go to detail first result search")
    public void admin_go_to_detail_first_result_search() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.seeDetailFirstResult()
        );
    }

    @And("Admin verify Purchase order")
    public void verify_PO(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(OrderDetailPage.LOGISTICS_PARTNER).text().contains(infos.get(0).get("logisticPartner")),
                Ensure.that(OrderDetailPage.STATUS_FULFILL).text().contains(infos.get(0).get("status")),
                Ensure.that(OrderDetailPage.DATE_FULFILL).text().contains(CommonHandle.setDate2(infos.get(0).get("dateFulfill"), "MM/dd/yy")),
                Check.whether(infos.get(0).get("adminNote").isEmpty())
                        .otherwise(Ensure.that(OrderDetailPage.PO_ADMIN_NOTE).text().contains(infos.get(0).get("adminNote"))),
                Check.whether(infos.get(0).get("lpNote").isEmpty())
                        .otherwise(Ensure.that(OrderDetailPage.PO_LP_NOTE).text().contains(infos.get(0).get("lpNote")))
        );
        if (infos.get(0).containsKey("proof")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(OrderDetailPage.PO_POD_FILE), equalToIgnoringCase("PoD_" + infos.get(0).get("logisticPartner").replaceAll(" ", "_") + "_" + Serenity.sessionVariableCalled("Id Sub-invoice LP") + ".jpg"))
            );
        }
    }

    @And("Admin close popup Purchase order")
    public void close_popup_purchase_order() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON1)
        );
    }

    @And("Admin go to Order summary from order detail")
    public void goToOrderSummary() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(OrderDetailPage.MANAGE_PRODUCT_ARRIVAL_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin check Sub invoice")
    public void checkSubInvoice(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(list.get(i).get("eta").isEmpty())
                            .otherwise(Ensure.that(OrderDetailPage.SUB_INVOICE_ETA(i + 1)).attribute("value").contains(CommonHandle.setDate2(list.get(i).get("eta"), "MM/dd/yy"))),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_PAYMENT_STATUS(i + 1)).text().contains(list.get(i).get("paymentStatus")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL(i + 1)).text().contains(list.get(i).get("total")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL_QUANTITY(i + 1)).text().contains(list.get(i).get("totalQuantity")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL_WEIGHT(i + 1)).text().contains(list.get(i).get("totalWeight"))
            );
            if (list.get(i).containsKey("trackingStatus")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.DYNAMIC_SHIPPO("tracking-status", i + 1)).text().contains(list.get(i).get("trackingStatus")),
                        Ensure.that(OrderDetailPage.DYNAMIC_SHIPPO("name", i + 1)).text().contains(list.get(i).get("nameTracking")),
                        Ensure.that(OrderDetailPage.DYNAMIC_SHIPPO("number", i + 1)).text().contains(list.get(i).get("numberTracking"))
                );
            }
        }
    }

    @And("Admin check sub invoice of order {string} in order detail")
    public void check_Sub_Invoice(String order, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String subInvoice = null;
        for (Map<String, String> item : list) {
            if (order.equals("create by api")) {
                subInvoice = Serenity.sessionVariableCalled("ID Order").toString() + item.get("sub");
            }

            theActorInTheSpotlight().attemptsTo(
                    Check.whether(item.get("eta").isEmpty())
                            .otherwise(Ensure.that(OrderDetailPage.SUB_INVOICE_ETA(subInvoice)).attribute("value").contains(CommonHandle.setDate2(item.get("eta"), "MM/dd/yy"))),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_PAYMENT_STATUS(subInvoice)).text().contains(item.get("paymentStatus")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL(subInvoice)).text().contains(item.get("total")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL_QUANTITY(subInvoice)).text().contains(item.get("totalQuantity")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL_WEIGHT(subInvoice)).text().contains(item.get("totalWeight")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_FULFILLMENT_STATUS(subInvoice)).text().contains(item.get("fulfillmentStatus"))

            );
            if (item.get("markFulfill").equals("Yes")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.SUB_INVOICE_MARK_FULFILL(subInvoice)).isDisplayed()
                );
            }
            if (item.get("markFulfill").equals("No")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.SUB_INVOICE_MARK_FULFILL(subInvoice)).isNotDisplayed()
                );
            }
        }
    }

    @And("Admin edit ETA of sub-invoice")
    public void admin_edit_eta_of_sub_invoice(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String subInvoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + list.get(0).get("skuName") + list.get(0).get("index"));
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.editETA(subInvoice, list.get(0).get("eta"))
        );
    }

    @And("Admin check delivery shippo")
    public void checkDeliveryShippo(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("nameTracking").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(OrderDetailPage.SHIP_DIRECT_TO_STORE), equalToIgnoringCase("Ship direct to stores"))
                );
            } else
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(OrderDetailPage.DYNAMIC_SHIPPO("tracking-status", i + 1)), equalToIgnoringCase(list.get(i).get("trackingStatus"))),
                        seeThat(CommonQuestions.targetText(OrderDetailPage.DYNAMIC_SHIPPO("name", i + 1)), equalToIgnoringCase(list.get(i).get("nameTracking"))),
                        seeThat(CommonQuestions.targetText(OrderDetailPage.DYNAMIC_SHIPPO("number", i + 1)), equalToIgnoringCase(list.get(i).get("numberTracking")))
                );

        }
    }

    @And("Admin check delivery detail")
    public void checkDeliveryDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (list.get(0).get("deliveryMethod").contains("Ship direct to stores"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Delivery method")), equalToIgnoringCase(list.get(0).get("deliveryMethod"))),
                    seeThat(CommonQuestions.targetValue(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Delivery date")), equalToIgnoringCase(CommonHandle.setDate2(list.get(0).get("deliveryDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetValue(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Carrier")), equalToIgnoringCase(list.get(0).get("carrier"))),
                    seeThat(CommonQuestions.targetValue(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Tracking number")), equalToIgnoringCase(list.get(0).get("trackingNumber"))),
                    seeThat(CommonQuestions.targetValue(CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Comment")), equalToIgnoringCase(list.get(0).get("comment")))
            );
    }

    @And("Admin {string} delete delivery detail")
    public void deleteDeliveryDetail(String action) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrderDetailPage.DELETE_DELIVERY),
                Click.on(OrderDetailPage.DELETE_DELIVERY),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                WindowTask.threadSleep(1000)

        );
    }

    @And("Admin open delivery detail of sub invoice {string} suffix {string}")
    public void open_delivery(String sub, String suffix) {
        if (sub.contains("create by api")) {
            sub = Serenity.sessionVariableCalled("ID Order");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openDeliveryDetail(sub + suffix)
        );
    }

    @And("Admin create new order")
    public void create_new_order(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.fillInfoToCreateOrder(list.get(0))
        );
    }

    @And("Admin fill info optional to create new order")
    public void admin_fill_info_optional_to_create_new_order(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.fillInfoOptionalToCreateOrder(list.get(0))
        );
    }

    @And("Admin upload file order {string}")
    public void upload_file_order(String fileName) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.uploadFileOrder(fileName)
        );
    }

    @And("Admin verify line item added")
    public void verify_line_item_added(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CreateNewOrderPage.BRAND_LINE_ITEM(expected.get(i).get("title"), i + 1)).text().contains(expected.get(i).get("brand")),
                    Ensure.that(CreateNewOrderPage.PRODUCT_LINE_ITEM(expected.get(i).get("title"), i + 1)).text().contains(expected.get(i).get("product")),
                    Ensure.that(CreateNewOrderPage.SKU_LINE_ITEM(expected.get(i).get("title"), i + 1)).text().contains(expected.get(i).get("sku")),
                    Ensure.that(CreateNewOrderPage.SKU_ID_LINE_ITEM(expected.get(i).get("title"), i + 1)).text().contains(expected.get(i).get("tag")),
                    Ensure.that(CreateNewOrderPage.UPC_LINE_ITEM(expected.get(i).get("title"), i + 1)).text().contains(expected.get(i).get("upc")),
                    Ensure.that(CreateNewOrderPage.UNITS_LINE_ITEM(expected.get(i).get("title"), i + 1)).text().contains(expected.get(i).get("unit"))
            );
        }
    }

    @And("Admin add line item is {string}")
    public void add_line_item(String skuName) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.addLineItem(skuName),
                WindowTask.threadSleep(1000)
        );
    }

    @And("Admin add line item {string} and quantities {string}")
    public void add_line_item_quty(String skuName, String num) {
        if (skuName.contains("random"))
            skuName = Serenity.sessionVariableCalled("SKU inventory").toString();
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.addLineItemQty(skuName, num),
                WindowTask.threadSleep(1000)
        );
    }

    @And("Admin add line item in order detail")
    public void admin_add_line_item_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "skuName", infos.get(0).get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
        info = CommonTask.setValue2(info, "skuName", info.get("skuName"), Serenity.sessionVariableCalled("SKU inventory" + info.get("skuName").substring(info.get("skuName").length() - 1)), "index");

        theActorInTheSpotlight().attemptsTo(
                HandleOrders.addLineItem(info.get("skuName")),
                HandleOrders.editNewLineItem(infos.get(0)),
                WindowTask.threadSleep(500),
                HandleOrders.saveAction()
        );
    }


    @And("Admin verify add line item in order detail")
    public void admin_verify_add_line_item_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isClickable(CreateNewOrderPage.ADD_LINE_BUTTON),
                JavaScriptClick.on(CreateNewOrderPage.ADD_LINE_BUTTON),
                CommonWaitUntil.isVisible(CreateNewOrderPage.SEARCH_ITEM));
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Enter.theValue(info.get("searchValue")).into(CreateNewOrderPage.SEARCH_ITEM),
                    CommonWaitUntil.isVisible(CreateNewOrderPage.ITEM_RESULT),
                    CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                    // Verify
                    Ensure.that(OrderDetailPage.SKU_IN_POPUP_SEARCH_LINE_ITEM(info.get("sku"))).text().isEqualTo(info.get("sku")),
                    Ensure.that(OrderDetailPage.PRODUCT_IN_POPUP_SEARCH_LINE_ITEM(info.get("sku"))).text().isEqualTo(info.get("product")),
                    Ensure.that(OrderDetailPage.BRAND_IN_POPUP_SEARCH_LINE_ITEM(info.get("sku"))).text().isEqualTo(info.get("brand")),
                    Ensure.that(OrderDetailPage.PRICE_IN_POPUP_SEARCH_LINE_ITEM(info.get("sku"))).text().isEqualTo(info.get("price")),
                    Ensure.that(OrderDetailPage.STATUS_IN_POPUP_SEARCH_LINE_ITEM(info.get("sku"))).text().isEqualTo(info.get("status")),
                    Ensure.that(OrderDetailPage.REGION_IN_POPUP_SEARCH_LINE_ITEM(info.get("sku"))).text().isEqualTo(info.get("region"))
            );
        }
        // close popup add line item
        theActorInTheSpotlight().attemptsTo(
                Click.on(OrderDetailPage.CLOSE_POPUP_SEARCH_LINE_ITEM),
                CommonWaitUntil.isNotVisible(CreateNewOrderPage.SEARCH_ITEM)
        );
    }

    @And("Admin can not add line item in order detail")
    public void admin_can_not_add_line_item_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.addLineItemNoFound(infos.get(0).get("skuName"))
        );
    }

    @Then("Admin verify info after upload file CSV")
    public void verify_info_after_upload_file_CSV(DataTable dt) {
        List<Map<String, String>> expecteds = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expecteds.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(expecteds.get(i).get("info").equals("empty"))
                            .otherwise(
                                    Ensure.that(CreateNewOrderPage.INFO_POPUP(i + 1)).text().contains(expecteds.get(i).get("info"))),
                    Check.whether(expecteds.get(i).get("warning").equals("empty"))
                            .otherwise(
                                    Ensure.that(CreateNewOrderPage.WARNING_POPUP(i + 1)).text().contains(expecteds.get(i).get("warning"))),
                    Check.whether(expecteds.get(i).get("danger").equals("empty"))
                            .otherwise(
                                    Ensure.that(CreateNewOrderPage.DANGER_POPUP(i + 1)).text().contains(expecteds.get(i).get("danger"))),
                    Check.whether(expecteds.get(i).get("uploadedPrice").equals("empty"))
                            .otherwise(
                                    Ensure.that(CreateNewOrderPage.UPLOADED_PRICE_POPUP(i + 1)).text().isEqualToIgnoringCase(expecteds.get(i).get("uploadedPrice"))),
                    Check.whether(expecteds.get(i).get("estimatedPrice").equals("empty"))
                            .otherwise(
                                    Check.whether(expecteds.get(i).get("promoPrice").equals("empty"))
                                            .andIfSo(Ensure.that(CreateNewOrderPage.ESTIMATED_PRICE_POPUP(i + 1)).text().isEqualToIgnoringCase(expecteds.get(i).get("estimatedPrice")))
                                            .otherwise(
                                                    Ensure.that(CreateNewOrderPage.ESTIMATED_PRICE_NEW_POPUP(i + 1)).text().isEqualToIgnoringCase(expecteds.get(i).get("promoPrice")),
                                                    Ensure.that(CreateNewOrderPage.ESTIMATED_PRICE_OLD_POPUP(i + 1)).text().isEqualToIgnoringCase(expecteds.get(i).get("estimatedPrice")))),
                    Check.whether(expecteds.get(i).get("quantity").equals("empty"))
                            .otherwise(
                                    Ensure.that(CreateNewOrderPage.QUANTITY_POPUP(i + 1)).attribute("aria-valuenow").contains(expecteds.get(i).get("quantity")))
            );
            if (expecteds.get(i).containsKey("skuID")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CreateNewOrderPage.UPLOADED_PRODUCT_POPUP(i + 1)).text().contains(expecteds.get(i).get("product")),
                        Ensure.that(CreateNewOrderPage.UPLOADED_SKU_POPUP(i + 1)).text().contains(expecteds.get(i).get("sku")),
                        Ensure.that(CreateNewOrderPage.UPLOADED_SKU_ID_POPUP(i + 1)).text().contains(expecteds.get(i).get("skuID")),
                        Ensure.that(CreateNewOrderPage.UPLOADED_UPC_POPUP(i + 1)).text().contains(expecteds.get(i).get("upc")),
                        Ensure.that(CreateNewOrderPage.UPLOADED_STATUS_POPUP(i + 1)).text().contains(expecteds.get(i).get("status")),
                        Ensure.that(CreateNewOrderPage.UPLOADED_REGION_POPUP(i + 1)).text().contains(expecteds.get(i).get("region"))
                );
            }
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(2000)
            );
        }
    }

    @Then("Admin verify price in create order upload file")
    public void verify_total_in_create_order(DataTable dt) {
        List<Map<String, String>> expecteds = dt.asMaps(String.class, String.class);
        int index = 0;
        for (Map<String, String> expected : expecteds) {
            switch (expected.get("type")) {
                case "Total":
                    index = 1;
                    break;
                case "In stock":
                    index = 2;
                    break;
                case "OOS or LS":
                    index = 3;
                    break;
            }
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CreateNewOrderPage.TOTAL_CASE_POPUP(index)).text().contains(expected.get("totalCase")),
                    Ensure.that(CreateNewOrderPage.TOTAL_ORDER_VALUE_POPUP(index)).text().contains(expected.get("totalOrderValue")),
                    Check.whether(expected.get("discount").equals(""))
                            .otherwise(Ensure.that(CreateNewOrderPage.DISCOUNT_POPUP(index)).text().contains(expected.get("discount"))),
                    Check.whether(expected.get("taxes").equals(""))
                            .otherwise(Ensure.that(CreateNewOrderPage.TAXES_POPUP(index)).text().contains(expected.get("taxes"))),
                    Check.whether(expected.get("logisticsSurcharge").equals(""))
                            .otherwise(Ensure.that(CreateNewOrderPage.LOGISTICS_SURCHARGE_POPUP(index)).text().contains(expected.get("logisticsSurcharge"))),
                    Check.whether(expected.get("specialDiscount").equals(""))
                            .otherwise(Ensure.that(CreateNewOrderPage.SPECIAL_DISCOUNT_POPUP(index)).text().contains(expected.get("specialDiscount"))),
                    Check.whether(expected.get("specialDiscount").equals(""))
                            .otherwise(Ensure.that(CreateNewOrderPage.TOTAL_PAYMENT_POPUP(index)).text().contains(expected.get("totalPayment")))
            );

        }
    }

    @And("Admin upload file CSV success")
    public void upload_file_CSV_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.uploadFileSucess()
        );
    }

    @And("Admin verify line item added with company name")
    public void verify_line_item_added_with_companyname(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        for (Map<String, String> expected : info) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CreateNewOrderPage.BRAND_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("brand")),
                    Ensure.that(CreateNewOrderPage.PRODUCT_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("product")),
                    Ensure.that(CreateNewOrderPage.SKU_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("sku")),
                    Ensure.that(CreateNewOrderPage.SKU_ID_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("tag")),
                    Ensure.that(CreateNewOrderPage.UPC_ID_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("upc")),
                    Ensure.that(CreateNewOrderPage.STATUS_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("status")),
                    Check.whether(expected.get("newPrice").equals("empty"))
                            .andIfSo(Ensure.that(CreateNewOrderPage.PRICE_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("price")))
                            .otherwise(
                                    Ensure.that(CreateNewOrderPage.PRICE_NEW_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("newPrice")),
                                    Ensure.that(CreateNewOrderPage.PRICE_OLD_MOV_LINE_ITEM(expected.get("sku"))).text().contains(expected.get("price"))
                            ),
                    Ensure.that(CreateNewOrderPage.QUANTITY_MOV_LINE_ITEM(expected.get("sku"))).attribute("aria-valuenow").contains(expected.get("quantity"))
            );
        }
    }

    @And("Admin create order success")
    public void admin_create_order_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.createOrderSuccess()
        );
        String orderID = Text.of(OrderDetailPage.ORDER_ID_HEADER).answeredBy(theActorInTheSpotlight()).toString();
        orderID = orderID.substring(orderID.lastIndexOf("#")).trim();
        System.out.println("ID Invoice " + orderID);
        Serenity.setSessionVariable("ID Invoice").to(orderID);
        Serenity.setSessionVariable("ID Order").to(orderID.substring(1));
        Serenity.setSessionVariable("ID Order create by admin").to(orderID);
//        Serenity.recordReportData().asEvidence().withTitle("Order ID").andContents(orderID);
    }

    @And("Admin create order success with customer already used of order {string}")
    public void admin_create_order_success_with_customer_already_used(String order) {
        order = Serenity.sessionVariableCalled("ID Invoice");
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.createOrderSuccessPo(order)
        );
        String orderID = Text.of(OrderDetailPage.ORDER_ID_HEADER).answeredBy(theActorInTheSpotlight()).toString();
        orderID = orderID.substring(orderID.lastIndexOf("#")).trim();
        System.out.println("ID Invoice " + orderID);
        Serenity.setSessionVariable("ID Invoice").to(orderID);
        Serenity.setSessionVariable("ID Order").to(orderID.substring(1));
        Serenity.setSessionVariable("ID Order create by admin").to(orderID);
    }

    @And("Admin create order then see message {string}")
    public void admin_create_order_then_see_message(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreateNewOrderPage.CREATE_ORDER_BUTTON),
                Click.on(CreateNewOrderPage.CREATE_ORDER_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin get ID of sub-invoice of order {string}")
    public void admin_get_id_sub_invoice(String type) {
        String subInvoiceID = Text.of(OrderDetailPage.SUB_INVOICE_ID_IN_LINE(type)).answeredBy(theActorInTheSpotlight()).toString();
        subInvoiceID = subInvoiceID.substring(1);
        System.out.println("Sub invoice ID = " + subInvoiceID);
        Serenity.setSessionVariable("Sub-invoice ID create by admin").to(subInvoiceID);
//        Serenity.recordReportData().asEvidence().withTitle("Sub-invoice ID").andContents(subInvoiceID);
    }

    @And("Admin get ID of sub-invoice {int} of order {string}")
    public void admin_get_id_sub_invoice(int index, String type) {
        String subInvoiceID = Text.of(OrderDetailPage.SUB_INVOICE_ID_IN_LINE1(index)).answeredBy(theActorInTheSpotlight()).toString();
        subInvoiceID = subInvoiceID.substring(1);
        System.out.println("Sub invoice ID = " + subInvoiceID);
        Serenity.setSessionVariable("Sub-invoice ID create by admin" + index).to(subInvoiceID);
//        Serenity.recordReportData().asEvidence().asEvidence().withTitle("Sub-invoice ID " + index).andContents(subInvoiceID);
    }

    @And("Admin refresh page by button")
    public void admin_refresh_page_by_button() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.refreshPageByButton()
        );
    }

    @And("Admin get sub invoice id to run job sidekiq")
    public void admin_get_sub_invoice_id_to_run_job() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(OrderDetailPage.DEBUG_BUTTON),
                CommonWaitUntil.isVisible(OrderDetailPage.CODE)
        );

        String text = Text.of(OrderDetailPage.CODE).answeredBy(theActorInTheSpotlight()).toString();
        JSONObject jsonObject = new JSONObject(text);
        JSONObject jsonObject1 = (JSONObject) jsonObject.getJSONArray("sub_invoices").get(0);
        System.out.println("ID Sub-invoice " + jsonObject1.get("id").toString());
        Serenity.setSessionVariable("ID Sub-invoice Job").to(jsonObject1.get("id").toString());
    }

    @And("Amin verify info of self deliver to store")
    public void verify_info_of_self_deliver_to_store(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(OrderDetailPage.EXPAND_ODER))
                        .andIfSo(
                                Click.on(OrderDetailPage.EXPAND_ODER),
                                CommonWaitUntil.isVisible(OrderDetailPage.SELF_DELIVER_TO_STORE_BUTTON),
                                Click.on(OrderDetailPage.SELF_DELIVER_TO_STORE_BUTTON)
                        )
        );

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(OrderDetailPage.D_TEXTBOX("Delivery method")).attribute("value").contains(list.get(0).get("deliveryMethod")),
                Ensure.that(OrderDetailPage.D_TEXTBOX("Delivery date")).attribute("value").contains(CommonHandle.setDate(list.get(0).get("deliveryDate"), "MM/dd/yy")),
                Ensure.that(OrderDetailPage.D_TEXTBOX("Delivery time")).attribute("value").contains(list.get(0).get("from")),
                Ensure.that(OrderDetailPage.D_TEXTBOX_2("Delivery time")).attribute("value").contains(list.get(0).get("to")),
                Ensure.that(OrderDetailPage.PROOF_OF_DELIVERY).text().contains(list.get(0).get("proof")),
                Ensure.that(OrderDetailPage.COMMENT_TEXTAREA).attribute("value").contains(list.get(0).get("comment"))
        );
    }

    @And("Admin verify receiving info")
    public void admin_verify_receiving_info(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        if (list.get(0).get("possibleReceiving").equals("Full Day")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.POSSIBLE_RECEIVING_DAY_LABEL(1)).text().contains("Mon"),
                    Ensure.that(OrderDetailPage.POSSIBLE_RECEIVING_DAY_LABEL(2)).text().contains("Tue"),
                    Ensure.that(OrderDetailPage.POSSIBLE_RECEIVING_DAY_LABEL(3)).text().contains("Wed"),
                    Ensure.that(OrderDetailPage.POSSIBLE_RECEIVING_DAY_LABEL(4)).text().contains("Thu"),
                    Ensure.that(OrderDetailPage.POSSIBLE_RECEIVING_DAY_LABEL(5)).text().contains("Fri"),
                    Ensure.that(OrderDetailPage.POSSIBLE_RECEIVING_DAY_LABEL(6)).text().contains("Sat"),
                    Ensure.that(OrderDetailPage.POSSIBLE_RECEIVING_DAY_LABEL(7)).text().contains("Sun")
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.POSSIBLE_RECEIVING_WEEKDAYS_LABEL).text().contains(list.get(0).get("possibleReceiving"))
            );
        }
        if (list.get(0).get("setReceiving").equals("Full Day")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.SET_RECEIVING_DAY_LABEL(1)).text().contains("Mon"),
                    Ensure.that(OrderDetailPage.SET_RECEIVING_DAY_LABEL(2)).text().contains("Tue"),
                    Ensure.that(OrderDetailPage.SET_RECEIVING_DAY_LABEL(3)).text().contains("Wed"),
                    Ensure.that(OrderDetailPage.SET_RECEIVING_DAY_LABEL(4)).text().contains("Thu"),
                    Ensure.that(OrderDetailPage.SET_RECEIVING_DAY_LABEL(5)).text().contains("Fri"),
                    Ensure.that(OrderDetailPage.SET_RECEIVING_DAY_LABEL(6)).text().contains("Sat"),
                    Ensure.that(OrderDetailPage.SET_RECEIVING_DAY_LABEL(7)).text().contains("Sun")
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.SET_RECEIVING_WEEKDAYS_LABEL).text().contains(list.get(0).get("setReceiving"))
            );
        }
        if (list.get(0).get("possibleReceiving").equals("")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.SET_RECEIVING_WEEKDAYS_LABEL).text().contains(list.get(0).get("setReceiving"))
            );
        }
        if (list.get(0).containsKey("receivingNote")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.EXPRESS_RECEIVING_NOTE_LABEL).text().contains(list.get(0).get("receivingNote"))
            );
        }
        if (list.get(0).containsKey("directReceivingNote")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.DIRECT_RECEIVING_NOTE_LABEL).text().contains(list.get(0).get("directReceivingNote"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(OrderDetailPage.RECEIVING_TIME_LABEL).text().contains(list.get(0).get("receivingTime"))
        );
    }

    @And("Admin verify line item express {string} index {string} can {string} edit")
    public void admin_verify_line_item_can_not_edit(String skuName, String index, String check) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder());
        if (check.equals("not")) {
            theActorInTheSpotlight().attemptsTo(
//                    Ensure.that(OrderDetailPage.ADD_LINE_ITEM_BUTTON).isNotDisplayed(),
                    Ensure.that(OrderDetailPage.FULFILL_DATE_TEXTBOX(skuName, index)).isDisabled(),
                    Ensure.that(OrderDetailPage.FULFILL_BUTTON_DISABLE(skuName)).isDisabled()
//                    Ensure.that(AllOrdersForm.PO_BUTTON).isNotDisplayed()
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.ADD_LINE_ITEM_BUTTON).isDisplayed(),
                    Ensure.that(OrderDetailPage.FULFILL_DATE_TEXTBOX(skuName, index)).isDisplayed(),
                    Ensure.that(AllOrdersForm.PO_BUTTON).isDisplayed()
            );
        }
    }

    @And("Admin verify info vendor payment")
    public void admin_verify_info_vendor_payment(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openVendorPayment(),
                Ensure.that(OrderDetailPage.VENDOR_PAYMENT_FULFILLMENT(expected.get(0).get("vendorCompany"))).text().contains(expected.get(0).get("fulfillment")),
                Ensure.that(OrderDetailPage.VENDOR_PAYMENT_PAYMENT_STATE(expected.get(0).get("vendorCompany"))).text().contains(expected.get(0).get("paymentState")),
                Ensure.that(OrderDetailPage.D_VENDOR_PAYMENT(expected.get(0).get("vendorCompany"), "value")).text().contains(expected.get(0).get("value")),
                Ensure.that(OrderDetailPage.D_VENDOR_PAYMENT(expected.get(0).get("vendorCompany"), "discount")).text().contains(expected.get(0).get("discount")),
                Ensure.that(OrderDetailPage.D_VENDOR_PAYMENT(expected.get(0).get("vendorCompany"), "service-fee")).text().contains(expected.get(0).get("serviceFee")),
                Ensure.that(OrderDetailPage.D_VENDOR_PAYMENT(expected.get(0).get("vendorCompany"), "additional-fee")).text().contains(expected.get(0).get("additionalFee")),
                Ensure.that(OrderDetailPage.D_VENDOR_PAYMENT(expected.get(0).get("vendorCompany"), "paid")).text().contains(expected.get(0).get("paid")),
                Ensure.that(OrderDetailPage.D_VENDOR_PAYMENT(expected.get(0).get("vendorCompany"), "payout-date")).text().contains(CommonHandle.setDate2(expected.get(0).get("payoutDate"), "MM/dd/yy")),
                Ensure.that(OrderDetailPage.D_VENDOR_PAYMENT(expected.get(0).get("vendorCompany"), "payment-type")).text().contains(expected.get(0).get("paymentType"))
        );
    }

    @And("Admin approve to fulfill this order")
    public void admin_approve_to_fulfill_this_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.approveToFulfillThisOrder()
        );
    }

    @And("Admin approve to fulfill all order")
    public void admin_approve_to_fulfill_all_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.approveToFulfillAllOrder()
        );
    }

    @And("Admin verify approve to fulfill all order is {string}")
    public void admin_verify_approve_to_fulfill_all_order(String numberOrders) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllOrdersForm.APPROVE_TO_FULFILL),
                Click.on(AllOrdersForm.APPROVE_TO_FULFILL),
                CommonWaitUntil.isVisible(AllOrdersForm.WARNING_POPUP),
                // verify
                Ensure.that(AllOrdersForm.APPROVE_ALL_ORDERS_BUTTON).text().contains(numberOrders),
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON1)
        );
    }

    @And("Admin verify approve to fulfill all order is not display")
    public void admin_verify_approve_to_fulfill_all_order() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllOrdersForm.APPROVE_TO_FULFILL),
                Click.on(AllOrdersForm.APPROVE_TO_FULFILL),
                CommonWaitUntil.isVisible(AllOrdersForm.WARNING_POPUP),
                // verify
                Ensure.that(AllOrdersForm.APPROVE_ALL_ORDERS_BUTTON).isNotDisplayed(),
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON1)
        );
    }

    @And("Admin update quantity of line items")
    public void admin_update_line_items(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.updateQuantity(infos.get(0).get("item"), infos.get(0).get("quantity"))
        );
    }

    @And("Admin unfulfill all line items created by buyer")
    public void admin_unfulfill_all_line_items_created_by_buyer(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> temp = CommonTask.setValue(info, "skuName", info.get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.unfulfillOrder(temp)
            );
        }
    }

    @And("Admin get ID of sub-invoice by info")
    public void admin_get_id_sub_invoice_by_info(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrderDetailPage.SUB_INVOICE_ID_IN_LINE_BY_SKU(item.get("skuName"), item.get("type"), item.get("index")))
            );
            String subInvoiceID = Text.of(OrderDetailPage.SUB_INVOICE_ID_IN_LINE_BY_SKU(item.get("skuName"), item.get("type"), item.get("index"))).answeredBy(theActorInTheSpotlight()).toString();
            subInvoiceID = subInvoiceID.substring(1);
            System.out.println("Sub invoice ID = " + subInvoiceID);
            Serenity.setSessionVariable("Sub-invoice ID create by admin" + item.get("skuName")).to(subInvoiceID);
            Serenity.setSessionVariable("Sub-invoice ID create by admin" + item.get("skuName") + item.get("index")).to(subInvoiceID);
        }
    }

    @And("Admin delete line item created by buyer")
    public void admin_delete_item_created_by_buyer(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> sku : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.openExpandOrder(),
                    HandleOrders.deleteLineItem(sku)
            );
        }
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(500),
                HandleOrders.saveAction()
        );
    }

    @And("Admin delete line item in {string}")
    public void admin_delete_item_in_non_invoice(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String typeLine = null;
        switch (type) {
            case "sub invoice":
                typeLine = "group";
                break;
            case "non invoice":
                typeLine = "group non-invoice-group";
                break;
            case "deleted or shorted items":
                typeLine = "group non-invoice-group order-disabled";
                break;
        }
        for (Map<String, String> sku : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.openExpandOrder(),
                    HandleOrders.deleteLineItem(typeLine, sku)
            );
        }
    }

    @And("Admin delete line item success in order detail")
    public void admin_delete_item_in_order_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.deleteLineItemSuccess()
        );
    }

    @And("Admin verify can not delete fulfill line item {string}")
    public void admin_verify_can_not_delete_fulfill_line_item(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String typeLine = null;
        switch (type) {
            case "sub invoice":
                typeLine = "group";
                break;
            case "non invoice":
                typeLine = "group non-invoice-group";
                break;
            case "deleted or shorted items":
                typeLine = "group non-invoice-group order-disabled";
                break;
        }
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.openExpandOrder(),
                    CommonWaitUntil.isVisible(OrderDetailPage.DELETE_LINE_ITEM_BY_SKU_DISABLE(typeLine, info.get("skuName"), info.get("index")))
            );
        }
    }

    @And("Admin verify error message after delete line item is {string}")
    public void admin_verify_error_message(String message) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CommonAdminForm.ALERT_MESSAGE(message)).isDisplayed()
        );

    }

    @And("Admin remove sub-invoice with info")
    public void admin_remove_sub_invoice_of_sku(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String subInvoice = infos.get(0).get("subinvoice");
        if (infos.get(0).get("subinvoice").isEmpty()) {
            subInvoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + infos.get(0).get("skuName") + infos.get(0).get("index"));
            System.out.println("sub invoice = " + subInvoice);
        }
        if (infos.get(0).get("subinvoice").equals("create by api")) {
            subInvoice = Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("index"));
            System.out.println("sub invoice = " + subInvoice);
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.removeSubInvoice(subInvoice)
        );
    }

    @And("Admin delete order by order number by info")
    public void admin_delete_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), Serenity.sessionVariableCalled("ID Invoice").toString().replaceAll("#", ""), "");
        info = CommonTask.setValue(info, "orderNumber", info.get("orderNumber"), Serenity.sessionVariableCalled("ID Invoice"), "create by api");

        theActorInTheSpotlight().attemptsTo(
                HandleOrders.deleteOrder(info)
        );
    }

    @And("Admin delete order from order detail")
    public void admin_delete_order_from_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.deleteOrderDetail(infos.get(0)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin delete order from order detail and verify message {string}")
    public void admin_delete_order_from_detail_and_verify_mesage(String message, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.deleteOrderDetail(infos.get(0)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))

        );
    }

    @And("Admin remove pod consignment deliverable of sku {string} in line item")
    public void admin_remove_pod_consignment_deliverable_in_line_item(String skuName) {
        if (skuName.equals("random")) {
            skuName = Serenity.sessionVariableCalled("SKU inventory");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.removePodConsignment(skuName)
        );
    }

    @And("Admin no found order in result")
    public void admin_no_found_order_in_result() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CommonAdminForm.NO_DATA_RESULT).isDisplayed()
        );
    }

    @And("Admin go to {string} by redirect icon and verify")
    public void admin_go_to_by_redirect_icon(String value) {
        Target target = null;
        Target targetResult = null;
        switch (value) {
            case "buyer":
                target = OrderDetailPage.BUYER_LINK;
                targetResult = AllStoresPage.DYNAMIC_DETAIL("email");
                break;
            case "store":
                target = OrderDetailPage.STORE_LINK;
                targetResult = AllStoresPage.DYNAMIC_DETAIL("name");
                break;
            case "creator":
                target = OrderDetailPage.LINK_TAG_LINK;
                targetResult = SettingAdminForm.ADMIN_HEADER;
                break;
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(target),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                Ensure.that(targetResult).isDisplayed()
        );
    }

    @And("{word} go back")
    public void admin_go_back(String actor) {
        theActorCalled(actor).attemptsTo(
                GoBack.theBrowser(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    /**
     * Delete Order Detail
     */
    @And("Admin verify general information of delete order detail")
    public void admin_verify_general_info_of_delete_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(orderDetailPage.CUSTOM_PO_FIELD_DELETE).text().contains(list.get(0).get("customerPo")),
                Ensure.that(orderDetailPage.DATE_FIELD_DELETE).text().contains(CommonHandle.setDate(list.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(orderDetailPage.REGION_FIELD_DELETE).text().contains(list.get(0).get("region")),
                Ensure.that(orderDetailPage.BUYER_FIELD_DELETE).text().contains(list.get(0).get("buyer")),
                Ensure.that(orderDetailPage.STORE_FIELD_DELETE).text().contains(list.get(0).get("store")),
                Ensure.that(orderDetailPage.BUYER_PAYMENT_FIELD_DELETE).text().contains(list.get(0).get("buyerPayment")),
                Ensure.that(orderDetailPage.PAYMENT_TYPE_FIELD_DELETE).text().contains(list.get(0).get("paymentType")),
                Ensure.that(orderDetailPage.PAYMENT_DATE_FIELD_DELETE).text().contains(list.get(0).get("paymentDate")),
                Ensure.that(orderDetailPage.VENDOR_PAYMENT_FIELD_DELETE).text().contains(list.get(0).get("vendorPayment")),
                Ensure.that(orderDetailPage.FULFILLMENT_FIELD_DELETE).text().contains(list.get(0).get("fulfillment")),
                Ensure.that(orderDetailPage.DELETED_BY_FIELD_DELETE).text().contains(list.get(0).get("deletedBy")),
                Ensure.that(orderDetailPage.DELETED_ON_FIELD_DELETE).text().contains(list.get(0).get("deletedOn")),
                Ensure.that(orderDetailPage.DELETE_REASON_FIELD_DELETE).text().contains(list.get(0).get("deletedReason"))
        );
    }

    @And("Admin verify price in delete order details")
    public void admin_verify_price_in_delete_order_details(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(orderDetailPage.D_PRICE_FIELD_DELETE("order-value")).text().contains(list.get(0).get("orderValue")),
                Ensure.that(orderDetailPage.D_PRICE_FIELD_DELETE("discount")).text().contains(list.get(0).get("discount")),
                Ensure.that(orderDetailPage.D_PRICE_FIELD_DELETE("taxes")).text().contains(list.get(0).get("taxes")),
                Ensure.that(orderDetailPage.D_PRICE_FIELD_DELETE1("shipping-fee")).text().contains(list.get(0).get("smallOrderSurcharge")),
                Ensure.that(orderDetailPage.D_PRICE_FIELD_DELETE1("logistics-surcharge")).text().contains(list.get(0).get("logisticsSurcharge")),
                Ensure.that(orderDetailPage.D_PRICE_FIELD_DELETE("special-discount")).text().contains(list.get(0).get("specialDiscount")),
                Ensure.that(orderDetailPage.D_PRICE_FIELD_DELETE("vendor-service-fee")).text().contains(list.get(0).get("vendorServiceFee")),
                Ensure.that(orderDetailPage.D_PRICE_FIELD_DELETE("order-value")).text().contains(list.get(0).get("total"))
        );
    }

    @And("Admin edit general information of order detail")
    public void admin_edit_general_information_of_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.editGeneralInformation(infos.get(0))
        );
    }

    @And("Admin edit address of order detail")
    public void admin_edit_address_of_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.goToEditAddress(),
                HandleOrders.editAddress(infos.get(0)),
                HandleOrders.updateEditAddressSuccess()
        );
    }


    @And("Admin verify button Send delivery confirmation is {string}")
    public void admin_verify_button_send_delivery_confirmation(String status) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(OrderDetailPage.SEND_DELIVERY_CONFIRMATION).attribute("class").contains(status)
        );

    }

    @And("Admin verify set receiving weekdays {string}")
    public void admin_verify_set_receiving_weekdays(String day) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAYS_LABEL),
                CommonWaitUntil.isVisible(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN(day)),
                Ensure.that(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN("Wednesday")).isNotDisplayed(),
                Ensure.that(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN("Thursday")).isNotDisplayed(),
                Ensure.that(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN("Friday")).isNotDisplayed(),
                Ensure.that(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN("Saturday")).isNotDisplayed(),
                Ensure.that(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN("Sunday")).isNotDisplayed()
        );
    }

    @And("Admin verify remove set receiving weekday")
    public void admin_verify_remove_set_receiving_weekdays() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllStoresPage.TOOLTIP_TEXTBOX),
                Clear.field(AllStoresPage.TOOLTIP_TEXTBOX),
                Click.on(OrderDetailPage.GENERAL_INFORMATION),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin change receiving time in order detail")
    public void admin_change_receiving_time_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.editReceivingTime(infos.get(0))
        );
    }

    @And("Admin change department in order detail {string}")
    public void admin_change_department_in_order_detail(String department) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.editDepartment(department)
        );
    }

    @And("Admin check line items {string} in order details")
    public void admin_check_line_item_non_invoice_in_order_detail(String type, DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        String typeLine = null;
        switch (type) {
            case "sub invoice":
                typeLine = "group";
                break;
            case "non invoice":
                typeLine = "group non-invoice-group";
                break;
            case "deleted or shorted items":
                typeLine = "group non-invoice-group order-disabled";
                break;
        }

        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValue(list.get(i), "sku", list.get(i).get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue2(info, "sku", info.get("sku"), Serenity.sessionVariableCalled("SKU inventory" + info.get("sku").substring(info.get("sku").length() - 1)), "index");

            theActorInTheSpotlight().attemptsTo(
                    Scroll.to(OrderDetailPage.LINE_ITEM_BRAND(typeLine, i + 1)),
                    Ensure.that(OrderDetailPage.LINE_ITEM_BRAND(typeLine, i + 1)).attribute("data-original-text").contains(list.get(i).get("brand")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_PRODUCT(typeLine, i + 1)).attribute("data-original-text").contains(list.get(i).get("product")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_SKU(typeLine, i + 1)).attribute("data-original-text").contains(info.get("sku")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_CASE_PRICE(typeLine, i + 1)).text().contains(list.get(i).get("casePrice")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_CASE_UNIT(typeLine, i + 1)).text().contains(list.get(i).get("unitCase")),
                    Check.whether(list.get(i).get("endQuantity").isEmpty())
                            .otherwise(Ensure.that(OrderDetailPage.LINE_ITEM_END_QUANTITY(typeLine, i + 1)).text().contains(list.get(i).get("endQuantity"))),
                    Ensure.that(OrderDetailPage.LINE_ITEM_TOTAL(typeLine, i + 1)).text().contains(list.get(i).get("total"))
            );
            if (!info.get("quantity").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(typeLine.equals("group non-invoice-group order-disabled"))
                                .andIfSo(Ensure.that(OrderDetailPage.LINE_ITEM_QUANTITY_DELETE1(typeLine)).text().contains(list.get(i).get("quantity")))
                                .otherwise(Ensure.that(OrderDetailPage.LINE_ITEM_QUANTITY1(typeLine, i + 1)).text().contains(list.get(i).get("quantity")))
                );
            }

            if (info.containsKey("skuID")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.LINE_ITEM_SKU_ID(list.get(i).get("skuID"))).text().contains(list.get(i).get("skuID"))
                );
            }
            if (info.containsKey("oldTotal")) {
                if (!info.get("oldTotal").isEmpty()) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(OrderDetailPage.LINE_ITEM_OLD_TOTAL(typeLine, i + 1)).text().contains(list.get(i).get("oldTotal"))
                    );
                }
            }
            if (info.containsKey("tax")) {
                if (!info.get("additionalFee").isEmpty()) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(OrderDetailPage.ADDITIONAL_FEE_OLD_TOTAL(typeLine, i + 1)).text().contains(list.get(i).get("additionalFee"))
                    );
                }
            }
            if (info.containsKey("directItemDelivery")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.DIRECT_ITEM_DELIVERY(typeLine, i + 1)).text().contains(list.get(i).get("directItemDelivery"))
                );
            }
            if (info.containsKey("expireDate")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.EXPIRE_LINE_ITEM(typeLine, i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("expireDate"), "MM/dd/yy"))
                );
            }
            if (info.containsKey("below75%")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.BELOW_LINE_ITEM(typeLine, i + 1)).text().contains(list.get(i).get("below75%"))
                );
            }
        }
    }

    @And("Admin check line items of sub invoice {string} with suffix {string} in order details")
    public void admin_check_line_item_with_suffix_in_order_detail(String subInvoice, String suffix, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        if(subInvoice.contains("api")){
            subInvoice = Serenity.sessionVariableCalled("ID Order").toString() + suffix;
        }
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValue(list.get(i), "sku", list.get(i).get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue2(info, "sku", info.get("sku"), Serenity.sessionVariableCalled("SKU inventory" + info.get("sku").substring(info.get("sku").length() - 1)), "index");
            theActorInTheSpotlight().attemptsTo(
                    Scroll.to(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_BRAND(subInvoice, i + 1)),
                    Ensure.that(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_BRAND(subInvoice, i + 1)).attribute("data-original-text").contains(list.get(i).get("brand")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_PRODUCT(subInvoice, i + 1)).attribute("data-original-text").contains(list.get(i).get("product")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_SKU(subInvoice, i + 1)).attribute("data-original-text").contains(info.get("sku")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_CASE_PRICE(subInvoice, i + 1)).text().contains(list.get(i).get("casePrice")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_CASE_UNIT(subInvoice, i + 1)).text().contains(list.get(i).get("unitCase")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_QUANTITY(subInvoice, i + 1)).text().contains(list.get(i).get("quantity")),
                    Check.whether(list.get(i).get("endQuantity").isEmpty())
                            .otherwise(Ensure.that(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_END_QUANTITY(subInvoice, i + 1)).text().contains(list.get(i).get("endQuantity"))),
                    Ensure.that(OrderDetailPage.LINE_ITEM_OF_SUB_INVOICE_END_TOTAL(subInvoice, i + 1)).text().contains(list.get(i).get("total"))
            );
        }
    }

    @And("Admin check line items {string} in order details when collapse")
    public void admin_check_line_item_non_invoice_in_order_detail_when_colapse(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.collapseOrder()
        );
        String typeLine = null;
        switch (type) {
            case "sub invoice":
                typeLine = "group";
                break;
            case "non invoice":
                typeLine = "group non-invoice-group";
                break;
            case "deleted or shorted items":
                typeLine = "group non-invoice-group order-disabled";
                break;
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(OrderDetailPage.LINE_ITEM_BRAND(typeLine, 1)).isNotDisplayed(),
                Ensure.that(OrderDetailPage.LINE_ITEM_PRODUCT(typeLine, 1)).isNotDisplayed(),
                Ensure.that(OrderDetailPage.LINE_ITEM_SKU(typeLine, 1)).isNotDisplayed(),
                Ensure.that(OrderDetailPage.LINE_ITEM_CASE_PRICE(typeLine, 1)).isNotDisplayed(),
                Check.whether(typeLine.equals("group non-invoice-group order-disabled"))
                        .andIfSo(Ensure.that(OrderDetailPage.LINE_ITEM_QUANTITY_DELETE(typeLine, 1)).isNotDisplayed())
                        .otherwise(Ensure.that(OrderDetailPage.LINE_ITEM_QUANTITY1(typeLine, 1)).isNotDisplayed()),
                Ensure.that(OrderDetailPage.LINE_ITEM_CASE_UNIT(typeLine, 1)).isNotDisplayed(),
                Ensure.that(OrderDetailPage.LINE_ITEM_END_QUANTITY(typeLine, 1)).isNotDisplayed(),
                Ensure.that(OrderDetailPage.LINE_ITEM_TOTAL(typeLine, 1)).isNotDisplayed()
        );
    }

    @And("Admin verify line item can not remove after fulfilled PO")
    public void admin_verify_line_item_can_not_remove(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        String subInvoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + list.get(0).get("skuName") + list.get(0).get("index"));
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllOrdersForm.PO_BUTTON).isNotDisplayed(),
                Ensure.that(OrderDetailPage.REMOVE_SUBINVOICE_BY_ID(subInvoice)).attribute("class").contains("disabled")
        );
    }

    @And("Admin verify line item express {string} index {string} can not edit of order paid")
    public void admin_verify_line_item_can_not_edit_of_order_paid(String skuName, String index) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
    }

    @And("Admin verify message {string} after click fulfill order paid")
    public void admin_verify_message(String message, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrderDetailPage.FULFILL_BUTTON(list.get(0).get("skuName"), list.get(0).get("index"))),
                Scroll.to(OrderDetailPage.FULFILL_BUTTON(list.get(0).get("skuName"), list.get(0).get("index"))),
                Click.on(OrderDetailPage.FULFILL_BUTTON(list.get(0).get("skuName"), list.get(0).get("index"))),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT(message)),
                Ensure.that(CommonAdminForm.DYNAMIC_ALERT(message)).isDisplayed(),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)
        );
    }

    @And("Admin verify message {string} after click turn off display surcharge")
    public void admin_verify_message_display_surcharge(String message) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(valueOf(OrderDetailPage.DISPLAY_SURCHARGE_BUTTON_CHECKED), isCurrentlyVisible())
                        .andIfSo(Click.on(OrderDetailPage.DISPLAY_SURCHARGE_BUTTON_CHECKED),
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT(message)))
        );
    }

    @And("Admin verify message {string} after remove sub-invoice paid")
    public void admin_verify_message_after_remove_sub_invoice_paid(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT(message)),
                Ensure.that(CommonAdminForm.DYNAMIC_ALERT(message)).isDisplayed(),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)
        );
    }

    @And("Amin set deliverable for order {string}")
    public void admin_set_deliverable_for_order(String subinvoice, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String sub = null;
        if (subinvoice.isEmpty()) {
            sub = Serenity.sessionVariableCalled("ID Invoice");
            sub = sub.substring(7);
        }
        if (subinvoice.contains("create by api")) {
            sub = Serenity.sessionVariableCalled("ID Invoice");
        }
        if (subinvoice.contains("create by admin")) {
            sub = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        }
        if (subinvoice.contains("sub")) {
            sub = Serenity.sessionVariableCalled("ID Order") + subinvoice.substring(3);

        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.setDeliveable(sub, list.get(0))
        );
    }

    @And("Admin edit line item in create new order page")
    public void admin_edit_line_item_in_create_new_order_page(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.editLineItemOfCreate(list.get(0))
        );
    }

    @And("Admin expand line item in order detail")
    public void admin_expand_line_item_in_order_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
    }

    @And("Admin delete order in order result")
    public void admin_delete_order_in_order_result() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
    }

    @And("Admin turn off display surcharges")
    public void admin_turn_off_display_surcharge() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.turnOffDisplaySurcharge()
        );
    }


    @And("Admin verify when turn off display surcharges")
    public void admin_verify_turn_off_display_surcharge() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrderDetailPage.DISPLAY_SURCHARGE_ALERT)
        );
    }

    @And("Admin set Pod Consignment")
    public void set_pod_consignment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
//                HandleOrders.setPodConsignment()
        );
    }

    @And("Admin change warehouse of sku {string} in line item to {string}")
    public void admin_change_warehouse_in_line_item(String skuName, String warehouse) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.changeWarehouseOfLineitem(skuName, warehouse)
        );
    }

    @And("Admin verify error message when create empty purchase order")
    public void verify_error_in_popup_purchase_order() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllOrdersForm.PO_BUTTON),
                CommonWaitUntil.isVisible(AllOrdersForm.DRIVER_TEXTBOX),
                Click.on(AllOrdersForm.CREATE_PO_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Logistics company must exist")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                // close popup
                Click.on(AllOrdersForm.CREATE_PO_CLOSE_POPUP_BUTTON)
        );
    }

    @And("Admin choose LP company only warehouse is {string} then verify No data")
    public void verify_choose_LP_company_only_warehouse_is(String lpCompany) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllOrdersForm.PO_BUTTON),
                CommonWaitUntil.isVisible(AllOrdersForm.DRIVER_TEXTBOX),
                Enter.theValue(lpCompany).into(AllOrdersForm.DRIVER_TEXTBOX),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA)
        );
    }

    @And("Admin edit line item in order detail")
    public void admin_edit_line_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "order", infos.get(0).get("order"), Serenity.sessionVariableCalled("ID Order").toString(), "create by api");
        info = CommonTask.setValue(info, "sub", info.get("sub"), "", "Non Invoice");
        if (info.containsKey("sku")) {
            info = CommonTask.setValue(info, "sku", info.get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "create by api");
        }
        if (info.get("subID").equals("create by api")) {
            info = CommonTask.setValue(info, "subID", info.get("subID"), Serenity.sessionVariableCalled("ID SKU Admin").toString(), "create by api");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder(),
                HandleOrders.editLineItemInOrderDetail(info)
        );
    }

    @And("Admin {string} quantity line item in order detail")
    public void admin_update_line_in_order_detail(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.updateQuantityInOrderDetail(type)
        );
    }

    @And("Admin {word} action in order detail")
    public void admin_action_in_order_detail(String action) {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(500),
                Check.whether(action.equals("save"))
                        .andIfSo(HandleOrders.saveAction())
                        .otherwise(HandleOrders.revertAction())
        );
    }

    @And("Admin verify message error {string}")
    public void admin_verify_message_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP(message))
        );
    }

    @And("Admin save action then verify message error {string}")
    public void admin_save_and_verify_message_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                //Save action
                CommonWaitUntil.isVisible(OrderDetailPage.SAVE_ACTION_BUTTON),
                Click.on(OrderDetailPage.SAVE_ACTION_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP(message))
        );
    }

    @And("Admin verify history change quantity of line item in order detail")
    public void admin_verify_history_change_quantity_of_line_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "order", infos.get(0).get("order"), Serenity.sessionVariableCalled("ID Order").toString(), "create by api");
        info = CommonTask.setValue(info, "sub", info.get("sub"), "", "Non Invoice");
        if (info.get("subID").equals("create by api")) {
            info = CommonTask.setValue(info, "subID", info.get("subID"), Serenity.sessionVariableCalled("ID SKU Admin").toString(), "create by api");
        }
        theActorInTheSpotlight().attemptsTo(
                // Verify info of popup
                Scroll.to(OrderDetailPage.ADD_LINE_ITEM_BUTTON),
                Click.on(OrderDetailPage.HELP_OF_QUANTITY_OF_LINEITEM(info.get("order") + info.get("sub"), info.get("subID"))),
                CommonWaitUntil.isVisible(OrderDetailPage.POPRER_HELP_VALUE(1))
        );
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.POPRER_HELP_VALUE(i + 1)).text().contains(infos.get(i).get("quantity")),
                    Ensure.that(OrderDetailPage.POPRER_HELP_REASON(i + 1)).text().contains(infos.get(i).get("reason")),
                    Ensure.that(OrderDetailPage.POPRER_HELP_UPDATE_BY(i + 1)).text().contains(infos.get(i).get("updateBy")),
//                    Check.whether(infos.get(i).get("updateOn").equals(""))
//                            .otherwise(Ensure.that(OrderDetailPage.POPRER_HELP_UPDATE_ON(i + 1)).text().contains(CommonHandle.setDate2(infos.get(i).get("updateOn"), "MM/dd/yy"))),
                    Ensure.that(OrderDetailPage.POPRER_HELP_NOTE(i + 1)).text().contains(infos.get(i).get("note")),
                    Ensure.that(OrderDetailPage.POPRER_HELP_SHOW(i + 1)).text().contains(infos.get(i).get("showOnVendor"))
            );
        }

        theActorInTheSpotlight().attemptsTo(
                Click.on(OrderDetailPage.HELP_OF_QUANTITY_OF_LINEITEM(info.get("order") + info.get("sub"), info.get("subID"))),
                CommonWaitUntil.isNotVisible(OrderDetailPage.POPRER_HELP_VALUE(1))
        );
    }

    @And("Admin create subtraction items in order detail")
    public void createSubtraction(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrders.editDeductionQuantity(map)
            );
        }
    }

    @And("Admin delete line item of sku {string} in create order")
    public void admin_delete_item_in_create_order(String skuID) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.deleteLineItemCreate(skuID)
        );
    }

    @And("Admin verify invalid file upload CSV in create ghost order")
    public void admin_verify_invalid_file_upload_csv() {
        theActorInTheSpotlight().attemptsTo(
                // verify invalid file type
                CommonFile.upload2("anhJPEG.jpg", CreateNewOrderPage.UPLOAD_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Invalid file type.")),
                Ensure.that(CommonAdminForm.ALERT_MESSAGE("Invalid file type.")).isDisplayed(),
                // verify file max size
                CommonFile.upload1("10MBgreater.jpg", CreateNewOrderPage.UPLOAD_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                Ensure.that(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")).isDisplayed()
        );
    }

    @And("Admin verify COI tab")
    public void admin_verify_COI_tab() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.COI_HELP_ICON),
                MoveMouse.to(VendorCompaniesPage.COI_HELP_ICON),
                CommonWaitUntil.isVisible(VendorCompaniesPage.COI_HELP_POPUP),
                Ensure.that(VendorCompaniesPage.COI_HELP_POPUP).text().contains(AdminConstant.COI),
                // verify choose coi file preview tooltip
                MoveMouse.to(VendorCompaniesPage.COI_FILE_PREVIEW),
                CommonWaitUntil.isVisible(VendorCompaniesPage.COI_FILE_PREVIEW_TOOLTIP),
                // verify choose coi file icon tooltip
                MoveMouse.to(VendorCompaniesPage.COI_FILE_PREVIEW_ICON),
                CommonWaitUntil.isVisible(VendorCompaniesPage.COI_FILE_PREVIEW_ICON_TOOLTIP)
        );
    }

    @And("Admin verify link Vendor Service Agreement in coi popup")
    public void admin_verify_link_in_coi_popup() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.COI_HELP_ICON),
                MoveMouse.to(VendorCompaniesPage.COI_HELP_ICON),
                CommonWaitUntil.isVisible(VendorCompaniesPage.COI_HELP_POPUP),
                Click.on(VendorCompaniesPage.COI_HELP_POPUP_LINK),
                // switch tab temp service
                Switch.toWindowTitled("Terms of service - For Vendors - Pod Foods | Online Distribution Platform for Emerging Brands"),
                CommonWaitUntil.isVisible(TermServiceBrand.TERM_OF_SERVICE_LABEL),
                WindowTask.switchToChildWindowsByTitle("AT Create Vendor Company 02 Edit")
        );
    }

    @And("Admin verify error message of coi")
    public void admin_verify_error_message_of_coi() {
        theActorInTheSpotlight().attemptsTo(
                // blank file preview file
                Enter.theValue(CommonHandle.setDate2("currentDate", "MM/dd/yy")).into(VendorCompaniesPage.COI_START_DATE_TEXTBOX).thenHit(Keys.ENTER),
                Enter.theValue(CommonHandle.setDate2("Plus1", "MM/dd/yy")).into(VendorCompaniesPage.COI_EXPIRY_DATE_TEXTBOX).thenHit(Keys.ENTER),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Certificate of insurance attachment can't be blank")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                WindowTask.threadSleep(1000),
                Click.on(VendorCompaniesPage.REFRESH_BUTTON),
                // blank expiry date
                CommonWaitUntil.isVisible(VendorCompaniesPage.COI_START_DATE_TEXTBOX),
                CommonFile.upload2("anhJPEG.jpg", VendorCompaniesPage.COI_UPLOAD_BUTTON),
                Enter.theValue(CommonHandle.setDate2("currentDate", "MM/dd/yy")).into(VendorCompaniesPage.COI_START_DATE_TEXTBOX).thenHit(Keys.ENTER),
                MoveMouse.to(VendorCompaniesPage.COI_EXPIRY_DATE_TEXTBOX),
                Click.on(CommonAdminForm.ICON_CIRCLE_DELETE),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Certificate of insurance expiry date can't be blank")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                WindowTask.threadSleep(1000),
                Click.on(VendorCompaniesPage.REFRESH_BUTTON),
                // blank start date
                CommonWaitUntil.isVisible(VendorCompaniesPage.COI_START_DATE_TEXTBOX),
                Enter.theValue(CommonHandle.setDate2("Plus1", "MM/dd/yy")).into(VendorCompaniesPage.COI_EXPIRY_DATE_TEXTBOX).thenHit(Keys.ENTER),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Certificate of insurance start date can't be blank")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                WindowTask.threadSleep(1000),
                Click.on(VendorCompaniesPage.REFRESH_BUTTON)
        );
    }

    @And("Admin verify other tab in company document")
    public void admin_verify_other_tab_in_company_document() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.OTHER_TAB),
                Click.on(VendorCompaniesPage.OTHER_TAB),
                // Verify
                CommonWaitUntil.isVisible(VendorCompaniesPage.OTHER_TAB_NOTE1),
                Ensure.that(VendorCompaniesPage.OTHER_TAB_NOTE1).isDisplayed(),
                Ensure.that(VendorCompaniesPage.OTHER_TAB_NOTE2).isDisplayed()
        );
    }

    @And("Admin add file other tab in company document")
    public void admin_upload_file_other_tab_in_company_document(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.uploadFileOtherTab(infos.get(0))
        );
    }

    @And("Admin subscribe order")
    public void admin_subscribe_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.subscribe()
        );
    }

    @And("Admin unsubscribe order")
    public void admin_unsubscribe_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.unsubscribe()
        );
    }

    @And("Admin verify history fulfillment status changelog in order detail")
    public void admin_verify_history_fulfillment_status_changelog_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrderDetailPage.FULFILLMENT_HISTORY_ICON),
                    Click.on(OrderDetailPage.FULFILLMENT_HISTORY_ICON),
                    CommonWaitUntil.isVisible(OrderDetailPage.FULFILLMENT_HISTORY_STATE(i + 1)),
                    Ensure.that(OrderDetailPage.FULFILLMENT_HISTORY_STATE(i + 1)).text().contains(infos.get(i).get("state")),
                    Ensure.that(OrderDetailPage.FULFILLMENT_HISTORY_UPDATE_BY(i + 1)).text().contains(infos.get(i).get("updatedBy")),
                    Ensure.that(OrderDetailPage.FULFILLMENT_HISTORY_UPDATE_ON(i + 1)).text().contains(CommonHandle.setDate2(infos.get(i).get("updatedOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin verify history fulfillment status changelog don't display in order detail")
    public void admin_verify_history_fulfillment_status_changelog_not_display() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(OrderDetailPage.FULFILLMENT_HISTORY_ICON)
        );

    }

    @And("Admin fulfill by mark as fulfilled in order detail")
    public void admin_fulfill_by_mark_as_fulfilled_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.fulfillByMarkAsFulfilled(infos.get(0))
        );
    }

    @And("Admin verify display surcharges button of order {string} with sub {string} error with message {string}")
    public void admin_verify_display_surcharges_button_error(String order, String sub, String message) {
        order = Serenity.sessionVariableCalled("ID Order");
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrderDetailPage.DISPLAY_SURCHARGE_BUTTON(order + sub)),
                Click.on(OrderDetailPage.DISPLAY_SURCHARGE_BUTTON(order + sub)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin verify history delete line item in order detail")
    public void admin_verify_history_delete_line_item_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Scroll.to(OrderDetailPage.HISTORY_LINEITEM_HELP_ICON(infos.get(0).get("sku"))),
                Click.on(OrderDetailPage.HISTORY_LINEITEM_HELP_ICON(infos.get(0).get("sku"))),
                CommonWaitUntil.isVisible(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Deleted by")),
                Ensure.that(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Deleted by")).text().contains(infos.get(0).get("deletedBy")),
                Check.whether(infos.get(0).get("deletedOn").isEmpty())
                        .otherwise(Ensure.that(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Deleted on")).text().contains(CommonHandle.setDate2(infos.get(0).get("deletedOn"), "MM/dd/yy"))),
                Ensure.that(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Reason")).text().contains(infos.get(0).get("reason")),
                Ensure.that(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Note")).text().contains(infos.get(0).get("note")),
                Ensure.that(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Show on vendor")).text().contains(infos.get(0).get("showOnVendor"))
        );
    }

    @And("Admin turn off show on vendor of history delete line item in order detail")
    public void admin_turn_off_history_delete_line_item_in_order_detail() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Show on vendor")),
                Click.on(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Show on vendor")),
                CommonWaitUntil.isVisible(OrderDetailPage.SHOW_ON_VENDOR_HISTORY_LINEITEM_UPDATE_BUTTON),
                Click.on(OrderDetailPage.SHOW_ON_VENDOR_HISTORY_LINEITEM_BUTTON),
                CommonWaitUntil.isVisible(OrderDetailPage.SHOW_ON_VENDOR_HISTORY_LINEITEM_UPDATE_BUTTON),
                Click.on(OrderDetailPage.SHOW_ON_VENDOR_HISTORY_LINEITEM_UPDATE_BUTTON),
                CommonWaitUntil.isNotVisible(OrderDetailPage.SHOW_ON_VENDOR_HISTORY_LINEITEM_UPDATE_BUTTON),
                Ensure.that(OrderDetailPage.DELETE_BY_HISTORY_LINEITEM("Show on vendor")).text().contains("No")
        );
    }

    /**
     * Export order
     */
    @And("Admin export order detail")
    public void export_order_detail() {
        String fileName = Serenity.sessionVariableCalled("ID Order API") + "-" + Serenity.sessionVariableCalled("Number Order API") + "-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        Serenity.setSessionVariable("Filename Order Detail CSV").to(fileName);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.exportOrderDetail(fileName)
        );
    }

    @And("Admin check content file export {string}")
    public void checkContentExportAll(String type, DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        String filename = null;
        if (type.equals("order detail")) {
            filename = Serenity.sessionVariableCalled("Filename Order Detail CSV");
            System.out.println("Filename Order Detail CSV " + filename);
        }
        if (type.equals("order list")) {
            filename = Serenity.sessionVariableCalled("Filename Order List CSV");
            System.out.println("Filename Order List CSV " + filename);
        }
        if (type.equals("delete order detail")) {
            filename = Serenity.sessionVariableCalled("Filename Delete Order Detail CSV");
            System.out.println("Filename Delete Order Detail CSV " + filename);
        }
        String path = System.getProperty("user.dir") + "/target/" + filename;
        List<String[]> file = CommonFile.readDataLineByLine(path);
        List<Map<String, String>> actual = CommonHandle.convertListArrayStringToMapString(file);
        System.out.println("actual number " + actual.get(0).get("Number"));
        System.out.println("expect number " + Serenity.sessionVariableCalled("Number Order API").toString());
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(actual.get(i).get("Order ID")).contains(Serenity.sessionVariableCalled("ID Order API").toString()),
                    Ensure.that(actual.get(i).get("Number")).contains(Serenity.sessionVariableCalled("Number Order API").toString()),
                    Ensure.that(actual.get(i).get("Customer PO")).contains(expected.get(i).get("customerPO")),
                    Ensure.that(actual.get(i).get("Date")).contains(CommonHandle.setDate2(expected.get(i).get("date"), "M/dd/yy")),
                    Ensure.that(actual.get(i).get("Store")).contains(expected.get(i).get("store")),
                    Ensure.that(actual.get(i).get("Shipping address")).contains(expected.get(i).get("shippingAddress")),
                    Ensure.that(actual.get(i).get("Receiving date")).contains(expected.get(i).get("receivingDate")),
                    Ensure.that(actual.get(i).get("Earliest receiving time")).contains(expected.get(i).get("earlestReceivingTime")),
                    Ensure.that(actual.get(i).get("Latest receiving time")).contains(expected.get(i).get("latestReceivingTime")),
                    Ensure.that(actual.get(i).get("Buyer")).contains(expected.get(i).get("buyer")),
                    Ensure.that(actual.get(i).get("Payment method")).contains(expected.get(i).get("paymentMethod")),
                    Ensure.that(actual.get(i).get("Region")).contains(expected.get(i).get("region")),
                    Ensure.that(actual.get(i).get("Brand ID")).contains(expected.get(i).get("brandID")),
                    Ensure.that(actual.get(i).get("Brand")).contains(expected.get(i).get("brand")),
                    Ensure.that(actual.get(i).get("Product")).contains(expected.get(i).get("product")),
                    Ensure.that(actual.get(i).get("SKU name")).contains(expected.get(i).get("sku").equals("random") ? Serenity.sessionVariableCalled("SKU inventory").toString() : expected.get(i).get("sku")),
                    Ensure.that(actual.get(i).get("Price/case")).contains(expected.get(i).get("priceCase")),
                    Ensure.that(actual.get(i).get("Unit/case")).contains(expected.get(i).get("unitCase")),
                    Ensure.that(actual.get(i).get("Taxes")).contains(expected.get(i).get("taxes")),
                    Ensure.that(actual.get(i).get("Quantity")).contains(expected.get(i).get("quantity")),
                    Ensure.that(actual.get(i).get("Promotion Value")).contains(expected.get(i).get("promotion")),
                    Ensure.that(actual.get(i).get("Item value")).contains(expected.get(i).get("itemValue")),
                    Ensure.that(actual.get(i).get("Item price")).contains(expected.get(i).get("itemPrice")),
                    Ensure.that(actual.get(i).get("Fulfilment date")).contains(expected.get(i).get("fulfillmentDate")),
                    Ensure.that(actual.get(i).get("Delivery method")).contains(expected.get(i).get("deliveryMethod")),
                    Ensure.that(actual.get(i).get("Delivery method detail")).contains(expected.get(i).get("deliveryDetail")),
                    Check.whether(actual.get(i).get("Sub invoice number").isEmpty())
                            .otherwise(Ensure.that(actual.get(i).get("Sub invoice number")).contains(Serenity.sessionVariableCalled("Number Order API").toString() + expected.get(i).get("sub")))
            );
        }
    }

    @And("Admin export order list")
    public void export_order_list() {
        String fileName = "order-details-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        Serenity.setSessionVariable("Filename Order List CSV").to(fileName);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.exportOrderList(fileName)
        );
    }

    @And("Admin send ETA email")
    public void admin_send_eta_email() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.sendEtaEmail()
        );
    }

    @And("Admin verify ETA email not set")
    public void admin_verify_eta_not_set() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrderDetailPage.ETA_NOT_SET),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Send ETA email"))
        );
    }
}

