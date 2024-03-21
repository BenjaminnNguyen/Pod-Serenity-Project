package cucumber.tasks.admin.orders;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.VendorPageForm;
import cucumber.user_interface.admin.orders.PreordersPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.matchers.WebElementStateMatchers;
import net.serenitybdd.screenplay.waits.WaitUntil;
import org.openqa.selenium.Keys;

import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandlePreOrders {

    public static Task check(Map<String, String> info) {
        return Task.where("Search pre order",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Enter.theValue(info.get("orderNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")),
                Check.whether(info.get("storeName").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("storeName"), PreordersPage.DYNAMIC_ITEM_DROPDOWN(info.get("storeName"))
                        )),
                Check.whether(info.get("buyer").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id"), info.get("buyer"), PreordersPage.DYNAMIC_ITEM_DROPDOWN1(info.get("buyer"))
                        )),
                Check.whether(info.get("brand").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("brand"), PreordersPage.DYNAMIC_ITEM_DROPDOWN(info.get("brand"))
                        )),
                Check.whether(info.get("managedBy").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id"), info.get("managedBy"), PreordersPage.DYNAMIC_ITEM_DROPDOWN(info.get("managedBy"))
                        )),
                Enter.theValue(CommonHandle.setDate(info.get("startDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("checkout_date_start")).thenHit(Keys.ENTER),
                Enter.theValue(CommonHandle.setDate(info.get("endDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("checkout_date_end")).thenHit(Keys.ENTER),
                Check.whether(info.get("state").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("state"), info.get("state"), PreordersPage.DYNAMIC_ITEM_DROPDOWN(info.get("state"))
                        )),

                Click.on(VendorPageForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(VendorPageForm.LOADING_ICON)
        );
    }

    public static Task goToCreateOrder(String idPre) {
        return Task.where("Go to create order",
                Click.on(PreordersPage.RESULT_BY_ID(idPre)),
                CommonWaitUntil.isVisible(PreordersPage.PRODUCT_IN_LINE_ITEM),
                Click.on(PreordersPage.ALL_SKU_CHECKBOX),
                CommonWaitUntil.isVisible(PreordersPage.CREATE_ORDER_BUTTON),
                Click.on(PreordersPage.CREATE_ORDER_BUTTON),
                Click.on(PreordersPage.CONFIRM_POPUP_BUTTON),
                CommonWaitUntil.isVisible(PreordersPage.CREATE_NEW_ORDER_TEXTBOX("Street address"))
        );
    }

    public static Task createOrder(Map<String, String> info) {
        return Task.where("Create order",
                Enter.theValue(info.get("street")).into(PreordersPage.CREATE_NEW_ORDER_TEXTBOX("Street address")).thenHit(Keys.ENTER),
                Enter.theValue(info.get("city")).into(PreordersPage.CREATE_NEW_ORDER_TEXTBOX("City")),
                CommonTask.chooseItemInDropdownWithValueInput(
                        PreordersPage.CREATE_NEW_ORDER_TEXTBOX("State (Province/Territory)"), info.get("state"), PreordersPage.DYNAMIC_ITEM(info.get("state"))),
                Enter.theValue(info.get("zip")).into(PreordersPage.CREATE_NEW_ORDER_TEXTBOX("Zip")),
                Scroll.to(PreordersPage.CREATE_NEW_ORDER_BUTTON),
                Click.on(PreordersPage.CREATE_NEW_ORDER_BUTTON)
        );
    }

    public static Task goToDetail(String idPre) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(PreordersPage.ID_IN_RESULT_TABLE(idPre)),
                Click.on(PreordersPage.ID_IN_RESULT_TABLE(idPre)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(PreordersPage.GENERAL_INFO_HEADER)
        );
    }

}
