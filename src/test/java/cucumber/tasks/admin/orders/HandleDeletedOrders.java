package cucumber.tasks.admin.orders;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.orders.DeletedOrderPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleDeletedOrders {
    public static Performable searchByInfo(Map<String, String> info) {
        return Task.where("Search order deleted by info",
                actor -> {
                    CommonTask commonTask = new CommonTask();
                    commonTask
                            .performWithContainKey(info, "orderNumber",
                                    Enter.theValue(info.get("orderNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")))
                            .performWithContainKey(info, "orderSpecific",
                                    Enter.theValue(info.get("orderSpecific")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("custom_store_name")))
                            .performWithContainKey(info, "store",
                                    CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store"))))
                            .performWithContainKey(info, "buyer",
                                    CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer"))))
                            .performWithContainKey(info, "vendorCompany",
                                    CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany"))))
                            .performWithContainKey(info, "brand",
                                    CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand"))))
                            .performWithContainKey(info, "sku",
                                    CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant"), info.get("sku"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sku"))))
                            .performWithContainKey(info, "fulfillment",
                                    CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("fulfillment_state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("fulfillment"))))
                            .performWithContainKey(info, "skuID",
                                    CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant"), info.get("skuID"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sku"))))
                            .performWithContainKey(info, "upc",
                                    Enter.theValue(info.get("upc")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("upc")))
                            .performWithContainKey(info, "buyerPayment",
                                    CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_payment_state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerPayment"))))
                            .performWithContainKey(info, "region",
                                    CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region"))))
                            .performWithContainKey(info, "vendorPayment",
                                    CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_payment_state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorPayment"))))
                            .performWithContainKey(info, "startDate",
                                    Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")).thenHit(Keys.ENTER))
                            .performWithContainKey(info, "endDate",
                                    Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")).thenHit(Keys.ENTER));

                    actor.attemptsTo(
                            Click.on(CommonAdminForm.SEARCH_BUTTON),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                    );
                }

        );
    }

    public static Task seeDetail(String idInvoice) {
        return Task.where("See detail order",
                Click.on(DeletedOrderPage.ORDER_DETAIL_BY_ID(idInvoice)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task exportDetail(String fileName) {
        return Task.where("Export detail",
                Click.on(DeletedOrderPage.EXPORT_BUTTON),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.waitToDownloadSuccessfully(fileName)
        );
    }

}
