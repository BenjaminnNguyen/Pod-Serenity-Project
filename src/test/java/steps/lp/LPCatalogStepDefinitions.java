package steps.lp;

import cucumber.tasks.common.CommonTask;
import io.cucumber.java.en.*;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.inventory.LPProductDetailPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class LPCatalogStepDefinitions {
    @And("LP search item {string} on catalog")
    public void search(String item) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonLPPage.SEARCH),
                Enter.theValue(item).into(CommonLPPage.SEARCH).thenHit(Keys.ENTER),
                WindowTask.threadSleep(2000)
        );
    }
    @And("{string} choose filter by {string}")
    public void choose_filter(String actor, String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonLPPage.SEARCH_FILTER),
                CommonTask.chooseItemInDropdown(CommonLPPage.SEARCH_FILTER, CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(type)),
                WindowTask.threadSleep(2000)
        );
    }

    @And("LP go to detail of product {string}")
    public void goDetail(String item) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonLPPage.PRODUCT_NAME(item)),
                MoveMouse.to(CommonLPPage.PRODUCT_NAME(item)),
                Click.on(CommonLPPage.PRODUCT_NAME(item)),
                WindowTask.threadSleep(2000)
        );
    }
    @And("LP check detail of product")
    public void checkDetail( DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPProductDetailPage.PRODUCT_NAME),
                Ensure.that(LPProductDetailPage.PRODUCT_NAME).text().containsIgnoringCase(list.get(0).get("product")),
                Ensure.that(LPProductDetailPage.BRAND_NAME).text().containsIgnoringCase(list.get(0).get("brand")),
                Ensure.that(LPProductDetailPage.UNIT_UPC).text().containsIgnoringCase(list.get(0).get("unitUPC")),
                Ensure.that(LPProductDetailPage.CASE_PACK).text().containsIgnoringCase(list.get(0).get("casePack"))

        );
        if(!list.get(0).get("available").isEmpty()){
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(LPProductDetailPage.AVAILABLE).text().containsIgnoringCase(list.get(0).get("available"))
            );
        }
    }
}
