package cucumber.tasks.common;

import cucumber.singleton.GVs;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.HomePageForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.matchers.WebElementStateMatchers;
import net.serenitybdd.screenplay.questions.WebElementQuestion;
import net.serenitybdd.screenplay.targets.Target;

import net.serenitybdd.screenplay.waits.WaitUntil;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyEnabled;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.stateOf;

public class NavigateToSideBar {

    public static Task navigate(String pageTitle, Target parentMenu, Target targetMenu) {
        return Task.where("Truy cập vào trang " + pageTitle + " qua sidebar",
                CommonWaitUntil.isVisible(parentMenu),
                Check.whether(WebElementQuestion.the(parentMenu), WebElementStateMatchers.isVisible())
                        .otherwise(Scroll.to(parentMenu)),
                Check.whether(WebElementQuestion.stateOf(targetMenu), WebElementStateMatchers.isVisible()).andIfSo(
                        Scroll.to(targetMenu),
                        Click.on(targetMenu)
                ).otherwise(
                        Click.on(parentMenu),
                        Scroll.to(targetMenu),
                        Check.whether(stateOf(targetMenu), isCurrentlyEnabled()),
                        Click.on(targetMenu)
                ),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task navigate(Target targetMenu) {
        return Task.where("Truy cập vào trang " + targetMenu + " qua sidebar",
                CommonWaitUntil.isVisible(targetMenu),
                Click.on(targetMenu),
                WaitUntil.the(CommonAdminForm.LOADING_SPINNER, WebElementStateMatchers.isNotVisible()).forNoMoreThan(GVs.HTTP_TIMEOUT).seconds(),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task navigateFlowSpace(Target targetMenu) {
        return Task.where("Truy cập vào trang " + targetMenu + " qua sidebar",
                CommonWaitUntil.isVisible(targetMenu),
                Click.on(targetMenu),
                WaitUntil.the(CommonAdminForm.LOADING_SPINNER, WebElementStateMatchers.isNotVisible()).forNoMoreThan(GVs.HTTP_TIMEOUT).seconds(),
                WindowTask.threadSleep(1000)
        );
    }
}
