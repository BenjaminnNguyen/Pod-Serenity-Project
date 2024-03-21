package steps.admin.brands;

import cucumber.singleton.GVs;
import cucumber.tasks.admin.brands.HandleBrand;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import cucumber.models.web.Admin.brand.SearchBrand;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.Brand.BrandDetailPage;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.Brand.BrandsPageForm;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class AdminBrandsStepDefinitions {

    @And("Admin search the brand by info then system show result")
    public void search_the_brand_by_full_name_field(List<SearchBrand> infos) {
        for (SearchBrand info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.showFilter(),
                    CommonTaskAdmin.resetFilter(),
                    HandleBrand.search(info)
            );
            Serenity.setSessionVariable("brandName").to(info.getName());
        }
    }

    @And("Admin search the brand by info")
    public void search_the_brand(List<SearchBrand> infos) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleBrand.search(infos.get(0))
        );
        Serenity.setSessionVariable("brandName").to(infos.get(0).getName());
    }

    @And("Admin remove the brand the first record")
    public void remove_the_brand() {
        String name = Serenity.sessionVariableCalled("brandName");
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(AllBrandsPage.BRAND_NAME)).andIfSo(
//                        Check.whether(CommonQuestions.targetText(BrandsPageForm.BRAND_NAME).equals(name))
//                                .andIfSo(
//                        CommonWaitUntil.isVisible(AllBrandsPage.DELETE_BUTTON),
                        JavaScriptClick.on(AllBrandsPage.DELETE_BUTTON),
//                        Click.on(AllBrandsPage.DELETE_BUTTON),
                        CommonWaitUntil.isVisible(AllBrandsPage.I_UNDERSTAND_AND_CONTINUE_BUTTON),

                        Click.on(AllBrandsPage.I_UNDERSTAND_AND_CONTINUE_BUTTON),
                        CommonWaitUntil.isNotVisible(AllBrandsPage.LOADING_ICON)
//                                )
                )
        );
    }

    @And("Admin create new brand")
    public void create_Brand(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.createBrand(infos.get(0))
        );
    }

    @And("Admin go to create brand")
    public void admin_go_to_create_buyer_company() {
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.goToCreate()
        );
    }

    @And("Admin close create brand")
    public void admin_close_create_buyer_company() {
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.closeCreateNewVendor()
        );
    }

    @And("Admin create brand success")
    public void admin_create_brand_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.createBrandSuccess()
        );
    }

    @And("Go to brand detail")
    public void gotoBrandDetail() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BrandsPageForm.BRAND_NAME),
                Click.on(BrandsPageForm.BRAND_NAME),
                CommonWaitUntil.isNotVisible(BrandsPageForm.LOADING_ICON)
        );
    }

    @And("Admin verify general information in brand detail")
    public void admin_verify_general_information_brand_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BrandDetailPage.STATE_STATUS), equalToIgnoringCase(infos.get(0).get("status"))),
                seeThat(CommonQuestions.targetText(BrandDetailPage.NAME), containsString(infos.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(BrandDetailPage.DESCRIPTION), containsString(infos.get(0).get("description"))),
                seeThat(CommonQuestions.targetText(BrandDetailPage.MICRO_DESCRIPTION), containsString(infos.get(0).get("microDescriptions"))),
                seeThat(CommonQuestions.targetText(BrandDetailPage.INBOUND_INVENTORY_MOQ_DETAIL), containsString(infos.get(0).get("inboundInventoryMOQ"))),
//                seeThat(CommonQuestions.targetText(BrandDetailPage.CITY), containsString(infos.get(0).get("city"))),
//                seeThat(CommonQuestions.targetText(BrandDetailPage.STATE), containsString(infos.get(0).get("state"))),
                seeThat(CommonQuestions.targetText(BrandDetailPage.VENDOR_COMPANY), containsString(infos.get(0).get("vendorCompany")))
        );
    }

    @And("Deactivate this brand")
    public void deactivateBrand() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BrandDetailPage.DEACTIVATE_THIS_BRAND_BUTTON),
                Click.on(BrandDetailPage.DEACTIVATE_THIS_BRAND_BUTTON),
                CommonWaitUntil.isVisible(BrandDetailPage.OK_DEACTIVATE_BRAND),
                Click.on(BrandDetailPage.OK_DEACTIVATE_BRAND),
                CommonWaitUntil.isVisible(BrandDetailPage.ACTIVE_THIS_BRAND_BUTTON)
        );
    }

    @And("Upload image of brands")
    public void uploadImageBrand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isPresent(BrandDetailPage.LOGO_IMAGE),
                Check.whether(list.get(0).get("logo").isEmpty()).otherwise(
                        CommonFile.upload2(list.get(0).get("logo"), BrandDetailPage.LOGO_IMAGE)
                ),
                Check.whether(list.get(0).get("cover").isEmpty()).otherwise(
                        CommonFile.upload2(list.get(0).get("cover"), BrandDetailPage.COVER_IMAGE)
                ),
                CommonWaitUntil.isVisible(BrandDetailPage.SAVE_IMAGE_BUTTON),
                Click.on(BrandDetailPage.SAVE_IMAGE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin add sub image of brands")
    public void uploadSubImageBrand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isPresent(BrandDetailPage.ADD_A_SUB_IMAGE),
                    Click.on(BrandDetailPage.ADD_A_SUB_IMAGE),
                    Check.whether(list.get(i).get("subImage").isEmpty()).otherwise(
                            CommonFile.upload2(list.get(i).get("subImage"), BrandDetailPage.SUB_IMAGE(i + 1))
                    )
            );
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BrandDetailPage.SAVE_IMAGE_BUTTON),
                Click.on(BrandDetailPage.SAVE_IMAGE_BUTTON),
                CommonWaitUntil.isNotVisible(BrandDetailPage.SAVE_IMAGE_BUTTON)
        );
    }

    @And("Wait for upload image brand success")
    public void waitUpload() {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(5000),
                CommonWaitUntil.isNotVisible(BrandDetailPage.SAVE_IMAGE_BUTTON)
        );
    }

    @And("Admin verify default form create brand")
    public void admin_verify_default_form_create_brand() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBrandsPage.CREATE_BRAND_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(AllBrandsPage.D_TEXTBOX_ERROR("Name")),
                Ensure.that(AllBrandsPage.D_TEXTBOX_ERROR("Name")).text().contains("Please input brand name"),
                Ensure.that(AllBrandsPage.D_TEXTBOX_ERROR("Vendor company")).text().contains("Please select a vendor company for this brand")
        );
    }

    @And("Admin create brand and verify message error {string}")
    public void admin_create_brand_and_verify_message_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin verify field description in create brand")
    public void admin_verify_field_description_in_create_brand() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue(GVs.STRING_1K).into(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Description")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Description is too long (maximum is 1000 characters)"))
        );
    }

    @And("Admin verify field micro description in create brand")
    public void admin_verify_field_micro_description_in_create_brand() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue("12345678901234567890123456789012345678901234567890123456789012345678901234567890").into(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Micro-descriptions")),
                CommonWaitUntil.isVisible(AllBrandsPage.D_TEXTBOX_ERROR("Micro-descriptions")),
                Ensure.that(AllBrandsPage.D_TEXTBOX_ERROR("Micro-descriptions")).text().contains("Micro-description should less than 70 characters")
        );
    }

    @And("Admin verify field inbound inventory MOQ in create brand")
    public void admin_verify_field_inbound_nventory_MOQ_in_create_brand() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue("abc").into(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Micro-descriptions")),
                Ensure.that(AllBrandsPage.D_CREATE_BRAND_TEXTBOX("Micro-descriptions")).attribute("value").contains("")
        );
    }

    @And("Admin add tags in create brand")
    public void admin_add_tags_in_create_new_vendor(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.addTags(infos)
        );
    }

    @And("Admin delete tags in create new brand")
    public void admin_delete_tags_in_create_new_brand(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.deleteTags(infos)
        );
    }

    @And("Admin verify brand in result search")
    public void admin_verify_brand_in_result_search(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBrandsPage.BRAND_IN_RESULT(infos.get(0).get("brandName"))),
                Ensure.that(AllBrandsPage.BRAND_IN_RESULT(infos.get(0).get("brandName"))).isDisplayed(),
                Ensure.that(AllBrandsPage.STATE_IN_RESULT(infos.get(0).get("brandName"))).text().contains(infos.get(0).get("state")),
                Ensure.that(AllBrandsPage.PRICING_IN_RESULT(infos.get(0).get("brandName"))).text().contains(infos.get(0).get("pricing")),
                Ensure.that(AllBrandsPage.ADDRESS_IN_RESULT(infos.get(0).get("brandName"))).text().contains(infos.get(0).get("address")),
                Ensure.that(AllBrandsPage.MANAGED_BY_IN_RESULT(infos.get(0).get("brandName"))).text().contains(infos.get(0).get("managedBy")),
                Ensure.that(AllBrandsPage.LAUNCHED_BY_IN_RESULT(infos.get(0).get("brandName"))).text().contains(infos.get(0).get("launchedBy"))
        );
    }

    @And("Admin go to brand {string} detail from edit")
    public void admin_go_to_brand_detail_from_edit(String brand) {
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.goToDetailFromEdit(brand)
        );
    }

    @And("Admin verify edit name field in brand detail")
    public void admin_verify_edit_name_field_in_brand_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(BrandDetailPage.NAME, info.get("brandName"), info.get("message"))
                );
            }
            if (info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(BrandDetailPage.NAME, info.get("brandName")),
                        WindowTask.threadSleep(1000),
                        Ensure.that(BrandDetailPage.NAME).text().contains(info.get("brandName"))
                );
            }
        }
    }

    @And("Admin verify edit inbound inventory MOQ field in brand detail")
    public void admin_verify_edit_inbound_field_in_brand_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        if (!infos.get(0).get("message").equals("Empty")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextboxError1(BrandDetailPage.INBOUND_INVENTORY_MOQ, infos.get(0).get("inbound"), infos.get(0).get("message"))
            );
        }
    }

    @And("Admin edit general information in brand detail")
    public void admin_edit_general_information_in_brand_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.editGeneral(infos.get(0))
        );

    }

    @And("Admin deactivate brand choose {string}")
    public void admin_deactivate_brand(String action) {
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.deactivateThisBrand(action)
        );
    }

    @And("Admin activate brand")
    public void admin_activate_brand() {
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.activeThisBrand()
        );
    }

    @And("Admin verify history active brand")
    public void admin_verify_active_brand(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.ACTIVE_HISTORY_ICON),
                MoveMouse.to(VendorCompaniesPage.ACTIVE_HISTORY_ICON),
                CommonWaitUntil.isVisible(VendorCompaniesPage.ACTIVE_HISTORY_STATE),
                //Verify
                Ensure.that(BrandDetailPage.ACTIVE_HISTORY_STATE).text().contains(infos.get(0).get("state")),
                Ensure.that(BrandDetailPage.ACTIVE_HISTORY_UPDATE_BY).text().contains(infos.get(0).get("updateBy")),
                Ensure.that(BrandDetailPage.ACTIVE_HISTORY_UPDATE_ON).text().contains(CommonHandle.setDate2(infos.get(0).get("updateOn"), "MM/dd/yy"))
        );
    }


    @And("Admin verify upload image logo in brand detail")
    public void admin_verify_upload_image_logo_in_brand_detail() {
        theActorInTheSpotlight().attemptsTo(
                // upload file invalid
                HandleBrand.uploadLogoImage("BOL.pdf"),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Logo attachment content type is invalid")),
                Ensure.that(BrandDetailPage.LOGO_IMAGE_UNSUPPORTED).isDisplayed(),
                // upload file > 10 MB
                CommonFile.upload1("10MBgreater.jpg", BrandDetailPage.LOGO_IMAGE),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded."))
        );
    }

    @And("Admin verify upload image cover in brand detail")
    public void admin_verify_upload_image_cover_in_brand_detail() {
        theActorInTheSpotlight().attemptsTo(
                // upload file invalid
                HandleBrand.uploadCoverImage("BOL.pdf"),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Main image attachment content type is invalid")),
                Ensure.that(BrandDetailPage.COVER_IMAGE_UNSUPPORTED).isDisplayed(),
                // upload file > 10 MB
                CommonFile.upload1("10MBgreater.jpg", BrandDetailPage.COVER_IMAGE),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded."))
        );
    }

    @And("Admin verify sub image of brands")
    public void verify_sub_image_of_brands() {
        theActorInTheSpotlight().attemptsTo(
                // upload file invalid
                CommonWaitUntil.isPresent(BrandDetailPage.ADD_A_SUB_IMAGE),
                Click.on(BrandDetailPage.ADD_A_SUB_IMAGE),
                CommonWaitUntil.isPresent(BrandDetailPage.ADD_A_SUB_IMAGE),
                Click.on(BrandDetailPage.ADD_A_SUB_IMAGE),
                CommonFile.upload2("BOL.pdf", BrandDetailPage.SUB_IMAGE(1)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Sub images attachment content type is invalid")),
                Ensure.that(BrandDetailPage.SUB_IMAGE_UNSUPPORTED).isDisplayed(),
                // upload file > 10 MB
                CommonFile.upload1("10MBgreater.jpg", BrandDetailPage.SUB_IMAGE(1)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded."))
        );


    }

    @And("Admin verify image in brands detail")
    public void verify_image_in_brand_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BrandDetailPage.IMAGE_ADDED("logo", infos.get(0).get("logo"))).attribute("style").contains(infos.get(0).get("logo")),
                Ensure.that(BrandDetailPage.IMAGE_ADDED("cover", infos.get(0).get("cover"))).attribute("style").contains(infos.get(0).get("cover"))
        );
    }

    @And("Admin verify sub image of brands detail")
    public void verify_sub_image_of_brand(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BrandDetailPage.IMAGE_ADDED("sub-images", infos.get(i).get("subImage"))),
                    Ensure.that(BrandDetailPage.IMAGE_ADDED("sub-images", infos.get(i).get("subImage"))).attribute("style").contains(infos.get(i).get("subImage"))
            );
        }
    }

    @And("Admin navigate footer link of brand {string} in detail")
    public void navigate_footer_link_in_brand_detail(String brand) {
        theActorInTheSpotlight().attemptsTo(
                // verify footer link product
                HandleBrand.verifyFooterLink("Find all brand's products", "Product", brand),
                HandleBrand.verifyFooterLink("Find all brand's inventories", "All inventory", brand),
                HandleBrand.verifyFooterLink("Find all brand's inbound inventories", "Incoming Inventories", brand),
                HandleBrand.verifyFooterLink("Find all brand's orders", "Orders", brand),
                HandleBrand.verifyFooterLink("Find all brand's preorders", "Preorders", brand),
                HandleBrand.verifyFooterLink("Find all brand's sample requests", "Sample requests", brand),
                HandleBrand.verifyFooterLink("Find all brand's change requests", "Product change requests", brand),
                HandleBrand.verifyFooterLink("Find all brand's promotions", "Promotions", brand),
                HandleBrand.verifyFooterLink("Find all brand's inventory status", "Inventory Status", brand),
                HandleBrand.verifyFooterLink("Find all brand's order summary", "Order Summary", brand)
        );
    }

    @And("Admin delete brand {string} in result")
    public void admin_delete_brand_in_result(String brand) {
        if(brand.equals("")) {
            brand = Serenity.sessionVariableCalled("brandName");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.deleteBrandInResult(brand)
        );
    }

    @And("Admin delete brand in detail")
    public void admin_delete_brand_in_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.deleteBrandInDetail()
        );
    }
}
