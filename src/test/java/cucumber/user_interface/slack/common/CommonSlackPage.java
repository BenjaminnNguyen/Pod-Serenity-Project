package cucumber.user_interface.slack.common;

import net.serenitybdd.screenplay.targets.Target;

public class CommonSlackPage {
    /**
     * Search header
     */
    public static final Target HEADER_SEARCH = Target.the("Header search")
            .locatedBy("(//button[contains(@class,'top_nav__search')])[1]");

    public static final Target SEARCH_TEXTBOX_IN_POPUP = Target.the("Search textbox in popup")
            .locatedBy("//div[@data-qa='focusable_search_input']//div[@aria-label='Search']");

}
