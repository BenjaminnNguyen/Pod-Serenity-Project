package cucumber.tasks.admin.vendors;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.vendors.SuccessFormPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleVendorSuccessForm {

    public static Task goToCreateNewForm() {
        return Task.where("Go to create new vendor success form",
                CommonWaitUntil.isVisible(SuccessFormPage.CREATE_NEW_FORM_BUTTON),
                Click.on(SuccessFormPage.CREATE_NEW_FORM_BUTTON),
                CommonWaitUntil.isVisible(SuccessFormPage.CREATE_NEW_SUCCESS_POPUP)
        );
    }

    public static Task closePopupCreateNewForm() {
        return Task.where("Close popup create new vendor success form",
                CommonWaitUntil.isVisible(SuccessFormPage.CREATE_NEW_ENTITY_POPUP),
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON),
                CommonWaitUntil.isNotVisible(SuccessFormPage.CREATE_NEW_ENTITY_POPUP)
        );
    }

    public static Task selectVendorInPopupCreate(String vendorCompany) {
        return Task.where("Select vendor in popup create new form",
                CommonWaitUntil.isVisible(SuccessFormPage.SELECT_VENDOR_TEXTBOX),
                CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SELECT_VENDOR_TEXTBOX, vendorCompany, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(vendorCompany))
        );
    }

    public static Task searchBuyerInPopupCreate(Map<String, String> info) {
        return Task.where("Search buyer in create new form",
                CommonWaitUntil.isVisible(SuccessFormPage.SELECT_VENDOR_TEXTBOX),
                Check.whether(info.get("buyerCompany").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SEARCH_D_TEXTBOX("Buyer company"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany")))),
                Check.whether(info.get("region").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SEARCH_D_TEXTBOX("Region"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Check.whether(info.get("storeType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SEARCH_D_TEXTBOX("Store type"), info.get("storeType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("storeType")))),
                Check.whether(info.get("keyAccount").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.SEARCH_D_TEXTBOX("Key account"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("keyAccount")))),
                Check.whether(info.get("distributionType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SEARCH_D_TEXTBOX("Distribution type"), info.get("distributionType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("distributionType")))),
                Check.whether(info.get("filledOrUnfilled").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.SEARCH_D_TEXTBOX("Filled & Unfilled"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("filledOrUnfilled")))),
                Check.whether(info.get("currentStore").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.SEARCH_D_TEXTBOX("Current store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("currentStore")))),
                Click.on(SuccessFormPage.CREATE_POPUP_SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task editStoreList(Map<String, String> info) {
        return Task.where("Edit store list in create new form",
                Check.whether(info.get("currentStore").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(SuccessFormPage.RESULT_CURRENT_STORE_IN_POPUP(info.get("buyerCompany")), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("currentStore"))),
                                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Store list have been added successfully!")),
                                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)),
                Check.whether(info.get("distributionType").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(SuccessFormPage.RESULT_DISTRIBUTION_IN_POPUP(info.get("buyerCompany")), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("distributionType"))),
                                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Store list have been added successfully!")),
                                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)),
                Check.whether(info.get("contacted").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(SuccessFormPage.RESULT_CONTACTED_IN_POPUP(info.get("buyerCompany")), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("contacted"))),
                                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Store list have been added successfully!")),
                                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)),
                Check.whether(info.get("sampleSent").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(SuccessFormPage.RESULT_SAMPLE_SENT_IN_POPUP(info.get("buyerCompany")), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sampleSent"))),
                                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Store list have been added successfully!")),
                                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)),
                Check.whether(info.get("sampleSent").equals(""))
                        .otherwise(
                                Clear.field(SuccessFormPage.RESULT_NOTE_IN_POPUP(info.get("buyerCompany"))),
                                Enter.theValue(info.get("note")).into(SuccessFormPage.RESULT_NOTE_IN_POPUP(info.get("buyerCompany"))).thenHit(Keys.TAB),
                                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Store list have been added successfully!")),
                                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON))
        );
    }

    public static Task searchStoreList(Map<String, String> info) {
        return Task.where("Search store list in success form",
                CommonWaitUntil.isVisible(SuccessFormPage.SEARCH_D_TEXTBOX("Vendor company")),
                Check.whether(info.get("vendorCompany").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SEARCH_D_TEXTBOX("Vendor company"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))),
                Check.whether(info.get("brand").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SEARCH_D_TEXTBOX("Brand"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand")))),
                Check.whether(info.get("vendor").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SEARCH_D_TEXTBOX("Vendor"), info.get("vendor"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendor")))),
                Check.whether(info.get("vendorEmail").equals(""))
                        .otherwise(Enter.theValue(info.get("vendorEmail")).into(SuccessFormPage.SEARCH_D_TEXTBOX("Vendor email"))),
                Check.whether(info.get("distributionType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.SEARCH_D_TEXTBOX("Distribution type"), info.get("distributionType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("distributionType")))),
                Check.whether(info.get("currentStore").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.SEARCH_D_TEXTBOX("Current store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("currentStore")))),
                Check.whether(info.get("managedBy").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.SEARCH_D_TEXTBOX("Managed by"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managedBy")))),

                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToEditDetail(String buyerCompany) {
        return Task.where("Go to edit detail of success form",
                CommonWaitUntil.isVisible(SuccessFormPage.RESULT_ID(buyerCompany)),
                Click.on(SuccessFormPage.RESULT_ID(buyerCompany)),
                CommonWaitUntil.isVisible(SuccessFormPage.D_EDIT_TEXTBOX("Vendor company"))
        );
    }

    public static Task closeEditDetail() {
        return Task.where("Close popup edit detail",
                CommonWaitUntil.isVisible(CommonAdminForm.POPUP_CLOSE_BUTTON),
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON),
                CommonWaitUntil.isNotVisible(SuccessFormPage.D_EDIT_TEXTBOX("Vendor company"))
        );
    }

    public static Task editDetail(Map<String, String> info) {
        return Task.where("Edit detail",
                Check.whether(info.get("contacted").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_EDIT_TEXTBOX("Contacted"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("contacted")))),
                Check.whether(info.get("currentStore").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_EDIT_TEXTBOX("Current store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("currentStore")))),
                Check.whether(info.get("distributionType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_EDIT_TEXTBOX("Distribution type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("distributionType")))),
                Check.whether(info.get("sampleSent").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_EDIT_TEXTBOX("Samples sent"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sampleSent")))),
                Check.whether(info.get("status").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_EDIT_TEXTBOX("Status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("status")))),
                Check.whether(info.get("adminNote").equals(""))
                        .otherwise(Enter.theValue(info.get("adminNote")).into(SuccessFormPage.D_EDIT_TEXTAREA("Admin note"))),
                Check.whether(info.get("showOnVendor").equals(""))
                        .otherwise(Click.on(SuccessFormPage.EDIT_POPUP_SHOW_VENDOR_CHECKBOX))
        );
    }

    public static Task updateEdit() {
        return Task.where("Update after edit",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(SuccessFormPage.D_EDIT_TEXTBOX("Vendor company"))
        );
    }

    public static Task updateEditError(String message) {
        return Task.where("Update after edit error then sê message " + message,
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    public static Task goToMassEditing() {
        return Task.where("Go to mass editing form",
                CommonWaitUntil.isVisible(SuccessFormPage.MASS_EDITING_BUTTON),
                Click.on(SuccessFormPage.MASS_EDITING_BUTTON),
                CommonWaitUntil.isVisible(SuccessFormPage.MASS_EDITING_POPUP)
        );
    }

    public static Task searchBuyerInPopupMassEdit(Map<String, String> info) {
        return Task.where("Search buyer in mass editing popup",
                CommonWaitUntil.isVisible(SuccessFormPage.D_MASS_EDIT_TEXTBOX("Vendor company")),
                Check.whether(info.get("vendorCompany").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.D_MASS_EDIT_TEXTBOX("Vendor company"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))),
                Check.whether(info.get("buyerCompany").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.D_MASS_EDIT_TEXTBOX("Buyer company"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany")))),
                Check.whether(info.get("region").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.D_MASS_EDIT_TEXTBOX("Region"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Check.whether(info.get("storeType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.D_MASS_EDIT_TEXTBOX("Store type"), info.get("storeType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("storeType")))),
                Check.whether(info.get("distributionType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.D_MASS_EDIT_TEXTBOX("Distribution type"), info.get("distributionType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("distributionType")))),
                Check.whether(info.get("filledOrUnfilled").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_MASS_EDIT_TEXTBOX("Filled & Unfilled"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("filledOrUnfilled")))),

                Click.on(SuccessFormPage.CREATE_POPUP_SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task editOfMass(Map<String, String> info) {
        return Task.where("Edit of mass editing",
                Check.whether(info.get("contacted").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_MASS_EDIT_BODY_TEXTBOX("Contacted"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("contacted")))),
                WindowTask.threadSleep(1000),
                Check.whether(info.get("currentStore").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_MASS_EDIT_BODY_TEXTBOX("Current store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("currentStore")))),
                WindowTask.threadSleep(1000),
                Check.whether(info.get("distributionType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_MASS_EDIT_BODY_TEXTBOX("Distribution type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("distributionType")))),
                Check.whether(info.get("sampleSent").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(SuccessFormPage.D_MASS_EDIT_BODY_TEXTBOX("Samples sent"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sampleSent")))),
                Check.whether(info.get("note").equals(""))
                        .otherwise(Enter.theValue(info.get("note")).into(SuccessFormPage.D_MASS_EDIT_BODY_TEXTAREA("Note")))
        );
    }

    public static Performable chooseStoreListOfMass(List<Map<String, String>> infos) {
        return Task.where("Choose store list to mass edit",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(SuccessFormPage.MASS_CHECKBOX(info.get("buyerCompany"))),
                                Click.on(SuccessFormPage.MASS_CHECKBOX(info.get("buyerCompany")))
                        );
                    }
                }
        );
    }

    public static Task updateEditOfMassSuccess() {
        return Task.where("Update edit of mass editing success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update all")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update all")),
                CommonWaitUntil.isNotVisible(SuccessFormPage.MASS_EDITING_POPUP)
        );
    }

    public static Task updateEditOfMassError(String message) {
        return Task.where("Update edit of mass editing success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update all")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update all")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    public static Task goToAddSpecial() {
        return Task.where("Go to add special buyer company",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add special buyer company")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add special buyer company")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add buyer company"))
        );
    }

    public static Task fillInfoToAddSpecial(Map<String, String> info) {
        return Task.where("Fill info to add special buyer company",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add buyer company")),
                CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.ADD_SPECIAL_BUYER_COMPANY_TEXTBOX, info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany"))),
                CommonTask.chooseItemInDropdownWithValueInput1(SuccessFormPage.ADD_SPECIAL_REGION_TEXTBOX, info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))
                );
    }

    public static Task addSpecial(String message) {
        return Task.where("Add special buyer company success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add buyer company")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add buyer company")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    public static Task deleteSpecial(String buyerCompany) {
        return Task.where("Delete special buyer company success",
                CommonWaitUntil.isVisible(SuccessFormPage.ADD_SPECIAL_RESULT_DELETE_BUTTON(buyerCompany)),
                Click.on(SuccessFormPage.ADD_SPECIAL_RESULT_DELETE_BUTTON(buyerCompany)),
                CommonWaitUntil.isNotVisible(SuccessFormPage.ADD_SPECIAL_RESULT_BUYER_COMPANY(buyerCompany))
        );
    }


}
