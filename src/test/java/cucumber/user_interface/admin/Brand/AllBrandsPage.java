package cucumber.user_interface.admin.Brand;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AllBrandsPage {

    public static Target SHOW_FILTER = Target.the("Show Filters")
            .located(By.cssSelector("div.search-bar .toggler"));

    public static Target ft_NAME_FIELD = Target.the("Name field")
            .located(By.xpath("//div[@data-field='q[search_term]']//input"));

    public static Target ft_VENDOR_COMPANY = Target.the("The Vendor Company field")
            .located(By.xpath("//div[@data-field='q[vendor_company_id]']//input"));

    public static Target ft_STATE_OF_BRAND = Target.the("The state of brand")
            .located(By.xpath("//div[@data-field='q[state]']//input"));

    public static Target ALL_STATE = Target.the("All State of brand")
            .located(By.cssSelector("div.popper-q-state li:nth-child(1)"));

    public static Target D_SEARCH(String title) {
        return Target.the("Search by " + title)
                .located(By.xpath("//div[contains(@data-field,'q[" + title + "]')]//input"));
    }

    public static Target ft_MANAGED_BY = Target.the("The managed by field")
            .located(By.xpath("//div[@data-field='q[manager_id]']//input"));

    public static Target ft_THE_FIRST_SUGGESTION_OF_THE_MANAGED_BY = Target.the("the first suggestion of the managed by")
            .located(By.cssSelector("div.popper-admin-select li:nth-child(2)"));

    public static Target SEARCH_BUTTON = Target.the("Search button")
            .located(By.cssSelector("button.search"));

    public static Target BRAND_NAME = Target.the("Brand Name")
            .located(By.cssSelector(".el-table__body-wrapper tr.el-table__row a.name >span"));

    public static Target DELETE_BUTTON = Target.the("Delete Button")
            .located(By.cssSelector("div.el-table__fixed-body-wrapper tr.el-table__row td.actions .cell button:nth-child(2)"));

    public static Target I_UNDERSTAND_AND_CONTINUE_BUTTON = Target.the("I Understand and continue button")
            .located(By.cssSelector("div.el-message-box .el-message-box__btns .el-button--primary"));

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target ft_RESET = Target.the("Reset button")
            .located(By.cssSelector("button.reset.el-button"));
    // Create popup
    public static Target CREATE_BRAND_BUTTON = Target.the("The create brand button")
            .locatedBy("//div[@class='page-header']//button//span[text()='Create']");

    public static Target SUBMIT_BUTTON = Target.the("Submit button")
            .located(By.cssSelector("div.el-dialog .el-button--submit"));

    public static Target D_TEXTBOX_ERROR(String title) {
        return Target.the("Message error of textbox")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//div[contains(@class,'error')]");
    }

    public static Target D_CREATE_BRAND_TEXTBOX(String title) {
        return Target.the("Textbox " + title)
                .located(By.xpath("(//div[@role='dialog']//label[text()='" + title + "']/following-sibling::div//input)[1]"));
    }

    public static Target TAG_CREATE_VENDOR(String tag) {
        return Target.the("Tag after added in create vendor popup")
                .located(By.xpath("//div[@class='tag']//div[contains(@class,'tooltip') and text()='" + tag + "']"));
    }

    public static Target TAG_CREATE_VENDOR_DELETE_BUTTON(String tag) {
        return Target.the("Tag after delete button in create vendor popup")
                .located(By.xpath("//div[text()='" + tag + "']/parent::div/following-sibling::div/div[@class='actions']"));
    }


    /**
     * Table Result
     */

    public static Target BRAND_IN_RESULT(String brand) {
        return Target.the("Brand " + brand)
                .located(By.xpath("(//td[contains(@class,'name')]//span[text()='" + brand + "' or @data-original-text ='" + brand + "'])[1]"));
    }

    public static Target STATE_IN_RESULT(String brand) {
        return Target.the("The state of brand " + brand)
                .locatedBy("//span[text()='" + brand + "' or @data-original-text ='" + brand + "']/ancestor::td/preceding-sibling::td[contains(@class,'state')]//div[@class='status-tag']");
    }

    public static Target PRICING_IN_RESULT(String brand) {
        return Target.the("The pricing of brand " + brand)
                .locatedBy("//span[text()='" + brand + "' or @data-original-text ='" + brand + "']/ancestor::td/following-sibling::td[contains(@class,'pricing')]//strong");
    }


    public static Target ADDRESS_IN_RESULT(String brand) {
        return Target.the("The address of brand " + brand)
                .locatedBy("//span[text()='" + brand + "' or @data-original-text ='" + brand + "']/ancestor::td/following-sibling::td[contains(@class,'address')]//div");
    }

    public static Target MANAGED_BY_IN_RESULT(String brand) {
        return Target.the("Managed by of brand " + brand)
                .locatedBy("(//span[text()='" + brand + " 'or @data-original-text ='" + brand + "']/ancestor::td/following-sibling::td[contains(@class,'managed-by')]//span)[1]");
    }

    public static Target LAUNCHED_BY_IN_RESULT(String brand) {
        return Target.the("Launched by of brand " + brand)
                .locatedBy("(//span[text()='" + brand + "' or @data-original-text ='" + brand + "']/ancestor::td/following-sibling::td[contains(@class,'launched-by')]//span)[1]");
    }

    public static Target EDIT_BUTTON_IN_RESULT(String brand) {
        return Target.the("Edit button of brand " + brand)
                .locatedBy("(//span[text()='" + brand + "']/ancestor::td/following-sibling::td[contains(@class,'action')]//a/button)[2]");
    }

    public static Target DELETE_BUTTON_IN_RESULT(String brand) {
        return Target.the("Delete button of brand " + brand)
                .locatedBy("(//span[text()='" + brand + "']/ancestor::td/following-sibling::td[contains(@class,'action')]//button)[2]");
    }
}
