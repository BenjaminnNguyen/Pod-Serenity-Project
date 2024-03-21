package cucumber.tasks.admin.brands;

import cucumber.actions.GoBack;
import cucumber.models.web.Admin.brand.SearchBrand;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.Brand.BrandDetailPage;
import cucumber.user_interface.admin.Brand.BrandsPageForm;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.VendorPageForm;
import cucumber.user_interface.admin.vendors.AllVendorsForm;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleBrand {

    public static Task search(SearchBrand info) {
        return Task.where("Search brands",
                Check.whether(!Objects.equals(info.getName(), ""))
                        .andIfSo(
                                Enter.theValue(info.getName()).into(AllBrandsPage.D_SEARCH("search_term"))
                        ),
                Check.whether(!Objects.equals(info.getVendorCompany(), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        AllBrandsPage.D_SEARCH("vendor_company_id"), info.getVendorCompany(), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.getVendorCompany()))
                        ),
                Check.whether(!Objects.equals(info.getState(), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        AllBrandsPage.D_SEARCH("state"), info.getState(), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.getState()))
                        ),
                Check.whether(!Objects.equals(info.getManagedBy(), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        AllBrandsPage.D_SEARCH("manager_id"), info.getManagedBy(), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.getManagedBy()))
                        ),
                Check.whether(!Objects.equals(info.getTags(), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        AllBrandsPage.D_SEARCH("tag_ids"), info.getTags(), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.getTags()))
                        ),
                Click.on(VendorPageForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(VendorPageForm.LOADING_ICON)
        );
    }

    public static Task goToCreate() {
        return Task.where("Go to create brand",
                CommonWaitUntil.isVisible(AllBrandsPage.CREATE_BRAND_BUTTON),
                Click.on(AllBrandsPage.CREATE_BRAND_BUTTON)
        );
    }

    public static Task createBrand(Map<String, String> info) {
        return Task.where("Create brand",
                CommonWaitUntil.isVisible(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Name")),
                Enter.theValue(info.get("name")).into(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Name")),
                Check.whether(info.get("description").equals(""))
                        .otherwise(Enter.theValue(info.get("description")).into(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Description"))),
                Check.whether(info.get("microDescriptions").equals(""))
                        .otherwise(Enter.theValue(info.get("microDescriptions")).into(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Micro-descriptions"))),
                Check.whether(info.get("inboundInventoryMOQ").equals(""))
                        .otherwise(Enter.theValue(info.get("inboundInventoryMOQ")).into(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Inbound Inventory MOQ"))),
                Check.whether(info.get("city").equals(""))
                        .otherwise(Enter.theValue(info.get("city")).into(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("City"))),
                Check.whether(info.get("state").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("State (Province/Territory)"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("state")))),
                CommonTask.chooseItemInDropdownWithValueInput1(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Vendor company"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))
        );
    }

    public static Task createBrandSuccess() {
        return Task.where("Create brand success",
                Click.on(AllBrandsPage.SUBMIT_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task closeCreateNewVendor() {
        return Task.where("Close create new vendor popup",
                CommonWaitUntil.isVisible(CommonAdminForm.CLOSE_POPUP),
                Click.on(CommonAdminForm.CLOSE_POPUP).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Name"))
        );
    }

    public static Performable addTags(List<Map<String, String>> infos) {
        return Task.where("Add tags in create brand",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Tags"), info.get("tags"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tags"))),
                                CommonWaitUntil.isVisible(AllVendorsForm.TAG_CREATE_VENDOR(info.get("tags"))),
                                Ensure.that(AllBrandsPage.TAG_CREATE_VENDOR(info.get("tags"))).isDisplayed()
                        );
                }
        );
    }

    public static Performable deleteTags(List<Map<String, String>> infos) {
        return Task.where("Delete tags in create brand",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AllBrandsPage.TAG_CREATE_VENDOR(info.get("tags"))),
                                Click.on(AllBrandsPage.TAG_CREATE_VENDOR_DELETE_BUTTON(info.get("tags"))),
                                CommonWaitUntil.isNotVisible(AllBrandsPage.TAG_CREATE_VENDOR(info.get("tags")))
                        );
                }
        );
    }

    public static Task goToDetailFromEdit(String brandName) {
        return Task.where("Go to detail from edit",
                CommonWaitUntil.isVisible(AllBrandsPage.EDIT_BUTTON_IN_RESULT(brandName)),
                Click.on(AllBrandsPage.EDIT_BUTTON_IN_RESULT(brandName)),
                CommonWaitUntil.isNotVisible(BrandsPageForm.LOADING_ICON)
        );
    }

    public static Task editGeneral(Map<String, String> info) {
        return Task.where("Edit general information",
                Check.whether(info.get("brandName").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(BrandDetailPage.NAME, info.get("brandName"))),
                Check.whether(info.get("description").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(BrandDetailPage.DESCRIPTION, info.get("description"))),
                Check.whether(info.get("microDescriptions").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(BrandDetailPage.MICRO_DESCRIPTION, info.get("microDescriptions"))),
                Check.whether(info.get("inboundInventoryMOQ").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(BrandDetailPage.INBOUND_INVENTORY_MOQ_DETAIL, info.get("inboundInventoryMOQ"))),
                Check.whether(info.get("vendorCompany").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipDropdownWithInput(BrandDetailPage.VENDOR_COMPANY, info.get("vendorCompany"))),
                Check.whether(info.get("city").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(BrandDetailPage.CITY, info.get("city"))),
                Check.whether(info.get("state").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipDropdownWithInput(BrandDetailPage.STATE, info.get("state")))
        );
    }

    public static Task deactivateThisBrand(String action) {
        return Task.where("Deactivate this brand",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this brand")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this brand")),
                CommonWaitUntil.isVisible(BrandDetailPage.DIALOG_MESSAGE("This will deactivate the brand. Would you also like to deactivate the associated vendor company?")),
                // action = Yes - Deactivate cả vendor company và brand
                // action = No - Deactivate brand
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                CommonWaitUntil.isNotVisible(BrandDetailPage.DIALOG_MESSAGE("This will deactivate the brand. Would you also like to deactivate the associated vendor company?")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_STATE_VALUE("Inactive"))
        );
    }

    public static Task activeThisBrand() {
        return Task.where("Activate this brand",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Activate this brand")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Activate this brand")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("This will activate current brand. Activating this brand will automatically activate its vendor company. Are you sure you want to continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("This will activate current brand. Activating this brand will automatically activate its vendor company. Are you sure you want to continue?")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_STATE_VALUE("Active"))
        );
    }

    public static Task uploadLogoImage(String file) {
        return Task.where("Upload logo image",
                CommonWaitUntil.isVisible(BrandDetailPage.IMAGE_SECTION),
                CommonFile.upload2(file, BrandDetailPage.LOGO_IMAGE),
                Click.on(BrandDetailPage.SAVE_IMAGE_BUTTON)
        );
    }

    public static Task uploadCoverImage(String file) {
        return Task.where("Upload cover image",
                CommonWaitUntil.isVisible(BrandDetailPage.IMAGE_SECTION),
                CommonFile.upload2(file, BrandDetailPage.COVER_IMAGE),
                Click.on(BrandDetailPage.SAVE_IMAGE_BUTTON)

        );
    }

    public static Performable uploadSubImage(List<Map<String, String>> infos) {
        return Task.where("Upload cover image",
                actor -> {
                    for (int i = 0; i < infos.size(); i++) {
                        theActorInTheSpotlight().attemptsTo(
                                CommonWaitUntil.isPresent(BrandDetailPage.ADD_A_SUB_IMAGE),
                                Click.on(BrandDetailPage.ADD_A_SUB_IMAGE),
                                CommonFile.upload2(infos.get(i).get("subImage"), BrandDetailPage.SUB_IMAGE(i + 1))

                        );
                    }
                    theActorInTheSpotlight().attemptsTo(
                            CommonWaitUntil.isVisible(BrandDetailPage.SAVE_IMAGE_BUTTON),
                            Click.on(BrandDetailPage.SAVE_IMAGE_BUTTON),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                    );
                }

        );
    }

    public static Task verifyFooterLink(String link, String title, String brand) {
        return Task.where("Verify footer link",
                CommonWaitUntil.isVisible(BrandDetailPage.FOOTER_LINK(link)),
                Click.on(BrandDetailPage.FOOTER_LINK(link)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.switchToChildWindowsByTitle(title),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id")).attribute("value").contains(brand),
                GoBack.theBrowser(),
                Switch.toDefaultContext()
        );
    }

    public static Task deleteBrandInResult(String brand) {
        return Task.where("Delete brand in result search",
                CommonWaitUntil.isVisible(AllBrandsPage.BRAND_IN_RESULT(brand)),
                JavaScriptClick.on(AllBrandsPage.DELETE_BUTTON_IN_RESULT(brand)),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Deleting this brand will also delete all its products and SKUs. Are you sure you want to continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue"))
        );
    }

    public static Task deleteBrandInDetail() {
        return Task.where("Delete brand in result search",
                CommonWaitUntil.isVisible(BrandDetailPage.DELETE_BRAND_BUTTON),
                Click.on(BrandDetailPage.DELETE_BRAND_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Deleting this brand will also delete all its products and SKUs. Are you sure you want to continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue"))
        );
    }
}
