package steps.admin.claims;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.claims.HandleAdminVendorClaim;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.claims.AdminVendorClaimPage;
import cucumber.user_interface.beta.Vendor.claims.VendorClaimsPage;
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

public class AdminVendorClaimStepDefinitions {

    @And("Admin verify default in create vendor claim")
    public void admin_verify_default_in_create_vendor_claim() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                // Verify default
                CommonWaitUntil.isVisible(AdminVendorClaimPage.D_TEXTBOX_ERROR("Vendors")),
                Ensure.that(AdminVendorClaimPage.D_TEXTBOX_ERROR("Vendors")).text().contains("Please select a vendor for this claim"),
                Ensure.that(AdminVendorClaimPage.D_TEXTBOX_ERROR("Issue")).text().contains("Please select a issue"),
                Ensure.that(AdminVendorClaimPage.D_TEXTBOX_ERROR("Issue Description")).text().contains("Please enter a issue description"),
                // verify button You must choose a vendor first
                Click.on(AdminVendorClaimPage.TYPE_VALUE_IN_CREATE("SKU(s)")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("You must choose a vendor first")),
                Click.on(AdminVendorClaimPage.TYPE_VALUE_IN_CREATE("Order(s)")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("You must choose a vendor first")),
                Click.on(AdminVendorClaimPage.TYPE_VALUE_IN_CREATE("Inbound Inventory(s)")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("You must choose a vendor first"))
        );
    }

    @And("Admin fill info to create vendor claim")
    public void admin_fill_info_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.fillInfoToCreate(infos.get(0))
        );
    }

    @And("Admin upload file to create vendor claim")
    public void admin_upload_file_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.uploadFile(infos)
        );
        if (infos.size() >= 10) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON_DISABLE("Add a document"))
            );
        }
    }

    @And("Admin add sku to create vendor claim")
    public void admin_add_sku_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.goToAddSkuToCreate(),
                HandleAdminVendorClaim.addSKUToCreate(infos)
        );
    }

    @And("Admin remove sku to create vendor claim")
    public void admin_remove_sku_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.removeSKUToCreate(infos)
        );
    }

    @And("Admin verify sku added in create vendor claim")
    public void admin_verify_sku_added_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminVendorClaimPage.SKU_ITEM_IN_CREATE(info.get("sku"))),
                    Ensure.that(AdminVendorClaimPage.SKU_ITEM_IN_CREATE(info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(AdminVendorClaimPage.SKU_ID_ITEM_IN_CREATE(info.get("sku"))).text().contains(info.get("skuID")),
                    Ensure.that(AdminVendorClaimPage.SKU_QUANTITY_TEXTBOX_IN_CREATE(info.get("sku"))).attribute("value").contains(info.get("quantity"))
            );
        }
    }

    @And("Admin create vendor claim success")
    public void admin_create_vendor_claim() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.createClaimSuccess()
        );
    }

    @And("Admin verify general information in vendor claim detail")
    public void admin_verify_general_information_in_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminVendorClaimPage.VENDOR_GENERAL_INFO),
                    Ensure.that(AdminVendorClaimPage.VENDOR_GENERAL_INFO).text().contains(info.get("name")),
                    Ensure.that(AdminVendorClaimPage.VENDOR_COMPANY_GENERAL_INFO).text().contains(info.get("vendorCompany")),
                    Check.whether(info.get("brand").equals(""))
                            .otherwise(Ensure.that(AdminVendorClaimPage.BRAND_GENERAL_INFO).text().contains(info.get("brand"))),
                    Ensure.that(AdminVendorClaimPage.REGION_GENERAL_INFO).text().contains(info.get("region")),
                    Ensure.that(AdminVendorClaimPage.ISSUE_GENERAL_INFO).text().contains(info.get("issue")),
                    Ensure.that(AdminVendorClaimPage.ISSUE_DESCRIPTION_GENERAL_INFO).text().contains(info.get("issueDescription")),
                    Check.whether(info.get("type").equals(""))
                            .otherwise(Ensure.that(AdminVendorClaimPage.TYPE_GENERAL_INFO).text().contains(info.get("type"))),
                    Ensure.that(AdminVendorClaimPage.DATE_OF_SUBMISSION_GENERAL_INFO).text().contains(CommonHandle.setDate2(info.get("dateOfSubmission"), "MM/dd/yy")),
                    Ensure.that(AdminVendorClaimPage.STATUS_GENERAL_INFO).text().contains(info.get("status")),
                    Ensure.that(AdminVendorClaimPage.ADMIN_NOTE_GENERAL_INFO).text().contains(info.get("adminNote"))
            );
        }
    }

    @And("Admin get number of vendor claim in detail")
    public void admin_get_number_in_vendor_claim_in_detail() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminVendorClaimPage.NUMBER_CLAIM)
        );

        String number = Text.of(AdminVendorClaimPage.NUMBER_CLAIM).answeredBy(theActorInTheSpotlight()).toString();
        Serenity.setSessionVariable("Claim Number").to(number.substring(6));
    }

    @And("Admin verify uploaded file in vendor claim detail")
    public void admin_verify_uploaded_file_in_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminVendorClaimPage.FILE_UPLOADED(info.get("fileName"))),
                    Ensure.that(AdminVendorClaimPage.FILE_UPLOADED(info.get("fileName"))).text().contains(info.get("fileName"))
            );
        }
    }

    @And("Admin verify sku info in vendor claim detail")
    public void admin_verify_sku_in_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminVendorClaimPage.SKU_DETAIL(infos.get(0).get("sku"))),
                Ensure.that(AdminVendorClaimPage.SKU_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("sku")),
                Ensure.that(AdminVendorClaimPage.SKU_ID_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("skuID")),
                Ensure.that(AdminVendorClaimPage.SKU_QUANTITY_DETAIL(infos.get(0).get("sku"))).attribute("value").contains(infos.get(0).get("quantity"))
        );

    }

    @And("Admin search vendor claim")
    public void admin_search_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue2(infos.get(0), "claimNumber", infos.get(0).get("claimNumber"), Serenity.sessionVariableCalled("Claim Number"), "create");

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                CommonTaskAdmin.showFilter(),
                HandleAdminVendorClaim.search(info)
        );
    }

    @And("Admin verify vendor claim after result")
    public void admin_verify_vendor_claim_after_result(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue2(infos.get(0), "claimNumber", infos.get(0).get("claimNumber"), Serenity.sessionVariableCalled("Claim Number"), "create");

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminVendorClaimPage.CLAIM_NUMBER_RESULT(info.get("claimNumber"))),
                Ensure.that(AdminVendorClaimPage.CLAIM_NUMBER_RESULT(info.get("claimNumber"))).text().contains(info.get("claimNumber")),
                Ensure.that(AdminVendorClaimPage.VENDOR_COMPANY_RESULT(info.get("claimNumber"))).attribute("data-original-text").contains(info.get("vendorCompany")),
                Ensure.that(AdminVendorClaimPage.BRAND_RESULT(info.get("claimNumber"))).attribute("data-original-text").contains(info.get("brand")),
                Ensure.that(AdminVendorClaimPage.ISSUE_RESULT(info.get("claimNumber"))).text().contains(info.get("issue")),
                Ensure.that(AdminVendorClaimPage.STATUS_RESULT(info.get("claimNumber"))).text().contains(info.get("status")),
                Ensure.that(AdminVendorClaimPage.ASSIGNED_RESULT(info.get("claimNumber"))).text().contains(info.get("assignedTo"))
        );

        if (!infos.get(0).get("inbound").equals("")) {
            for (Map<String, String> item : infos) {
                String inbound = Serenity.sessionVariableCalled("Number Inbound Inventory api" + item.get("inbound"));
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AdminVendorClaimPage.INBOUND_RESULT(info.get("claimNumber"), inbound)).text().contains(item.get("inbound"))
                );
            }
        }
    }

    @And("Admin go to detail vendor claim {string}")
    public void admin_go_to_detail_vendor_claim(String claimNumber) {
        if (claimNumber.contains("create")) {
            claimNumber = Serenity.sessionVariableCalled("Claim Number");
        }

        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.goToDetail(claimNumber)
        );
    }

    @And("Admin change status of vendor claim to {string}")
    public void admin_change_status_vendor_claim(String status) {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.changeStatus(status)
        );
    }

    @And("Admin verify {string} in vendor claim detail")
    public void admin_verify_inbound_inventory_in_vendor_claim_detail(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String number = null;
        for (Map<String, String> info : infos) {
            if (type.equals("order")) {
                number = Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString();
            }
            if (type.equals("inbound")) {
                number = Serenity.sessionVariableCalled("Number Inbound Inventory api" + info.get("index")).toString();
            }
            if (info.get("index").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(VendorClaimsPage.ORDER_NUMBER_IN_DETAIL(number)),
                        Ensure.that(VendorClaimsPage.ORDER_NUMBER_IN_DETAIL(number)).text().contains(number)
                );
            }

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminVendorClaimPage.INBOUND_DETAIL(number)).isDisplayed(),
                    Ensure.that(AdminVendorClaimPage.SKU_INBOUND_DETAIL(number, info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(AdminVendorClaimPage.SKU_ID_INBOUND_DETAIL(number, info.get("sku"))).text().contains(info.get("skuID")),
                    Ensure.that(AdminVendorClaimPage.QUANTITY_INBOUND_DETAIL(number, info.get("sku"))).attribute("value").contains(info.get("quantity"))
            );
        }
    }

    @And("Admin verify upload file")
    public void admin_verify_upload_file() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Remove")),
                // file > 10 MB
                CommonFile.upload1("10MBgreater.jpg", AdminVendorClaimPage.D_TEXTBOX_IN_CREATE("Upload files")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded."))
        );
    }

    @And("Admin create vendor claim success then see message {string}")
    public void admin_create_vendor_claim_then_see_message(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.createClaimSeeMessage(message)
        );
    }

    @And("Admin add order to create vendor claim")
    public void admin_add_order_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.addOrderToCreate(infos)
        );
    }

    @And("Admin edit line item of order to create vendor claim")
    public void admin_edit_line_item_of_order_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.editLineItemOrder(infos)
        );
    }

    @And("Admin verify order added in create vendor claim")
    public void admin_verify_order_added_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> item = CommonTask.setValue2(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString(), "create by api");

            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminVendorClaimPage.SKU_ITEM_IN_CREATE(item.get("order"), item.get("sku"))),
                    Ensure.that(AdminVendorClaimPage.SKU_ITEM_IN_CREATE(item.get("order"), item.get("sku"))).text().contains(item.get("sku")),
                    Ensure.that(AdminVendorClaimPage.SKU_ID_ITEM_IN_CREATE(item.get("order"), item.get("sku"))).text().contains(item.get("skuID")),
                    Ensure.that(AdminVendorClaimPage.SKU_QUANTITY_ITEM_IN_CREATE(item.get("order"), item.get("sku"))).attribute("value").contains(item.get("quantity"))
            );
        }
    }

    @And("Admin remove order to create vendor claim")
    public void admin_remove_order_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.removeOrderToCreate(infos)
        );
    }

    @And("Admin add inbound to create vendor claim")
    public void admin_add_inbound_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.addInboundToCreate(infos)
        );
    }

    @And("Admin edit line item of inbound to create vendor claim")
    public void admin_edit_line_item_of_inbound_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.editInboundOrder(infos)
        );
    }

    @And("Admin remove inbound to create vendor claim")
    public void admin_remove_inbound_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.removeInboundToCreate(infos)
        );
    }

    @And("Admin verify inbound added in create vendor claim")
    public void admin_verify_inbound_added_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> item = CommonTask.setValue2(info, "inbound", info.get("inbound"), Serenity.sessionVariableCalled("Number Inbound Inventory api" + info.get("index")).toString(), "create by api");

            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminVendorClaimPage.SKU_ITEM_IN_CREATE(item.get("inbound"), item.get("sku"))),
                    Ensure.that(AdminVendorClaimPage.SKU_ITEM_IN_CREATE(item.get("inbound"), item.get("sku"))).text().contains(item.get("sku")),
                    Ensure.that(AdminVendorClaimPage.SKU_ID_ITEM_IN_CREATE(item.get("inbound"), item.get("sku"))).text().contains(item.get("skuID")),
                    Ensure.that(AdminVendorClaimPage.SKU_QUANTITY_ITEM_IN_CREATE(item.get("inbound"), item.get("sku"))).attribute("value").contains(item.get("quantity"))
            );
        }
    }

    @And("Admin edit general information in vendor claim detail")
    public void admin_edit_general_information_in_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.editGeneralInfoDetail(infos.get(0))
        );
    }

    @And("Admin delete vendor claim {string}")
    public void admin_delete_detail_vendor_claim(String claimNumber) {
        if (claimNumber.contains("")) {
            claimNumber = Serenity.sessionVariableCalled("Claim Number");
        }

        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.deleteClaim(claimNumber)
        );
    }

    @And("Admin add inbound in vendor claim detail")
    public void admin_add_inbound_in_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.addInboundInDetail(infos)
        );
    }

    @And("Admin remove inbound in vendor claim detail")
    public void admin_remove_inbound_in_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.removeInboundToCreate(infos)
        );
    }

    @And("Admin save action in vendor claim detail")
    public void admin_save_action_in_vendor_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.save()
        );
    }

    @And("Admin add sku to vendor claim detail")
    public void admin_add_sku_to_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.addSKUToCreate(infos)
        );
    }

    @And("Admin verify assigned to blank in vendor claim detail")
    public void admin_verify_assigned_to_blank_vendor_claim_detail() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add Admin")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add Admin")),
                CommonWaitUntil.isVisible(AdminVendorClaimPage.ASSIGNED_TO_FIELD(1)),
                Click.on(AdminVendorClaimPage.ASSIGNED_TO_FIELD(1)),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Vendor claim admins admin must exist")),
                Click.on(AdminVendorClaimPage.ASSIGNED_TO_REMOVE_BUTTON(1)),
                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.ASSIGNED_TO_REMOVE_BUTTON(1)),
                WindowTask.threadSleep(1000)
        );
    }

    @And("Admin assigned to in vendor claim detail")
    public void admin_assigned_to_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.assignedTo(infos)
        );
    }

    @And("Admin verify assigned of vendor claim detail")
    public void admin_verify_assigned_of_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminVendorClaimPage.ASSIGNED_TO_FIELD(i + 1)),
                    Ensure.that(AdminVendorClaimPage.ASSIGNED_TO_FIELD(i + 1)).text().contains(infos.get(i).get("assigned"))
            );
        }
    }

    @And("Admin add order in vendor claim detail")
    public void admin_add_order_in_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.addOrderInDetail(infos)
        );
    }
}
