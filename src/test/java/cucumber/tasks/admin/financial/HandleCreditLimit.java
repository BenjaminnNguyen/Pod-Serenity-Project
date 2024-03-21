package cucumber.tasks.admin.financial;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.CreditLimitPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.ui.Button;
import org.openqa.selenium.Keys;

import java.awt.*;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleCreditLimit {

    public static Task search(Map<String, String> info) {
        return Task.where("Search buyer company in credit limit",
                CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("id"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany"))),
                Check.whether(info.get("diff").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("diff_str"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("diff")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task searchInvalid(String buyerCompany) {
        return Task.where("Search buyer company in credit limit",
                CommonWaitUntil.isEnabled(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("id")),
                Click.on(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("id")),
                Enter.theValue(buyerCompany).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("id")),
                WindowTask.threadSleep(1000),
                Ensure.that(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(buyerCompany)).isNotDisplayed()
        );
    }

    public static Task goToDetail(String buyerCompany) {
        return Task.where("Go to detail buyer company limit",
                CommonWaitUntil.isVisible(CreditLimitPage.BUYER_COMPANY_IN_RESULT_EDIT(buyerCompany)),
                Click.on(CreditLimitPage.BUYER_COMPANY_IN_RESULT_EDIT(buyerCompany)),
                CommonWaitUntil.isVisible(CreditLimitPage.SET_CREDIT_LIMIT_POPUP(buyerCompany))
        );
    }

    public static Task set(String amount) {
        return Task.where("Set buyer company limit",
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CreditLimitPage.SET_CREDIT_LIMIT_TEXTBOX),
                Enter.theValue(amount).into(CreditLimitPage.SET_CREDIT_LIMIT_TEXTBOX)
        );
    }

    public static Task goToAddTemporary() {
        return Task.where("Go to add temporary",
                CommonWaitUntil.isVisible(Button.withText("Add temporary credit")),
                Click.on(Button.withText("Add temporary credit"))
        );
    }


    public static Task fillInfoTemporary(Map<String, String> info) {
        return Task.where("Fill info temporary credit limit",
                CommonWaitUntil.isVisible(Button.withText("Remove temporary credit")),
                Enter.theValue(info.get("temporary")).into(CreditLimitPage.TEMPORARY_CREDIT_LIMIT_TEXTBOX),
                Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(CreditLimitPage.TEMPORARY_START_DATE_TEXTBOX).thenHit(Keys.ENTER),
                Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(CreditLimitPage.TEMPORARY_END_DATE_TEXTBOX).thenHit(Keys.ENTER)
        );
    }

    public static Task removeTemporary() {
        return Task.where("Remove temporary credit limit",
                Check.whether(valueOf(Button.withText("Remove temporary credit")), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(Button.withText("Remove temporary credit")),
                                CommonWaitUntil.isVisible(Button.withText("Add temporary credit"))
                        )
        );
    }

    public static Task update() {
        return Task.where("Update limit",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update"))
        );
    }
}
