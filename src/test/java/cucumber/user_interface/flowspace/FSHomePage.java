package cucumber.user_interface.flowspace;

import net.serenitybdd.screenplay.targets.Target;

public class FSHomePage {

    /**
     * Sidebar
     */
    public static Target SIDEBAR_MENU(String title) {
        return Target.the("Menu sidebar " + title)
                .locatedBy("//ul[@class='nav nav-stacked']//a[@aria-label='" + title + "']");
    }


}
