package cucumber.user_interface.admin.Brand;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class BrandsPageForm {

    public static Target SHOW_FILTER = Target.the("Show Filters")
            .located(By.cssSelector("div.search-bar .toggler"));

    public static Target ft_NAME_FIELD = Target.the("Name field")
            .located(By.xpath("//div[@data-field='q[search_term]']//input"));

    public static Target ft_VENDOR_COMPANY = Target.the("The Vendor Company field")
            .located(By.xpath("//div[@data-field='q[vendor_company_id]']//input"));

    public static Target ft_THE_FIRST_SUGGESTION_OF_VENDOR_COMPANY = Target.the("The first suggestion of vendor company")
            .located(By.cssSelector("div.popper-vendor-company-select li:nth-child(2)"));

    public static Target ft_STATE_OF_BRAND = Target.the("The state of brand")
            .located(By.xpath("//div[@data-field='q[state]']//input"));

    public static Target ALL_STATE = Target.the("All State of brand")
            .located(By.cssSelector("div.popper-q-state li:nth-child(1)"));

    public static Target ACTIVE_STATE = Target.the("The Active state")
            .located(By.cssSelector("div.popper-q-state li:nth-child(3)"));

    public static Target INACTIVE_STATE = Target.the("Inactive State")
            .located(By.cssSelector("div.popper-q-state li:nth-child(2)"));

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
            .located(By.cssSelector("div.page-header .el-button--primary"));

    public static Target NAME_FIELD = Target.the("The name field")
            .located(By.cssSelector("div.el-dialog .name input"));

    public static Target DESCRIPTION_FIELD = Target.the("The description field")
            .located(By.cssSelector("div.el-dialog .description input"));

    public static Target MICRO_DESCRIPTION_FIELD = Target.the("The description field")
            .located(By.cssSelector("div.el-dialog .micro-description input"));

    public static Target CITY_FIELD = Target.the("The city field")
            .located(By.cssSelector("div.el-dialog .city input"));

    public static Target STATE_FIELD = Target.the("The state field")
            .located(By.cssSelector("div.el-dialog .state input"));

    public static Target THE_FIRST_SUGGESTION_OF_STATE = Target.the("The first suggestion of state")
            .located(By.cssSelector("div.popper-address-state-select .el-select-dropdown__item:nth-child(1) span"));

    public static Target VENDOR_COMPANY_FIELD = Target.the("Vendor Company field")
            .located(By.cssSelector("div.el-dialog .vendor_company input"));

    public static Target THE_FIRST_SUGGESTION_OF_VENDOR_COMPANY = Target.the("The first suggestion of vendor company")
            .located(By.cssSelector("body >div.popper-vendor-company-select li.el-select-dropdown__item"));

    public static Target SUBMIT_BUTTON = Target.the("Submit button")
            .located(By.cssSelector("div.el-dialog .el-button--submit"));
}
