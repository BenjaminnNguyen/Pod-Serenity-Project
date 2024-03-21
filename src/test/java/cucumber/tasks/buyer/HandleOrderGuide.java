package cucumber.tasks.buyer;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.orders.GhostOrderPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.beta.Buyer.BuyerCatalogPage;
import cucumber.user_interface.beta.Buyer.BuyerOrderGuidePage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.orders.OrderGuideForm;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleOrderGuide {

    public static Task search(String typeOrder, String item) {
        return Task.where("Search item in Order Guide",
                Check.whether(typeOrder.equals("Store order guide"))
                        .andIfSo(
                                Click.on(OrderGuideForm.ORDER_GUIDE(typeOrder))),
                Enter.theValue(item).into(OrderGuideForm.SEARCH_TEXTBOX),
                Click.on(OrderGuideForm.SEARCH_BUTTON)

        );
    }

    public static Task search(Map<String, String> map) {
        Task task = Task.where("Search item in Order Guide",
                Check.whether(map.get("item").isEmpty()).otherwise(
                        Enter.theValue(map.get("item")).into(BuyerOrderGuidePage.ITEM_CODE).thenHit(Keys.ENTER)
                ),
                Check.whether(map.get("timeInterval").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(BuyerOrderGuidePage.TIME_INTERVAL, BuyerCatalogPage.SEARCH_OPTION(map.get("timeInterval")))
                ),
                Check.whether(map.get("orderBy").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(BuyerOrderGuidePage.ORDER_BY, BuyerCatalogPage.SEARCH_OPTION(map.get("orderBy")))
                ),
                Check.whether(map.get("activeOnly").isEmpty()).otherwise(
                        Click.on(BuyerOrderGuidePage.ACTIVE_ONLY)
                )
        );
        if (map.containsKey("store")) {
            task.then(
                    Check.whether(map.get("store").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdownWithValueInput(BuyerOrderGuidePage.STORE, map.get("store"), BuyerCatalogPage.SEARCH_OPTION(map.get("store")))
                    )
            );
        }
        task.then(CommonWaitUntil.isNotVisible(CommonBuyerPage.D_LOADING_MESSAGE("Fetching your order guide...")));
        return task;
    }

    public static Task goToTab(String item) {
        return Task.where("Search item in Order Guide",
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_TEXT(item)),
                Click.on(CommonBuyerPage.DYNAMIC_TEXT(item)),
                WindowTask.threadSleep(500)
        );
    }

    public static Task addToCart(String item) {
        return Task.where("Add cart in Order Guide",
                CommonWaitUntil.isVisible(OrderGuideForm.ADD_CART_BUTTON(item)),
                Click.on(OrderGuideForm.ADD_CART_BUTTON(item)),
                WindowTask.threadSleep(3000)
        );
    }

    public static Task editGeneralInformation(Map<String, String> info) {
        return Task.where("Edit general information",
                Check.whether(info.get("customerPO").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(OrderDetailPage.CUSTOM_PO_FIELD, info.get("customerPO"))),
                Check.whether(info.get("adminNote").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(OrderDetailPage.ADMIN_NOTE_FIELD_EDIT, info.get("adminNote")))
        );
    }
}
