package cucumber.user_interface.beta;

import net.serenitybdd.screenplay.targets.Target;

public class DashBoardForm {

    public static final Target ORDER_GUIDE = Target.the("'Order guide'")
            .locatedBy("//a[@title='Order guide']");

    public static final Target FAVORITE_BUTTON = Target.the("'Favorite button'")
            .locatedBy("//a[@title='Favorites']");


    public static final Target DASHBOARD_BUTTON = Target.the("Dashboard button")
            .locatedBy("//span[text()='Dashboard']");

    public static Target LOADING_ICON(String value) {
        return Target.the("Loading " + value)
                .locatedBy("//div[text()='" + value + "']");
    }

    public static final Target SETTINGS_BUTTON = Target.the("Settings button")
            .locatedBy("//a[@href='/buyers/settings']");

    public static Target SIDEBAR_BUTTON(String value) {
        return Target.the("Button " + value)
                .locatedBy("//a//span[text()='" + value + "']");
    }

}
