package cucumber.tasks.vendor.inventory;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.DashBoardForm;
import cucumber.user_interface.beta.Vendor.inventory.AllInventoryPage;
import cucumber.user_interface.lp.CommonLPPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;
import java.util.Objects;

public class HandleInventoryStatus {

    public static Task search(Map<String, String> info) {
        return Task.where("Search inventory Status",
                CommonWaitUntil.isNotVisible(DashBoardForm.LOADING_ICON("Fetching your orders...")),
                Check.whether(info.get("skuName").isEmpty()).otherwise(
                        Enter.theValue(info.get("skuName")).into(AllInventoryPage.DYNAMIC_SEARCH_TEXTBOX("Search term")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("orderBy").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        AllInventoryPage.DYNAMIC_SEARCH_TEXTBOX("Order by"), AllInventoryPage.DYNAMIC_ITEM_DROPDOWN(info.get("orderBy")))
                        ),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories..."))
        );
    }
}
