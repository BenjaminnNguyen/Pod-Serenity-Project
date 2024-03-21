package steps.vendor.storeList;

import cucumber.constants.vendor.WebsiteConstants;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.vendor.storeList.HandleVendorStoreList;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.storeList.VendorStoreListPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class VendorStoreListStepDefinitions {

    @And("Vendor go to {string} of store list")
    public void vendor_go_to_of_store_list(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorStoreListPage.DYNAMIC_TAB(type)),
                Click.on(VendorStoreListPage.DYNAMIC_TAB(type))
        );
    }

    @And("Vendor search info of store list")
    public void vendor_search_info_of_store_list(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : infos)
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorStoreList.search(map)
            );
    }

    @And("Vendor create account store list")
    public void vendor_create_account_store_list(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStoreList.create(infos.get(0))
        );
    }

    @And("Vendor verify store list after search")
    public void vendor_verify_store_list_after_search(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorStoreListPage.RESULT_BUYER_COMPANY(map.get("buyerCompany"))),
                    Ensure.that(VendorStoreListPage.RESULT_BUYER_COMPANY(map.get("buyerCompany"))).text().contains(map.get("buyerCompany")),
                    Ensure.that(VendorStoreListPage.RESULT_STORE_TYPE(map.get("buyerCompany"))).text().contains(map.get("storeType")),
                    Ensure.that(VendorStoreListPage.RESULT_KEY_ACCOUNT(map.get("buyerCompany"))).text().contains(map.get("keyAccount")),
                    Ensure.that(VendorStoreListPage.RESULT_CURRENT_STORE(map.get("buyerCompany"))).attribute("value").contains(map.get("currentStore")),
                    Ensure.that(VendorStoreListPage.RESULT_DISTRIBUTION_TYPE(map.get("buyerCompany"))).attribute("value").contains(map.get("distributionType")),
                    Ensure.that(VendorStoreListPage.RESULT_CONTACTED(map.get("buyerCompany"))).attribute("value").contains(map.get("contacted")),
                    Ensure.that(VendorStoreListPage.RESULT_SAMPLE_SENT(map.get("buyerCompany"))).attribute("value").contains(map.get("sampleSent")),
                    Ensure.that(VendorStoreListPage.RESULT_NOTE(map.get("buyerCompany"))).attribute("value").contains(map.get("note")),
                    Ensure.that(VendorStoreListPage.RESULT_POD_FOODS_NOTES(map.get("buyerCompany"))).text().contains(map.get("podFoodsNotes"))
            );
            if (map.containsKey("region")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorStoreListPage.RESULT_REGION(map.get("buyerCompany"))).text().contains(map.get("region"))
                );
            }
        }
    }

    @And("Vendor check warning on store list page")
    public void vendor_check_warning() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorStoreListPage.RESULT_POD_FOODS_NOTES),
                Ensure.that(VendorStoreListPage.RESULT_POD_FOODS_NOTES).text().contains(WebsiteConstants.VENDOR_STORE_LIST_WARNING)
        );
    }

    @And("Vendor check redirect link to buyer company on store list")
    public void vendor_check_link(String buyerName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorStoreListPage.LINK_BCN(buyerName))
        );
    }

    @And("Vendor edit record store list")
    public void vendor_edit_store_list(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStoreList.edit(infos.get(0))
        );
    }

    @And("Vendor choose {string} buyer company mass editing store list")
    public void chooseBcnMassEditing(String all, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (all.equalsIgnoreCase("all"))
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorStoreList.chooseAllMassEditing()
            );
        else
            for (Map<String, String> map : list)
                theActorInTheSpotlight().attemptsTo(
                        HandleVendorStoreList.chooseStoreMassEditing(map.get("buyerCompany"))
                );
    }

    @And("Vendor mass editing store list")
    public void massEditing(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStoreList.massEditing(list.get(0))
        );
    }

    @And("Vendor check cannot mass editing store list and unselect above stores")
    public void cannotMassEditing(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ALERT_TEXT("Your selected action is not applicable for the following stores because Distribution type cannot be updated once it's Pod is Distributor:"))
        );
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonVendorPage.DYNAMIC_ALERT_TEXT(map.get("buyerCompany"))).isDisplayed()
            );
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CommonVendorPage.DYNAMIC_ALERT_TEXT("Please unselect them before continuing.")).isDisplayed(),
                Click.on(CommonVendorPage.DYNAMIC_ALERT_BUTTON("Unselect above stores"))
        );
    }
}
