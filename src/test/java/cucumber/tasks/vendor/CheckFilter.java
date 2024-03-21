package cucumber.tasks.vendor;

import cucumber.models.web.Admin.Vendors.SearchVendor;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.VendorPageForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class CheckFilter {

    public static Task check(SearchVendor info) {
        return Task.where("",
                Check.whether(valueOf(VendorPageForm.ft_FULL_NAME), isCurrentlyVisible())
                        .otherwise(
                                Click.on(VendorPageForm.SHOW_FILTER)),
                Check.whether(info.getFullName()!=null)
                                .andIfSo(Enter.theValue(info.getFullName()).into(VendorPageForm.ft_FULL_NAME)),
                Check.whether(info.getEmail()!=null)
                        .andIfSo(Enter.theValue(info.getEmail()).into(VendorPageForm.ft_EMAIL)),
                Click.on(VendorPageForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(VendorPageForm.LOADING_ICON)
        );
    }

    public static Task resetFilter() {
        return Task.where("Reset filter",
                Check.whether(valueOf(VendorPageForm.ft_FULL_NAME), isCurrentlyVisible())
                        .andIfSo(Click.on(VendorPageForm.ft_RESET),
                                CommonWaitUntil.isNotVisible(VendorPageForm.LOADING_ICON)
                        )
        );
    }
}
