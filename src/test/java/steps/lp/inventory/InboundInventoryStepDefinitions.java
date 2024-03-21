package steps.lp.inventory;

import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.lp.HandleOrdersLP;
import cucumber.tasks.lp.inventory.HandleIncomingInventoryLP;
import cucumber.tasks.vendor.orders.HandleOrdersVendor;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.inventory.InboundInventoryDetailLPPage;
import cucumber.user_interface.lp.inventory.InboundInventoryLPPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class InboundInventoryStepDefinitions {
    @And("LP search and check Inbound inventory")
    public void search(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventoryLP.search(list.get(i).get("number"))
            );
            if (list.get(i).get("number").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat("check number ", CommonQuestions.targetText(InboundInventoryLPPage.TABLE_NUMBER(i + 1)), equalToIgnoringCase(Serenity.sessionVariableCalled("Inventory_Reference").toString())),
                        seeThat("check brand ", CommonQuestions.targetText(InboundInventoryLPPage.TABLE_BRAND(i + 1)), equalToIgnoringCase(list.get(i).get("brand"))),
                        seeThat("check eta ", CommonQuestions.targetText(InboundInventoryLPPage.TABLE_ETA(i + 1)), equalToIgnoringCase(CommonHandle.setDate2(list.get(i).get("eta"), "MM/dd/yy")))
                );
            } else
                theActorInTheSpotlight().should(
                        seeThat("check number ", CommonQuestions.targetText(InboundInventoryLPPage.TABLE_NUMBER(i + 1)), equalToIgnoringCase(list.get(i).get("number"))),
                        seeThat("check brand ", CommonQuestions.targetText(InboundInventoryLPPage.TABLE_BRAND(i + 1)), equalToIgnoringCase(list.get(i).get("brand"))),
                        seeThat("check eta ", CommonQuestions.targetText(InboundInventoryLPPage.TABLE_ETA(i + 1)), equalToIgnoringCase(CommonHandle.setDate2(list.get(i).get("eta"), "MM/dd/yy")))
                );
        }
    }

    @And("Search Inbound inventory")
    public void searchInbound(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<String, String>(list.get(0));

        if (list.get(0).get("number").contains("create by api"))
            info = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Number Inbound Inventory api").toString(), "create by api");
        if (list.get(0).get("number").contains("create by vendor"))
            info = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Inventory_Reference").toString(), "create by vendor");
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.search(info)
        );
    }

    @And("LP Check list of Inbound inventory")
    public void checkInbound(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        for (Map<String, String> map : list) {
            String number = map.get("number").contains("create by api") ? Serenity.sessionVariableCalled("Number Inbound Inventory api").toString() : map.get("number").isEmpty() ? Serenity.sessionVariableCalled("Inventory_Reference").toString() : map.get("number");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(InboundInventoryLPPage.TABLE_INFO(number, "brands"))
            );
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(InboundInventoryLPPage.TABLE_INFO(number, "brands")).text().contains(map.get("brand")),
                    Ensure.that(InboundInventoryLPPage.TABLE_INFO(number, "eta")).text().contains(CommonHandle.setDate2(map.get("eta"), "MM/dd/yy")),
                    Ensure.that(InboundInventoryLPPage.TABLE_INFO(number, "pallets")).text().contains(map.get("pallets")),
                    Ensure.that(InboundInventoryLPPage.TABLE_INFO(number, "sellable-retail-cases")).text().contains(map.get("cases")),
                    Ensure.that(InboundInventoryLPPage.TABLE_INFO(number, "freight-carrier")).text().contains(map.get("freightCarrier"))
            );
            if (map.containsKey("status")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(InboundInventoryLPPage.TABLE_INFO(number, "status")).text().contains(map.get("status"))
                );
            }
        }
    }

    @And("Search {string} and check No found Inbound inventory")
    public void searchCheckNoFound(String num) {
        if (num.equals("")) {
            num = Serenity.sessionVariableCalled("Inventory_Reference");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.search(num)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(InboundInventoryLPPage.NO_INVENTORY_FOUND))
        );
    }

    @And("LP Check General Information of Inbound inventory")
    public void checkGeneralInformation(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat("Check region", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Region")), equalToIgnoringCase(list.get(0).get("region"))),
                seeThat("Check vendorCompany", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Vendor Company")), equalToIgnoringCase(list.get(0).get("vendorCompany"))),
                seeThat("Check status", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Status")), equalToIgnoringCase(list.get(0).get("status"))),
                seeThat("Check Inbound Delivery Method", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Inbound Delivery Method")), equalToIgnoringCase(list.get(0).get("deliveryMethod"))),
                seeThat("lp REVIEW", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("LP Review")), equalToIgnoringCase(list.get(0).get("lpReview"))),
                seeThat("Check eta", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Estimated Date of Arrival")), equalToIgnoringCase(CommonHandle.setDate2(list.get(0).get("eta"), "MM/dd/yy"))),
                seeThat("Check ofPallet", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("# of Pallets")), equalToIgnoringCase(list.get(0).get("ofPallet"))),
                seeThat("Check ofSellableRetail", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("# of Sellable Retail Cases")), equalToIgnoringCase(list.get(0).get("ofSellableRetail"))),
                seeThat("Check ofMasterCarton", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("# of Master Cartons")), equalToIgnoringCase(list.get(0).get("ofMasterCarton"))),
                seeThat("of Sellable Retail Per Carton", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("# of Sellable Retail Cases per Master Carton")), equalToIgnoringCase(list.get(0).get("ofSellableRetailPerCarton"))),
                seeThat("Transportation Coordinator Contact Name", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Transportation Coordinator Contact Name")), equalToIgnoringCase(list.get(0).get("transportContactName"))),
                seeThat("Transportation Coordinator Contact Phone Number", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Transportation Coordinator Contact Phone Number")), equalToIgnoringCase(list.get(0).get("transportContactPhone"))),
                seeThat("Other special shipping details", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Other special shipping details")), equalToIgnoringCase(list.get(0).get("otherShippingDetail"))),
                seeThat("Freight Carrier", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Freight Carrier")), equalToIgnoringCase(list.get(0).get("freightCarrier"))),
                seeThat("trackingNumber", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Tracking Number")), equalToIgnoringCase(list.get(0).get("trackingNumber"))),
                seeThat("Reference number", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("Reference number")), equalToIgnoringCase(list.get(0).get("referenceNumber"))),
                seeThat("BOL", CommonQuestions.targetText(InboundInventoryDetailLPPage.DYNAMIC_GENERAL_INFORMATION("BOL")), equalToIgnoringCase(list.get(0).get("bol")))
        );
    }

    @And("LP Check SKUs Information of Inbound inventory")
    public void checkSKuInformation(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "brand")), containsString(list.get(i).get("brand"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "product")), containsString(list.get(i).get("product"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "variant")), containsString(list.get(i).get("nameSKU"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "upc")), containsString(list.get(i).get("unitUpc"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.CASE_UPC(list.get(i).get("lotCode"))), containsString(list.get(i).get("caseUpc"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "pack")), containsString(list.get(i).get("pack"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "edt-piece case pf-nowrap")), containsString(list.get(i).get("ofCase"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "edt-piece expiry pf-nowrap")), containsString(CommonHandle.setDate2(list.get(i).get("expiryDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "edt-piece receive pf-nowrap")), containsString(CommonHandle.setDate2(list.get(i).get("receivingDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "edt-piece storage pf-nowrap")), containsString(list.get(i).get("storage"))),
                    seeThat(CommonQuestions.targetText(InboundInventoryDetailLPPage.ITEM(list.get(i).get("lotCode"), "edt-piece temperature pf-nowrap")), containsString(list.get(i).get("temperature"))),
                    seeThat(CommonQuestions.targetValue(InboundInventoryDetailLPPage.ITEM_CASES(list.get(i).get("lotCode"), "# of Cases Received")), containsString(list.get(i).get("caseReceived"))),
                    seeThat(CommonQuestions.targetValue(InboundInventoryDetailLPPage.ITEM_CASES(list.get(i).get("lotCode"), "# of Damaged Cases")), containsString(list.get(i).get("caseDamaged"))),
                    seeThat(CommonQuestions.targetValue(InboundInventoryDetailLPPage.ITEM_CASES(list.get(i).get("lotCode"), "# of Shorted Cases")), containsString(list.get(i).get("caseShorted"))),
                    seeThat(CommonQuestions.targetValue(InboundInventoryDetailLPPage.ITEM_CASES(list.get(i).get("lotCode"), "# of Excess Cases")), containsString(list.get(i).get("caseExcess")))
            );
        }
    }

    @And("LP verify inbound inventory images")
    public void lp_verify_inbound_inventory_images(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(InboundInventoryDetailLPPage.INBOUND_INVENTORY_IMAGE(list.get(i).get("image"))).isDisplayed(),
                    Ensure.that(InboundInventoryDetailLPPage.INBOUND_INVENTORY_IMAGE_PREVIEW(list.get(i).get("image"))).isDisplayed(),
                    Ensure.that(InboundInventoryDetailLPPage.INBOUND_INVENTORY_IMAGE_DELETE(list.get(i).get("image"))).isDisplayed()
            );
        }
    }

    @And("LP upload inbound inventory images")
    public void lp_upload_inbound_inventory_images(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.uploadInventoryImage(infos)
        );
    }

    @And("LP remove all inbound inventory images")
    public void lp_remove_inbound_inventory_images() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.removeInventoryImage()
        );
    }

    @And("LP verify error inbound inventory images")
    public void lp_verify_error_inbound_inventory_images() {
        theActorInTheSpotlight().attemptsTo(
                //open upload file
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Add an image")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add an image")),
                CommonWaitUntil.isPresent(InboundInventoryDetailLPPage.REMOVE_IMAGE_BUTTON("1")),
                WindowTask.threadSleep(1000),
                // upload file >10MB
                CommonFile.upload2("10MBgreater.jpg", InboundInventoryDetailLPPage.IMAGE_INDEX("1")),
                CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Maximum file size exceeded.")),
                WindowTask.threadSleep(1000),
                // upload file not type jpg
                CommonFile.upload1("autotest.csv", InboundInventoryDetailLPPage.IMAGE_INDEX("1")),
                CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Invalid file type")),
                WindowTask.threadSleep(1000),
                // Close add image
                Click.on(InboundInventoryDetailLPPage.REMOVE_IMAGE_BUTTON("1"))
        );
    }


    @And("LP search inbound with all filter")
    public void search_order_all_filter(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.searchAll()
        );
        HashMap<String, String> info = new HashMap<String, String>(list.get(0));
        if (list.get(0).get("number").contains("create by api"))
            info = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Number Inbound Inventory api").toString(), "create by api");
        if (list.get(0).get("number").contains("create by vendor"))
            info = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Inventory_Reference").toString(), "create by vendor");
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.inputSearchAll(info)
        );
    }

    @And("LP clear search all filters inbound")
    public void clear_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.clearSearchAll()
        );
    }

    @And("LP close search all filters inbound")
    public void close_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.closeSearchAll()
        );
    }

    @And("LP export Item List")
    public void exportSummary() {
        String file = "Pod_Foods_inbound-inventories_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".csv";
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Item List")),
                Click.on(CommonLPPage.DYNAMIC_BUTTON("Item List")),
                WindowTask.threadSleep(5000),
                CommonWaitUntil.waitToDownloadSuccessfully(file)
        );
    }

    @And("LP check content file Item List")
    public void checkExportSummary(DataTable table) {
        List<String[]> list2 = CommonHandle.convertDataTableToListArrayString(table);
        String path = System.getProperty("user.dir") + "/target/Pod_Foods_inbound-inventories_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".csv";
        List<String[]> file = new ArrayList<>();
        file = CommonFile.readDataLineByLine(path);
        for (int i = 0; i < list2.size(); i++) {
            for (int j = 0; j < list2.get(i).length; j++)
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.AskForContainValue(file.get(i)[j], list2.get(i)[j]))
                );
        }
    }

    @And("LP choose Appointment date inbound")
    public void choose_appointment_Date(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.chooseAppointmentDate(list.get(0).get("appointmentDate"), list.get(0).get("appointmentTime"))
        );
    }

    @And("LP check Appointment date inbound")
    public void check_appointment_Date(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetValue(InboundInventoryDetailLPPage.APPOINTMENT_DATE), equalToIgnoringCase(CommonHandle.setDate2(list.get(0).get("appointmentDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetValue(InboundInventoryDetailLPPage.APPOINTMENT_TIME), equalToIgnoringCase(list.get(0).get("appointmentTime")))
        );
    }

    @And("LP remove Appointment date inbound")
    public void remove_appointment_Date() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.removeAppointmentDate(),
                HandleIncomingInventoryLP.removeAppointmentTime()
        );
    }

    @And("LP edit cases info of items on inbound")
    public void edit_case_info(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventoryLP.editCaseInfo(map)
            );
    }

}
