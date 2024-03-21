package cucumber.tasks.vendor;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.HomePageForm;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.lp.inventory.InventoryLPPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.matchers.WebElementStateMatchers;
import net.serenitybdd.screenplay.questions.WebElementQuestion;
import net.serenitybdd.screenplay.targets.Target;
import net.serenitybdd.screenplay.waits.WaitUntil;

public class VendorDashboardTask {

    public static Task navigate(String pageTitle, Target title) {
        return Task.where("Truy cập vào trang " + pageTitle + " qua sidebar",
                CommonWaitUntil.isPresent(title),
                Check.whether(WebElementQuestion.the(title), WebElementStateMatchers.isVisible())
                        .otherwise(Scroll.to(title)),
                JavaScriptClick.on(title),
                CommonWaitUntil.isNotVisible(InventoryLPPage.LOADING)
        );
    }
    public static Task checkHelpTooltip(String field, String message) {
        return Task.where("check help tooltip of field " + field,
                CommonWaitUntil.isVisible(CommonVendorPage.HELP_TOOLTIP(field)),
                Scroll.to(CommonVendorPage.HELP_TOOLTIP(field)),
                MoveMouse.to(CommonVendorPage.HELP_TOOLTIP(field)),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(message)));
    }


}
