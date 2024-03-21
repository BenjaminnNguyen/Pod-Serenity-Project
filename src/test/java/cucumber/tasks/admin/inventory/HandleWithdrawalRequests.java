package cucumber.tasks.admin.inventory;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.InventoryDetailPage;
import cucumber.user_interface.admin.inventory.withdrawalRequest.CreateWithdrawalRequestsPage;
import cucumber.user_interface.admin.inventory.withdrawalRequest.WithdrawalRequestsDetailPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

import static cucumber.user_interface.admin.inventory.withdrawalRequest.WithdrawalRequestsPage.DYNAMIC_SEARCH;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.*;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleWithdrawalRequests {

    public static Task search(Map<String, String> map, String num) {
        return Task.where("",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isClickable())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(num.isEmpty()).otherwise(
                        Enter.theValue(num).into(DYNAMIC_SEARCH("Number"))),
                Check.whether(map.get("vendorCompany").isEmpty()).otherwise(
                        Enter.theValue(map.get("vendorCompany")).into(DYNAMIC_SEARCH("Vendor company")),
                        CommonTask.ChooseValueFromSuggestions(map.get("vendorCompany"))),
                Check.whether(map.get("brand").isEmpty()).otherwise(
                        Enter.theValue(map.get("brand")).into(DYNAMIC_SEARCH("Brand")),
                        CommonTask.ChooseValueFromSuggestions(map.get("brand"))),
                Check.whether(map.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(DYNAMIC_SEARCH("Region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(map.get("region")))),
                Check.whether(map.get("status").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(DYNAMIC_SEARCH("Status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(map.get("status")))),
                Check.whether(map.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy")).into(DYNAMIC_SEARCH("Start date")).thenHit(Keys.ENTER)),
                Check.whether(map.get("endDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")).into(DYNAMIC_SEARCH("End date")).thenHit(Keys.ENTER)),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToCreateWithdrawal() {
        return Task.where("Go to withdrawal request",
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.CREATE_BUTTON),
                Click.on(CreateWithdrawalRequestsPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.DYNAMIC_INFO("vendor-company"))
        );
    }

    public static Task create(Map<String, String> map) {
        return Task.where("Create withdrawal request",
                Check.whether(map.get("vendorCompany").isEmpty()).otherwise(
                        Enter.theValue(map.get("vendorCompany")).into(CreateWithdrawalRequestsPage.DYNAMIC_INFO("vendor-company")),
                        CommonTask.ChooseValueFromSuggestions(map.get("vendorCompany"))
                ),
                Check.whether(map.get("pickerDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("pickerDate"), "MM/dd/yy")).into(CreateWithdrawalRequestsPage.DYNAMIC_INFO("date-picker")).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("pickerFrom").isEmpty()).otherwise(
                        Enter.theValue(map.get("pickerFrom")).into(CreateWithdrawalRequestsPage.DYNAMIC_INFO("time-range-from")).thenHit(Keys.ENTER)
//                        CommonTask.chooseItemInDropdown(CreateWithdrawalRequestsPage.DYNAMIC_INFO("time-range-from"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("pickerFrom")))
                ),
                Check.whether(map.get("pickerTo").isEmpty()).otherwise(
                        Enter.theValue(map.get("pickerTo")).into(CreateWithdrawalRequestsPage.DYNAMIC_INFO("time-range-to")).thenHit(Keys.ENTER)
//                        CommonTask.chooseItemInDropdown(CreateWithdrawalRequestsPage.DYNAMIC_INFO("time-range-to"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("pickerTo")))
                ),
                Check.whether(map.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CreateWithdrawalRequestsPage.DYNAMIC_INFO("region"), map.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(map.get("region")))
                ),
                Check.whether(map.get("pickupType").isEmpty()).otherwise(
                        Check.whether(map.get("pickupType").equalsIgnoreCase("Self pickup")).andIfSo(
                                Click.on(CreateWithdrawalRequestsPage.SELF_PICKUP)
                        ).otherwise(
                                Click.on(CreateWithdrawalRequestsPage.CARRIER_PICKUP)
                        )
                ),
                Check.whether(map.get("pickupPartner").isEmpty()).otherwise(
                        Enter.theValue(map.get("pickupPartner")).into(CreateWithdrawalRequestsPage.DYNAMIC_INFO("pickup-partner"))
                ),
                Check.whether(map.get("contactEmail").isEmpty()).otherwise(
                        Enter.theValue(map.get("contactEmail")).into(CommonAdminForm.DYNAMIC_INPUT("Contact email"))
                ),
                Check.whether(map.get("palletWeight").isEmpty()).otherwise(
                        Enter.theValue(map.get("palletWeight")).into(CreateWithdrawalRequestsPage.DYNAMIC_INFO("pallet-weight"))
                ),
                Check.whether(map.get("bol").isEmpty()).otherwise(
                        CommonFile.upload2(map.get("bol"), CreateWithdrawalRequestsPage.DYNAMIC_INFO("attachement"))
                ),
                Check.whether(map.get("comment").isEmpty()).otherwise(
                        Enter.theValue(map.get("comment")).into(CreateWithdrawalRequestsPage.DYNAMIC_INFO("comment"))
                )
        );
    }

    public static Task searchLotcodeInAdd(Map<String, String> map) {
        return Task.where("Search lot code to add",
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.D_ADD_LOTCODE("Vendor brand")),
                Check.whether(map.get("vendorBrand").isEmpty()).otherwise(
                        Enter.theValue(map.get("vendorBrand")).into(CreateWithdrawalRequestsPage.D_ADD_LOTCODE("Vendor brand")),
                        CommonTask.ChooseValueFromSuggestions(map.get("vendorBrand"))
                ),
                Check.whether(map.get("skuName").isEmpty()).otherwise(
                        Enter.theValue(map.get("skuName")).into(CreateWithdrawalRequestsPage.D_ADD_LOTCODE("SKU name"))
                ),
                Check.whether(map.get("productName").isEmpty()).otherwise(
                        Enter.theValue(map.get("productName")).into(CreateWithdrawalRequestsPage.D_ADD_LOTCODE("Product name"))
                ),
                Check.whether(map.get("lotCode").isEmpty()).otherwise(
                        Enter.theValue(map.get("lotCode")).into(CreateWithdrawalRequestsPage.D_ADD_LOTCODE("Lot code"))
                ),
                Click.on(CreateWithdrawalRequestsPage.SEARCH_LOT_CODE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task clickSearchLotcodeInAdd() {
        return Task.where("Search lot code to add",
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.ADD_LOT_CODE_BUTTON),
                Click.on(CreateWithdrawalRequestsPage.ADD_LOT_CODE_BUTTON),
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.D_ADD_LOTCODE("Vendor brand"))
        );
    }

    public static Task addLotcodeAfterSearch(Map<String, String> map) {
        return Task.where("Search lot code to add",
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.FIRST_LOT_CODE),
                // Choose inventory with lotcode in result
                Click.on(CreateWithdrawalRequestsPage.LOT_CODE_CHECKBOX(map.get("lotCode"))),
                Click.on(CreateWithdrawalRequestsPage.ADD_LOT_CODE_BUTTON_IN_POPUP),
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.CASES(map.get("lotCode"))),
                WindowTask.threadSleep(1000),
                Enter.theValue(map.get("case")).into(CreateWithdrawalRequestsPage.CASES(map.get("lotCode")))
        );
    }

    public static Task createSuccess() {
        return Task.where("Create withdrawal request success",
                Click.on(CreateWithdrawalRequestsPage.CREATE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Withdrawal request has been created successfully !!")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.TITLE)
        );
    }

    public static Task saveSuccess() {
        return Task.where("Save withdrawal request success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_MESSAGE_POPUP("Lot code has been updated successfully !!")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.TITLE)
        );
    }

    public static Task removeLotCode(String lotCode) {
        return Task.where("Remove lot code",
                Click.on(CreateWithdrawalRequestsPage.DELETE_LOTCODE(lotCode)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save"))
        );
    }

    public static Task approveSuccess() {
        return Task.where("Approve withdrawal request success",
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Approve")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Approve")),
                //popup confirm approve request
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Are you sure that you want to approve this withdraw request?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Withdraw request has been approved successfully!")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_CLOSE_BUTTON),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Complete")),
                WindowTask.refeshBrowser(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task createWithBlankValue(String type) {
        return Task.where("Create with blank value",
                Check.whether(type.equalsIgnoreCase("Self pickup"))
                        .andIfSo(Click.on(CreateWithdrawalRequestsPage.SELF_PICKUP))
                        .otherwise(Click.on(CreateWithdrawalRequestsPage.CARRIER_PICKUP)),
                Click.on(CreateWithdrawalRequestsPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.DYNAMIC_INFO_ERROR("Vendor Company"))
        );
    }

    public static Task changeCaseOfLotCode(Map<String, String> map) {
        return Task.where("Change case of lotcode",
                Clear.field(CreateWithdrawalRequestsPage.CASES(map.get("lotCode"))),
                Enter.theValue(map.get("case")).into(CreateWithdrawalRequestsPage.CASES(map.get("lotCode")))
        );
    }

    public static Task changeGeneralInformation(Map<String, String> info) {
        return Task.where("Change info of general information",
                Check.whether(info.get("vendorCompany").isEmpty())
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipDropdownWithInput(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Vendor company"), info.get("vendorCompany"))),
                Check.whether(info.get("pickupDate").isEmpty())
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipDateTime(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pickup date"), CommonHandle.setDate2(info.get("pickupDate"), "MM/dd/yy"))),
                Check.whether(info.get("startTime").isEmpty())
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipTime(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pickup time"), info.get("startTime"), info.get("endTime"))),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipDropdownWithInput(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pickup region"), info.get("region"))),
                Check.whether(info.get("pickupType").isEmpty())
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipDropdown(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pickup type"), info.get("pickupType"))),
                Check.whether(info.get("partner").isEmpty())
                        .otherwise(
                                Check.whether(info.get("partner").contains("Withdrawal"))
                                        .andIfSo(CommonTaskAdmin.changeValueTooltipTextbox(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Name of contact"), info.get("partner")))
                                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Carrier"), info.get("partner")))),
                Check.whether(info.get("bol").isEmpty())
                        .otherwise(
                                CommonFile.upload2(info.get("bol"), WithdrawalRequestsDetailPage.UPLOAD_BOL)),
                Check.whether(info.get("palletWeight").isEmpty())
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipTextbox(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Pallet weight"), info.get("palletWeight"))),
                Check.whether(info.get("comment").isEmpty())
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipTextarea(WithdrawalRequestsDetailPage.D_TEXT_GENERAL("Comment"), info.get("comment")))
        );
    }

    public static Task cancelSuccess(Map<String, String> map) {
        String number = map.get("number");
        if (map.get("number").contains("create by admin")) {
            number = Serenity.sessionVariableCalled("Withdrawal Request Number");
        }
        if (map.get("number").contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number Withdraw request api");
        }
        return Task.where("Remove withdrawal request success",
                CommonWaitUntil.isVisible(CreateWithdrawalRequestsPage.CANCEL_BUTTON(number)),
                Click.on(CreateWithdrawalRequestsPage.CANCEL_BUTTON(number)),
                CommonWaitUntil.isVisible(WithdrawalRequestsDetailPage.CANCEL_POPUP),
                Enter.theValue(map.get("note")).into(CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Please leave an internal cancelation note")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Cancel")),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(WithdrawalRequestsDetailPage.CANCEL_POPUP)
        );
    }

    public static Task cancelDetailSuccess(Map<String, String> map) {
        String number = map.get("number");
        if (map.get("number").contains("create by admin")) {
            number = Serenity.sessionVariableCalled("Withdrawal Request Number");
        }
        if (map.get("number").contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number Withdraw request api");
        }
        return Task.where("Remove withdrawal request in detail success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Cancel")),
                Click.on(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Cancel")),
                CommonWaitUntil.isVisible(WithdrawalRequestsDetailPage.CANCEL_POPUP),
                Enter.theValue(map.get("note")).into(CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Please leave an internal cancelation note")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Cancel")),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(WithdrawalRequestsDetailPage.CANCEL_POPUP)
        );
    }

    public static Task clickToLotcode(String lotCode) {
        return Task.where("Click to lotcode",
                Click.on(WithdrawalRequestsDetailPage.LOTCODE_LINK(lotCode)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.switchToChildWindowsByTitle("Inventory"),
                CommonWaitUntil.isVisible(InventoryDetailPage.PRODUCT_NAME)
        );
    }
}
