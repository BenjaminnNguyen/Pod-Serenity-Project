package steps.admin.orders;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.brands.HandleBrand;
import cucumber.tasks.admin.orders.HandlePurchaseOrder;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.orders.PurchaseRequestsPage;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminPurchaseOrderStepDefinitions {

    @And("Admin search the purchase orders by info")
    public void search_the_purchase_order_(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));

        if (infos.get(0).get("email").equals("random")) {
            info = CommonTask.setValue(infos.get(0), "email", infos.get(0).get("email"), Serenity.sessionVariableCalled("Purchase Order Email"), "random");
        }
        if (infos.get(0).get("purchaseNumber").equals("random")) {
            info = CommonTask.setValue(infos.get(0), "purchaseNumber", infos.get(0).get("purchaseNumber"), Serenity.sessionVariableCalled("Purchase Order Number"), "random");
        }
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandlePurchaseOrder.search(info)
        );
    }

    @And("Admin verify result purchase requests")
    public void admin_verify_result_purchase_requests(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(expected.get(0));
        if (info.get("email").equals("random")) {
            info = CommonTask.setValue(expected.get(0), "email", expected.get(0).get("email"), Serenity.sessionVariableCalled("Purchase Order Email"), "random");
        }

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(PurchaseRequestsPage.LIST_RESULT_CURRENT_RETAIL(info.get("email"))).text().contains(expected.get(0).get("retailPartner")),
                Ensure.that(PurchaseRequestsPage.LIST_RESULT_BUYER(info.get("email"))).text().contains(expected.get(0).get("buyer")),
                Ensure.that(PurchaseRequestsPage.LIST_RESULT_EMAIL(info.get("email"))).text().contains(info.get("email")),
                Ensure.that(PurchaseRequestsPage.LIST_RESULT_STORE(info.get("email"))).text().contains(expected.get(0).get("store")),
                Ensure.that(PurchaseRequestsPage.LIST_RESULT_STATUS(info.get("email"))).text().contains(expected.get(0).get("status"))
        );
    }

    @And("Admin get ID of purchase requests in result")
    public void admin_get_id_purchase_requests_in_result() {
        // lưu purchase request number
        String id = Text.of(PurchaseRequestsPage.LIST_RESULT_NUMBER_PURCHASE(Serenity.sessionVariableCalled("Purchase Order Email"))).answeredBy(theActorInTheSpotlight()).toString();
        Serenity.setSessionVariable("Purchase Order Number").to(id);
    }

    @And("Admin go to detail of purchase requests {string}")
    public void admin_go_to_purchase_requestst(String number) {
        String purchaseNumber = null;
        if (number.equals("create by vendor")) {
            purchaseNumber = Serenity.sessionVariableCalled("Purchase Order Number");
        }
        theActorInTheSpotlight().attemptsTo(
                HandlePurchaseOrder.goToDetail(purchaseNumber)
        );
    }

    @And("Admin verify general information of purchase requests in detail")
    public void admin_verify_general_information_of_purchase_requests_in_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(expected.get(0));
        if (info.get("email").equals("random")) {
            info = CommonTask.setValue(info, "email", info.get("email"), Serenity.sessionVariableCalled("Purchase Order Email"), "random");
        }
        if (info.get("purchaseNumber").equals("random")) {
            info = CommonTask.setValue(info, "purchaseNumber", info.get("purchaseNumber"), Serenity.sessionVariableCalled("Purchase Order Number"), "random");
        }

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(PurchaseRequestsPage.STORE_PURCHASE_DETAIL),
                Ensure.that(PurchaseRequestsPage.STORE_PURCHASE_DETAIL).text().contains(info.get("store")),
                Ensure.that(PurchaseRequestsPage.PURCHASE_NUMBER_DETAIL).text().contains(info.get("purchaseNumber")),
                Check.whether(info.get("adminNote").isEmpty())
                        .otherwise(Ensure.that(PurchaseRequestsPage.ADMIN_NOTE_PURCHASE_DETAIL).text().contains(info.get("adminNote"))),
                Check.whether(info.get("adminNote").isEmpty())
                        .otherwise(Ensure.that(PurchaseRequestsPage.ADMIN_USER_PURCHASE_DETAIL).text().contains(info.get("adminUser"))),
                Ensure.that(PurchaseRequestsPage.BUYER_PURCHASE_DETAIL).text().contains(info.get("buyer")),
                Ensure.that(PurchaseRequestsPage.BUYER_EMAIL_PURCHASE_DETAIL).text().contains(info.get("email")),
                Ensure.that(PurchaseRequestsPage.RETAIL_PARTNER_PURCHASE_DETAIL).text().contains(info.get("retailPartner")),
                Ensure.that(PurchaseRequestsPage.STATUS_PURCHASE_DETAIL).text().contains(info.get("status"))
        );
    }

    @And("Admin verify requested items of purchase requests in detail")
    public void admin_verify_requested_items_of_purchase_requests_in_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(expected.get(0));

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(PurchaseRequestsPage.BRAND_REQUESTED_ITEMS(info.get("skuID"))),
                Ensure.that(PurchaseRequestsPage.BRAND_REQUESTED_ITEMS(info.get("skuID"))).text().contains(info.get("brand")),
                Ensure.that(PurchaseRequestsPage.PRODUCT_REQUESTED_ITEMS(info.get("skuID"))).text().contains(info.get("product")),
                Ensure.that(PurchaseRequestsPage.SKU_REQUESTED_ITEMS(info.get("skuID"))).text().contains(info.get("sku")),
                Ensure.that(PurchaseRequestsPage.SKU_ID_REQUESTED_ITEMS(info.get("skuID"))).text().contains(info.get("skuID"))
        );
    }

    @And("Admin edit info of purchase requests in detail")
    public void admin_edit_info_purchase_requestst(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                HandlePurchaseOrder.editInfo(infos.get(0))
        );
    }

    @And("Admin change status of purchase requests in detail to {string}")
    public void admin_change_status_of_purchase_requests(String status) {
        theActorInTheSpotlight().attemptsTo(
                HandlePurchaseOrder.changeStatus(status)
        );
    }

    @And("Admin verify history status of purchase request")
    public void admin_verify_active_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(PurchaseRequestsPage.STATUS_ICON_HISTORY_DETAIL),
                MoveMouse.to(PurchaseRequestsPage.STATUS_ICON_HISTORY_DETAIL),
                CommonWaitUntil.isVisible(VendorCompaniesPage.ACTIVE_HISTORY_STATE),
                //Verify
                Ensure.that(CommonAdminForm.ACTIVE_HISTORY_STATE).text().contains(infos.get(0).get("state")),
                Ensure.that(CommonAdminForm.ACTIVE_HISTORY_UPDATE_BY).text().contains(infos.get(0).get("updateBy")),
                Ensure.that(CommonAdminForm.ACTIVE_HISTORY_UPDATE_ON).text().contains(CommonHandle.setDate2(infos.get(0).get("updateOn"), "MM/dd/yy"))
        );
    }

    @And("Admin delete of purchase request in detail")
    public void admin_delete_of_purchase_request_in_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandlePurchaseOrder.delete()
        );
    }

    @And("Admin navigate brand {string} link of sku ID {string} in purchase detail")
    public void navigate_brand_link_in_purchase_detail(String brand, String skuID) {
        theActorInTheSpotlight().attemptsTo(
                // verify footer link brand
                HandlePurchaseOrder.verifyBrandLink(brand, skuID)
        );
    }

    @And("Admin navigate product {string} link of sku ID {string} in purchase detail")
    public void navigate_product_link_in_purchase_detail(String product, String skuID) {
        theActorInTheSpotlight().attemptsTo(
                // verify footer link product
                HandlePurchaseOrder.verifyProductLink(product, skuID)

        );
    }
}
