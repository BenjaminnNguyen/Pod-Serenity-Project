package cucumber.tasks.buyer.brandreferral;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Buyer.brandrefferal.BrandRefferalPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

public class HandleBrandReferral {

    public static Task fillInfoInvite(Map<String, String> info, int index) {
        return Task.where("Fill info to invite",
                CommonWaitUntil.isVisible(BrandRefferalPage.BRAND_NAME_TEXTBOX(index + 1)),
                Enter.theValue(info.get("brand")).into(BrandRefferalPage.BRAND_NAME_TEXTBOX(index + 1)),
                Enter.theValue(info.get("email")).into(BrandRefferalPage.EMAIL_TEXTBOX(index + 1)),
                Enter.theValue(info.get("contactName")).into(BrandRefferalPage.CONTACT_TEXTBOX(index + 1)),
                Check.whether(info.get("work").equals(""))
                        .otherwise(Click.on(BrandRefferalPage.WORK_CHECKBOX(index + 1))),
                Check.whether(info.get("addMore").equals(""))
                        .otherwise(Click.on(BrandRefferalPage.ADD_MORE_BUTTON))
        );
    }

    public static Task inviteSuccess() {
        return Task.where("Fill info to invite",
                Click.on(BrandRefferalPage.INVITE_BUTTON),
                CommonWaitUntil.isVisible(BrandRefferalPage.THANK_YOU_POPUP),
                Click.on(BrandRefferalPage.CONTINUE_BUTTON_IN_POPUP)

        );
    }
}
