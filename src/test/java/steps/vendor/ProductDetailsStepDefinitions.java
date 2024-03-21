package steps.vendor;

import io.cucumber.java.en.*;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.CatalogForm;
import cucumber.user_interface.beta.DashBoardForm;
import net.serenitybdd.screenplay.actions.Click;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class ProductDetailsStepDefinitions {

    @And("{word} go to Product details {string}")
    public void go_to_product_details(String role, String name) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CatalogForm.PRODUCT_CARD(name)),
                Click.on(CatalogForm.PRODUCT_CARD(name))
        );
    }

    @And("{word} go to Favorites {string}")
    public void go_to_favorites(String role, String name) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(DashBoardForm.FAVORITE_BUTTON)
        );
    }
}
