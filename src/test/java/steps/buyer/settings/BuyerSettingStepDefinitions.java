package steps.buyer.settings;

import cucumber.tasks.buyer.settings.BuyerSettingTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.vendor.setting.HandleVendorGeneralSetting;
import cucumber.user_interface.beta.Buyer.setting.GeneralPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class BuyerSettingStepDefinitions {

    @And("Buyer edit store information")
    public void buyer_edit_store_information(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                BuyerSettingTask.goToStoreInformationPopup(),
                BuyerSettingTask.editStoreInformation(infos.get(0)),
                BuyerSettingTask.editStoreInfoSuccess()
        );
    }

    @And("Buyer go to general")
    public void buyer_go_to_general() {
        theActorInTheSpotlight().attemptsTo(
                BuyerSettingTask.goToGeneralSetting()
        );
    }

    @And("Buyer go to payments")
    public void buyer_go_to_payment() {
        theActorInTheSpotlight().attemptsTo(
                BuyerSettingTask.goToPaymentsSetting()
        );
    }

    @And("Buyer delete current card")
    public void buyer_delete_current_card() {
        theActorInTheSpotlight().attemptsTo(
                BuyerSettingTask.deleteCurrentCard()
        );
    }

    @And("Buyer verify company information in general settings")
    public void buyer_verify_company_information_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(GeneralPage.COMPANY_NAME),
                Ensure.that(GeneralPage.COMPANY_NAME).text().contains(infos.get(0).get("companyName")),
                Ensure.that(GeneralPage.EIN).text().contains(infos.get(0).get("ein"))
        );
    }

    @And("Buyer verify company document in general settings")
    public void buyer_verify_company_document_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(GeneralPage.COMPANY_DOCUMENT_LINK).text().contains(infos.get(0).get("link")),
                Ensure.that(GeneralPage.COMPANY_DOCUMENT_DESCRIPTION).text().contains(infos.get(0).get("description")),
                Click.on(GeneralPage.COMPANY_DOCUMENT_DESCRIPTION),
                WindowTask.switchToChildWindowsByTitle(infos.get(0).get("link")),
                WindowTask.switchToChildWindowsByTitle("General Settings - Pod Foods | Online Distribution Platform for Emerging Brands")
        );
    }

    @And("Buyer verify business license certificates in general settings")
    public void buyer_verify_business_license_certificates_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(GeneralPage.BUSINESS_LICENSE_CERTIFICATES_LINK).text().contains(infos.get(0).get("link")),
                Ensure.that(GeneralPage.BUSINESS_LICENSE_CERTIFICATES_DESCRIPTION).text().contains(infos.get(0).get("description")),
                Click.on(GeneralPage.BUSINESS_LICENSE_CERTIFICATES_DESCRIPTION),
                WindowTask.switchToChildWindowsByTitle(infos.get(0).get("link")),
                WindowTask.switchToChildWindowsByTitle("General Settings - Pod Foods | Online Distribution Platform for Emerging Brands")
        );
    }

    @And("Buyer verify resale certificates in general settings")
    public void buyer_verify_resale_certificates_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(GeneralPage.RESALE_CERTIFICATES_LINK).text().contains(infos.get(0).get("link")),
                Ensure.that(GeneralPage.RESALE_CERTIFICATES_DESCRIPTION).text().contains(infos.get(0).get("description")),
                Click.on(GeneralPage.RESALE_CERTIFICATES_DESCRIPTION),
                WindowTask.switchToChildWindowsByTitle(infos.get(0).get("link")),
                WindowTask.switchToChildWindowsByTitle("General Settings - Pod Foods | Online Distribution Platform for Emerging Brands")
        );
    }

    @And("Buyer go to edit personal in general settings")
    public void buyer_go_to_edit_personal() {
        theActorInTheSpotlight().attemptsTo(
                BuyerSettingTask.goToEditPersonal()
        );
    }

}
