package steps.admin.sampleRequest;

import cucumber.tasks.admin.inventory.HandleInventory;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderDetailPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.sampleRequest.SampleRequestTask;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.sampleRequest.SampleRequestPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class SampleRequestStepAdminDefinitions {

    @And("Search sample request by info then system show result")
    public void search_the_sample_request(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                SampleRequestTask.search(list.get(0)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_TABLE("number")), containsString(list.get(0).get("number").isEmpty() ? Serenity.sessionVariableCalled("Number sample request").toString().replaceAll("#", "") : list.get(0).get("number"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_TABLE("region")), containsString(list.get(0).get("region"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_TABLE("buyer")), containsString(list.get(0).get("buyer"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_TABLE("store")), containsString(list.get(0).get("store"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_TABLE("fulfillment")), containsString(list.get(0).get("fulfillment")))
        );
    }

    @And("Admin search sample request")
    public void search(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.resetFilter(),
                    SampleRequestTask.search2(map)
            );
    }

    @And("Admin check list of sample request after search")
    public void check_the_sample_request(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(SampleRequestPage.DYNAMIC_TABLE2("number", list.get(i).get("number")))),
                    seeThat(CommonQuestions.isControlDisplay(SampleRequestPage.DYNAMIC_TABLE2("region", list.get(i).get("region")))),
                    seeThat(CommonQuestions.isControlDisplay(SampleRequestPage.DYNAMIC_TABLE2("buyer el-table__cell", list.get(i).get("buyer")))),
                    seeThat(CommonQuestions.isControlDisplay(SampleRequestPage.DYNAMIC_TABLE2("link-tag buyer-company", list.get(i).get("buyerCompany")))),
                    seeThat(CommonQuestions.isControlDisplay(SampleRequestPage.DYNAMIC_TABLE2("store-tag", list.get(i).get("store")))),
                    seeThat(CommonQuestions.isControlDisplay(SampleRequestPage.DYNAMIC_TABLE2("fulfillment-state", list.get(i).get("fulfillment"))))
            );
    }

    @And("Admin go to detail of first sample request record")
    public void the_first_sample_request() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(SampleRequestPage.NUMBER("23")),
                Click.on(SampleRequestPage.NUMBER("23")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin create new sample request for Head buyer")
    public void create_sample_request(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                SampleRequestTask.createSampleHeadBuyer(list.get(0))

        );
    }

    @And("Admin create new sample request for Normal buyer")
    public void create_sample_request_normal_buyer(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                SampleRequestTask.createSampleNormalBuyer(list.get(0))
        );
    }

    @And("Admin add buyer to new sample request for Normal buyer")
    public void add_buyer_sample_request_normal_buyer(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    SampleRequestTask.addBuyers(map)
            );
    }

    @And("Admin remove buyers added to sample request")
    public void remove_add_buyer_sample_request_normal_buyer(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SampleRequestPage.REMOVE_BUYER(map.get("buyer"))),
                    Click.on(SampleRequestPage.REMOVE_BUYER(map.get("buyer")))
            );
    }

    @And("Admin check buyers added to sample request")
    public void check_add_buyer_sample_request_normal_buyer(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(SampleRequestPage.REMOVE_BUYER(map.get("buyer")))
            );
    }

    @And("Admin check receiving when create sample request")
    public void check_receiving_sample_request_normal_buyer(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(1000),
                    Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Full name")).value().contains(map.get("name")),
                    Ensure.that(CommonAdminForm.DYNAMIC_INPUT("ATTN")).value().contains(map.get("attn")),
                    Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Street address")).value().contains(map.get("street1")),
                    Ensure.that(CommonAdminForm.DYNAMIC_INPUT2("Street address", 2)).value().contains(map.get("street2")),
                    Ensure.that(CommonAdminForm.DYNAMIC_INPUT("City")).value().contains(map.get("city")),
                    Ensure.that(CommonAdminForm.DYNAMIC_INPUT("State (Province/Territory)")).value().contains(map.get("state")),
                    Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Zip")).value().contains(map.get("zip")),
                    Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Phone number")).value().contains(map.get("phoneNumber"))
            );
    }

    @And("Admin add SKUs of product {string} to new sample request")
    public void add_sku_create_sample_request(String product, DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT("Add Product & SKUs")),
                CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_INPUT("Add Product & SKUs")
                        , product, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(product))
        );
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    SampleRequestTask.addSku(map)
            );
        }
    }

    @And("Admin check SKUs of product after add product to new sample request")
    public void check_sku_create_sample_request(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SampleRequestPage.SKU_INFO(map.get("sku"), map.get("product"))).isDisplayed(),
                    Ensure.that(SampleRequestPage.SKU_IMAGE(map.get("sku"), map.get("product"))).attribute("style").containsIgnoringCase(map.get("image"))
            );
        }
    }

    @And("Admin use default head buyer store address")
    public void useDefaultAddress(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                SampleRequestTask.useDefaultReceiving(list.get(0))
        );
    }

    @And("Admin add another address to sample request")
    public void addAnotherAddress(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                SampleRequestTask.addAnotherAddress(list.get(0))
        );
    }

    @And("Admin choose stores to sample request")
    public void chooseStore(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                SampleRequestTask.chooseStore(list.get(0))
        );
    }

    @And("Admin create sample request success")
    public void createSuccess() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin go to sample detail with number {string}")
    public void goToDetail(String number) {
        if (number.isEmpty())
            number = Serenity.sessionVariableCalled("Number sample request").toString().replaceAll("#", "");
        if (number.contains("create by api"))
            number = Serenity.sessionVariableCalled("Number of Sample api").toString();
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(SampleRequestPage.NUMBER(number)),
                Click.on(SampleRequestPage.NUMBER(number)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Check general information sample detail")
    public void checkGeneral(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("created-date")), equalToIgnoringCase(CommonHandle.setDate(list.get(0).get("created"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("link-tag vendor-company")), equalToIgnoringCase(list.get(0).get("vendor_company"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("link-tag buyer-company-name")), equalToIgnoringCase(list.get(0).get("buyer_company"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("link-tag buyer")), equalToIgnoringCase(list.get(0).get("buyer"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("buyer-email")), containsStringIgnoringCase(list.get(0).get("email"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("address-stamp")), containsStringIgnoringCase(list.get(0).get("address"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("status-tag")), equalToIgnoringCase(list.get(0).get("fulfillmentState"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("fulfillment-date")), containsString(CommonHandle.setDate2(list.get(0).get("fulfillmentDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(SampleRequestPage.COMMENT), containsStringIgnoringCase(list.get(0).get("comment")))
        );
        if (list.get(0).containsKey("region"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("region")), equalToIgnoringCase(list.get(0).get("region")))
            );
        if (list.get(0).containsKey("store"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("link-tag store")), equalToIgnoringCase(list.get(0).get("store")))
            );
        if (list.get(0).containsKey("adminNote"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SampleRequestPage.ADMIN_NOTE), containsString(list.get(0).get("adminNote")))
            );
        if (list.get(0).containsKey("canceledReason"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("vendor-canceled-reason bold")), containsString(list.get(0).get("canceledReason")))
            );
        if (list.get(0).containsKey("cancelationNote"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_GENERAL("vendor-cancelation-note")), containsString(list.get(0).get("cancelationNote")))
            );
        Serenity.setSessionVariable("Sample request number").to(SampleRequestPage.SAMPLE_NUMBER.resolveFor(theActorInTheSpotlight()).getText().split("#")[1].trim().toString());
    }

    @And("Check SKUs in sample detail")
    public void checkSKUs(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(SampleRequestPage.DYNAMIC_PRODUCT("brand", i + 1), "data-original-text"), containsString(list.get(i).get("brand"))),
                    seeThat(CommonQuestions.attributeText(SampleRequestPage.DYNAMIC_PRODUCT("product", i + 1), "data-original-text"), containsString(list.get(i).get("product"))),
                    seeThat(CommonQuestions.attributeText(SampleRequestPage.DYNAMIC_PRODUCT("variant", i + 1), "data-original-text"), containsString(list.get(i).get("variant"))),
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_SKU("units", i + 1)), containsString(list.get(i).get("units"))),
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_SKU("comments", i + 1)), containsString(list.get(i).get("comments"))),
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_SKU("upc-tag unit", i + 1)), containsString(list.get(i).get("unitUPC"))),
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_SKU("upc-tag case", i + 1)), containsString(list.get(i).get("caseUPC")))
            );
            if (list.get(i).get("unitPrice").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_SKU_UNIT_PRICE(i + 1)), containsString(list.get(i).get("unitPrice"))),
                        seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_SKU_CASE_PRICE(i + 1)), containsString(list.get(i).get("casePrice")))
                );
            } else {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_SKU("unit-price", i + 1)), containsString(list.get(i).get("unitPrice"))),
                        seeThat(CommonQuestions.targetText(SampleRequestPage.DYNAMIC_SKU("case-price", i + 1)), containsString(list.get(i).get("casePrice")))
                );
            }
        }
    }

    @And("Admin check delivery in sample detail")
    public void checkDelivery(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DELIVERY("carrier")), equalToIgnoringCase(list.get(0).get("carrier"))),
                    seeThat(CommonQuestions.targetText(SampleRequestPage.DELIVERY("tracking-number")), equalToIgnoringCase(list.get(0).get("trackingNumber")))
            );
        }
    }

    @And("Admin Export Sample request {string} CSV")
    public void exportSample(String type) {
        String fileName = "";
        String total = "Sample request detail CSV";
        if (type.equals("detail")) {
            fileName = "sample-request-details-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        }
        if (type.equals("summary")) {
            fileName = "sample-request-summary-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
            total = "Sample request summary CSV";
        }
        theActorInTheSpotlight().attemptsTo(
                CommonFile.deleteFileToDownload(fileName),
                SampleRequestTask.exportSample(total),
                CommonWaitUntil.waitToDownloadSuccessfully(fileName)
        );
    }

    @And("Admin check content file Export sample request detail")
    public void checkContentExportAll(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        String path = System.getProperty("user.dir") + "/target/" + "sample-request-details-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        List<String[]> file = CommonFile.readDataLineByLine(path);
        List<Map<String, String>> actual = CommonHandle.convertListArrayStringToMapString(file);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(actual.get(i).get("ID")).containsIgnoringCase(expected.get(i).get("id").isEmpty() ? Serenity.sessionVariableCalled("ID of Sample api").toString() : expected.get(i).get("id")),
                    Ensure.that(actual.get(i).get("Number")).containsIgnoringCase(expected.get(i).get("number").isEmpty() ? Serenity.sessionVariableCalled("Number of Sample api").toString() : expected.get(i).get("number")),
                    Ensure.that(actual.get(i).get("Created at")).containsIgnoringCase(CommonHandle.setDate2(expected.get(i).get("createdAt"), "MM/dd/yy")),
                    Ensure.that(actual.get(i).get("Store")).containsIgnoringCase(expected.get(i).get("store")),
                    Ensure.that(actual.get(i).get("Buyer")).containsIgnoringCase(expected.get(i).get("buyer")),
                    Ensure.that(actual.get(i).get("Vendor company")).containsIgnoringCase(expected.get(i).get("vendorCompany")),
                    Ensure.that(actual.get(i).get("SKU")).containsIgnoringCase(expected.get(i).get("sku")),
                    Ensure.that(actual.get(i).get("Product")).containsIgnoringCase(expected.get(i).get("product")),
                    Ensure.that(actual.get(i).get("Brand")).containsIgnoringCase(expected.get(i).get("brand")),
                    Ensure.that(actual.get(i).get("Unit UPC / EAN")).containsIgnoringCase(expected.get(i).get("unitUpc")),
                    Ensure.that(actual.get(i).get("Case UPC / EAN")).containsIgnoringCase(expected.get(i).get("caseUpc"))
            );
        }
    }

    @And("Admin check content file Export sample request summary")
    public void checkContentExportSummary(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        String path = System.getProperty("user.dir") + "/target/" + "sample-request-summary-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        List<String[]> file = CommonFile.readDataLineByLine(path);
        List<Map<String, String>> actual = CommonHandle.convertListArrayStringToMapString(file);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(actual.get(i).get("ID")).containsIgnoringCase(expected.get(i).get("id").isEmpty() ? Serenity.sessionVariableCalled("ID of Sample api").toString() : expected.get(i).get("id")),
                    Ensure.that(actual.get(i).get("Number")).containsIgnoringCase(expected.get(i).get("number").isEmpty() ? Serenity.sessionVariableCalled("Number of Sample api").toString() : expected.get(i).get("number")),
                    Ensure.that(actual.get(i).get("Created at")).containsIgnoringCase(CommonHandle.setDate2(expected.get(i).get("createdAt"), "MM/dd/yy")),
                    Ensure.that(actual.get(i).get("Store")).containsIgnoringCase(expected.get(i).get("store")),
                    Ensure.that(actual.get(i).get("Buyer")).containsIgnoringCase(expected.get(i).get("buyer")),
                    Ensure.that(actual.get(i).get("Vendor company")).containsIgnoringCase(expected.get(i).get("vendorCompany")),
                    Ensure.that(actual.get(i).get("Fulfillment state")).containsIgnoringCase(expected.get(i).get("fulfillmentState")),
                    Ensure.that(actual.get(i).get("Fulfillment date")).containsIgnoringCase(CommonHandle.setDate2(expected.get(i).get("fulfillmentDate"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin redirect icon of field")
    public void redirect(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        for (Map<String, String> map : expected)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.REDIRECT_ICON(map.get("field"))),
                    Click.on(CommonAdminForm.REDIRECT_ICON(map.get("field"))),
                    WindowTask.threadSleep(1000)
            );
    }

    @And("Admin verify print Packing slip sample request")
    public void verify_info_in_packing_slip(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String number = expected.get(0).get("number");
        if (expected.get(0).get("number").contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number of Sample api").toString();
        }
        if (expected.get(0).get("number").contains("create by admin")) {
            number = Serenity.sessionVariableCalled("Sample request number").toString();
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.ANY_TEXT("Packing slip")).then(
                        Click.on(CommonAdminForm.ANY_TEXT("Packing slip"))
                ).then(
                        WindowTask.switchToChildWindowsByTitle("Sample request — " + number)
                ),
                CommonWaitUntil.isVisible(SampleRequestPage.NUM_SUB_PACKING_SLIP),
                Ensure.that(SampleRequestPage.NUM_SUB_PACKING_SLIP).text().contains(number),
                Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP("Buyer")).text().containsIgnoringCase(expected.get(0).get("buyer")),
                Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP("Created at")).text().containsIgnoringCase(CommonHandle.setDate2(expected.get(0).get("createdAt"), "MM/dd/yy")),
                Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP("Address")).text().containsIgnoringCase(expected.get(0).get("address")),
                Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP("Comment")).text().containsIgnoringCase(expected.get(0).get("comment"))
        );
        if (expected.get(0).containsKey("store")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP("Store")).text().containsIgnoringCase(expected.get(0).get("store"))
            );
        }
        if (expected.get(0).containsKey("buyerCompany")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP("Buyer Company")).text().containsIgnoringCase(expected.get(0).get("buyerCompany"))
            );
        }
    }

    @And("Admin verify items of Packing slip sample request")
    public void verify_items_in_packing_slip(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : expected)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP2(map.get("sku"), "brand")).text().contains(map.get("brand")),
                    Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP2(map.get("sku"), "product")).text().contains(map.get("product")),
                    Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP2(map.get("sku"), "upc")).text().contains(map.get("upc")),
                    Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP2(map.get("sku"), "case-upc")).text().contains(map.get("case-upc")),
                    Ensure.that(SampleRequestPage.D_INFO_SUB_PACKING_SLIP2(map.get("sku"), "case-units")).text().contains(map.get("case-units"))
            );
    }


    @And("Admin edit sample request field")
    public void editSample(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        for (Map<String, String> map : expected)
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(map.get("fulfillmentDate").isEmpty()).otherwise(
                            Click.on(SampleRequestPage.DYNAMIC_GENERAL_FIELD("Fulfillment date")),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_TOOLTIP_INPUT()),
                            Enter.theValue(CommonHandle.setDate2(map.get("fulfillmentDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_TOOLTIP_INPUT()).thenHit(Keys.TAB),
                            CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")).then(
                                    Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update"))
                            ),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
//                            CommonTaskAdmin.changeValueTooltipDateTime(SampleRequestPage.DYNAMIC_GENERAL_FIELD("Fulfillment date"), CommonHandle.setDate2(map.get("fulfillmentDate"), "MM/dd/yy"))
                    ),
                    Check.whether(map.get("comment").isEmpty()).otherwise(
                            CommonTaskAdmin.changeValueTooltipTextbox(SampleRequestPage.DYNAMIC_GENERAL_FIELD("Buyer comment"), map.get("comment"))
                    ),
                    Check.whether(map.get("carrier").isEmpty()).otherwise(
                            CommonTaskAdmin.changeValueTooltipDropdown(SampleRequestPage.DYNAMIC_GENERAL_FIELD("Carrier"), map.get("carrier"))
                    ),
                    Check.whether(map.get("trackingNumber").isEmpty()).otherwise(
                            CommonTaskAdmin.changeValueTooltipTextbox(SampleRequestPage.DYNAMIC_GENERAL_FIELD("Tracking number"), map.get("trackingNumber"))
                    ),
                    WindowTask.threadSleep(1000)
            );
    }

    @And("Admin edit fulfillment state sample request")
    public void editFulfillStateSample(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        if (expected.get(0).containsKey("fulfillmentDate")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipDateTime(SampleRequestPage.DYNAMIC_GENERAL_FIELD("Fulfillment date"), CommonHandle.setDate2(expected.get(0).get("fulfillmentDate"), "MM/dd/yy"))
            );
        }

        theActorInTheSpotlight().attemptsTo(
                Check.whether(expected.get(0).get("fulfillmentState").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipDropdown(SampleRequestPage.DYNAMIC_GENERAL_FIELD("Fulfillment state"), expected.get(0).get("fulfillmentState"))
                )
        );

        if (expected.get(0).get("fulfillmentState").contains("Canceled")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Please leave an internal cancelation note")),
                    Enter.theValue(expected.get(0).get("note")).into(
                            CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Please leave an internal cancelation note")
                    ),
                    Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(expected.get(0).get("action"))),
                    CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Please leave an internal cancelation note"))
            );
        }
    }

}
