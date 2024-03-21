package steps.admin.regions;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.regions.HandleDistributionCenter;
import cucumber.tasks.admin.regions.HandleRoute;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.regions.AdminRegionsForm;
import cucumber.user_interface.admin.regions.AdminRouteForm;
import cucumber.user_interface.admin.regions.DistributionCenterForm;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminRouteStepDefinitions {

    @And("Admin verify default of create new route")
    public void admin_verify_default_of_create_new_route() {
        theActorInTheSpotlight().attemptsTo(
                HandleRoute.goToCreateForm(),
                Ensure.that(AdminRouteForm.D_TEXT("Name")).attribute("value").contains(""),
                Ensure.that(AdminRouteForm.D_TEXT("Region")).attribute("value").contains(""),
                Ensure.that(AdminRouteForm.D_TEXT("Weekdays")).attribute("value").contains(""),
                Ensure.that(AdminRouteForm.STORE_LABEL).isDisplayed(),
                Ensure.that(AdminRouteForm.D_TEXT("Delivery cost")).attribute("value").contains(""),
                Ensure.that(AdminRouteForm.D_TEXT("Case Pick Fee")).attribute("value").contains("")
        );
    }

    @And("Admin verify error empty when create new route")
    public void admin_verify_error_empty_of_create_new_route() {
        theActorInTheSpotlight().attemptsTo(
                Scroll.to(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")).afterWaitingUntilEnabled(),
                // Verify
                CommonWaitUntil.isVisible(AdminRouteForm.D_TEXT("Name")),
                Ensure.that(DistributionCenterForm.D_ERROR("Name")).text().contains("Please input a name for this route"),
                Ensure.that(DistributionCenterForm.D_ERROR("Region")).text().contains("Please select a region for this route"),
                Ensure.that(DistributionCenterForm.D_ERROR("Weekdays")).text().contains("Please select weekdays for this route")
        );
    }

    @And("Admin fill info to create route")
    public void admin_fill_info_to_create_route(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleRoute.fillInfo(expected)
        );
    }

    @And("Admin create route success")
    public void admin_create_route_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleRoute.createSuccess()
        );
    }

    @And("Admin edit route success")
    public void admin_edit_route_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleRoute.editSuccess()
        );
    }

    @And("Admin search route")
    public void admin_search_route(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleRoute.search(infos.get(0))
        );
    }

    @And("Admin verify route result after search")
    public void admin_verify_result_after_search(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminRouteForm.NAME_RESULT),
                Ensure.that(AdminRouteForm.NAME_RESULT).text().contains(infos.get(0).get("name")),
                Ensure.that(AdminRouteForm.REGION_RESULT).text().contains(infos.get(0).get("region")),
                Ensure.that(AdminRouteForm.WEEKDAYS_RESULT).text().contains(infos.get(0).get("weekdays"))
        );
    }

    @And("Admin go to detail route {string}")
    public void admin_go_to_detail_route(String route) {
        theActorInTheSpotlight().attemptsTo(
                HandleRoute.goToDetail(route)
        );
    }

    @And("Admin verify route detail")
    public void admin_verify_route_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminRouteForm.EDIT_LABEL(infos.get(0).get("name"))),
                Ensure.that(AdminRouteForm.D_TEXT("Name")).attribute("value").contains(infos.get(0).get("name")),
                Ensure.that(AdminRouteForm.D_TEXT("Region")).attribute("value").contains(infos.get(0).get("region")),
                Ensure.that(AdminRouteForm.WITHIN_7_DAY_CHECKED).isDisplayed(),
                Ensure.that(AdminRouteForm.STORE_CHOOSED).text().contains(infos.get(0).get("store")),
                Ensure.that(AdminRouteForm.D_TEXT("Delivery cost")).attribute("value").contains(infos.get(0).get("deliveryCost")),
                Ensure.that(AdminRouteForm.D_TEXT("Case Pick Fee")).attribute("value").contains(infos.get(0).get("casePickFee"))
        );
    }

    @And("Admin edit route {string}")
    public void admin_edit_route(String route, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleRoute.goToDetail(route),
                HandleRoute.edit(infos)
        );
    }

    @And("Admin close popup route")
    public void admin_close_popup_route() {
        theActorInTheSpotlight().attemptsTo(
                HandleRoute.closePopup()
        );
    }

    @And("Admin verify search field after choose filter in route")
    public void admin_verify_search_field_after_choose_filter_route(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminRouteForm.NAME_SEARCH_TEXTBOX),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("name")).attribute("value").contains(infos.get(0).get("name")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id")).attribute("value").contains(infos.get(0).get("region"))
        );
    }
}
