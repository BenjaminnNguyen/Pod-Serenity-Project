package steps.admin.vendors;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.vendors.HandleVendorSuccessForm;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.vendors.SuccessFormPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class VendorSuccessFormStepDefinitions {

    @And("Admin go to create new vendor success form")
    public void admin_go_to_create_vendor_success_form() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.goToCreateNewForm()
        );
    }

    @And("Admin close popup create new vendor success form")
    public void admin_close_popup_create_vendor_success_form() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.closePopupCreateNewForm()
        );
    }

    @And("Admin search buyer in create new entity of success form")
    public void admin_search_buyer_in_create_new_entity_of_success_form(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Check.whether(infos.get(0).get("vendorCompany").equals(""))
                        .otherwise(
                                HandleVendorSuccessForm.selectVendorInPopupCreate(infos.get(0).get("vendorCompany"))),
                HandleVendorSuccessForm.searchBuyerInPopupCreate(infos.get(0))
        );
    }

    @And("Admin verify message {string} when edit buyer {string} without vendor company in create new entity of success form")
    public void admin_verify_message_when_edit_buyer_without_vendor_company(String message, String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(SuccessFormPage.CREATE_POPUP_SEARCH_BUTTON),
                Click.on(SuccessFormPage.CREATE_POPUP_SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                // Verify
                CommonTask.chooseItemInDropdown1(SuccessFormPage.RESULT_CURRENT_STORE_IN_POPUP(buyerCompany), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Yes")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin verify buyer after search in create new entity of success form")
    public void admin_verify_buyer_after_search_in_create_new_entity_of_success_form(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SuccessFormPage.RESULT_BUYER_COMPANY_IN_POPUP(info.get("buyerCompany"))),
                    Ensure.that(SuccessFormPage.RESULT_BUYER_COMPANY_IN_POPUP(info.get("buyerCompany"))).text().contains(info.get("buyerCompany")),
                    Ensure.that(SuccessFormPage.RESULT_REGION_IN_POPUP(info.get("buyerCompany"))).text().contains(info.get("region")),
                    Ensure.that(SuccessFormPage.RESULT_STORE_TYPE_IN_POPUP(info.get("buyerCompany"))).text().contains(info.get("storeType")),
                    Ensure.that(SuccessFormPage.RESULT_KEY_ACCOUNT_IN_POPUP(info.get("buyerCompany"))).text().contains(info.get("keyAccount")),
                    Ensure.that(SuccessFormPage.RESULT_CURRENT_STORE_IN_POPUP(info.get("buyerCompany"))).attribute("value").contains(info.get("currentStore")),
                    Ensure.that(SuccessFormPage.RESULT_DISTRIBUTION_IN_POPUP(info.get("buyerCompany"))).attribute("value").contains(info.get("distributionType")),
                    Ensure.that(SuccessFormPage.RESULT_CONTACTED_IN_POPUP(info.get("buyerCompany"))).attribute("value").contains(info.get("contacted")),
                    Ensure.that(SuccessFormPage.RESULT_SAMPLE_SENT_IN_POPUP(info.get("buyerCompany"))).attribute("value").contains(info.get("sampleSent")),
                    Ensure.that(SuccessFormPage.RESULT_NOTE_IN_POPUP(info.get("buyerCompany"))).attribute("value").contains(info.get("note"))
            );
        }
    }

    @And("Admin edit store list in create new form")
    public void admin_edit_store_list_in_create_new_form(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.editStoreList(infos.get(0))
        );
    }

    @And("Admin search store list in success form")
    public void admin_search_store_list_in_success_form(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleVendorSuccessForm.searchStoreList(infos.get(0))
        );
    }

    @And("Admin verify store list after search in success form")
    public void admin_verify_buyer_after_search_in_success_form(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SuccessFormPage.RESULT_BUYER_COMPANY(info.get("buyerCompany"))),
                    Ensure.that(SuccessFormPage.RESULT_VENDOR_COMPANY(info.get("buyerCompany"))).text().contains(info.get("vendorCompany")),
                    Ensure.that(SuccessFormPage.RESULT_VENDOR_NAME(info.get("buyerCompany"))).text().contains(info.get("vendorName")),
                    Check.whether(info.get("currentStore").equals(""))
                            .otherwise(Ensure.that(SuccessFormPage.RESULT_SUBMITTED_DATE(info.get("buyerCompany"))).text().contains(CommonHandle.setDate2(info.get("submittedDate"), "MM/dd/yy"))),
                    Ensure.that(SuccessFormPage.RESULT_BUYER_COMPANY(info.get("buyerCompany"))).text().contains(info.get("buyerCompany")),
                    Ensure.that(SuccessFormPage.RESULT_REGION(info.get("buyerCompany"))).text().contains(info.get("region")),
                    Ensure.that(SuccessFormPage.RESULT_STORE_TYPE(info.get("buyerCompany"))).text().contains(info.get("storeType")),
                    Ensure.that(SuccessFormPage.RESULT_KEY_ACCOUNT(info.get("buyerCompany"))).text().contains(info.get("keyAccount")),
                    Check.whether(info.get("currentStore").equals(""))
                            .otherwise(Ensure.that(SuccessFormPage.RESULT_CURRENT_STORE(info.get("buyerCompany"))).text().contains(info.get("currentStore"))),
                    Ensure.that(SuccessFormPage.RESULT_DISTRIBUTION_TYPE(info.get("buyerCompany"))).text().contains(info.get("distributionType")),
                    Check.whether(info.get("contacted").equals("")).
                            otherwise(Ensure.that(SuccessFormPage.RESULT_CONTACTED(info.get("buyerCompany"))).text().contains(info.get("contacted"))),
                    Ensure.that(SuccessFormPage.RESULT_SAMPLE_SENT(info.get("buyerCompany"))).text().contains(info.get("sampleSent")),
                    Check.whether(info.get("status").equals(""))
                            .otherwise(Ensure.that(SuccessFormPage.RESULT_STATUS(info.get("buyerCompany"))).text().contains(info.get("status"))),
                    Ensure.that(SuccessFormPage.RESULT_NOTES(info.get("buyerCompany"))).text().contains(info.get("note"))

            );
        }
    }

    @And("Admin verify no found store {string} list after search in success form")
    public void admin_verify_buyer_after_search_in_success_form(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(SuccessFormPage.RESULT_BUYER_COMPANY(buyerCompany)).isNotDisplayed()
        );
    }

    @And("Admin go to edit store list {string} in success form")
    public void admin_go_to_edit_store_list_in_create_new_form(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.goToEditDetail(buyerCompany)
        );
    }

    @And("Admin verify edit detail in success form")
    public void admin_verify_edit_detail_in_success_form(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        Map<String, String> info = infos.get(0);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(SuccessFormPage.D_EDIT_TEXTBOX("Vendor company")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Vendor company")).attribute("value").contains(info.get("vendorCompany")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Buyer company")).attribute("value").contains(info.get("buyerCompany")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Region")).attribute("value").contains(info.get("region")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Store type")).attribute("value").contains(info.get("storeType")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Key accounts")).attribute("value").contains(info.get("keyAccount")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Current store")).attribute("value").contains(info.get("currentStore")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Distribution type")).attribute("value").contains(info.get("distributionType")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Contacted")).attribute("value").contains(info.get("contacted")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Samples sent")).attribute("value").contains(info.get("sampleSent")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTBOX("Status")).attribute("value").contains(info.get("status")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTAREA("Note")).attribute("value").contains(info.get("note")),
                Ensure.that(SuccessFormPage.D_EDIT_TEXTAREA("Admin note")).attribute("value").contains(info.get("adminNote")),
                Check.whether(info.get("showOnVendor").equals("Yes"))
                        .andIfSo(Ensure.that(SuccessFormPage.EDIT_POPUP_SHOW_VENDOR_CHECKBOX).attribute("class").contains("is-checked"))
        );
    }

    @And("Admin close popup store list detail in success form")
    public void admin_close_popup_store_list_in_create_new_form() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.closeEditDetail()
        );
    }


    @And("Admin edit detail store list {string} in success form")
    public void admin_edit_detail_store_list_in_create_new_form(String buyerCompany, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        Map<String, String> info = infos.get(0);

        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.editDetail(info)
        );
    }

    @And("Admin update success edit detail store list in success form")
    public void admin_update_edit_store_list_in_create_new_form() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.updateEdit()
        );
    }

    @And("Admin update edit detail store list error in success form then see message {string}")
    public void admin_update_edit_store_list_in_create_new_form(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.updateEditError(message)
        );
    }

    @And("Admin go to mass editing in success form")
    public void admin_go_to_mass_editing_success_form() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.goToMassEditing()
        );
    }


    @And("Admin search store list in mass editing popup")
    public void admin_search_store_list_in_mass_editing_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilterInPopup(),
                HandleVendorSuccessForm.searchBuyerInPopupMassEdit(infos.get(0))
        );
    }

    @And("Admin verify store list in mass editing popup")
    public void admin_verify_store_list_in_mass_editing_popup(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SuccessFormPage.MASS_BUYER_COMPANY(info.get("buyerCompany"))),
                    Ensure.that(SuccessFormPage.MASS_BUYER_COMPANY(info.get("buyerCompany"))).isDisplayed(),
                    Ensure.that(SuccessFormPage.MASS_REGION(info.get("buyerCompany"))).text().contains(info.get("region")),
                    Ensure.that(SuccessFormPage.MASS_STORE_TYPE(info.get("buyerCompany"))).text().contains(info.get("storeType")),
                    Ensure.that(SuccessFormPage.MASS_CURRENT_STORE(info.get("buyerCompany"))).text().contains(info.get("currentStore")),
                    Ensure.that(SuccessFormPage.MASS_DISTRIBUTION_TYPE(info.get("buyerCompany"))).text().contains(info.get("distributionType"))
            );
        }
    }

    @And("Admin edit detail store list in mass editing")
    public void admin_edit_detail_store_list_in_mass_editing(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        Map<String, String> info = infos.get(0);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.editOfMass(info)
        );
    }

    @And("Admin choose store list to edit in mass editing")
    public void admin_choose_store_list_in_mass_editing(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.chooseStoreListOfMass(infos)
        );
    }

    @And("Admin update after edit detail store list in mass editing")
    public void admin_update_after_edit_detail_store_list_in_mass_editing() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.updateEditOfMassSuccess()
        );
    }

    @And("Admin update after edit detail store list in mass editing then see error {string}")
    public void admin_update_after_edit_detail_store_list_in_mass_editing_then_see_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.updateEditOfMassError(message)
        );
    }

    @And("Admin go to add special buyer company in success form")
    public void admin_go_to_add_special_buyer_company() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.goToAddSpecial()
        );
    }

    @And("Admin add special buyer company in success form")
    public void admin_add_special_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.fillInfoToAddSpecial(infos.get(0))
        );
    }

    @And("Admin add special buyer company in success form then see message {string}")
    public void admin_add_special_buyer_company_see_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.addSpecial(message)
        );
    }

    @And("Admin verify buyer company in add special in success form")
    public void admin_verify_in_add_special_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SuccessFormPage.ADD_SPECIAL_RESULT_BUYER_COMPANY(info.get("store"))),
                    Ensure.that(SuccessFormPage.ADD_SPECIAL_RESULT_BUYER_COMPANY(info.get("store"))).text().contains(info.get("store")),
                    Ensure.that(SuccessFormPage.ADD_SPECIAL_RESULT_REGION(info.get("store"))).text().contains(info.get("region")),
                    Ensure.that(SuccessFormPage.ADD_SPECIAL_RESULT_STORE_TYPE(info.get("store"))).text().contains(info.get("storeType")),
                    Ensure.that(SuccessFormPage.ADD_SPECIAL_RESULT_DATE(info.get("store"))).text().contains(CommonHandle.setDate2(info.get("date"), "MM/dd/yy")),
                    Ensure.that(SuccessFormPage.ADD_SPECIAL_RESULT_MANAGED_BY(info.get("store"))).text().contains(info.get("managedBy"))
            );
        }
    }

    @And("Admin delete special buyer company {string} in success form")
    public void admin_delete_special_buyer_company(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSuccessForm.deleteSpecial(buyerCompany)
        );
    }


}
