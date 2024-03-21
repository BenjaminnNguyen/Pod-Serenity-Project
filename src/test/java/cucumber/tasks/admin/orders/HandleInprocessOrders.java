package cucumber.tasks.admin.orders;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

public class HandleInprocessOrders {

    public static Task checkByInfo(Map<String, String> info) {
        return Task.where("Search in-process order by info",
                Check.whether(info.get("orderNumber").isEmpty())
                        .otherwise(Enter.theValue(info.get("orderNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("order_number"))),
                Check.whether(info.get("customerPO").isEmpty())
                        .otherwise(Enter.theValue(info.get("customerPO")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("customer_po"))),
                Check.whether(info.get("buyer").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer")))),
                Check.whether(info.get("createdBy").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("admin_id"), info.get("createdBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("createdBy")))),
                Check.whether(info.get("status").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("state"), info.get("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("status")))),

                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }


}
