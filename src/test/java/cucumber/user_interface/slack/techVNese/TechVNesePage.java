package cucumber.user_interface.slack.techVNese;

import net.serenitybdd.screenplay.targets.Target;

public class TechVNesePage {

    public static final Target TITLE_MESSAGE = Target.the("Title message")
            .locatedBy("//span[text()='New inbound inventory processed!']");

    public static final Target BODY_MESSAGE = Target.the("Body message")
            .locatedBy("(//div[@class='c-search_message__content']//span[@dir='auto'])[2]");


}
