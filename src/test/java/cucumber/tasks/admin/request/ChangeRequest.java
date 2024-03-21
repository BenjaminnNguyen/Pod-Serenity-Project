package cucumber.tasks.admin.request;

import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.RequestsPageForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class ChangeRequest {

    public static Task check(Map<String, String> info) {
        return Task.where("Search brands",
                Check.whether(valueOf(CommonAdminForm.SEARCH_BUTTON), isCurrentlyVisible())
                        .otherwise(
                                Click.on(AllBrandsPage.SHOW_FILTER)),
                Check.whether(!info.get("productName").isEmpty())
                        .andIfSo(Enter.theValue(info.get("productName")).into(RequestsPageForm.PRODUCTNAME_TEXTBOX)),
                Check.whether(!info.get("skuName").isEmpty())
                        .andIfSo(Enter.theValue(info.get("skuName")).into(RequestsPageForm.SKUNAME_TEXTBOX)),
                Click.on(CommonAdminForm.SEARCH_BUTTON)
        );
    }

}
