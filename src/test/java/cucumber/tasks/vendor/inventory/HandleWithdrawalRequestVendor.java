package cucumber.tasks.vendor.inventory;

import cucumber.constants.vendor.WebsiteConstants;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorWithdrawalRequestPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleWithdrawalRequestVendor {

    public static Task goToCreate() {
        return Task.where("go to create info",
                Check.whether(CommonQuestions.isControlDisplay(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup date"))).otherwise(
                        CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.CREATE_WITHDRAWAL_REQUEST),
                        Click.on(VendorWithdrawalRequestPage.CREATE_WITHDRAWAL_REQUEST),
                        // Check popup general instructions
                        CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Confirm")),
                        Ensure.that(VendorWithdrawalRequestPage.INSTRUCTIONS).text().contains(WebsiteConstants.WITHDRAWAL_GENERAL_INSTRUCTIONS),
                        Click.on(CommonVendorPage.DYNAMIC_BUTTON("Confirm")),
                        CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup date"))
                )
        );
    }

    public static Task fillInfo(Map<String, String> map) {
        Performable task = Task.where("Fill info to create",
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup date")),
                Check.whether(map.get("pickupDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("pickupDate"), "MM/dd/yy")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup date")).thenHit(Keys.ENTER)
                ),
                Check.whether(map.get("pickupFrom").isEmpty()).otherwise(
                        Enter.theValue(map.get("pickupFrom")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup time (Start)")).thenHit(Keys.ENTER)
                ),
                Check.whether(map.get("pickupTo").isEmpty()).otherwise(
                        Enter.theValue(map.get("pickupTo")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup time (End)")).thenHit(Keys.ENTER)
                ),
                Check.whether(map.get("region").isEmpty()).otherwise(
                        Enter.theValue(map.get("region")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pickup region")),
                        CommonTask.ChooseValueFromSuggestions(map.get("region"))
                ),
                Check.whether(map.get("carrier").isEmpty()).otherwise(
                        Click.on(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Are you using a freight carrier?")),
                        CommonTask.ChooseValueFromSuggestions(map.get("carrier"))
                ),
                Check.whether(map.get("nameContact").isEmpty()).otherwise(
                        Enter.theValue(map.get("nameContact")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Name of Contact"))
                ),
                Check.whether(map.get("palletWeight").isEmpty()).otherwise(
                        Enter.theValue(map.get("palletWeight")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Pallet weight in total"))
                ),
                Check.whether(map.get("comment").isEmpty()).otherwise(
                        Enter.theValue(map.get("comment")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Comment"))
                ),
                Check.whether(map.get("bol").isEmpty()).otherwise(
                        CommonFile.uploadAll(map.get("bol"), VendorWithdrawalRequestPage.UPLOAD_BOL)
                )
        );
        if (map.containsKey("carrierName"))
            task.then(
                    Check.whether(map.get("carrierName").isEmpty()).otherwise(
                            Enter.theValue(map.get("carrierName")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Carrier"))
                    )
            );
        if (map.containsKey("contactEmail"))
            task.then(
                    Check.whether(map.get("contactEmail").isEmpty()).otherwise(
                            Enter.theValue(map.get("contactEmail")).into(VendorWithdrawalRequestPage.DYNAMIC_FIELD("Contact email")).thenHit(Keys.TAB)
                    )
            );
        return Task.where("", task);
    }

    public static Task searchLot(String lot) {
        return Task.where("add lot code",
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.ADD_NEW_LOT),
                Click.on(VendorWithdrawalRequestPage.ADD_NEW_LOT),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.FIND_LOT),
                Enter.theValue(lot).into(VendorWithdrawalRequestPage.FIND_LOT),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.isNotVisible(VendorWithdrawalRequestPage.LOADING_SPIN)
        );
    }

    public static Task getEndQuantity(Map<String, String> map) {
        return Task.where("add lot code",
                Check.whether(map.get("sku").isEmpty()).andIfSo(
                        CommonTask.setSessionVariable("End Quantity", CommonQuestions.getText(theActorInTheSpotlight(), VendorWithdrawalRequestPage.END_QUANTITY_OF_SKU)),
                        CommonTask.setSessionVariable("End Quantity After", String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(map.get("lotQuantity"))))
                ).otherwise(
                        CommonTask.setSessionVariable("End Quantity", CommonQuestions.getText(theActorInTheSpotlight(), VendorWithdrawalRequestPage.END_QUANTITY_OF_SKU(map.get("sku")))),
                        CommonTask.setSessionVariable("End Quantity After", String.valueOf(Integer.parseInt(Serenity.sessionVariableCalled("End Quantity").toString()) - Integer.parseInt(map.get("lotQuantity"))))
                ));
    }

    public static Task choseSKU(Map<String, String> map) {
        return Task.where("add lot code",
                Click.on(VendorWithdrawalRequestPage.DYNAMIC_SKU(1, map.get("sku"))),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.ADD_SELECTED_LOT),
                Click.on(VendorWithdrawalRequestPage.ADD_SELECTED_LOT),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.ADD_NEW_LOT),
                Enter.theValue(map.get("lotQuantity")).into(VendorWithdrawalRequestPage.LOT_QUANTITY_FIELD(map.get("sku")))
        );
    }

    public static Task choseSkuWithLotcode(Map<String, String> map) {
        return Task.where("add lot code",
                Click.on(VendorWithdrawalRequestPage.DYNAMIC_SKU_BY_LOTCODE(map.get("lotCode"))),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.ADD_SELECTED_LOT),
                Click.on(VendorWithdrawalRequestPage.ADD_SELECTED_LOT),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.ADD_NEW_LOT),
                Enter.theValue(map.get("lotQuantity")).into(VendorWithdrawalRequestPage.D_QUANTITY_DETAILS(map.get("lotCode"))),
                Check.whether(map.get("max").equals("Yes"))
                        .andIfSo(Click.on(VendorWithdrawalRequestPage.D_MAX_DETAILS(map.get("lotCode"))))
        );
    }

    public static Task choseSkuWithLotcode2(Map<String, String> map) {
        return Task.where("add lot code",
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.D_QUANTITY_DETAILS(map.get("lotCode"))),
                Enter.theValue(map.get("lotQuantity")).into(VendorWithdrawalRequestPage.D_QUANTITY_DETAILS(map.get("lotCode"))),
                Check.whether(map.get("max").equals("Yes"))
                        .andIfSo(Click.on(VendorWithdrawalRequestPage.D_MAX_DETAILS(map.get("lotCode"))))
        );
    }

    public static Task addLots1(Map<String, String> map) {
        return Task.where("add lot code",
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.ADD_NEW_LOT),
                Click.on(VendorWithdrawalRequestPage.ADD_NEW_LOT),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.FIND_LOT),
                Enter.theValue(map.get("sku")).into(VendorWithdrawalRequestPage.FIND_LOT),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.LOADING_SPIN),
                CommonWaitUntil.isNotVisible(VendorWithdrawalRequestPage.LOADING_SPIN)
        );
    }

    public static Task addLots2(Map<String, String> map) {
        return Task.where("add lot code",
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.DYNAMIC_SKU_BY_LOTCODE(map.get("lotCode"))),
                Click.on(VendorWithdrawalRequestPage.DYNAMIC_SKU_BY_LOTCODE(map.get("lotCode"))),
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.ADD_SELECTED_LOT),
                Click.on(VendorWithdrawalRequestPage.ADD_SELECTED_LOT)
        );
    }

    public static Task goToTab(String tabName) {
        return Task.where("Go to tab " + tabName,
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.DYNAMIC_TAB(tabName)),
                Click.on(VendorWithdrawalRequestPage.DYNAMIC_TAB(tabName)),
                CommonWaitUntil.isNotVisible(VendorWithdrawalRequestPage.LOADING_SPIN)
        );
    }

    public static Task updateSuccess() {
        return Task.where("Update success",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Update")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Update")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT("Withdrawal inventory updated successfully.")),
                Click.on(CommonVendorPage.D_ALERT_CLOSE_BUTTON1),
                Check.whether(valueOf(CommonVendorPage.DYNAMIC_P_ALERT("Thank you for filling out the inventory withdrawal form. Your request is under review and Pod Foods will reach out to you shortly.")), isCurrentlyVisible())
                        .andIfSo(Click.on(CommonVendorPage.DYNAMIC_BUTTON("OK")))
        );
    }

    public static Task removeLotCode(String lotCode) {
        return Task.where("Remove lot code",
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.D_DELETE_DETAILS(lotCode)),
                Click.on(VendorWithdrawalRequestPage.D_DELETE_DETAILS(lotCode)),
                CommonWaitUntil.isNotVisible(VendorWithdrawalRequestPage.D_DELETE_DETAILS(lotCode))
        );
    }

    public static Task editLotCode(Map<String, String> map) {
        return Task.where("Edit lot code",
                CommonWaitUntil.isVisible(VendorWithdrawalRequestPage.D_QUANTITY_DETAILS(map.get("lotCode"))),
                Clear.field(VendorWithdrawalRequestPage.D_QUANTITY_DETAILS(map.get("lotCode"))),
                Enter.theValue(map.get("lotQuantity")).into(VendorWithdrawalRequestPage.D_QUANTITY_DETAILS(map.get("lotCode"))),
                Check.whether(map.get("max").equals("Yes"))
                        .andIfSo(Click.on(VendorWithdrawalRequestPage.D_MAX_DETAILS(map.get("lotCode"))))
        );
    }

    public static Task createSuccess() {
        return Task.where("Create withdrawal request success",
                Click.on(VendorWithdrawalRequestPage.CREATE_BUTTON),
                CommonWaitUntil.isNotVisible(VendorWithdrawalRequestPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT("Thank you for filling out the inventory withdrawal form. Your request is under review and Pod Foods will reach out to you shortly.")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("OK")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Update"))
        );
    }

    public static Task uploadBOL(String bol) {
        return Task.where("upload bol",
                CommonFile.uploadAll(bol, VendorWithdrawalRequestPage.UPLOAD_BOL)
        );
    }
}
