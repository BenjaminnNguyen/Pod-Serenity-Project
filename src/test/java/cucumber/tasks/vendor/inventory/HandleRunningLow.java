package cucumber.tasks.vendor.inventory;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleRunningLow {

    public static Task search(Map<String, String> info) {
        return Task.where("Search inventory running low",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(info.get("skuName").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_id"), info.get("skuName"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("skuName")))
                        ),
                Check.whether(info.get("productName").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("productName")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_name"))
                        ),
                Check.whether(info.get("vendorCompany").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorCompany")))
                        ),
                Check.whether(info.get("vendorBrand").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("vendorBrand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorBrand")))
                        ),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task searchWithItemCode(Map<String, String> info) {
        return Task.where("Search inventory running low",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(info.get("itemCode").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_id"), info.get("skuName"),
                                        CommonAdminForm.FIRST_ITEM_DROPDOWN))

        );
    }
}
