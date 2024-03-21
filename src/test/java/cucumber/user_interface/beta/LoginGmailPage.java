package cucumber.user_interface.beta;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.screenplay.targets.Target;
import net.thucydides.core.annotations.DefaultUrl;
import org.openqa.selenium.By;

@DefaultUrl("https://mail.google.com/mail")
public class LoginGmailPage extends PageObject {

    public static final Target USERNAME_FIELD = Target.the("'Tên đăng nhập'").locatedBy("//input[@type='email']");

    public static final Target PASSWORD_FIELD = Target.the("'Mật khẩu'").locatedBy("//input[@type='password']");

    public static final Target BUTTON_NEXT = Target.the("'Next'").locatedBy("//*[contains(text(),'Next')]");

    public static final Target GMAIL_TITLE = Target.the("GMAIL").located(By.cssSelector("a[class='gb_ke gb_vc gb_ie']"));

    public static final Target BUTTON_REFRESH = Target.the("Refesh").located(By.xpath("//div[@aria-label='Refresh' or @title='Refresh']"));

    public static final Target SEARCH_BOX = Target.the("Search box").located(By.xpath("//input[@placeholder='Search in mail']|//input[@placeholder='Search all conversations']"));

    public static final Target NO_EMAIL = Target.the("no email").located(By.xpath("//td[@class='TC']"));

    public static final Target EMAIL_CONTENT = Target.the("content of email").located(By.xpath("//div[@role='main']//table[@role='presentation']//div[@role='listitem'][last()]|(//div[@role='main']//table[@role='presentation']//div[@role='listitem'])[last()-1]"));

    public static final Target EMAIL_CONTENT1(String email) {
        return Target.the("content of email").located(By.xpath("(//div[@role='main']//table[@role='presentation']//span[text()='" + email + "']/ancestor::table/parent::div/following-sibling::div)[last()]"));
    }

    public static final Target SHOW_TRIMMED_CONTENT = Target.the("show trimmed content").located(By.xpath("(//img//parent::div[@aria-label='Show trimmed content' and @aria-expanded='false'])[last()]"));

    public static final Target EXPAND_EMAIL_CONTENT = Target.the("content of email").located(By.xpath("//div[@role='main']//table[@role='presentation']//div[@role='listitem' and @style][last()] //div[@role='button' and @aria-expanded = 'false' and not(@data-tooltip='More')]"));
    public static final Target EXPAND_EMAIL_CONTENT2 = Target.the("content of email").located(By.xpath("//div[@data-tooltip='Show trimmed content']"));
    //div[@role='main']//table[@role="presentation"]//div[@role='listitem' and @style][last()] //div[@role='button' and @aria-expanded and not(@data-tooltip='More')]
    public static final Target FIRST_EMAIL = Target.the("content of email").located(By.xpath("//div[@role='main']//tbody/tr"));

    public static Target EMAIL_WITH_TITLE(String title) {
        return Target.the("Email with title").located(By.xpath("//table//span[text()='" + title + "']"));
    }

    public static Target EMAIL_WITH_TITLE1(String title) {
//        return Target.the("Email with title").located(By.xpath("(//span[text()='Pod Foods Co']/parent::span/following-sibling::span[text()='" + title + "']//ancestor::td)[last()]"));
        return Target.the("Email with title").located(By.xpath("(//span/following-sibling::span[text()='" + title + "']//ancestor::td)[last()]"));
    }


    public static Target email(String title) {
        Target email = Target.the("").locatedBy("//tbody//tr//div[@role='link']//span[normalize-space()='" + title + "']/span");
        return email;
    }

    public static Target titleDetailEmail(String title) {
        Target email = Target.the("").locatedBy("//table[@role='presentation']//*[text()='" + title + "']");
        return email;
    }

    public static Target GG_STACKOVER = Target.the("'Button Log in'")
            .locatedBy("//button[@data-provider='google']");

    public static final Target EMAIL_CONTENT2 = Target.the("content of email")
            .located(By.xpath("(//div[@role='main'] //div[@role='list'] //div[@role='listitem'])[last()]"));

    public static final Target SHOW_ITEM_ICON = Target.the("Show item icon")
            .located(By.xpath("(//div[@role='main'] //div[@role='list'] //div[@role='listitem'])[last()]//div[@data-tooltip='Show trimmed content']"));


    public static Target EMAIL_CONTENT(String title) {
        return Target.the("Email with content " + title).located(By.xpath("//table[@role='presentation']//*[contains(text(),\"" + title + "\")]"));
    }

    public static final Target INBOX_BUTTON = Target.the("Inbox button").locatedBy("//a[text()='Inbox']");
    public static final Target REFESH_BUTTON = Target.the("Refresh button").locatedBy("//div[@aria-label='Refresh']");

    public static Target D_MAIL_INVENTORY(String title) {
        Target email = Target.the("D_MAIL_INVENTORY " + title).locatedBy("//td[text()=\"" + title + "\"]/following-sibling::td");
        return email;
    }

    public static final Target EXPAND_ALL_EMAIL = Target.the("Expand all email")
            .locatedBy("(//table//button[@aria-label='Expand all'])[1]");

}
