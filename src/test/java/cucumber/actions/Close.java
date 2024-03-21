package cucumber.actions;

import net.serenitybdd.markers.IsSilent;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Interaction;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;

public class Close implements Interaction, IsSilent {
    @Override
    public <T extends Actor> void performAs(T actor) {
        BrowseTheWeb.as(actor).getDriver().close();
    }

    public static Close theBrowserSession() {
        return new Close();
    }
}
