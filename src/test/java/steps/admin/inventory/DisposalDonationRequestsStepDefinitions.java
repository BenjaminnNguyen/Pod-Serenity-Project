package steps.admin.inventory;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.inventory.HandleInventoryRequest;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.disposeDonateRequest.InventoryRequestPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class DisposalDonationRequestsStepDefinitions {

    @And("Admin search disposal donation requests")
    public void admin_search_disposal_donation_requests(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValue(map, "number", map.get("number"), Serenity.sessionVariableCalled("Request Dispose Donate Number"), "random");
            info = CommonTask.setValue(info, "number", info.get("number"), Serenity.sessionVariableCalled("Inventory Request Number API"), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.showFilter(),
                    CommonTaskAdmin.resetFilter(),
                    HandleInventoryRequest.search(info)
            );
        }
    }

    @And("Admin verify result dispose donate request")
    public void admin_verify_result_dispose_donate_request(DataTable dt) {
        List<Map<String, String>> map = dt.asMaps(String.class, String.class);
        Map<String, String> info = CommonTask.setValue(map.get(0), "number", map.get(0).get("number"), Serenity.sessionVariableCalled("Request Dispose Donate Number"), "random");
        info = CommonTask.setValue(info, "number", map.get(0).get("number"), Serenity.sessionVariableCalled("Inventory Request Number API"), "create by api");
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(InventoryRequestPage.RESULT_NUMBER(info.get("number"))).isDisplayed(),
                Ensure.that(InventoryRequestPage.RESULT_REQUEST_DATE).text().contains(CommonHandle.setDate2(info.get("requestDate"), "MM/dd/yy")),
                Ensure.that(InventoryRequestPage.RESULT_VENDOR_COMPANY).attribute("data-original-text").contains(info.get("vendorCompany")),
                Ensure.that(InventoryRequestPage.RESULT_BRAND).text().contains(info.get("brand")),
                Ensure.that(InventoryRequestPage.RESULT_REGION).text().contains(info.get("region")),
                Ensure.that(InventoryRequestPage.RESULT_TYPE).text().contains(info.get("type")),
                Ensure.that(InventoryRequestPage.RESULT_STATUS).text().contains(info.get("status"))
        );
    }

    @And("Admin verify create inventory requests with blank value")
    public void admin_verify_create_inventory_requests_with_blank_value() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventoryRequest.goToCreate(),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(InventoryRequestPage.D_CREATE_ERROR_MESSAGE("Vendor Company")),
                Ensure.that(InventoryRequestPage.D_CREATE_ERROR_MESSAGE("Vendor Company")).text().contains("Please select a vendor company for the inventory request"),
                Ensure.that(InventoryRequestPage.D_CREATE_ERROR_MESSAGE("Region")).text().contains("Please select a region for the inventory request"),
                Ensure.that(InventoryRequestPage.D_CREATE_ERROR_MESSAGE("Type")).text().contains("Please select a type for the inventory request"),
                Ensure.that(InventoryRequestPage.D_CREATE_ERROR_MESSAGE("Pullable Inventory")).text().contains("Pullable inventory must have at least one")
        );
    }

    @And("Admin create inventory requests")
    public void admin_search_inventory_requests(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleInventoryRequest.goToCreate(),
                HandleInventoryRequest.create(infos.get(0))
        );
    }

    @And("Admin edit new inventory requests")
    public void admin_edit_inventory_requests(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleInventoryRequest.editNew(infos.get(0))
        );
    }

    @And("Admin go to add pullable inventory")
    public void admin_go_to_add_pullable_inventory() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventoryRequest.goToAddInventory()
        );
    }

    @And("Admin add inventory to create inventory requests")
    public void admin_add_inventory_to_create_inventory_request(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> temp = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleInventoryRequest.goToAddInventory(),
                    HandleInventoryRequest.searchPullAbleInventory(temp),
                    HandleInventoryRequest.addLotcodeAfterSearch(temp)
            );
        }
    }

    @And("Admin search pull able inventory")
    public void admin_search_pull_able_inventory(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> temp = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleInventoryRequest.searchPullAbleInventory(temp)
            );
        }
    }

    @And("Admin choose lots to pull able inventory")
    public void admin_choose_lots_pull_able_inventory(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> temp = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleInventoryRequest.addLotcodeAfterSearch(temp)
            );
        }
    }

    @And("Admin check lot after search pull able inventory")
    public void admin_verify_search_pull_able_inventory(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            HashMap<String, String> temp = CommonTask.setValue(infos.get(i), "lotCode", infos.get(i).get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + infos.get(i).get("sku") + infos.get(i).get("index")), "random");
            if (temp.get("product").isEmpty())
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(InventoryRequestPage.SEARCH_RESULTS("product-name", i + 1)).isNotDisplayed()
                );
            else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(InventoryRequestPage.SEARCH_RESULTS("product-name", i + 1)).text().contains(temp.get("product")),
                        Ensure.that(InventoryRequestPage.SEARCH_RESULTS("sku-name", i + 1)).text().contains(temp.get("sku")),
                        Ensure.that(InventoryRequestPage.SEARCH_RESULTS("lot-code", i + 1)).text().contains(temp.get("lotCode")),
                        Ensure.that(InventoryRequestPage.SEARCH_RESULTS("expiry-date", i + 1)).text().contains(CommonHandle.setDate2(temp.get("expiryDate"), "MM/dd/yy")),
                        Ensure.that(InventoryRequestPage.SEARCH_RESULTS("pull-date", i + 1)).text().contains(CommonHandle.setDate2(temp.get("pullDate"), "MM/dd/yy"))
                );
        }
    }

    @And("Admin save action in inventory requests")
    public void admin_save_action_in_inventory_request() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventoryRequest.saveAction()
        );
    }

    @And("Admin remove inventory to inventory requests detail")
    public void admin_remove_inventory_to_create_inventory_request(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> temp = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleInventoryRequest.removeInventory(temp)
            );
        }
    }

    @And("Admin create inventory requests success")
    public void admin_create_inventory_request_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventoryRequest.createSuccess()
        );
    }

    @And("Admin create inventory requests and see message {string}")
    public void admin_create_inventory_request_success_and_see_message(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleInventoryRequest.createError(message)
        );
    }

    @And("Admin verify general information of inventory requests detail")
    public void admin_verify_general_information_inventory_request_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(InventoryRequestPage.GENERAL_INFORMATION_DETAIL("vendor-company")),
                Ensure.that(InventoryRequestPage.GENERAL_INFORMATION_DETAIL("vendor-company")).text().contains(infos.get(0).get("vendorCompany")),
                Ensure.that(InventoryRequestPage.GENERAL_INFORMATION_DETAIL("request-date")).text().contains(CommonHandle.setDate2(infos.get(0).get("requestDate"), "MM/dd/yy")),
                Ensure.that(InventoryRequestPage.GENERAL_INFORMATION_DETAIL("pickup-region")).text().contains(infos.get(0).get("region")),
                Ensure.that(InventoryRequestPage.GENERAL_INFORMATION_STATUS).text().contains(infos.get(0).get("status")),
                Ensure.that(InventoryRequestPage.GENERAL_INFORMATION_COMMENT).text().contains(infos.get(0).get("comment")),
                Ensure.that(InventoryRequestPage.GENERAL_INFORMATION_DETAIL("request-type")).text().contains(infos.get(0).get("requestType"))
        );
    }

    @And("Admin verify pullable inventory of inventory requests detail")
    public void admin_verify_pullable_inventory_of_inventory_request_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> temp = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(InventoryRequestPage.PULLABLE_BRAND(temp.get("lotCode"))),
                    Ensure.that(InventoryRequestPage.PULLABLE_BRAND(temp.get("lotCode"))).text().contains(temp.get("brand")),
                    Ensure.that(InventoryRequestPage.PULLABLE_PRODUCT(temp.get("lotCode"))).text().contains(temp.get("product")),
                    Ensure.that(InventoryRequestPage.PULLABLE_SKU(temp.get("lotCode"))).text().contains(temp.get("sku")),
                    Check.whether(temp.get("skuID").isEmpty()).otherwise(
                            Ensure.that(InventoryRequestPage.PULLABLE_SKU_ID(temp.get("lotCode"))).text().contains(temp.get("skuID"))
                    ),
                    Check.whether(temp.get("expiryDate").isEmpty())
                            .otherwise(Ensure.that(InventoryRequestPage.PULLABLE_EXPIRY_DATE(temp.get("lotCode"))).text().contains(CommonHandle.setDate2(temp.get("expiryDate"), "MM/dd/yy"))),
                    Check.whether(temp.get("pullDate").isEmpty())
                            .otherwise(Ensure.that(InventoryRequestPage.PULLABLE_PULL_DATE(temp.get("lotCode"))).text().contains(CommonHandle.setDate2(temp.get("pullDate"), "MM/dd/yy"))),
                    Ensure.that(InventoryRequestPage.PULLABLE_CASE(temp.get("lotCode"))).attribute("value").contains(temp.get("case"))
            );
        }
    }

    @And("Admin get inventory requests number in detail")
    public void admin_get_inventory_request_number() {
        String number = Text.of(InventoryRequestPage.GENERAL_INFORMATION_DETAIL("request-number")).answeredBy(theActorInTheSpotlight());
        number = number.substring(1);
        Serenity.setSessionVariable("Request Dispose Donate Number").to(number);
    }
}
