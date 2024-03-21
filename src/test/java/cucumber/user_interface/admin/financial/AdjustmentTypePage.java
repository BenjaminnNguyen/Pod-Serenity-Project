package cucumber.user_interface.admin.financial;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AdjustmentTypePage {

    public static Target CREATE_ADJUSTMENT_TYPE_BUTTON = Target.the("Create adjustment type button")
            .located(By.xpath(""));


    /**
     * Popup create adjustment type
     */
    public static Target NAME_CREATE_TEXTBOX = Target.the("Name textbox in create popup")
            .located(By.xpath("//div[@role='dialog']//input"));

    public static Target NAME_CREATE_ERROR = Target.the("Name error in create popup")
            .located(By.xpath("//label[text()='Name']/following-sibling::div/div[@class='el-form-item__error']"));

    /**
     * Adjustment type list
     */

    public static Target NAME_IN_RESULT(String name) {
        return Target.the("Name textbox in result")
                .located(By.xpath("//td[contains(@class,'name')]//*[text()='" + name + "']"));
    }

    public static Target DELETE_IN_RESULT(String name) {
        return Target.the("Delete button in result")
                .located(By.xpath("(//*[text()='" + name + "']/ancestor::td/following-sibling::td//button)[2]"));
    }

    public static Target NEXT_TAB_BUTTON = Target.the("Next tab button")
            .located(By.xpath("(//button[@class='btn-next'])[1]"));


    /**
     * Adjustment type detail
     */

    public static Target TITLE_POPUP_DETAIL(String name) {
        return Target.the("Title adjustment type in popup detail")
                .located(By.xpath("//div[@role='dialog']//span[contains(text(),'" + name + "')]"));
    }

    public static Target MESSAGE_UPDATE = Target.the("Message update")
            .located(By.xpath("//h2[text()='Master data updated']"));

}
