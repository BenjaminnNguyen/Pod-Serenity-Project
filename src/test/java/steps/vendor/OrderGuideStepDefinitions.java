package steps.vendor;

import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.buyer.HandleOrderGuide;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Buyer.orders.OrderGuideForm;
import cucumber.user_interface.beta.DashBoardForm;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Scroll;

import static cucumber.user_interface.beta.Vendor.products.VendorProductDetailPage.ARROW_ICON;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class OrderGuideStepDefinitions {
    @And("{word} search in {string} by name {string}")
    public void search_product_in_order_guide(String role, String typeOrder, String name) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(DashBoardForm.ORDER_GUIDE),
                HandleOrderGuide.search(typeOrder, name),
                CommonWaitUntil.isVisible(OrderGuideForm.PRODUCT_IN_RESULT_SEARCH)
        );
    }

    @And("Check icon arrow {word} in {string}")
    public void check_icon_arrow(String typeArrow, String pageName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(ARROW_ICON(typeArrow)),
                Scroll.to(ARROW_ICON(typeArrow))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(ARROW_ICON(typeArrow)))
        );
    }
    @And("Add cart sku {string} from order guide")
    public void add_Cart(String sku) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrderGuide.addToCart(sku)
        );
    }
}
