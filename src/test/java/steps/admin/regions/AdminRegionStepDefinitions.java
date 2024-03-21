package steps.admin.regions;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.regions.HandleRegion;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.regions.AdminRegionsForm;
import cucumber.user_interface.admin.regions.DistributionCenterForm;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;


public class AdminRegionStepDefinitions {

    @And("Admin verify info of region")
    public void admin_verify_info_of_region(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminRegionsForm.REGION_ALERT),
                Ensure.that(AdminRegionsForm.REGION_ALERT).text().contains("DO NOT edit a region name without notifying engineers!!!")
        );
        for (Map<String, String> item : expected) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminRegionsForm.NAME_REGION(item.get("name"))).text().contains(item.get("name")),
                    Ensure.that(AdminRegionsForm.TYPE_REGION(item.get("name"))).text().contains(item.get("type")),
                    Ensure.that(AdminRegionsForm.PRICING_REGION(item.get("name"))).text().contains(item.get("pricing")),
                    Ensure.that(AdminRegionsForm.ABBREVIATED_REGION(item.get("name"))).text().contains(item.get("abbreviated")),
                    Check.whether(item.get("description").equals(""))
                            .otherwise(Ensure.that(AdminRegionsForm.DESCRIPTION_REGION(item.get("name"))).attribute("data-original-text").contains(item.get("description")))
            );
        }
    }

    @And("Admin go to region {string} detail")
    public void admin_go_to_region_detail(String region) {
        theActorInTheSpotlight().attemptsTo(
                HandleRegion.goToRegionDetail(region)
        );

    }

    @And("Admin verify general info of region detail")
    public void admin_verify_general_info_of_region_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AdminRegionsForm.NAME_GENERAL).text().contains(expected.get(0).get("name")),
                Ensure.that(AdminRegionsForm.DESCRIPTION_GENERAL).text().contains(expected.get(0).get("description")),
                Ensure.that(AdminRegionsForm.ABBREVIATED_GENERAL).text().contains(expected.get(0).get("abbreviated")),
                Check.whether(expected.get(0).get("pricing").isEmpty())
                        .otherwise(
                                Ensure.that(CommonAdminForm.DYNAMIC_BUTTON("Remove specified %")).isDisplayed(),
                                Ensure.that(AdminRegionsForm.PRICING_GENERAL).text().contains(expected.get(0).get("pricing"))),
                Check.whether(expected.get(0).get("deleveryMethod").equals("Ship direct to stores"))
                        .andIfSo(
                                Ensure.that(AdminRegionsForm.SHIP_DIRECT_TO_STORE_GENERAL).text().contains(expected.get(0).get("deleveryMethod")),
                                Ensure.that(AdminRegionsForm.SELF_DELIVER_TO_STORE_GENERAL).text().contains("Self deliver to store")
                        )
                        .otherwise(
                                Ensure.that(AdminRegionsForm.POD_CONSIGNMENT_GENERAL).text().contains(expected.get(0).get("deleveryMethod"))),
                Check.whether(expected.get(0).get("cutOffTime").isEmpty())
                        .otherwise(
                                Ensure.that(AdminRegionsForm.CUT_OFF_TIME_GENERAL).text().contains(expected.get(0).get("cutOffTime"))),
                Ensure.that(CommonAdminForm.DYNAMIC_BUTTON("Set fixed %")).isDisplayed()
        );
    }

    @And("Admin verify redirect link of region {string} in detail")
    public void admin_verify_redirect_link_of_region_detail(String regionID) {
        theActorInTheSpotlight().attemptsTo(
                // verify Find all region's orders link
                HandleRegion.checkLink("Find all region's orders", "Orders", regionID),
                // verify Find all region's sample requests link
                HandleRegion.checkLink("Find all region's sample requests", "Sample requests", regionID),
                // verify Find all region's products link
                HandleRegion.checkLink("Find all region's products", "Products", regionID),
                // verify Find all region's price requests link
                HandleRegion.checkLink("Find all region's price requests", "Product change requests", regionID),
                // verify Find all region's promotions link
                HandleRegion.checkLink("Find all region's promotions", "Promotions", regionID),
                // verify Find all region's inventories link
                HandleRegion.checkLink("Find all region's inventories", "All inventory", regionID),
                // verify Find all region's stores link
                HandleRegion.checkLink("Find all region's stores", "Stores", regionID),
                // verify Find all region's vendors link
                HandleRegion.checkLink("Find all region's vendors", "Vendors", regionID),
                // verify Find all region's vendor companies link
                HandleRegion.checkLink("Find all region's vendor companies", "Vendor companies", regionID)
        );
    }

}
