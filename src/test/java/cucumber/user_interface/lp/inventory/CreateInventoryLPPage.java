package cucumber.user_interface.lp.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CreateInventoryLPPage {
    /**
     * Create new inventory
     */
    public static Target CREATE_NEW_INVENTORY_HEADER = Target.the("Create new inventory header")
            .located(By.xpath("//h1[text()='Create new Inventory']"));

    public static Target NEW_INVENTORY_BUTTON = Target.the("New inventory button")
            .located(By.xpath("//button//span[text()='New Inventory']"));

    public static Target IMAGE = Target.the("IMAGE")
            .located(By.xpath("(//div[@class='file-input']//input[@type='file'])[last()]"));

    public static Target IMAGE_DES = Target.the("IMAGE")
            .located(By.xpath("(//div[@class='info']//input[@type='text'])[last()]"));

    public static Target D_TEXTBOX_CREATENEW(String title) {
        return Target.the("Textbox " + title + " of create new inventory")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target D_LINK(String value) {
        return Target.the("Link " + value)
                .locatedBy("//a[text()='" + value + "']");
    }


}
