package steps.admin.brands;

import cucumber.singleton.GVs;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.CreateNewOrderPage;
import io.cucumber.java.en.And;
import cucumber.tasks.admin.brands.HandleBrandReferrals;
import cucumber.tasks.api.CommonHandle;
import cucumber.user_interface.admin.Brand.BrandReferralPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class BrandReferralStepDefinitions {

    @And("Admin search brand referral with info")
    public void search_brand_referral_with_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleBrandReferrals.search(infos.get(0))
        );
    }

    @And("Admin no found brand referral {string} in result")
    public void admin_no_found_brand_referral_in_result(String brand) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(BrandReferralPage.D_BRAND_IN_RESULT(1, brand))
        );
    }

    @And("Admin verify result brand referrals")
    public void verify_result_brand_referrals(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BrandReferralPage.D_IN_RESULT("date-submitted")).text().contains(CommonHandle.setDate(expected.get(i).get("date"), "MM/dd/yy")),
                    Ensure.that(BrandReferralPage.D_IN_RESULT("store-name")).text().contains(expected.get(i).get("store")),
                    Ensure.that(BrandReferralPage.D_IN_RESULT("buyer-name")).text().contains(expected.get(i).get("buyer")),
                    Ensure.that(BrandReferralPage.D_BRAND_IN_RESULT(i + 1, expected.get(i).get("brand"))).text().contains(expected.get(i).get("brand")),
                    Ensure.that(BrandReferralPage.D_EMAIL_IN_RESULT(i + 1, expected.get(i).get("brand"))).text().contains(expected.get(i).get("email")),
                    Ensure.that(BrandReferralPage.D_CONTACT_IN_RESULT(i + 1, expected.get(i).get("brand"))).text().contains(expected.get(i).get("contactName")),
                    Ensure.that(BrandReferralPage.D_WORKING_IN_RESULT(i + 1, expected.get(i).get("brand"))).attribute("class").contains(expected.get(i).get("working")),
                    Ensure.that(BrandReferralPage.D_ONBOARD_IN_RESULT(i + 1, expected.get(i).get("brand"))).attribute("class").contains(expected.get(i).get("onboarded")),
                    Ensure.that(BrandReferralPage.D_VENDOR_COMPANY_IN_RESULT(i + 1, expected.get(i).get("brand"))).text().contains(expected.get(i).get("vendorCompany"))
            );
        }
    }

    @And("Admin go to brand referrals details")
    public void verify_result_brand_referrals_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleBrandReferrals.goToDetail()
        );
    }

    @And("Admin choose brand, edit and mark as onboarded with vendor company {string}")
    public void choose_brand_and_mark_as_onboarded(String vendorCompany, DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrandReferrals.chooseBrandAndMark(expected),
                HandleBrandReferrals.chooseMarkAsOnboardedAndConfirm(vendorCompany)
        );
    }

    @And("Admin edit info of brand referral")
    public void admin_edit_info_of_brand_referral(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrandReferrals.editInfo(expected)
        );
    }

    @And("Admin verify result brand referrals after mark as onboarded")
    public void verify_result_brand_referrals_after_mark_as_onboarded(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);

        List<WebElementFacade> size = BrandReferralPage.ROW_IN_BRAND_TABLE.resolveAllFor(theActorInTheSpotlight());

        for (int i = 0; i < size.size(); i++) {
            String brandInput = BrandReferralPage.BRAND_TEXTBOX(i + 1).resolveFor(theActorInTheSpotlight()).getAttribute("value").trim();
            for (int j = 0; j < expected.size(); j++) {
                if (brandInput.equals(expected.get(j).get("brand"))) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BrandReferralPage.BRAND_TEXTBOX(i + 1)).attribute("value").contains(expected.get(i).get("brand")),
                            Ensure.that(BrandReferralPage.EMAIL_TEXTBOX(i + 1)).attribute("value").contains(expected.get(i).get("email")),
                            Ensure.that(BrandReferralPage.CONTACT_TEXTBOX(i + 1)).attribute("value").contains(expected.get(i).get("contactName")),
                            Ensure.that(BrandReferralPage.WORKING_TEXTBOX(i + 1)).attribute("value").contains(expected.get(i).get("working")),
                            Ensure.that(BrandReferralPage.ONBOARD_LABEL(i + 1)).attribute("class").contains(expected.get(i).get("onboarded")),
                            Ensure.that(BrandReferralPage.VENDOR_COMPANY_LABEL(i + 1)).attribute("data-original-text").contains(expected.get(i).get("vendorCompany")),
                            Ensure.that(BrandReferralPage.NOTE_TEXTAREA(i + 1)).attribute("value").contains(expected.get(i).get("note"))
                    );
                }
            }
        }
    }

    @And("Admin delete brand referral {string}")
    public void admin_delete_brand_referral(String brand) {
        theActorInTheSpotlight().attemptsTo(
                HandleBrandReferrals.delete(brand)
        );
    }

    @And("Admin verify general information of brand referral detail")
    public void verify_general_information_of_brand_referral_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BrandReferralPage.STORE_DETAIL).text().contains(expected.get(0).get("store")),
                Ensure.that(BrandReferralPage.BUYER_DETAIL).text().contains(expected.get(0).get("buyer")),
                Ensure.that(BrandReferralPage.DATE_DETAIL).text().contains(CommonHandle.setDate2(expected.get(0).get("date"), "MM/dd/yy"))
        );

    }

    @And("Admin remove brand in brand referral detail")
    public void admin_remove_brand_in_brand_referral_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrandReferrals.removeBrand(expected)
        );
    }

    @And("Admin save action in brand referral")
    public void admin_save_action_in_brand_referral() {
        theActorInTheSpotlight().attemptsTo(
                HandleBrandReferrals.save()
        );
    }

    @And("Admin redirect vendor company link in brand referral")
    public void admin_redirect_vendor_company_link_in_brand_referral(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                HandleBrandReferrals.redirect(expected.get(0))
        );
    }

    @And("Admin verify brand field of brand referral")
    public void admin_verify_brand_field_of_brand_referral() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue(GVs.STRING_300).into(BrandReferralPage.BRAND_TEXTBOX(1)),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Referral brand items name is too long (maximum is 256 characters)")),

                Enter.theValue(GVs.STRING_300).into(BrandReferralPage.CONTACT_TEXTBOX(1)),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Referral brand items contact name is too long (maximum is 256 characters)"))
        );
    }



}
