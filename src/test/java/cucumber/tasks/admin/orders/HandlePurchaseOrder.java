package cucumber.tasks.admin.orders;

import cucumber.actions.GoBack;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.BrandDetailPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.PurchaseRequestsPage;
import cucumber.user_interface.admin.products.AdminProductDetailPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.Map;

import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandlePurchaseOrder {

    public static Task search(Map<String, String> info) {
        return Task.where("Search purchase order",
                Check.whether(info.get("purchaseNumber").isEmpty())
                        .otherwise(Enter.theValue(info.get("purchaseNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number"))),
                Check.whether(info.get("email").isEmpty())
                        .otherwise(Enter.theValue(info.get("email")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email"))),
                Check.whether(info.get("adminUser").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("admin_id"), info.get("adminUser"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("adminUser")))),
                Check.whether(info.get("status").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("status")))),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String purchaseNumber) {
        return Task.where("Go to detail purchase order",
                CommonWaitUntil.isVisible(PurchaseRequestsPage.NUMBER_PURCHASE(purchaseNumber)),
                Click.on(PurchaseRequestsPage.NUMBER_PURCHASE(purchaseNumber))
        );
    }

    public static Task editInfo(Map<String, String> info) {
        return Task.where("edit info of purchase order",
                CommonWaitUntil.isVisible(PurchaseRequestsPage.ADMIN_NOTE_PURCHASE_EDIT_DETAIL),
                CommonTaskAdmin.changeValueTooltipTextarea(PurchaseRequestsPage.ADMIN_NOTE_PURCHASE_EDIT_DETAIL, info.get("adminNote")),
                CommonTaskAdmin.changeValueTooltipDropdownWithInput(PurchaseRequestsPage.ADMIN_USER_PURCHASE_EDIT_DETAIL, info.get("adminUser"))
        );
    }

    public static Task changeStatus(String status) {
        return Task.where("Change status",
                CommonWaitUntil.isVisible(PurchaseRequestsPage.STATUS_PURCHASE_DETAIL),
                CommonTaskAdmin.changeValueTooltipDropdown(PurchaseRequestsPage.STATUS_PURCHASE_DETAIL, status)

        );
    }

    public static Task delete() {
        return Task.where("Delete purchase request",
                // open popup delete order
                CommonWaitUntil.isVisible(PurchaseRequestsPage.DELETE_PURCHASE_BUTTON_EDIT_DETAIL),
                Click.on(PurchaseRequestsPage.DELETE_PURCHASE_BUTTON_EDIT_DETAIL),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this purchase request. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this purchase request. Continue?"))
                );
    }

    public static Task verifyBrandLink(String brand, String skuID) {
        return Task.where("Verify brand link",
                CommonWaitUntil.isVisible(PurchaseRequestsPage.BRAND_LINK_REQUESTED_ITEMS(skuID)),
                Click.on(PurchaseRequestsPage.BRAND_LINK_REQUESTED_ITEMS(skuID)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.switchToChildWindowsByTitle(brand),
                CommonWaitUntil.isVisible(BrandDetailPage.NAME),
                Ensure.that(BrandDetailPage.NAME).attribute("value").contains(brand),
                GoBack.theBrowser(),
                Switch.toDefaultContext()
        );
    }

    public static Task verifyProductLink(String product, String skuID) {
        return Task.where("Verify product link",
                CommonWaitUntil.isVisible(PurchaseRequestsPage.PRODUCT_LINK_REQUESTED_ITEMS(skuID)),
                Click.on(PurchaseRequestsPage.PRODUCT_LINK_REQUESTED_ITEMS(skuID)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.switchToChildWindowsByTitle(product),
                CommonWaitUntil.isVisible(AdminProductDetailPage.PRODUCT_NAME),
                Ensure.that(AdminProductDetailPage.PRODUCT_NAME).attribute("value").contains(product),
                GoBack.theBrowser(),
                Switch.toDefaultContext()
        );
    }
}
