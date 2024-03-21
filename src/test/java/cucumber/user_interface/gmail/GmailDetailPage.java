package cucumber.user_interface.gmail;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class GmailDetailPage {

    /**
     * Brand Referral
     */

    public static final Target PRICE_TOTAL = Target.the("Payment confirmation header")
            .located(By.xpath("//td[text()='Total']/following-sibling::td/span"));

    public static final Target CLEAR_DOT = Target.the("Button clear bot in email detail")
            .located(By.xpath("//img[contains(@src,'mail/images/cleardot.gif')]"));

    public static final Target HEADER_DETAIL = Target.the("Header detail")
            .located(By.xpath("//h1"));

    public static final Target SHOW_TRIMMED_CONTENT = Target.the("Show trimmed content")
            .located(By.xpath("//div[@aria-label='Show trimmed content' and @role='button']"));

    public static Target BRAND_REFERRAL_CONTENT(String content) {
        return Target.the("Brand referral content")
                .located(By.xpath("(//h2)[last()]"));
    }

}
