package cucumber.tasks.admin.lp;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleLPCompanies {

    public static Task search(Map<String, String> info) {
        return Task.where("Search lp company",
                Check.whether(info.get("businessName").isEmpty()).otherwise(
                        Enter.theValue(info.get("businessName")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("business_name"))
                ),
                Check.whether(info.get("contactNumber").isEmpty()).otherwise(
                        Enter.theValue(info.get("contactNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("contact_number"))
                ),
                Check.whether(info.get("roles").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("roles_name"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("roles")))
                ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String vendorCompany) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(VendorCompaniesPage.NAME_RESULT(vendorCompany)),
                Click.on(VendorCompaniesPage.NAME_RESULT(vendorCompany)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }
}
