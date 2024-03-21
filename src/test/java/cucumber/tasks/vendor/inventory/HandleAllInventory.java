package cucumber.tasks.vendor.inventory;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.DashBoardForm;
import cucumber.user_interface.beta.Vendor.inventory.AllInventoryPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorInventoryPage;
import cucumber.user_interface.lp.CommonLPPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class HandleAllInventory {

    public static Task search(Map<String, String> info) {
        return Task.where("Search inventory",
                CommonWaitUntil.isNotVisible(DashBoardForm.LOADING_ICON("Fetching your orders...")),
                Check.whether(info.get("skuName").isEmpty()).otherwise(
                        Enter.theValue(info.get("skuName")).into(AllInventoryPage.DYNAMIC_SEARCH_TEXTBOX("Search term")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("zeroQuantity").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        AllInventoryPage.DYNAMIC_SEARCH_TEXTBOX("Show zero-quantity lots?"), info.get("zeroQuantity"), AllInventoryPage.DYNAMIC_ITEM_DROPDOWN(info.get("zeroQuantity")))
                        ),
                Check.whether(info.get("orderBy").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        AllInventoryPage.DYNAMIC_SEARCH_TEXTBOX("Order by"), info.get("orderBy"), AllInventoryPage.DYNAMIC_ITEM_DROPDOWN(info.get("orderBy")))
                        ),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories..."))
        );
    }

    public static Task inputInfoOptional(Map<String, String> record) {
        return Task.where("Input info optional to inbound",
                Check.whether(record.get("otherShipping").isEmpty()).otherwise(
                        Enter.theValue(record.get("otherShipping")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("other-detail"))
                ),
                Check.whether(record.get("freightCarrier").isEmpty()).otherwise(
                        Enter.theValue(record.get("freightCarrier")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("freight-carrier"))
                ),
                Check.whether(record.get("trackingNumber").isEmpty()).otherwise(
                        Enter.theValue(record.get("trackingNumber")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("tracking-number"))
                ),
                Check.whether(record.get("referenceNumber").isEmpty()).otherwise(
                        Enter.theValue(record.get("referenceNumber")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("reference-number"))
                ),
                Check.whether(record.get("estimatedWeek").isEmpty())
                        .otherwise(
                                Enter.theValue(record.get("estimatedWeek")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("estimated-covered-period"))),
                Check.whether(record.get("note").isEmpty()).otherwise(
                        Enter.theValue(record.get("note")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("notes"))
                ),
                Check.whether(record.get("palletTransit").isEmpty()).otherwise(
                        Click.on(VendorInventoryPage.PALLET_STACKABLE_IN_TRANSIT(record.get("palletTransit")))
                ),
                Check.whether(record.get("palletWarehouse").isEmpty()).otherwise(
                        Click.on(VendorInventoryPage.PALLET_STACKABLE_IN_WAREHOUSE(record.get("palletWarehouse")))
                ),
                Check.whether(record.get("fileBOL").isEmpty()).otherwise(
                        CommonFile.upload2(record.get("fileBOL"), VendorInventoryPage.UPLOAD_BOL)
                ),
                Check.whether(record.get("transportName").isEmpty()).otherwise(
                        Enter.theValue(record.get("transportName")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("transport-coordinator-name"))
                ),
                Check.whether(record.get("transportPhone").isEmpty()).otherwise(
                        Enter.theValue(record.get("transportPhone")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("transport-coordinator-phone"))
                )
        );
    }

    public static HashMap<String, String> setSKURandom(Map<String, String> list, String key) {
        HashMap<String, String> info = new HashMap<>(list);
        if (info.get(key).equals("random")) {
            info.replace(key, "random", Serenity.sessionVariableCalled("SKU inventory"));
        }
        if (info.get(key).equals("item code api")) {
            info.replace(key, "item code api", Serenity.sessionVariableCalled("ID SKU Admin"));
        }
        return info;
    }

    public static Task goToInventoryTab(String tabName) {
        return Task.where("Go to inventory tab",
                CommonWaitUntil.isVisible(VendorInventoryPage.DYNAMIC_TAB_HEADER(tabName)),
                Click.on(VendorInventoryPage.DYNAMIC_TAB_HEADER(tabName)),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.LOADING)
        );
    }

    public static Task uploadPOD(String file) {
        return Task.where("uploadPOD",
                CommonFile.upload2(file, VendorInventoryPage.UPLOAD_POD)
        );
    }
}
