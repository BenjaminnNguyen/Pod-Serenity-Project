//package cucumber.actions;
//
//import net.serenitybdd.core.environment.EnvironmentSpecificConfiguration;
//import net.serenitybdd.screenplay.Actor;
//import net.serenitybdd.screenplay.Interaction;
//import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
//import net.thucydides.core.guice.Injectors;
//import net.thucydides.core.util.EnvironmentVariables;
//
//public class ChangeHrefLocation implements Interaction{
//	String url;
//	public ChangeHrefLocation(String url) {
//		this.url = url;
//	}
//
//    @Override
//    public <T extends Actor> void performAs(T actor) {
//        BrowseTheWeb.as(actor).openUrl(this.url);
//    }
//
//    public static ChangeHrefLocation navigateTo(String url) {
//    	String webBaseUrl =  EnvironmentSpecificConfiguration.from(Injectors.getInjector().getInstance(EnvironmentVariables.class)).getProperty("webdriver.base.url");
//        return new ChangeHrefLocation(webBaseUrl + url);
//    }
//}
