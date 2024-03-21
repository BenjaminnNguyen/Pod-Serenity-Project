package steps.admin.regions;

import cucumber.tasks.admin.regions.HandleDistributionCenter;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.regions.DistributionCenterForm;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;


public class DistributionCenterStepDefinitions {

    @And("Admin verify default of create new distribution center")
    public void admin_verify_default_of_create_new_distribution_center() {
        theActorInTheSpotlight().attemptsTo(
                HandleDistributionCenter.goToCreateForm(),
                Ensure.that(DistributionCenterForm.ALERT_FORM_LABEL).text().contains("Do not create a new warehouse/ edit current warehouse's address during peak times because this is a very heavy task!"),
                Ensure.that(DistributionCenterForm.D_TEXT("Region")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("Warehousing LP")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("Timezone")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("Name")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("ATTN")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("Street 1")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("Street 2")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("City")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("State (Province/Territory)")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("Zip")).attribute("value").contains(""),
                Ensure.that(DistributionCenterForm.D_TEXT("Phone number")).attribute("value").contains("")
        );
    }

    @And("Admin verify error empty when create new distribution center")
    public void admin_verify_error_empty_of_create_new_distribution_center() {
        theActorInTheSpotlight().attemptsTo(
                Scroll.to(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")).afterWaitingUntilEnabled(),
                // Verify
                CommonWaitUntil.isVisible(DistributionCenterForm.D_ERROR("Region")),
                Ensure.that(DistributionCenterForm.D_ERROR("Region")).text().contains("Please select a region for this Distribution Center"),
                Ensure.that(DistributionCenterForm.D_ERROR("Warehousing LP")).text().contains("Please select a LP company for this Distribution Center"),
                Ensure.that(DistributionCenterForm.D_ERROR("Timezone")).text().contains("Please select a timezone for this Distribution Center"),
                Ensure.that(DistributionCenterForm.D_ERROR("Name")).text().contains("Please input Distribution Center name"),
                Ensure.that(DistributionCenterForm.D_ERROR("Street 1")).text().contains("Please select a specific street address for this Distribution Center"),
                Ensure.that(DistributionCenterForm.D_ERROR("City")).text().contains("Please select a specific city for this Distribution Center."),
                Ensure.that(DistributionCenterForm.D_ERROR("State (Province/Territory)")).text().contains("Please select a specific state for this Distribution Center."),
                Ensure.that(DistributionCenterForm.D_ERROR("Zip")).text().contains("Please enter a valid 5-digits zip code")
        );
    }

    @And("Admin search distribution center {string}")
    public void admin_search_distribution_center(String distributionName) {
        theActorInTheSpotlight().attemptsTo(
                HandleDistributionCenter.search(distributionName)
        );
    }

    @And("Admin fill info to create distribution center")
    public void admin_fill_info_to_create_distribution_center(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleDistributionCenter.fillInfo(expected.get(0))
        );
    }

    @And("Admin create distribution center success")
    public void admin_create_distribution_center_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleDistributionCenter.createSuccess()
        );
    }

    @And("Admin verify result after create distribution center")
    public void admin_verify_result_after_create_distribution_center(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(DistributionCenterForm.NAME_RESULT(expected.get(0).get("name"))).isDisplayed(),
                Ensure.that(DistributionCenterForm.TIME_ZONE_RESULT(expected.get(0).get("name"))).text().contains(expected.get(0).get("timezone")),
                Ensure.that(DistributionCenterForm.DESCRIPTION_RESULT(expected.get(0).get("name"))).text().contains(expected.get(0).get("description"))
        );
    }

    @And("Admin go to detail distribution center {string}")
    public void admin_go_to_detail_distributon_center(String name) {
        theActorInTheSpotlight().attemptsTo(
            HandleDistributionCenter.goToDetail(name)
        );
    }

    @And("Admin delete distribution center {string}")
    public void admin_delete_distribution_center(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleDistributionCenter.delete(name)
        );
    }

    @And("Admin verify info distribution center detail")
    public void admin_verify_info_distribution_center_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(DistributionCenterForm.EDIT_FORM_LABEL(expected.get(0).get("name"))),

                Ensure.that(DistributionCenterForm.D_TEXT("Region")).attribute("value").contains(expected.get(0).get("region")),
                Ensure.that(DistributionCenterForm.D_TEXT("Warehousing LP")).attribute("value").contains(expected.get(0).get("warehouse")),
                Ensure.that(DistributionCenterForm.D_TEXT("Timezone")).attribute("value").contains(expected.get(0).get("timeZone")),
                Ensure.that(DistributionCenterForm.D_TEXT("Name")).attribute("value").contains(expected.get(0).get("name")),
                Ensure.that(DistributionCenterForm.D_TEXT("ATTN")).attribute("value").contains(expected.get(0).get("attn")),
                Ensure.that(DistributionCenterForm.D_TEXT("Street 1")).attribute("value").contains(expected.get(0).get("street1")),
                Ensure.that(DistributionCenterForm.D_TEXT("Street 2")).attribute("value").contains(expected.get(0).get("street2")),
                Ensure.that(DistributionCenterForm.D_TEXT("City")).attribute("value").contains(expected.get(0).get("city")),
                Ensure.that(DistributionCenterForm.D_TEXT("State (Province/Territory)")).attribute("value").contains(expected.get(0).get("state")),
                Ensure.that(DistributionCenterForm.D_TEXT("Zip")).attribute("value").contains(expected.get(0).get("zip")),
                Ensure.that(DistributionCenterForm.D_TEXT("Phone number")).attribute("value").contains(expected.get(0).get("phone"))
        );
    }
}
