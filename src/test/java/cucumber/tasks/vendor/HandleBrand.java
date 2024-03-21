package cucumber.tasks.vendor;

import cucumber.models.web.Vendor.CreateNewBrand;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.VendorDashboardPage;
import cucumber.user_interface.beta.Vendor.brands.VendorDetailBrandDashboardPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.List;
import java.util.Map;

public class HandleBrand {

    public static Task create(CreateNewBrand infos) {
        return Task.where("Create the brand ",
                Click.on(VendorDashboardPage.NEW_BRAND_BUTTON),
                CommonWaitUntil.isVisible(VendorDashboardPage.BRAND_NAME_CREATE),
                Enter.keyValues(infos.getName()).into(VendorDashboardPage.BRAND_NAME_CREATE),
                Enter.keyValues(infos.getDescription()).into(VendorDashboardPage.BRAND_DESCRIPTION_CREATE),
                CommonTask.chooseItemInDropdownWithValueInput(
                        VendorDashboardPage.BRAND_CONTRY_CREATE, infos.getCountry(), VendorDashboardPage.DYNAMIC_DROPDOWN_OPTION(infos.getCountry())),
                CommonTask.chooseItemInDropdownWithValueInput(
                        VendorDashboardPage.BRAND_STATE_CREATE, infos.getStage(), VendorDashboardPage.DYNAMIC_DROPDOWN_OPTION(infos.getStage())),
                Enter.keyValues(infos.getCity()).into(VendorDashboardPage.BRAND_CITY_CREATE),
                Click.on(VendorDashboardPage.BUTTON_CREATE),
                CommonWaitUntil.isNotVisible(VendorDashboardPage.BRAND_NAME_CREATE),
                CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.BRAND_NAME)
        );
    }

    public static Task enterInfo(List<Map<String, String>> list) {
        return Task.where("Create the brand ",
                Check.whether(list.get(0).get("brandName").isEmpty()).otherwise(
                        Enter.theValue(list.get(0).get("brandName")).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Brand name"))
                ),
                Check.whether(list.get(0).get("description").isEmpty()).otherwise(
                        Enter.theValue(list.get(0).get("description")).into(CommonVendorPage.DYNAMIC_TEXT_AREA2("Brand description (maximum 1000 characters)"))
                ),
                Check.whether(list.get(0).get("country").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Country"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(list.get(0).get("country")))
                ),
                Check.whether(list.get(0).get("state").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonVendorPage.DYNAMIC_DIALOG_INPUT("State (Province/Territory)"), list.get(0).get("state"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(list.get(0).get("state")))
                ),
                Check.whether(list.get(0).get("city").isEmpty()).otherwise(
                        Enter.theValue(list.get(0).get("city")).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("City"))
                )
        );
    }
}
