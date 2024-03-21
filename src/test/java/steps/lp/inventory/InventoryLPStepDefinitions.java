package steps.lp.inventory;

import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin_old.login.sidekiq.ScheduledPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.Utility;
import cucumber.tasks.lp.inventory.HandleAllInventoryLP;
import cucumber.tasks.lp.HandleWithdrawRequest;
import cucumber.tasks.lp.inventory.HandleIncomingInventoryLP;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.LPOrdersDetailPage;
import cucumber.user_interface.lp.inventory.InboundInventoryDetailLPPage;
import cucumber.user_interface.lp.inventory.InboundInventoryLPPage;
import cucumber.user_interface.lp.inventory.InventoryLPPage;
import cucumber.user_interface.lp.LPWithdrawalRequestPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;

public class InventoryLPStepDefinitions {

    @And("Lp go to Inbound inventory tab")
    public void goToInboundTab() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(InboundInventoryLPPage.INBOUND_TAB),
                Click.on(InboundInventoryLPPage.INBOUND_TAB),
                CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
        );
    }

    @And("Lp go to All inventory tab")
    public void goToAllTab() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(InventoryLPPage.ALL_TAB),
                Click.on(InventoryLPPage.ALL_TAB),
                CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING),
                Click.on(InventoryLPPage.ALL_TAB_SMALL),
                CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
        );
    }

    @And("Lp go to {string} tab")
    public void lp_go_to_tab(String tab) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllInventoryLP.goToTab(tab)
        );
    }

    @And("LP search {string} inventory")
    public void searchAll(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(InventoryLPPage.D_TAB(type)),
                Click.on(InventoryLPPage.D_TAB(type)),
                CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Fetching your"))
        );
        for (Map<String, String> item : list) {
            HashMap<String, String> info = CommonTask.setValue(item, "sku", item.get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleAllInventoryLP.search(info)
            );
        }
    }

    @And("Check search result in All inventory")
    public void checkSearchAll(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValue(list.get(i), "sku", list.get(i).get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code"), "random");
            if (list.get(i).get("lotCode").equals("randomInbound")) {
                info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("sku") + " " + info.get("index")), "randomInbound");
                System.out.println("Lot Code Inbound " + info.get("sku") + " " + info.get("index") + Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("sku") + " " + info.get("index")));
            }
            if (list.get(i).get("lotCode").equals("randomIndex")) {
                info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "randomIndex");
                System.out.println("Lot Code" + info.get("sku") + " " + info.get("index") + Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")));
            }

            // tìm các trang tiếp theo
            if (InventoryLPPage.LOT_CODE_IN_TABLE_RESULT(info.get("lotCode")).resolveAllFor(theActorInTheSpotlight()).isEmpty()) {
                List<WebElementFacade> listArgumentsE = InventoryLPPage.LOT_CODE_IN_TABLE_RESULT(info.get("lotCode")).resolveAllFor(theActorInTheSpotlight());
                System.out.println("List " + listArgumentsE);
                while (listArgumentsE.isEmpty()) {
                    theActorInTheSpotlight().attemptsTo(
                            Scroll.to(InventoryLPPage.NEXT_RESULT_BUTTON),
                            Click.on(InventoryLPPage.NEXT_RESULT_BUTTON),
                            WindowTask.threadSleep(2000)
                    );

                    listArgumentsE = InventoryLPPage.LOT_CODE_IN_TABLE_RESULT(info.get("lotCode")).resolveAllFor(theActorInTheSpotlight());
                }
            }

            // verify
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(InventoryLPPage.SKU_IN_TABLE_RESULT(info.get("lotCode"))), containsString(info.get("sku"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.DISTRIBUTION_IN_TABLE_RESULT(info.get("lotCode"))), containsString(info.get("distributionCenter"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.VENDOR_COMPANY_IN_TABLE_RESULT(info.get("lotCode"))), containsString(info.get("vendorCompany"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.LOT_CODE_IN_TABLE_RESULT(info.get("lotCode"))), containsString(info.get("lotCode"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.CURRENT_QTY_IN_TABLE_RESULT(info.get("lotCode"))), containsString(info.get("currentQuantity").equalsIgnoreCase("End Quantity After") ? Serenity.sessionVariableCalled("End Quantity After") : list.get(i).get("currentQuantity"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.ORIGINAL_QTY_IN_TABLE_RESULT(info.get("lotCode"))), containsString(info.get("originalQuantity"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.RECEIVE_QTY_IN_TABLE_RESULT(info.get("lotCode"))), containsString(CommonHandle.setDate2(list.get(i).get("received"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.EXPIRY_QTY_IN_TABLE_RESULT(info.get("lotCode"))), containsString(CommonHandle.setDate2(list.get(i).get("expiry"), "MM/dd/yy")))
            );
        }
    }

    @And("Check search result in Running low inventory")
    public void checkSearchAllRunninglow(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValue(list.get(i), "sku", list.get(i).get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(InventoryLPPage.RUNNING_LOW_PRODUCT_IN_TABLE_RESULT(info.get("sku"))), containsString(info.get("product"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.RUNNING_LOW_VENDOR_IN_TABLE_RESULT(info.get("sku"))), containsString(info.get("vendorCompany"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.CURRENT_QTY_IN_TABLE_RESULT(info.get("sku"))), containsString(info.get("currentQuantity").equalsIgnoreCase("End Quantity After") ? Serenity.sessionVariableCalled("End Quantity After") : list.get(i).get("currentQuantity"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.ORIGINAL_QTY_IN_TABLE_RESULT(info.get("sku"))), containsString(info.get("originalQuantity"))),
                    seeThat(CommonQuestions.targetText(InventoryLPPage.END_QTY_IN_TABLE_RESULT(info.get("sku"))), containsString(info.get("endQuantity"))))
            ;
        }
    }

    @And("LP Search Withdrawal Request")
    public void searchWithdrawal(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawRequest.search(list.get(0))
        );
    }

    @And("LP add image for Inventory")
    public void addImages(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleAllInventoryLP.addImage(map.get("image"), map.get("description"))
            );
    }

    @And("LP delete image of Inventory number {int}")
    public void addImages(Integer number) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllInventoryLP.deleteImage(number)
        );
    }

    @And("LP Check record Withdrawal Request")
    public void checkRequestWithdrawal(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(LPWithdrawalRequestPage.DYNAMIC_TABLE("number", i + 1)), containsString(list.get(i).get("number").isEmpty() ? Serenity.sessionVariableCalled("Withdrawal Request Number") : list.get(i).get("number"))),
                    seeThat(CommonQuestions.targetText(LPWithdrawalRequestPage.DYNAMIC_TABLE("request-date", i + 1)), containsString(list.get(i).get("brand"))),
                    seeThat(CommonQuestions.targetText(LPWithdrawalRequestPage.DYNAMIC_TABLE("pickup-date", i + 1)), containsString(CommonHandle.setDate2(list.get(i).get("pickupDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(LPWithdrawalRequestPage.DYNAMIC_TABLE("status", i + 1)), containsString(list.get(i).get("status")))
            );
        }
    }

    @And("LP go to Inbound inventory detail of number {string}")
    public void go_to_detail_inbound_inventory(String num) {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.goToDetail(num)
        );
    }

    @And("LP upload Signed WPL with file {string}")
    public void lp_upload_signed_wpl_with_file(String file) {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.uploadSignedWPL(file)
        );
    }

    @And("LP create new inventory")
    public void lp_create_new_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        if (list.get(0).get("lotCode").contains("random")) {
            String lotCode = "Lot code" + Utility.getRandomString(5);
            Serenity.setSessionVariable("Lot Code").to(lotCode);
        }

        HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "sku", Serenity.sessionVariableCalled("SKU inventory"));
        info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code"), "random");


        theActorInTheSpotlight().attemptsTo(
                HandleAllInventoryLP.createNewInventory(info));
    }

    @And("LP go to create new inventory")
    public void lp_go_create_new_inventory() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllInventoryLP.goCreateNewInventory());
    }

    @And("LP create new inventory successfully")
    public void lp_create_new_inventory() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.createNewInventorySuccess()
        );
    }

    @And("LP verify info of inventory detail")
    public void lp_verify_info_of_inventory_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Product name")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Product name")).attribute("value").contains(expected.get(0).get("product")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("SKU")).attribute("value").contains(expected.get(0).get("sku").contains("random") ? Serenity.sessionVariableCalled("SKU inventory").toString() : expected.get(0).get("sku")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Current Quantity")).attribute("value").contains(expected.get(0).get("quantity")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Total case")).attribute("value").contains(expected.get(0).get("totalCase")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Distribution center")).attribute("value").contains(expected.get(0).get("distribution")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Lot code")).attribute("value").contains(expected.get(0).get("lotCode").equals("random") ? Serenity.sessionVariableCalled("Lot Code").toString() : expected.get(0).get("lotCode")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Receive date")).attribute("value").contains(CommonHandle.setDate2(expected.get(0).get("receiveDate"), "MM/dd/yy")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Expiry date")).attribute("value").contains(CommonHandle.setDate2(expected.get(0).get("expiryDate"), "MM/dd/yy")),
                Ensure.that(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Comment")).attribute("value").contains(expected.get(0).get("comment"))
        );
    }

    @And("LP go to back all inventory from detail")
    public void lp_go_to_back_from_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.goBackFromDetail("< Back to Inventory")
        );
    }

    @And("LP go to back inbound inventory from detail")
    public void lp_go_to_back_inbound_from_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.goBackFromDetail("< Back to Inbound Inventories")
        );
    }

    @And("LP go to back Withdrawal request from detail")
    public void lp_go_to_back_Withdrawal_from_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventoryLP.goBackFromDetail("< Back to Withdrawal Requests")
        );
    }

    @And("LP check no found inventory")
    public void search_and_check_no_found_inventory() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(InboundInventoryLPPage.NO_INVENTORY_FOUND))
        );
    }

    @And("LP check inventory image")
    public void LP_check_inventory_image(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(InventoryLPPage.IMAGE_PREVIEW(item.get("file"), item.get("index"))).isDisplayed(),
                    Ensure.that(InventoryLPPage.DESCRIPTION_IMAGE(item.get("index"))).text().contains(item.get("comment"))
            );
        }
    }

    @And("LP go to detail inventory {string}")
    public void LP_go_to_detail_inventory(String lotCode) {
        if (lotCode.equals("")) {
            lotCode = Serenity.sessionVariableCalled("Lot Code");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleAllInventoryLP.goToDetail(lotCode)
        );
        String num = LPOrdersDetailPage.NUMBER_PO.resolveFor(theActorInTheSpotlight()).getText().split("#")[1];
        Serenity.setSessionVariable("Id Inventory").to(num);
    }

    @And("LP download Inbound packing list {string}")
    public void downloadPacking(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String number = list.get(0).get("inbound");
        if (list.get(0).get("inbound").contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number Inbound Inventory api").toString();
        }
        if (type.equals("PDF")) {
            String file = list.get(0).get("brand") + "__" + CommonHandle.setDate2("currentDate", "MMddyy") + "__" + number + ".pdf";
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON2("PDF")),
                    Click.on(CommonLPPage.DYNAMIC_BUTTON2("PDF")),
                    CommonWaitUntil.waitToDownloadSuccessfully(file)
            );
        } else {
            String file = list.get(0).get("brand") + "__" + CommonHandle.setDate2("currentDate", "MMddyy") + "__" + number + ".xlsx";
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON2("Excel")),
                    Click.on(CommonLPPage.DYNAMIC_BUTTON2("Excel")),
                    CommonWaitUntil.waitToDownloadSuccessfully(file)
            );
        }
    }

}
