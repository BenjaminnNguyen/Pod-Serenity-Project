package cucumber.tasks.admin.regions;

import cucumber.actions.GoBack;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.regions.AdminRegionsForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

public class HandleRegion {

    public static Task goToRegionDetail(String region) {
        return Task.where("go to region detail",
                Click.on(AdminRegionsForm.NAME_REGION(region)).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task checkLink(String link, String title, String regionID) {
        return Task.where("check link",
                Click.on(AdminRegionsForm.ALL_REGION_LINK(link)),
                CommonWaitUntil.isVisible(CommonAdminForm.TITLE_PAGE),
                Ensure.that(CommonAdminForm.TITLE_PAGE).text().contains(title),
                Ensure.thatTheCurrentPage().currentUrl().contains(regionID),
                new GoBack(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

}
