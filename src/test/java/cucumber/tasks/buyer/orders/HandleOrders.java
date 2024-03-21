package cucumber.tasks.buyer.orders;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Buyer.cart.CartPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerOrderDetailPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerOrderPage;
import cucumber.user_interface.beta.DashBoardForm;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.Vendor.VendorDashboardPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

public class HandleOrders {

    public static Task searchByValue(String typeSearch, String value) {
        return Task.where("Tìm kiếm theo " + typeSearch,
                Check.whether(typeSearch.equals("Brands"))
                        .andIfSo(
                                // chọn brand
                                CommonTask.chooseItemInDropdown(HomePageForm.PRODUCT_BUTTON, HomePageForm.TYPE_SEARCH(typeSearch))
                        ),
                Enter.theValue(value).into(HomePageForm.SEARCH_FIELD),
                Click.on(HomePageForm.SEARCH_BUTTON)
        );
    }

    public static Task goToTabFromDashboard(String title) {
        return Task.where("Tìm kiếm theo ",
                Click.on(DashBoardForm.DASHBOARD_BUTTON),
                CommonWaitUntil.isVisible(DashBoardForm.SIDEBAR_BUTTON(title)),
                Click.on(DashBoardForm.SIDEBAR_BUTTON(title))
        );
    }

    public static Task reorder(String sku, String quantity) {
        return Task.where("Tìm kiếm theo ",
                CommonWaitUntil.isVisible(BuyerOrderDetailPage.REORDER),
                Click.on(BuyerOrderDetailPage.REORDER),
                CommonWaitUntil.isVisible(BuyerOrderDetailPage.REORDER_QUANTITY_OF_SKU(sku)),
                Enter.theValue(quantity).into(BuyerOrderDetailPage.REORDER_QUANTITY_OF_SKU(sku)).thenHit(Keys.TAB),
                Click.on(BuyerOrderDetailPage.REORDER_ADD)
        );
    }

    public static Performable reOrderPopup(List<Map<String, String>> infos) {
        return Task.where("Reorder in popup",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART(info.get("sku"))),
                                Enter.theValue(info.get("quantity")).into(HomePageForm.QUANTITY_POPUP_ADDTOCART(info.get("sku"))).thenHit(Keys.ENTER)
                                );
                    }
                    actor.attemptsTo(
                            Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add")).afterWaitingUntilEnabled(),
                            CommonWaitUntil.isNotVisible(CartPage.MESSAGE_ADD_TO_CART)
                    );
                }
        );
    }

    public static Task backToOrders() {
        return Task.where("Back to Orders ",
                CommonWaitUntil.isVisible(BuyerOrderDetailPage.BACK_TO_ORDER),
                Click.on(BuyerOrderDetailPage.BACK_TO_ORDER),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your orders...")),
                CommonWaitUntil.isVisible(VendorDashboardPage.ORDERS)
        );
    }

    /**
     * Go to tab in page
     *
     * @param tab (All, Pending, In Progress, Fulfilled, Pre-order)
     * @return
     */
    public static Task goToTab(String tab) {
        return Task.where("Go to tab " + tab,
                Click.on(BuyerOrderPage.TAB_SCREEN(tab)),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your orders..."))
        );
    }

    /**
     * Go to page
     *
     * @param tab (Your Orders, Your Store, Store Buyer)
     * @return
     */
    public static Task goToPage(String tab) {
        return Task.where("Go to Page " + tab,
                Click.on(BuyerOrderPage.PAGE_SCREEN(tab)),
                WindowTask.threadSleep(500)
        );
    }
}
