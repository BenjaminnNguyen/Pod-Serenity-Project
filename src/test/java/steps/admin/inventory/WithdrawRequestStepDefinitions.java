package steps.admin.inventory;

import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.store.AllStoresPage;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.inventory.WithdrawalRequestLPPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.inventory.HandleWithdrawalRequests;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.withdrawalRequest.CreateWithdrawalRequestsPage;
import cucumber.user_interface.admin.inventory.withdrawalRequest.WithdrawalRequestsDetailPage;
import cucumber.user_interface.admin.inventory.withdrawalRequest.WithdrawalRequestsPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.equalToIgnoringCase;
import static org.hamcrest.Matchers.in;

public class WithdrawRequestStepDefinitions {
    @And("Admin search withdraw request")
    public void searchWithdrawal(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : infos) {
            HashMap<String, String> info = new HashMap<>(map);
            String numb = "";
            if (info.get("number").equals("create by admin")) {
                numb = Serenity.sessionVariableCalled("Withdrawal Request Number");
            }
            if (info.get("number").equals("create by vendor")) {
                numb = Serenity.sessionVariableCalled("Withdrawal Request Number");
            }
            if (info.get("number").equals("create by api")) {
                numb = Serenity.sessionVariableCalled("Number Withdraw request api");
            }
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequests.search(info, numb)
            );
        }
    }

    @And("Admin go to detail withdraw request number {string}")
    public void goToDetail(String number) {
        String numb = number;
        if (number.isEmpty())
            numb = Serenity.sessionVariableCalled("Withdrawal Request Number");
        if (number.equals("create by api")) {
            numb = Serenity.sessionVariableCalled("Number Withdraw request api");
        }
        if (number.equals("create by vendor")) {
            numb = Serenity.sessionVariableCalled("Withdrawal Request Number");
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(WithdrawalRequestsPage.DYNAMIC_INFO1(numb, "number")),
                Click.on(WithdrawalRequestsPage.DYNAMIC_INFO1(numb, "number")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin Complete withdraw request")
    public void complete() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(WithdrawalRequestsDetailPage.DYNAMIC_SPAN_TEXT("Complete")),
                Click.on(WithdrawalRequestsDetailPage.DYNAMIC_SPAN_TEXT("Complete")),
                CommonWaitUntil.isVisible(WithdrawalRequestsDetailPage.DYNAMIC_SPAN_TEXT("OK")),
                Click.on(WithdrawalRequestsDetailPage.DYNAMIC_SPAN_TEXT("OK")),
                CommonWaitUntil.isVisible(WithdrawalRequestsDetailPage.DYNAMIC_ALERT("Withdraw request has been completed successfully!")),
                CommonWaitUntil.isNotVisible(WithdrawalRequestsDetailPage.DYNAMIC_ALERT("Withdraw request has been completed successfully!"))
        );
    }

    @And("Admin check record on list withdrawal request")
    public void verifyRecord(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            String number = map.get("number");
            if (map.get("number").contains("create by admin")) {
                number = Serenity.sessionVariableCalled("Withdrawal Request Number");
            }
            if (map.get("number").contains("create by api")) {
                number = Serenity.sessionVariableCalled("Number Withdraw request api");
            }
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(WithdrawalRequestsPage.DYNAMIC_INFO(number, "number")), equalToIgnoringCase(number)),
                    seeThat(CommonQuestions.attributeText(WithdrawalRequestsPage.VENDOR_COMPANY(number, "vendor-company-name"), "data-original-text"), equalToIgnoringCase(map.get("vendorCompany"))),
                    seeThat(CommonQuestions.targetText(WithdrawalRequestsPage.DYNAMIC_INFO(number, "brand")), equalToIgnoringCase(map.get("brand"))),
                    seeThat(CommonQuestions.targetText(WithdrawalRequestsPage.DYNAMIC_INFO(number, "region-name")), equalToIgnoringCase(map.get("region"))),
                    seeThat(CommonQuestions.targetText(WithdrawalRequestsPage.PICKUP_DATE(number, "pickup-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("pickupDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(WithdrawalRequestsPage.DYNAMIC_INFO(number, "status")), equalToIgnoringCase(map.get("status")))
            );
        }
    }

    @And("Admin create withdrawal request")
    public void createWithdraw(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.goToCreateWithdrawal(),
                HandleWithdrawalRequests.create(list.get(0))
        );
    }

    @And("Admin go to create withdrawal request")
    public void goToCreateWithdraw() {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.goToCreateWithdrawal()
        );
    }

    @And("Admin create withdraw request success")
    public void admin_create_withdraw_request_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.createSuccess()
        );
        // number của withdrawal
        String[] number = CommonQuestions.targetText(CreateWithdrawalRequestsPage.TITLE).answeredBy(theActorInTheSpotlight()).split(" - ");
        Serenity.setSessionVariable("Withdrawal Request Number").to(number[1]);

        System.out.println("Withdrawal Request Numbe" + number[1]);

        // id của withdrawal
        String id = CommonQuestions.targetText(CreateWithdrawalRequestsPage.TITLE).answeredBy(theActorInTheSpotlight()).substring(20, 24);
        Serenity.setSessionVariable("Withdrawal Request ID").to(id);
    }

    @And("Admin add lot codes to withdrawal request")
    public void addLotCode(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (Map<String, String> map : list) {
            // nếu sku là random
            info = CommonTask.setValue(map, "skuName", map.get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")), "random");

            System.out.println("Lot code = " + Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")));
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequests.clickSearchLotcodeInAdd(),
                    HandleWithdrawalRequests.searchLotcodeInAdd(info),
                    HandleWithdrawalRequests.addLotcodeAfterSearch(info)
            );
            if (map.get("lotCode").isEmpty()) {
                Serenity.setSessionVariable("End Quantity").to(CommonQuestions.getText(theActorInTheSpotlight(), CreateWithdrawalRequestsPage.FIRST_LOT_CODE_QTY).replaceAll(",", ""));
                Serenity.setSessionVariable("End Quantity After").to(String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(info.get("case"))));
            } else {
                Serenity.setSessionVariable("End Quantity").to(CommonQuestions.getText(theActorInTheSpotlight(), CreateWithdrawalRequestsPage.LOT_CODE_QTY(info.get("lotCode"))).replaceAll(",", ""));//
                Serenity.setSessionVariable("End Quantity After").to(String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(info.get("case"))));
            }
        }
    }

    @And("Admin check general information {string} withdrawal request")
    public void checkInformationDetail(String type, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(WithdrawalRequestsDetailPage.WAIT_REGION(list.get(0).get("region"))),
                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("company")).text().isEqualTo(list.get(0).get("vendorCompany")),
                Check.whether(type.equals("complete"))
                        .andIfSo(
                                Ensure.that(WithdrawalRequestsDetailPage.PICKUP_DATE_COMPLETE).text().isEqualTo((CommonHandle.setDate2(list.get(0).get("pickupDate"), "MM/dd/yy"))))
                        .otherwise(
                                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("pickup-date")).text().isEqualTo((CommonHandle.setDate2(list.get(0).get("pickupDate"), "MM/dd/yy")))),
                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("start-time")).text().isEqualTo((list.get(0).get("startTime"))),
                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("end-time")).text().isEqualTo((list.get(0).get("endTime"))),
                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("pickup-region")).text().isEqualTo((list.get(0).get("region"))),
                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("pickup-type")).text().isEqualTo((list.get(0).get("pickupType"))),
                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("pickup-partner-name")).text().isEqualTo((list.get(0).get("partner"))),
                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("pallet-weight")).text().isEqualTo((list.get(0).get("palletWeight"))),
                Ensure.that(WithdrawalRequestsDetailPage.STATUS).text().isEqualTo((list.get(0).get("status"))),
                Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("comment")).text().isEqualTo((list.get(0).get("comment"))),
                Ensure.that(WithdrawalRequestsDetailPage.BOL).text().contains(list.get(0).get("bol"))
        );
        if (list.get(0).containsKey("buttonWPL")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestsDetailPage.BACK_BUTTON).isDisplayed(),
                    Ensure.that(WithdrawalRequestsDetailPage.WPL_BUTTON).isDisplayed(),
                    Ensure.that(WithdrawalRequestsDetailPage.DELETE_BUTTON).isDisplayed()
            );
        }
        if (list.get(0).containsKey("contactEmail")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestsDetailPage.DYNAMIC_SPAN("email")).text().contains(list.get(0).get("contactEmail"))
            );
        }
        if (list.get(0).containsKey("createBy")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestsDetailPage.CREATE_BY).text().contains(list.get(0).get("createBy"))
            );
        }
        if (list.get(0).containsKey("createOn")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestsDetailPage.CREATE_ON).text().contains(CommonHandle.setDate2(list.get(0).get("createOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check lot code in withdrawal request")
    public void checkInformationDetailLotCode(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (Map<String, String> item : list) {
            // nếu sku là random
            info = CommonTask.setValue(item, "sku", item.get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(WithdrawalRequestsDetailPage.PRODUCT_INFO(info.get("lotCode"))).text().contains(info.get("product")),
                    Ensure.that(WithdrawalRequestsDetailPage.SKU_INFO(info.get("lotCode"))).text().contains(info.get("sku")),
                    Ensure.that(WithdrawalRequestsDetailPage.LOTCODE_INFO(info.get("lotCode"))).text().contains(info.get("lotCode")),
                    Check.whether(info.get("endQty").isEmpty())
                            .otherwise(Ensure.that(WithdrawalRequestsDetailPage.ENDQTY_INFO(info.get("lotCode"))).text().contains(info.get("endQty"))),
                    Ensure.that(WithdrawalRequestsDetailPage.CASE_INFO(info.get("lotCode"))).attribute("value").contains(info.get("case"))
            );
            if (info.containsKey("expiryDate")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(WithdrawalRequestsDetailPage.EXPIRY_DATE(info.get("lotCode"))).text().contains(info.get("expiryDate"))
                );
            }
            if (info.containsKey("pullQty")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(WithdrawalRequestsDetailPage.PULL_QTY(info.get("lotCode"))).text().contains(info.get("pullQty"))
                );
            }
        }
    }

    @And("Admin add same lot codes to withdrawal request")
    public void admin_add_same_lot_code(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (Map<String, String> map : list) {
            info = CommonTask.setValue(map, "lotCode", map.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + map.get("skuName") + map.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequests.clickSearchLotcodeInAdd(),
                    HandleWithdrawalRequests.searchLotcodeInAdd(info),
                    Ensure.that(CreateWithdrawalRequestsPage.LOT_CODE_IN_ADD(info.get("lotCode"))).isNotDisplayed()
            );
        }
    }

    @And("Admin create withdrawal request {string} with blank value")
    public void admin_create_withdrawal_request_with_blank_value(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.createWithBlankValue(type),
                Ensure.that(CreateWithdrawalRequestsPage.DYNAMIC_INFO_ERROR("Vendor Company")).text().contains("Please select a vendor company for the withdrawal request"),
                Ensure.that(CreateWithdrawalRequestsPage.DYNAMIC_INFO_ERROR("Pickup date")).text().contains("Please select a pickup date for the withdrawal request"),
                Ensure.that(CreateWithdrawalRequestsPage.DYNAMIC_INFO_ERROR("Pickup time")).text().contains("Please select pickup time for the withdrawal request"),
                Ensure.that(CreateWithdrawalRequestsPage.DYNAMIC_INFO_ERROR("Region")).text().contains("Please select a region for the withdrawal request"),
                Check.whether(type.equals("Carrier pickup"))
                        .otherwise(Ensure.that(CreateWithdrawalRequestsPage.DYNAMIC_INFO_ERROR("Name of Contact")).text().contains("This field cannot be empty")),
                Ensure.that(CreateWithdrawalRequestsPage.DYNAMIC_INFO_ERROR("Lot codes")).text().contains("Lot codes must have at least one")
        );
    }

    @And("Admin input invalid vendor company")
    public void admin_enter_invalid_vendor_company(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.goToCreateWithdrawal()
        );
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTask.enterInvalidToDropdown(CreateWithdrawalRequestsPage.DYNAMIC_INFO("vendor-company"), item.get("vendorCompany")),
                    Click.on(CreateWithdrawalRequestsPage.DYNAMIC_INFO("pickup-partner"))
            );
        }
    }

    @And("Admin verify # of case of lotcode")
    public void admin_verify_of_case_of_lotcode(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    Clear.field(CreateWithdrawalRequestsPage.CASES_VERIRY),
                    Enter.theValue(item.get("case")).into(CreateWithdrawalRequestsPage.CASES_VERIRY),
                    Check.whether(item.get("result").equals(""))
                            .otherwise(Ensure.that(CreateWithdrawalRequestsPage.CASES_ERROR).text().contains(item.get("result")))
            );
        }
    }

    @And("Admin verify pallet weight")
    public void admin_verify_pallet_weight(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Clear.field(CreateWithdrawalRequestsPage.DYNAMIC_INFO("pallet-weight")),
                Enter.theValue(list.get(0).get("palletWeight")).into(CreateWithdrawalRequestsPage.DYNAMIC_INFO("pallet-weight"))
        );
    }

    @And("Admin verify upload BOL")
    public void admin_verify_upload_bol(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonFile.upload1(list.get(0).get("bol"), CreateWithdrawalRequestsPage.DYNAMIC_INFO("attachement")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP(list.get(0).get("result"))),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_MESSAGE_POPUP(list.get(0).get("result")))
        );
    }

    @And("Admin save withdraw request success")
    public void admin_save_withdraw_request_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.saveSuccess()
        );
    }

    @And("Admin remove lot cote in withdraw request success")
    public void admin_remove_lotcode_of_withdraw_request_success(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (Map<String, String> item : list) {
            info = CommonTask.setValueRandom(item, "lotCode", Serenity.sessionVariableCalled("Lot Code" + item.get("skuName") + item.get("index")));
            System.out.println("Lot code = " + Serenity.sessionVariableCalled("Lot Code" + item.get("skuName") + item.get("index")));
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequests.removeLotCode(info.get("lotCode"))
            );
        }
    }

    @And("Admin approve withdraw request success")
    public void admin_approve_withdraw_request_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.approveSuccess()
        );
    }

    @And("Admin change case of lotcode")
    public void admin_edit_lot_code(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (Map<String, String> map : list) {
            info = CommonTask.setValue(map, "skuName", map.get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")), "random");
            System.out.println("Lot code = " + Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")));
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequests.changeCaseOfLotCode(info),
                    HandleWithdrawalRequests.saveSuccess()
            );
        }
    }

    @And("Admin edit case of lot code")
    public void admin_edit_case_lot_code(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (Map<String, String> map : list) {
            info = CommonTask.setValue(map, "skuName", map.get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleWithdrawalRequests.changeCaseOfLotCode(info)
            );
        }
    }

    @And("Admin change info of general information in withdrawal request")
    public void admin_change_info_of_general_information_in_withdrawl_request(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.changeGeneralInformation(infos.get(0))
        );
    }

    @And("Admin change info of pallet weight field of withdrawal and see message")
    public void admin_change_info_pallet_weight_field_of_withdrawal(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.changeValueTooltipTextboxError(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pallet weight"), infos.get(0).get("value"), infos.get(0).get("message"))
        );
    }

    @And("Admin change info of {string} field of withdrawal and see message")
    public void admin_change_info_field_of_withdrawal_and_see_message(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(type.equals("pallet weight"))
                        .andIfSo(
                                CommonTaskAdmin.changeValueTooltipTextboxError(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pallet weight"), infos.get(0).get("value"), infos.get(0).get("message"))),
                Check.whether(type.equals("pickup date"))
                        .andIfSo(
                                CommonTaskAdmin.chooseDateFromTooltipDateTimeError(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pickup date"), infos.get(0).get("message"))),
                Check.whether(type.equals("pickup time"))
                        .andIfSo(
                                CommonTaskAdmin.changeValueTooltipTimeBlankError(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pickup time"), infos.get(0).get("message"))),
                Check.whether(type.equals("bol"))
                        .andIfSo(
                                CommonFile.upload1(infos.get(0).get("value"), WithdrawalRequestsDetailPage.UPLOAD_BOL),
                                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP(infos.get(0).get("message"))))
        );
    }

    @And("Admin cancel withdraw request success")
    public void admin_cancel_withdraw_request_success(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.cancelSuccess(infos.get(0))
        );
    }

    @And("Admin cancel withdraw request in detail success")
    public void admin_cancel_withdraw_request_in_detail_success(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.cancelDetailSuccess(infos.get(0))
        );
    }

    @And("Admin no found data in result")
    public void admin_no_found_data_in_result() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA_RESULT),
                Ensure.that(CommonAdminForm.NO_DATA_RESULT).isDisplayed()
        );
    }

    @And("Admin no found data in popup result")
    public void admin_no_found_data_in_popup_result() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CommonAdminForm.NO_DATA_RESULT_IN_POPUP).isDisplayed()
        );
    }

    @And("Admin click to lotcode in withdrawal detail")
    public void admin_click_to_lotcode_in_withdrawl_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "lotCode", Serenity.sessionVariableCalled("Lot Code" + infos.get(0).get("skuName") + infos.get(0).get("index")));

        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.clickToLotcode(info.get("lotCode"))
        );

    }

    @And("Admin get withdrawal request number")
    public void get_withdrawal_request_number() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(WithdrawalRequestsDetailPage.WITHDRAWAL_NUMBER)
        );
        String title = Text.of(WithdrawalRequestsDetailPage.WITHDRAWAL_NUMBER).answeredBy(theActorInTheSpotlight());
        String[] words = title.split("\\s");
        String number = words[4];
        System.out.println("number = " + number);
        Serenity.setSessionVariable("Withdrawal Request Number").to(number);
    }

    @And("Admin search add lot codes to withdrawal request")
    public void searchAddLotCode(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleWithdrawalRequests.searchLotcodeInAdd(list.get(0))
        );
    }

    @And("Admin verify result after search add lot codes withdrawal request")
    public void verifySearchAddLotCode(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("productName").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(WithdrawalRequestsDetailPage.SEARCH_LOT_RESULT("product-name", i + 1)).isNotDisplayed()
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(WithdrawalRequestsDetailPage.SEARCH_LOT_RESULT("product-name", i + 1)).text().contains(list.get(i).get("productName")),
                        Ensure.that(WithdrawalRequestsDetailPage.SEARCH_LOT_RESULT("sku-name", i + 1)).text().contains(list.get(i).get("skuName")),
                        Ensure.that(WithdrawalRequestsDetailPage.SEARCH_LOT_RESULT("lot-code", i + 1)).text().contains(list.get(i).get("lotCode")),
                        Ensure.that(WithdrawalRequestsDetailPage.SEARCH_LOT_RESULT("end-qty", i + 1)).text().contains(list.get(i).get("endQty")),
                        Ensure.that(WithdrawalRequestsDetailPage.SEARCH_LOT_RESULT("pull-quantity", i + 1)).text().contains(list.get(i).get("pullQty"))
                );
        }
    }

    @And("Admin choose lot codes add to withdrawal request")
    public void chooseLotCode(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Click.on(WithdrawalRequestsDetailPage.SEARCH_LOT_CHECKBOX(list.get(i).get("lotCode"), list.get(i).get("index"))).afterWaitingUntilEnabled()
            );
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add")).afterWaitingUntilEnabled()
        );
    }
}
