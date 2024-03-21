package cucumber.tasks.buyer.settings;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.setting.GeneralPage;
import cucumber.user_interface.beta.Buyer.setting.PaymentsPage;
import cucumber.user_interface.beta.Vendor.setting.VendorSettingGeneralPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class BuyerSettingTask {

    public static Task goToGeneralSetting() {
        return Task.where("Go to General Setting",
                CommonWaitUntil.isVisible(GeneralPage.GENERAL_BUTTON),
                Click.on(GeneralPage.GENERAL_BUTTON),
                CommonWaitUntil.isVisible(GeneralPage.GENERAL_HEADER)
        );
    }

    public static Task goToPaymentsSetting() {
        return Task.where("Go to Payments Setting",
                CommonWaitUntil.isVisible(PaymentsPage.PAYMENTS_BUTTON),
                Click.on(PaymentsPage.PAYMENTS_BUTTON),
                CommonWaitUntil.isVisible(PaymentsPage.PAYMENT_HEADER)
        );
    }

    public static Task goToStoreInformationPopup() {
        return Task.where("Go to store information popup",
                CommonWaitUntil.isVisible(GeneralPage.EDIT_STORE_BUTTON),
                Click.on(GeneralPage.EDIT_STORE_BUTTON),
                CommonWaitUntil.isVisible(GeneralPage.STORE_INFORMATION_POPUP)
        );
    }

    public static Task editStoreInformation(Map<String, String> info) {
        return Task.where("Edit store information",
                Check.whether(info.get("name").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("name")).into(GeneralPage.D_TEXTBOX_STORE_INFO("Business name"))),
                Check.whether(info.get("storeType").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(GeneralPage.D_TEXTBOX_STORE_INFO("Store type"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("storeType")))),
                Check.whether(info.get("storeSize").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(GeneralPage.D_TEXTBOX_STORE_INFO("Store size"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("storeSize")))),
                Check.whether(info.get("phone").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("phone")).into(GeneralPage.D_TEXTBOX_STORE_INFO("Business phone"))),
                Check.whether(info.get("timeZone").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(GeneralPage.D_TEXTBOX_STORE_INFO("Timezone"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("timeZone")))),
                Check.whether(info.get("attn").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("attn")).into(GeneralPage.D_TEXTBOX_STORE_INFO("Attn"))),
                Check.whether(info.get("address").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("address")).into(GeneralPage.D_TEXTBOX_STORE_INFO("Street address"))),
                Check.whether(info.get("apt").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("apt")).into(GeneralPage.D_TEXTBOX_STORE_INFO("Apt, Suite, etc."))),
                Check.whether(info.get("city").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("city")).into(GeneralPage.D_TEXTBOX_STORE_INFO("City"))),
                Check.whether(info.get("state").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(GeneralPage.D_TEXTBOX_STORE_INFO("State"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("state")))),
                Check.whether(info.get("zip").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("zip")).into(GeneralPage.D_TEXTBOX_STORE_INFO("Zip code")))
        );
    }

    public static Task editStoreInfoSuccess() {
        return Task.where("Edit store information Success",
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_BUTTON("Update")),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_MESSAGE),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.D_MESSAGE_POPUP("Updated successfully."))


        );
    }

    public static Task deleteCurrentCard() {
        return Task.where("Go to Payments Setting",
                Check.whether(valueOf(PaymentsPage.DELETE_CURRENT_CART), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(PaymentsPage.DELETE_CURRENT_CART),
                                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP("Are you sure you want to remove this payment method?")),
                                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("OK")),
                                CommonWaitUntil.isVisible(PaymentsPage.NO_CARD_ADDED)
                        )
        );
    }

    public static Task goToEditPersonal() {
        return Task.where("Go to edit personal",
                CommonWaitUntil.isVisible(GeneralPage.PERSONAL_EDIT_BUTTON),
                Click.on(GeneralPage.PERSONAL_EDIT_BUTTON),
                CommonWaitUntil.isVisible(GeneralPage.POPUP_EDIT_TITLE)
        );
    }
}
