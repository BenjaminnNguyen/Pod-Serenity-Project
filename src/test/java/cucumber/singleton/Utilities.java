package cucumber.singleton;

import net.thucydides.core.webdriver.ThucydidesWebDriverSupport;
import net.thucydides.core.webdriver.WebDriverFacade;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;

import java.util.Base64;

public class Utilities {

    public static String PasswordUnmasking(String password) {
        byte[] decodedBytes = Base64.getDecoder().decode(password);
        String decodedString = new String(decodedBytes);
        return decodedString;
    }
}
