package cucumber.tasks.admin.inventory;

import cucumber.tasks.common.WindowTask;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Interaction;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.targets.Target;
import net.thucydides.core.annotations.Step;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;

public class ChangeStatusIncomingInventory implements Interaction {

    @Step("{0} select the submitted status")
    @Override
    public <T extends Actor> void performAs(T actor) {
        WebDriver driver = BrowseTheWeb.as(actor).getDriver();
        JavascriptExecutor js = (JavascriptExecutor) driver;

        String id = js
                .executeScript("return document.querySelector('div.status-tag.incoming-status').parentElement.getAttribute('aria-describedby')")
                .toString();

        Target SUBMITTED = Target.the("Submitted")
                .located(By.cssSelector("div.popper-inventory-status-select ul li:nth-child(2)"));

        Target UPDATE_BUTTON = Target.the("Update button")
                .located(By.cssSelector("#"+id+" .el-button--primary"));

        actor.attemptsTo(
                Click.on(SUBMITTED),
                Click.on(UPDATE_BUTTON)
        );
    }

    public static Interaction as() {
        return Tasks.instrumented(ChangeStatusIncomingInventory.class);
    }
}
