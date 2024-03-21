package cucumber.user_interface.admin;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class VendorPageForm {

    public static Target SEARCH_BUTTON = Target.the("Search button")
            .located(By.cssSelector("button.search"));

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target SHOW_FILTER = Target.the("Show Filters")
            .located(By.cssSelector("div.search-bar .toggler"));

    public static Target ft_FULL_NAME = Target.the("The Full Name field")
            .located(By.xpath("//div[@data-field='q[full_name]']//input"));

    public static Target ft_EMAIL = Target.the("The Email field")
            .located(By.xpath("//div[@data-field='q[email]']//input"));

    public static Target ft_VENDOR_COMPANY = Target.the("The Vendor Company field")
            .located(By.xpath("//div[@data-field='q[vendor_company_id]']//input"));

    public static Target THE_FIRST_SUGGESTION_OF_VENDOR_COMPANY = Target.the("The first suggestion of vendor company")
            .located(By.cssSelector("div.popper-vendor-company-select li:nth-child(2)"));

    public static Target ft_BRAND = Target.the("The Brand field")
            .located(By.xpath("//div[@data-field='q[brand_id]']//input"));

    public static Target THE_FIRST_SUGGESTION_OF_BRAND = Target.the("The first suggestion of brand")
            .located(By.cssSelector("div.popper-brand-select li:nth-child(2)"));

    public static Target ft_ADDRESS_CITY = Target.the("The Address City field")
            .located(By.xpath("//div[@data-field='q[vendor_company_address_city]']//input"));

    public static Target ft_REGION = Target.the("The Region field")
            .located(By.xpath("//div[@data-field='region_id']//input"));

    public static Target NEW_YORK_REGION = Target.the("NEW YORK REGION")
            .located(By.xpath("//span[text()='New York Express']"));

    public static Target SAN_FRANCISCO_REGION = Target.the("San Francisco region")
            .located(By.xpath("//span[text()='South California Express']"));

    public static Target CHICAGO_REGION = Target.the("Chicago region")
            .located(By.xpath("//span[text()='Chicagoland Express']"));

    public static Target LOS_ANGELES_REGION = Target.the("The Los Angeles Region")
            .located(By.xpath("//span[text()='North California Express']"));

    public static Target ft_STATE = Target.the("The Address State field")
            .located(By.xpath("//div[@data-field='q[vendor_company_address_address_state_id]']//input"));

    public static Target NEW_YORK_STATE = Target.the("The New York state")
            .located(By.cssSelector("div.popper-address-state-select li:nth-child(34)"));

    public static Target CREATE_VENDOR_ACCOUNT_BUTTON = Target.the("The Create vendor account button")
            .located(By.cssSelector("div.page-header .el-button--primary"));

    public static Target popup_FIRST_NAME = Target.the("The First Name field")
            .located(By.cssSelector("div.first-name.el-input input"));

    public static Target popup_LAST_NAME = Target.the("The Last Name field")
            .located(By.cssSelector("div.last-name.el-input input"));

    public static Target popup_EMAIL = Target.the("The Email field")
            .located(By.cssSelector("div.email.el-input input"));

    public static Target popup_COMPANY = Target.the("The Company field")
            .located(By.cssSelector("div.vendor-company-select input"));

    public static Target THE_FIRST_COMPANY_ON_THE_SUGGESTION = Target.the("The first company on the suggestion")
            .located(By.cssSelector("div.popper-vendor-company-select li:first-child"));

    public static Target popup_PASSWORD = Target.the("The Password field")
            .located(By.cssSelector("div.password.el-input input"));

    public static Target popup_STREET = Target.the("The street field")
            .located(By.cssSelector("div.street-1.el-input input"));

    public static Target popup_CITY = Target.the("The City field")
            .located(By.cssSelector("div.city.el-input input"));

    public static Target popup_STATE = Target.the("The State field")
            .located(By.cssSelector("div.state.address-state-select input"));

    public static Target popup_NEW_YORK = Target.the("New York region")
            .located(By.cssSelector("div.popper-address-state-select li:nth-child(33)"));

    public static Target popup_ZIP = Target.the("The Zip field")
            .located(By.cssSelector("div.zip.el-input input"));

    public static Target popup_CREATE_BUTTON = Target.the("The Create button on the popup")
            .located(By.cssSelector("button.el-button--submit"));

    // table
    public static Target DELETE_VENDOR_BUTTON = Target.the("The delete vendor button")
            .located(By.cssSelector("table.el-table__body tr:first-child .actions .cell >button"));

    public static Target UNDERSTAND_AND_CONTINUE_REMOVE = Target.the("The Understand & Continue")
            .located(By.cssSelector("div.el-message-box button.el-button--primary"));

    public static Target ft_RESET = Target.the("Reset button")
            .located(By.cssSelector("button.reset.el-button"));

    /**
     * Table Result
     */

    public static Target FULL_NAME_RESULT(String name) {
        return Target.the("FullName " + name)
                .located(By.xpath("//table//a//span[text()='" + name + "']"));
    }
}
