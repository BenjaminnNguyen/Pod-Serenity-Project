package steps.vendor.Inventory;

import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.withdrawalRequest.CreateWithdrawalRequestsPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.tasks.vendor.inventory.HandleWithdrawalRequestVendor;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorWithdrawalRequestPage;
import cucumber.user_interface.lp.CommonLPPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.*;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;
import static org.hamcrest.Matchers.*;

public class WithdrawalRequestVendorStep {

    @And("Vendor check withdrawal request just created on tab {string}")
    public void checkRecord(String tab, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Withdrawal Request Number"), "random");
        info = CommonTask.setValue(info, "number", info.get("number"), Serenity.sessionVariableCalled("Number Withdraw request api"), "create by api");
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.goToTab(tab),
                Ensure.that(VendorWithdrawalRequestPage.RECORD(info.get("number"), "request-date")).text().contains(CommonHandle.setDate2(info.get("requestDate"), "MM/dd/yy")),
                Ensure.that(VendorWithdrawalRequestPage.RECORD(info.get("number"), "pickup-date")).text().contains(CommonHandle.setDate2(info.get("pickupDate"), "MM/dd/yy")),
                Ensure.that(VendorWithdrawalRequestPage.RECORD(info.get("number"), "cases")).text().contains(info.get("case")),
                Ensure.that(VendorWithdrawalRequestPage.RECORD(info.get("number"), "status")).text().contains(info.get("status"))
        );
    }

    @And("Vendor check withdrawal request number {string} not show on tab {string}")
    public void checkNotRecord(String num, String tab) {
        if (num.contains("create by api"))
            num = Serenity.sessionVariableCalled("Number Withdraw request api");
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.goToTab(tab),
                Ensure.that(VendorWithdrawalRequestPage.RECORD(num, "request-date")).isNotDisplayed()
        );
    }

    @And("Vendor go to detail of withdrawal request {string}")
    public void checkDetail(String number, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (number.isEmpty()) {
            number = Serenity.sessionVariableCalled("Withdrawal Request Number");
        } else if (number.contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number Withdraw request api");
        }
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(VendorWithdrawalRequestPage.STATUS)).otherwise(
                        CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.RECORD(number, "number")),
                        Click.on(VendorWithdrawalRequestPage.RECORD(number, "number")),
                        CommonWaitUntil.isNotVisible(VendorWithdrawalRequestPage.LOADING_SPIN),
                        WindowTask.threadSleep(1000)
                )
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorWithdrawalRequestPage.STATUS), equalToIgnoringCase(list.get(0).get("status"))),
                seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup date"), "value"), equalToIgnoringCase(CommonHandle.setDate2(list.get(0).get("pickupDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup time (Start)"), "value"), equalToIgnoringCase(list.get(0).get("pickupFrom"))),
                seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup time (End)"), "value"), equalToIgnoringCase(list.get(0).get("pickupTo"))),
                seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup region"), "value"), equalToIgnoringCase(list.get(0).get("region"))),
                seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Are you using a freight carrier?"), "value"), equalToIgnoringCase(list.get(0).get("type"))),
                seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pallet weight in total"), "value"), equalToIgnoringCase(list.get(0).get("palletWeight"))),
                seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Comment"), "value"), equalToIgnoringCase(list.get(0).get("comment"))),
                seeThat(CommonQuestions.targetText(VendorWithdrawalRequestPage.BOL), equalToIgnoringCase(list.get(0).get("bol")))
        );
        if (list.get(0).containsKey("endQuantity")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorWithdrawalRequestPage.LOT_REMAINING), containsString(list.get(0).get("endQuantity").equals("End Quantity") ? Serenity.sessionVariableCalled("End Quantity").toString() : Serenity.sessionVariableCalled("End Quantity After")))
            );
        }
        if (list.get(0).containsKey("name")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Name of Contact"), "value"), equalToIgnoringCase(list.get(0).get("name")))
            );
        }
        if (list.get(0).containsKey("carrier")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Carrier"), "value"), equalToIgnoringCase(list.get(0).get("carrier")))
            );
        }
        if (list.get(0).containsKey("address")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorWithdrawalRequestPage.ADDRESS), containsString(list.get(0).get("address")))
            );
        }
    }

    @And("Vendor check lots in detail of withdrawal request")
    public void checkDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (Map<String, String> item : list) {
            info = CommonTask.setValue(item, "sku", item.get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
            System.out.println("Lot code = " + Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")));

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorWithdrawalRequestPage.D_BRAND_DETAILS(info.get("lotCode"))).text().contains(info.get("brand")),
                    Ensure.that(VendorWithdrawalRequestPage.D_PRODUCT_DETAILS(info.get("lotCode"))).text().contains(info.get("product")),
                    Ensure.that(VendorWithdrawalRequestPage.D_SKU_DETAILS(info.get("lotCode"))).text().contains(info.get("sku")),
                    Ensure.that(VendorWithdrawalRequestPage.D_SKU_ID_DETAILS(info.get("lotCode"))).text().contains(info.get("skuID")),
                    Ensure.that(VendorWithdrawalRequestPage.D_LOTCODE_DETAILS(info.get("lotCode"))).text().contains(info.get("lotCode")),
                    Ensure.that(VendorWithdrawalRequestPage.D_QUANTITY_DETAILS(info.get("lotCode"))).attribute("value").contains(info.get("quantity"))
            );
        }
    }

    @And("Vendor create withdrawal request")
    public void create(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.goToCreate(),
                HandleWithdrawalRequestVendor.fillInfo(list.get(0))
        );
    }

    @And("Vendor update withdrawal request")
    public void vendor_update_withdrawal_request(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.fillInfo(list.get(0))
        );
    }

    @And("Vendor update BOL is {string}")
    public void vendor_update_bol_is(String bol) {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.uploadBOL(bol)
        );
    }

    @And("Vendor click create withdrawal request")
    public void vendor_click_create_withdrawal_request() {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.createSuccess()
        );
        String[] number = CommonQuestions.targetText(VendorWithdrawalRequestPage.TITLE).answeredBy(theActorInTheSpotlight()).split("#");
        Serenity.setSessionVariable("Withdrawal Request Number").to(number[1]);
        String id = CommonHandle.getCurrentURL().split("withdrawal-requests/")[1];
        Serenity.setSessionVariable("Withdrawal Request ID").to(id);
    }

    @And("Vendor click create withdrawal request and see error {string}")
    public void vendor_click_create_withdrawal_request_and_see_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorWithdrawalRequestPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT(message))
        );
    }

    @And("Vendor verify region available in withdrawal request")
    public void verifyRegion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup region")),
                Click.on(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup region")),
                WindowTask.threadSleep(1000)
        );
        List<WebElementFacade> regions = VendorWithdrawalRequestPage.LIST_REGION.resolveAllFor(theActorInTheSpotlight());
        theActorInTheSpotlight().should(
                seeThat("Number of region are available", CommonQuestions.getNumElement(VendorWithdrawalRequestPage.LIST_REGION), equalTo(list.size()))
        );
        for (int i = 0; i < regions.size(); i++)
            theActorInTheSpotlight().should(
                    seeThat("Number of region are available", CommonQuestions.webElementFacadeText(regions.get(i)), equalToIgnoringCase(list.get(i).get("region")))
            );
        theActorInTheSpotlight().attemptsTo(
                Hit.the(Keys.TAB).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup region"))
        );
    }

    @And("Vendor add new lot code to withdrawal request 2")
    public void addLotcode(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "lotCode", Serenity.sessionVariableCalled("Lot Code" + list.get(0).get("sku") + list.get(0).get("index")));

            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.searchLot(info.get("sku"))
            );
            if (map.get("sku").isEmpty()) {
                Serenity.setSessionVariable("End Quantity").to(CommonQuestions.getText(theActorInTheSpotlight(), VendorWithdrawalRequestPage.END_QUANTITY_OF_SKU).replaceAll(",", ""));
                Serenity.setSessionVariable("End Quantity After").to(String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(map.get("lotQuantity"))));

            } else {
                Serenity.setSessionVariable("End Quantity").to(CommonQuestions.getText(theActorInTheSpotlight(), VendorWithdrawalRequestPage.END_QUANTITY_OF_SKU(map.get("sku"))).replaceAll(",", ""));
                Serenity.setSessionVariable("End Quantity After").to(String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(map.get("lotQuantity"))));

            }
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.choseSKU(info)
            );
        }
    }

    @And("Vendor add new sku with lot code to withdrawal request")
    public void vendor_add_lotcode_to_withdrawal(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValue(map, "sku", map.get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.searchLot(info.get("lotCode"))
            );
            if (map.get("sku").isEmpty()) {
                Serenity.setSessionVariable("End Quantity").to(CommonQuestions.getText(theActorInTheSpotlight(), VendorWithdrawalRequestPage.END_QUANTITY_OF_SKU).replaceAll(",", ""));
                Serenity.setSessionVariable("End Quantity After").to(String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(map.get("lotQuantity"))));
            } else {
                Serenity.setSessionVariable("End Quantity").to(CommonQuestions.getText(theActorInTheSpotlight(), VendorWithdrawalRequestPage.END_QUANTITY_OF_SKU(map.get("sku"))).replaceAll(",", ""));
                Serenity.setSessionVariable("End Quantity After").to(String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(map.get("lotQuantity"))));
            }
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.choseSkuWithLotcode(info)
            );
        }
    }

    @And("Vendor search value {string} and add lot to withdrawal request")
    public void vendor_search_add_lot_code_to_withdrawal(String search, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.searchLot(search)
        );
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValue(list.get(i), "sku", list.get(i).get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");

            if (list.get(i).get("lotCode").isEmpty())
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_SKU_BY_LOTCODE(list.get(i).get("lotCode"))).isNotDisplayed()
                );
            else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("brand pf-ellipsis", i + 1)).text().contains(info.get("brand")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("product pf-ellipsis", i + 1)).text().contains(info.get("product")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("sku__name pf-ellipsis", i + 1)).text().contains(info.get("sku")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("lot__value pf-break-word", i + 1)).text().contains(info.get("lotCode")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("lot__current-qty tr", i + 1)).text().contains(info.get("currentQty")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("lot__end-qty tr", i + 1)).text().contains(info.get("endQty")),
                        Ensure.that(VendorWithdrawalRequestPage.SEARCH_VALUE("lot__pulled-qty tr", i + 1)).text().contains(info.get("pulledQty")),
                        Click.on(VendorWithdrawalRequestPage.SEARCH_VALUE("product pf-ellipsis", i + 1)),
                        Ensure.that(VendorWithdrawalRequestPage.ADD_SELECTED_LOT).text().contains("Add \n" + (i + 1) + " \nselected lot")
                );
                if (i == list.size() - 1)
                    theActorInTheSpotlight().attemptsTo(
                            Click.on(VendorWithdrawalRequestPage.ADD_SELECTED_LOT)
                    );
            }
        }
    }

    @And("Vendor search value {string} and check lot added on withdrawal request")
    public void vendor_search_added_lot_code_to_withdrawal(String search, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.searchLot(search)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorWithdrawalRequestPage.SKU_ADDED(list.get(i).get("sku"))).attribute("class").contains("disabled")
            );
        }
    }

    @And("Vendor add new lot code to withdrawal request")
    public void vendor_add_lotcode_to_withdrawal2(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValueRandom(map, "lotCode", Serenity.sessionVariableCalled("Lot Code" + map.get("sku") + map.get("index")));
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.addLots1(info)
            );
            if (map.get("sku").isEmpty()) {
                Serenity.setSessionVariable("End Quantity").to(CommonQuestions.getText(theActorInTheSpotlight(), VendorWithdrawalRequestPage.END_QUANTITY_OF_SKU).replaceAll(",", ""));
                Serenity.setSessionVariable("End Quantity After").to(String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(map.get("lotQuantity"))));
            } else {
                Serenity.setSessionVariable("End Quantity").to(CommonQuestions.getText(theActorInTheSpotlight(), VendorWithdrawalRequestPage.END_QUANTITY_OF_SKU(map.get("sku"))).replaceAll(",", ""));
                Serenity.setSessionVariable("End Quantity After").to(String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(map.get("lotQuantity"))));
            }
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.addLots2(info)
            );
        }
    }

    @And("Vendor input lot code info to withdrawal request")
    public void vendor_input_lotcode_to_withdrawal2(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValue(map, "lotCode", map.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + map.get("sku") + map.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.choseSkuWithLotcode2(info)
            );
        }
    }

    @And("Vendor check withdrawal request {string} on tab {string} no found")
    public void check_withdrawal_request_no_found(String number, String tab) {
        if (number.equals("")) {
            number = Serenity.sessionVariableCalled("Withdrawal Request Number");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.goToTab(tab),
                Ensure.that(VendorWithdrawalRequestPage.RECORD(number, "request-date")).isNotDisplayed()
        );
    }

    @And("Vendor update withdrawal request success")
    public void vendor_update_withdrawal_request_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.updateSuccess()
        );
    }

    @And("Vendor remove sku with lot code to withdrawal request")
    public void vendor_remove_lotcode_to_withdrawal(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValue(map, "lotCode", map.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + map.get("sku") + map.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.removeLotCode(info.get("lotCode"))
            );
        }
    }

    @And("Vendor verify field in create withdrawal")
    public void vendor_verify_field_in_create_withdrawal(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.goToCreate(),
                // Verify pickupdate
                Click.on(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup date")),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.PICKUP_DATE_DAY_DISABLE(CommonHandle.setDate2("Plus5", "d"))),
                // Verify pickup time
                CommonTask.chooseItemInDropdown(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup time (Start)"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(list.get(0).get("pickupFrom"))),
                Click.on(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup time (End)")),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(list.get(0).get("pickupTo"))),
                Ensure.that(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(list.get(0).get("pickupFrom"))).attribute("class").contains("disabled"),
                Click.on(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(list.get(0).get("pickupTo"))),
                // Verify partner
                CommonTask.chooseItemInDropdown(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Are you using a freight carrier?"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1("Self Pickup")),
                Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Name of Contact")).isDisplayed(),
                CommonTask.chooseItemInDropdown(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Are you using a freight carrier?"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1("Carrier Pickup")),
                Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Carrier")).isDisplayed(),
                // Verify pallet weight in total
                Enter.theValue("e").into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pallet weight in total")),
                Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_FIELD_ERROR("Pickup date")).text().contains("Please enter pickup date")
        );
    }

    @And("Vendor verify blank value in create withdrawal with carrier is {string}")
    public void vendor_verify_blank_value_in_create_withdrawal(String carrier) {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequestVendor.goToCreate(),
                CommonTask.chooseItemInDropdown(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Are you using a freight carrier?"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(carrier)),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Create")),
                WindowTask.threadSleep(1000),
                Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_FIELD_ERROR("Pickup date")).text().contains("Please enter pickup date"),
                Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_FIELD_ERROR("Pickup time (Start)")).text().contains("Please select pickup start time"),
                Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_FIELD_ERROR("Pickup time (End)")).text().contains("Please select pickup end time"),
                Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_FIELD_ERROR("Pickup region")).text().contains("Please select pickup region"),
                Check.whether(carrier.equals("Self Pickup"))
                        .andIfSo(
                                Ensure.that(VendorWithdrawalRequestPage.DYNAMIC_FIELD_ERROR("Name of Contact")).text().contains("Please enter pickup partner name")),
                Ensure.that(VendorWithdrawalRequestPage.ADD_NEW_LOT_DISABLED).attribute("class").contains("disabled"),
                Ensure.that(VendorWithdrawalRequestPage.MESSAGE_LOT_ERROR).text().contains("Please select at least one inventory lot")
        );
    }

    @And("Vendor edit sku with lot code to withdrawal request")
    public void vendor_edit_lotcode_to_withdrawal(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValueRandom(map, "lotCode", Serenity.sessionVariableCalled("Lot Code" + map.get("sku") + map.get("index")));

            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequestVendor.editLotCode(info)
            );
        }

    }

    @And("LP download WPL {string} and brand {string}")
    public void downloadPacking(String number, String brand) {
        if (number.contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number Withdraw request api").toString();
            String file = brand + "__" + CommonHandle.setDate2("currentDate", "MMddyy") + "__" + number + ".xlsx";
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON2("WPL Export")),
                    Click.on(CommonLPPage.DYNAMIC_BUTTON2("WPL Export")),
                    CommonWaitUntil.waitToDownloadSuccessfully(file)
            );
        }
    }

    @And("LP check content WPL Export")
    public void checkContentWPL(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        String number = expected.get(0).get("number");
        String itemCode = expected.get(0).get("itemCode");
        if (expected.get(0).get("number").contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number Withdraw request api").toString();
        }
        if (expected.get(0).get("itemCode").contains("create by api")) {
            itemCode = Serenity.sessionVariableCalled("ID SKU Admin").toString();
        }
        String path = System.getProperty("user.dir") + "/target/" + expected.get(0).get("brand") + "__" + Utility.getTimeNow("MMddyy") + "__" + number + ".xlsx";
        List<String[]> file = CommonFile.readDataExcelLineByLine(path);
        List<Map<String, String>> acture = CommonHandle.convertListArrayStringToMapString(file);
        for (Map<String, String> map : expected) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(acture.get(0).get("Inventory Withdrawal Number")).containsIgnoringCase(number),
                    Ensure.that(acture.get(0).get("Brand ID")).containsIgnoringCase(map.get("brandId")),
                    Ensure.that(acture.get(0).get("Brand")).containsIgnoringCase(map.get("brand")),
                    Ensure.that(acture.get(0).get("Product")).containsIgnoringCase(map.get("product")),
                    Ensure.that(acture.get(0).get("SKU")).containsIgnoringCase(map.get("sku")),
                    Ensure.that(acture.get(0).get("Item Code")).containsIgnoringCase(itemCode),
                    Ensure.that(acture.get(0).get("Quantity")).containsIgnoringCase(map.get("quantity")),
                    Ensure.that(acture.get(0).get("Case packs")).containsIgnoringCase(map.get("casePack")),
                    Ensure.that(acture.get(0).get("Unit UPC/EANs")).containsIgnoringCase(map.get("unitUPC")),
                    Ensure.that(acture.get(0).get("Case UPC/EANs")).containsIgnoringCase(map.get("caseUPC")),
                    Ensure.that(acture.get(0).get("Min Temperature")).containsIgnoringCase(map.get("minTemperature")),
                    Ensure.that(acture.get(0).get("Max Temperature")).containsIgnoringCase(map.get("maxTemperature")),
                    Ensure.that(acture.get(0).get("Expiration Date")).containsIgnoringCase(CommonHandle.setDate2(map.get("expirationDate"), "yyyy-MM-dd"))
            );
        }
    }


}
