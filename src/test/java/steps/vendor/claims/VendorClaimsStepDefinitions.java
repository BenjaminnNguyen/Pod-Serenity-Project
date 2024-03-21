package steps.vendor.claims;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.vendor.claims.HandleVendorClaim;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.claims.VendorClaimsPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class VendorClaimsStepDefinitions {

    @And("Vendor go to create claims page")
    public void vendor_go_to_create_claims_page() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.goToCreateClaims()
        );
    }

    @And("Vendor verify default in create vendor claim")
    public void vendor_verify_default_in_create_claim() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Create")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Create")),
                // Verify default
                CommonWaitUntil.isVisible(VendorClaimsPage.D_TEXTBOX_ERROR("Issue Type")),
                Ensure.that(VendorClaimsPage.D_TEXTBOX_ERROR("Issue Type")).text().contains("This field cannot be blank."),
                Ensure.that(VendorClaimsPage.D_TEXTBOX_ERROR("Additional Notes")).text().contains("This field cannot be blank."),
                Ensure.that(VendorClaimsPage.HELP_TEXT).text().contains("* Please share your inbound reference # if your claim is related to an inbound shipment.")
        );
    }

    @And("Vendor fill info to create vendor claim")
    public void vendor_fill_info_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.fillInfoToCreate(infos.get(0))
        );
    }

    @And("Vendor add sku to create vendor claim")
    public void vendor_add_sku_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.addSKUToCreate(infos)
        );
    }

    @And("Vendor verify can not add sku added in create vendor")
    public void vendor_verify_can_not_add_sku_added_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.addSKUNotAdded(infos.get(0))
        );
    }

    @And("Vendor remove sku to create vendor claim")
    public void vendor_remove_sku_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.removeSKUToCreate(infos)
        );
    }

    @And("Vendor verify sku added in create vendor claim")
    public void vendor_verify_sku_added_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorClaimsPage.SKU_ITEM_IN_CREATE(info.get("sku"))),
                    Ensure.that(VendorClaimsPage.PRODUCT_SKU_ITEM_IN_CREATE(info.get("sku"))).text().contains(info.get("product")),
                    Ensure.that(VendorClaimsPage.BRAND_SKU_ITEM_IN_CREATE(info.get("sku"))).text().contains(info.get("brand")),
                    Ensure.that(VendorClaimsPage.SKU_ITEM_IN_CREATE(info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(VendorClaimsPage.SKU_ID_ITEM_IN_CREATE(info.get("sku"))).text().contains(info.get("skuID")),
                    Ensure.that(VendorClaimsPage.SKU_QUANTITY_TEXTBOX_IN_CREATE(info.get("sku"))).attribute("value").contains(info.get("quantity"))
            );
        }
    }

    @And("Vendor select order to add in create vendor claim")
    public void vendor_select_order_to_add_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue2(infos.get(0), "order", infos.get(0).get("order"), Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("index")).toString(), "create by api");

        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.selectOrderToAdd(info)
        );
    }

    @And("Vendor verify line item in order of add popup in create vendor claim")
    public void vendor_verify_line_item_in_order_of_add_popup_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorClaimsPage.LINE_ITEM_PRODUCT_IN_ADD_NEW_ORDERS_POPUP(info.get("sku"))),
                    Ensure.that(VendorClaimsPage.LINE_ITEM_PRODUCT_IN_ADD_NEW_ORDERS_POPUP(info.get("sku"))).text().contains(info.get("product")),
                    Ensure.that(VendorClaimsPage.LINE_ITEM_BRAND_IN_ADD_NEW_ORDERS_POPUP(info.get("sku"))).text().contains(info.get("brand")),
                    Ensure.that(VendorClaimsPage.LINE_ITEM_SKU_IN_ADD_NEW_ORDERS_POPUP(info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(VendorClaimsPage.LINE_ITEM_SKU_ID_IN_ADD_NEW_ORDERS_POPUP(info.get("sku"))).text().contains(info.get("skuID")),
                    Ensure.that(VendorClaimsPage.LINE_ITEM_QUANTITY_IN_ADD_NEW_ORDERS_POPUP(info.get("sku"))).text().contains(info.get("quantity"))
            );
        }
    }

    @And("Vendor select line item in {word} to add in create vendor claim")
    public void vendor_select_line_item_in_to_add_in_create_vendor_claim(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.selectLineItem(infos)
        );
    }

    @And("Vendor add {string} in create vendor claim")
    public void vendor_add_order_in_create_vendor_claim(String value) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.addItemInPopup(value)
        );
    }

    @And("Vendor verify can not add order added in create vendor")
    public void vendor_verify_can_not_add_order_added_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String order = Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("index")).toString();

        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.addOrderNotAdded(order)
        );
    }

    @And("Vendor go to detail claim {string}")
    public void vendor_go_to_detail_claim(String number) {
        if (number.equals("")) {
            number = Serenity.sessionVariableCalled("Claim Number");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.goToDetail(number)
        );
    }

    @And("Vendor create vendor claim success with message {string}")
    public void vendor_create_vendor_claim(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.createClaimSuccess(message)
        );
    }

    @And("Vendor update vendor claim success with message {string}")
    public void vendor_update_vendor_claim(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.updateClaimSuccess(message)
        );
    }

    @And("Vendor get vendor claim number after create")
    public void vendor_get_vendor_claim_number() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isPresent(VendorClaimsPage.NUMBER_CLAIM)
        );

        String number = Text.of(VendorClaimsPage.NUMBER_CLAIM).answeredBy(theActorInTheSpotlight()).toString();
        System.out.println("Claim Number" + number.substring(7));
        Serenity.setSessionVariable("Claim Number").to(number.substring(7));
        Serenity.setSessionVariable("Claim Number").to(number.substring(7));
    }

    @And("Vendor click here after create claim")
    public void vendor_click_here_after_create_claim() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.clickHere()
        );
    }

    @And("Vendor verify list claims")
    public void vendor_verify_list_claims(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue2(infos.get(0), "number", infos.get(0).get("number"), Serenity.sessionVariableCalled("Claim Number"), "create");

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorClaimsPage.NUMBER_CLAIM_RESULT(info.get("number"))),
                Ensure.that(VendorClaimsPage.SUBMITTED_CLAIM_RESULT(info.get("number"))).text().contains(CommonHandle.setDate2(info.get("submitted"), "MM/dd/yy")),
                Ensure.that(VendorClaimsPage.NUMBER_CLAIM_RESULT(info.get("number"))).text().contains(info.get("number")),
                Ensure.that(VendorClaimsPage.BRAND_CLAIM_RESULT(info.get("number"))).text().contains(info.get("brand")),
                Ensure.that(VendorClaimsPage.REGION_CLAIM_RESULT(info.get("number"))).text().contains(info.get("region")),
                Ensure.that(VendorClaimsPage.STATUS_CLAIM_RESULT(info.get("number"))).text().contains(info.get("status"))
        );
    }

    @And("Vendor verify info in claim detail")
    public void vendor_verify_info_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Update")),
                Ensure.that(VendorClaimsPage.ISSUE_TYPE_SELECTED_IN_DETAIL(infos.get(0).get("issueType"))).attribute("value").contains(infos.get(0).get("issueType")),
                Ensure.that(VendorClaimsPage.D_TEXTBOX_CREATE("Select Express Region")).attribute("value").contains(infos.get(0).get("region")),
                Ensure.that(VendorClaimsPage.TYPE_SELECTED_IN_DETAIL(infos.get(0).get("type"))).attribute("value").contains(infos.get(0).get("type")),
                Ensure.that(VendorClaimsPage.D_TEXTAREA_CREATE("Additional Notes")).attribute("value").contains(infos.get(0).get("additionalNote"))
        );
    }

    @And("Vendor verify sku info in claim detail")
    public void vendor_verify_sku_info_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorClaimsPage.SKU_ITEM_IN_CREATE(infos.get(0).get("sku"))),
                Ensure.that(VendorClaimsPage.SKU_ITEM_IN_CREATE(infos.get(0).get("sku"))).text().contains(infos.get(0).get("sku")),
                Ensure.that(VendorClaimsPage.SKU_ID_ITEM_IN_CREATE(infos.get(0).get("sku"))).text().contains(infos.get(0).get("skuId")),
                Ensure.that(VendorClaimsPage.SKU_QUANTITY_TEXTBOX_IN_CREATE(infos.get(0).get("sku"))).attribute("value").contains(infos.get(0).get("quantity"))

        );
    }

    @And("Vendor verify upload file in claim detail")
    public void vendor_verify_upload_file_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorClaimsPage.UPLOADED_FILE_IN_DETAIL(info.get("index"))),
                    Ensure.that(VendorClaimsPage.UPLOADED_FILE_IN_DETAIL(info.get("index"))).text().contains(info.get("file"))
            );
        }
    }

    @And("Vendor verify order info in claim detail")
    public void vendor_verify_order_info_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String order = null;
        for (Map<String, String> info : infos) {
            order = Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString();
            if (info.get("index").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(VendorClaimsPage.ORDER_NUMBER_IN_DETAIL(order)),
                        Ensure.that(VendorClaimsPage.ORDER_NUMBER_IN_DETAIL(order)).text().contains(order)
                );
            }

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorClaimsPage.BRAND_IN_ORDER_IN_DETAIL(order, info.get("sku"))).text().contains(info.get("brand")),
                    Ensure.that(VendorClaimsPage.PRODUCT_IN_ORDER_IN_DETAIL(order, info.get("sku"))).text().contains(info.get("product")),
                    Ensure.that(VendorClaimsPage.SKU_IN_ORDER_IN_DETAIL(order, info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(VendorClaimsPage.SKU_ID_IN_ORDER_IN_DETAIL(order, info.get("sku"))).text().contains(info.get("skuID")),
                    Ensure.that(VendorClaimsPage.QUANTITY_IN_ORDER_IN_DETAIL(order, info.get("sku"))).attribute("value").contains(info.get("quantity"))
            );
        }
    }

    @And("Vendor edit order in claim detail")
    public void vendor_edit_order_in_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.editOrder(infos)
        );
    }

    @And("Vendor remove order to create vendor claim")
    public void vendor_remove_order_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.removeOrderToCreate(infos)
        );
    }

    @And("Vendor select inbound to add in create vendor claim")
    public void vendor_select_inbound_to_add_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue2(infos.get(0), "inbound", infos.get(0).get("inbound"), Serenity.sessionVariableCalled("Number Inbound Inventory api" + infos.get(0).get("index")).toString(), "create by api");

        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.selectInboundToAdd(info)
        );
    }

    @And("Vendor verify can not add inbound added in create vendor")
    public void vendor_verify_can_not_add_inbound_added_in_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String number = Serenity.sessionVariableCalled("Number Inbound Inventory api" + infos.get(0).get("index")).toString();

        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.addInboundNotAdded(number)
        );
    }

    @And("Vendor remove inbound to create vendor claim")
    public void vendor_remove_inbound_to_create_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.removeInboundToCreate(infos)
        );
    }

    @And("Vendor edit inbound in claim detail")
    public void vendor_edit_inbound_in_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.editInbound(infos)
        );
    }

    @And("Vendor verify {string} info in claim detail")
    public void vendor_verify_inbound_info_claim_detail(String type, DataTable dt) {
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
                    Ensure.that(VendorClaimsPage.BRAND_IN_ORDER_IN_DETAIL(number, info.get("sku"))).text().contains(info.get("brand")),
                    Ensure.that(VendorClaimsPage.PRODUCT_IN_ORDER_IN_DETAIL(number, info.get("sku"))).text().contains(info.get("product")),
                    Ensure.that(VendorClaimsPage.SKU_IN_ORDER_IN_DETAIL(number, info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(VendorClaimsPage.SKU_ID_IN_ORDER_IN_DETAIL(number, info.get("sku"))).text().contains(info.get("skuID")),
                    Ensure.that(VendorClaimsPage.QUANTITY_IN_ORDER_IN_DETAIL(number, info.get("sku"))).attribute("value").contains(info.get("quantity"))
            );
        }
    }

    @And("Vendor edit info in vendor claim")
    public void vendor_edit_info_vendor_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.fillInfoToCreate(infos.get(0))
        );
    }

    @And("Vendor add sku to vendor claim detail")
    public void vendor_add_sku_to_vendor_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorClaim.addSKUToCreate(infos)
        );
    }

    @And("Vendor verify resolved info in claim detail")
    public void vendor_verify_resolved_info_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorClaimsPage.REGION_RESOLVED_IN_DETAIL),
                Ensure.that(VendorClaimsPage.STATUS_RESOLVED_IN_DETAIL).text().contains(infos.get(0).get("status")),
                Ensure.that(VendorClaimsPage.REGION_RESOLVED_IN_DETAIL).attribute("value").contains(infos.get(0).get("region")),
                Ensure.that(VendorClaimsPage.ADDITIONAL_NOTE_RESOLVED_IN_DETAIL).attribute("value").contains(infos.get(0).get("additionalNote")),
                Ensure.that(VendorClaimsPage.ADD_FILE_RESOLVED_IN_DETAIL).isDisplayed(),
                Ensure.that(VendorClaimsPage.UPDATE_RESOLVED_IN_DETAIL).isDisplayed()
        );
    }

}
