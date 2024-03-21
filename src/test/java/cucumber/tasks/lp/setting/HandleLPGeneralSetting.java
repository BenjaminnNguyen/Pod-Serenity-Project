package cucumber.tasks.lp.setting;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Vendor.setting.VendorSettingGeneralPage;
import cucumber.user_interface.lp.LPSettingPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

public class HandleLPGeneralSetting {

    public static Task goToEditCompany() {
        return Task.where("Go to edit company",
                CommonWaitUntil.isVisible(LPSettingPage.COMPANY_EDIT_BUTTON),
                Click.on(LPSettingPage.COMPANY_EDIT_BUTTON),
                CommonWaitUntil.isVisible(LPSettingPage.POPUP_EDIT_TITLE)
        );
    }

    public static Performable editCompany(Map<String, String> info) {
        return Task.where("Edit company",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(info.get("companyName").equals(""))
                                    .otherwise(
                                            Enter.theValue(info.get("companyName")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company name"))),
                            Check.whether(info.get("contactNumber").equals(""))
                                    .otherwise(
                                            Enter.theValue(info.get("contactNumber")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Contact number")))
                    );
                }
        );
    }
}
