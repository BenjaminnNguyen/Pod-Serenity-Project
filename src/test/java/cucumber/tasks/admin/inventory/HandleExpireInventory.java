package cucumber.tasks.admin.inventory;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleExpireInventory {

    public static Task search(Map<String, String> info) {
        return Task.where("Search expire inventory",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(info.get("skuName").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_id"),info.get("skuName"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("skuName")))
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
                Check.whether(info.get("distribution").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("warehouse_id"), info.get("distribution"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("distribution")))
                        ),
                Check.whether(info.get("createdBy").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("creator_type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("createdBy")))
                        ),
                Check.whether(info.get("lotZero").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("current_quantity_gt"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("lotZero")))
                        ),
                Check.whether(info.get("storageSheftLife").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("storage_shelf_life_condition"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("storageSheftLife")))
                        ),
                Check.whether(info.get("tag").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("tag")))
                        ),
                Check.whether(info.get("dayUntilPullDateCondition").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("until_pull_date_type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("dayUntilPullDateCondition")))
                        ),
                Check.whether(info.get("dayUntilPullDate").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("dayUntilPullDate")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX2("until_pull_date_type"))
                        ),
                Check.whether(info.get("pullStartDate").isEmpty())
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("pullStartDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("pull_date_start")).thenHit(Keys.ENTER)
                        ),
                Check.whether(info.get("pullEndDate").isEmpty())
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("pullEndDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("pull_date_end")).thenHit(Keys.ENTER)
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }
}
