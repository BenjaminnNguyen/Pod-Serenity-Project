package steps.buyer.BrandReferral;

import io.cucumber.java.en.*;
import cucumber.tasks.buyer.brandreferral.HandleBrandReferral;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Buyer.brandrefferal.BrandRefferalPage;
import cucumber.user_interface.beta.User_Header;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class BrandReferralStepDefinitions {

    @And("{word} go to Brand Referral")
    public void go_to_buyer_referral(String actor) {
        theActorCalled(actor).attemptsTo(
                CommonWaitUntil.isVisible(User_Header.BRAND_REFERRAL),
                Click.on(User_Header.BRAND_REFERRAL),
                CommonWaitUntil.isVisible(BrandRefferalPage.INVITE_BUTTON)
        );
    }

    @And("Buyer verify message after click invite")
    public void verify_message_after_click_invite() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(BrandRefferalPage.INVITE_BUTTON),
                CommonWaitUntil.isVisible(BrandRefferalPage.ERROR_MESSAGE),
                Ensure.that(BrandRefferalPage.ERROR_MESSAGE).isDisplayed()
        );
    }

    @And("Buyer fill info to form brand referral")
    public void fill_info_to_form_brand_referral(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    HandleBrandReferral.fillInfoInvite(list.get(i), i)
            );
        }
    }

    @And("Buyer invite success")
    public void buyer_invite_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleBrandReferral.inviteSuccess()
        );

    }

}
