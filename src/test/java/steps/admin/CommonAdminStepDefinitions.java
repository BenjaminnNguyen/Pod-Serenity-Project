package steps.admin;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.promotions.HandlePromotions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Vendor.inventory.VendorWithdrawalRequestPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class CommonAdminStepDefinitions {

    @And("{word} close dialog form")
    public void close(String actor) {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.closeCreateForm()
        );
    }

    @And("Admin uncheck field of edit visibility in search")
    public void admin_uncheck_field_of_edit_visibility_in_search(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                CommonTaskAdmin.editVisibility(infos.get(0))
        );
    }

    @And("Admin verify region available")
    public void verifyRegion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup region")),
                Click.on(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup region")),
                WindowTask.threadSleep(1000)
        );
        List<WebElementFacade> regions = VendorWithdrawalRequestPage.LIST_REGION.resolveAllFor(theActorInTheSpotlight());
        theActorInTheSpotlight().should(
                seeThat("Number of region are available", CommonQuestions.getNumElement(VendorWithdrawalRequestPage.LIST_REGION), equalTo(list.size()))
        );
        for (int i = 0; i < regions.size(); i++)
            theActorInTheSpotlight().should(
                    seeThat("Number of region are available", CommonQuestions.webElementFacadeText(regions.get(i)), equalToIgnoringCase(list.get(i).get("region")))
            );
        theActorInTheSpotlight().attemptsTo(
                Hit.the(Keys.TAB).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup region"))
        );
    }

    @And("Admin save filter by info")
    public void admin_save_filter(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.saveFilter(infos.get(0))
        );
    }

    @And("Admin choose filter preset is {string}")
    public void admin_choose_filter(String filterName) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.chooseFilter(filterName)
        );
    }

    @And("Admin verify field search uncheck all in edit visibility")
    public void admin_verify_field_search_uncheck_in_edit_visibility(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.uncheckAllEditVisibility(info)
        );
    }

    @And("Admin verify field search in edit visibility")
    public void admin_verify_field_search_in_edit_visibility(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.checkAllEditVisibility(info)
        );
    }

    @And("Admin verify search field after choose filter")
    public void admin_verify_search_field_after_choose_filter(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000)
        );
        if (info.containsKey("number")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")).attribute("value").contains(infos.get(0).get("number")));
        }
        if (info.containsKey("orderSpecific")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("custom_store_name")).attribute("value").contains(infos.get(0).get("orderSpecific")));
        }
        if (info.containsKey("stores")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("store_id")).text().contains(infos.get(0).get("store")));
        }
        if (info.containsKey("stores")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("store_id")).text().contains(infos.get(0).get("store")));
        }
        if (info.containsKey("buyer")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).attribute("value").contains(infos.get(0).get("buyer")));
        }
        if (info.containsKey("vendorCompany")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id")).attribute("value").contains(infos.get(0).get("vendorCompany")));
        }
        if (info.containsKey("brand")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id")).attribute("value").contains(infos.get(0).get("brand")));
        }
        if (info.containsKey("sku")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("product_variant_ids")).text().contains(infos.get(0).get("sku")));
        }
        if (info.containsKey("upc")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("upc")).attribute("value").contains(infos.get(0).get("upc")));
        }
        if (info.containsKey("buyerCompany")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id")).attribute("value").contains(infos.get(0).get("buyerCompany")));
        }
        if (info.containsKey("fulfillment")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("fulfillment_states")).text().contains(infos.get(0).get("fulfillment")));
        }
        if (info.containsKey("fulfillmentOrder")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("fulfillment_state")).attribute("value").contains(infos.get(0).get("fulfillmentOrder")));
        }
        if (info.containsKey("buyerPayment")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_payment_state")).attribute("value").contains(infos.get(0).get("buyerPayment")));
        }
        if (info.containsKey("region")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id")).attribute("value").contains(infos.get(0).get("region")));
        }
        if (info.containsKey("route")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX_MULTI("route_id")).text().contains(infos.get(0).get("route")));
        }
        if (info.containsKey("managed")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_manager_id")).attribute("value").contains(infos.get(0).get("managed")));
        }
        if (info.containsKey("pod")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("lack_pod")).attribute("value").contains(infos.get(0).get("pod")));
        }
        if (info.containsKey("tracking")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("lack_tracking")).attribute("value").contains(infos.get(0).get("tracking")));
        }
        if (info.containsKey("startDate")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("startDate"), "MM/dd/yy")));
        }
        if (info.containsKey("endDate")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("endDate"), "MM/dd/yy")));
        }
        if (info.containsKey("temp")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("temperature_name")).attribute("value").contains(infos.get(0).get("temp")));
        }
        if (info.containsKey("oos")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("has_out_of_stock_items")).attribute("value").contains(infos.get(0).get("oos")));
        }
        if (info.containsKey("orderType")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("type")).attribute("value").contains(infos.get(0).get("orderType")));
        }
        if (info.containsKey("exProcess")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("express_progress")).attribute("value").contains(infos.get(0).get("exProcess")));
        }
        if (info.containsKey("edi")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("only_spring_po")).attribute("value").contains(infos.get(0).get("edi")));
        }
        if (info.containsKey("perPage")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("per_page")).attribute("value").contains(infos.get(0).get("perPage")));
        }
        if (info.containsKey("numberCreditMemo")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")).attribute("value").contains(infos.get(0).get("numberCreditMemo")));
        }
        if (info.containsKey("buyerEmail")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_email")).attribute("value").contains(infos.get(0).get("buyerEmail")));
        }
        if (info.containsKey("state")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("state")).attribute("value").contains(infos.get(0).get("state")));
        }
        if (info.containsKey("id")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("id")).attribute("value").contains(infos.get(0).get("id")));
        }
        if (info.containsKey("vendorPayment")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_payment_state")).attribute("value").contains(infos.get(0).get("vendorPayment")));
        }
        if (info.containsKey("customPOInprocess")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("customer_po")).attribute("value").contains(infos.get(0).get("customPOInprocess")));
        }
        if (info.containsKey("createdByInprocess")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("admin_id")).attribute("value").contains(infos.get(0).get("createdByInprocess")));
        }
        if (info.containsKey("statusInprocess")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("state")).attribute("value").contains(infos.get(0).get("statusInprocess")));
        }
        if (info.containsKey("email")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email")).attribute("value").contains(infos.get(0).get("email")));
        }
        if (info.containsKey("adminUser")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("admin_id")).attribute("value").contains(infos.get(0).get("adminUser")));
        }
        if (info.containsKey("status")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status")).attribute("value").contains(infos.get(0).get("status")));
        }
        if (info.containsKey("fullName")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("full_name")).attribute("value").contains(infos.get(0).get("fullName")));
        }
        if (info.containsKey("addressCity")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_address_city")).attribute("value").contains(infos.get(0).get("addressCity")));
        }
        if (info.containsKey("addressState")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_address_address_state_id")).attribute("value").contains(infos.get(0).get("addressState")));
        }
        if (info.containsKey("tag")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids")).attribute("value").contains(infos.get(0).get("tag")));
        }
        if (info.containsKey("approved")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("approved")).attribute("value").contains(infos.get(0).get("approved")));
        }
        if (info.containsKey("shopify")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("shopify")).attribute("value").contains(infos.get(0).get("shopify")));
        }
        if (info.containsKey("activeState")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("active_state")).attribute("value").contains(infos.get(0).get("activeState")));
        }
    }

    @And("Admin delete filter preset is {string}")
    public void admin_delete_filter(String filterName) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.deleteFilter(filterName)
        );
    }

    @And("Admin verify filter {string} is not display")
    public void admin_verify_filter_not_display(String filterName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.FILTER_NAME_SAVED(filterName))
        );
    }

    @And("Admin go back with button")
    public void goBack() {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.goBack()
        );
    }

}
