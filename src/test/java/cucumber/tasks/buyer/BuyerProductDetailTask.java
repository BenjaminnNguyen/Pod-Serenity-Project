package cucumber.tasks.buyer;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Buyer.products.BuyerProductDetailPage;
import cucumber.user_interface.beta.HomePageForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;

public class BuyerProductDetailTask {

    public static Task checkAddToCardNotVisible() {
        return Task.where("Add to card is not visible ",
                CommonQuestions.AskForElementIsDisplay(BuyerProductDetailPage.ADD_TO_CART_BUTTON, false)
        );
    }
}
