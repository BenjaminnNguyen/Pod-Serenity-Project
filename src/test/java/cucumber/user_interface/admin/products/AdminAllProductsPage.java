package cucumber.user_interface.admin.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AdminAllProductsPage {

    public static Target SHOW_FILTERS = Target.the("Show Filters")
            .located(By.xpath("//span[normalize-space()='Show filters']"));

    public static Target ft_SEARCH_TERM = Target.the("Search term field")
            .located(By.xpath("//div[@data-field='q[search_term]']//input"));

    public static Target ft_PRODUCT_STATE = Target.the("The Product state field")
            .located(By.xpath("//div[@data-field='q[state]']//input"));

    public static Target ALL_PRODUCT_STATE = Target.the("-")
            .located(By.cssSelector("div.popper-product-state-select li.el-select-dropdown__item:nth-child(1)"));

    public static Target ACTIVE_PRODUCT_STATE = Target.the("Active state")
            .located(By.cssSelector("div.popper-product-state-select li.el-select-dropdown__item:nth-child(2)"));

    public static Target INACTIVE_PRODUCT_STATE = Target.the("Inactive state")
            .located(By.cssSelector("div.popper-product-state-select li.el-select-dropdown__item:nth-child(3)"));

    public static Target ft_BRAND = Target.the("The Brand field")
            .located(By.xpath("//div[@data-field=\"q[brand_id]\"]//input"));

    public static Target THE_FIRST_SUGGESTION_OF_BRAND = Target.the("The first suggestion of brand")
            .located(By.cssSelector("div.popper-brand-select li:nth-child(2)"));

    public static Target ft_VENDOR_COMPANY = Target.the("The Vendor company field")
            .located(By.xpath("//div[@data-field=\"q[vendor_company_id]\"]//input"));

    public static Target THE_FIRST_SUGGESTION_OF_THE_VENDOR_COMPANY = Target.the("The first suggestion of the vendor company")
            .located(By.cssSelector("div.popper-vendor-company-select li:nth-child(2)"));

    public static Target ft_PRODUCT_TYPE = Target.the("The Product type field")
            .located(By.xpath("//div[@data-field=\"q[product_type_id]\"]//input"));

    public static Target THE_FIRST_SUGGESTION_OF_THE_PRODUCT_TYPE = Target.the("The first suggestion of Product Type")
            .located(By.cssSelector("div.popper-product-type-select ul li:not(li[style=\"display: none;\"])"));

    public static Target CHAI_TEA_PRODUCT_TYPE = Target.the("Chai Tea Product Type")
            .located(By.cssSelector("div.popper-product-type-select li:nth-child(11)"));

    public static Target ft_PACKING_SIZE = Target.the("The Packing Size")
            .located(By.xpath("//div[@data-field=\"q[package_size_id]\"]//input"));

    public static Target THE_FIRST_SUGGESTION_OF_THE_PACKAGE_SIZE = Target.the("The first package sizwe on suggestion")
            .located(By.cssSelector("div.popper-product-package-size-select ul li:not([style])"));

    public static Target THE_FIRST_SUGGESTION_OF_THE_AVAILABLE_IN = Target.the("The first package sizwe on suggestion")
            .located(By.cssSelector("div.el-select-dropdown.el-popper.popper-region-select ul li:not(li[style=\"display: none;\"])"));

    public static Target INDIVIDUAL_SERVING = Target.the("Individual serving packing")
            .located(By.cssSelector("div.popper-product-package-size-select li:nth-child(2)"));

    public static Target MULTIPLE_SERVING = Target.the("Multiple serving packing")
            .located(By.cssSelector("div.popper-product-package-size-select li:nth-child(3)"));

    public static Target BULK = Target.the("Bulk packing")
            .located(By.cssSelector("div.popper-product-package-size-select li:nth-child(4)"));

    public static Target ft_SAMPLEABLE = Target.the("Sampleable field")
            .located(By.xpath("//div[@data-field=\"q[sampleable]\"]//input"));

    public static Target YES_SAMPLEABLE = Target.the("Yes sampleable")
            .located(By.cssSelector("div.popper-q-sampleable li:nth-child(2)"));

    public static Target NOT_SAMPLEABLE = Target.the("Not Sampleable")
            .located(By.cssSelector("div.popper-q-sampleable li:nth-child(3)"));

    public static Target ft_AVAILABLE_IN = Target.the("The Available In field")
            .located(By.xpath("//div[@data-field=\"q[region_id]\"]//input"));

    public static Target NEW_YORK_REGION = Target.the("The New York region")
            .located(By.xpath("//span[text()='New York Express']"));

    public static Target SAN_FRANCISCO_REGION = Target.the("The San Francisco region")
            .located(By.xpath("//span[text()='North California Express']"));

    public static Target LOS_ANGELES_REGION = Target.the("Los Angeles region")
            .located(By.xpath("//span[text()='South California Express']"));

    public static Target ft_SKU = Target.the("The SKU field")
            .located(By.xpath("//div[@data-field='q[product_variant_ids]']//input"));
    public static Target ft_TAGS = Target.the("The Tags field")
            .located(By.xpath("//div[@data-field=\"q[tag_ids][]\"]//input"));

    public static Target THE_FIRST_TAGS_ON_SUGGESTION = Target.the("The First Tags on suggestion")
            .located(By.cssSelector("div.popper-product-tag-select ul li:not([style='display: none;'])"));

    public static Target ADMIN_TAG_1 = Target.the("Admin tag 1")
            .located(By.cssSelector("div.popper-product-tag-select li:nth-child(3)"));

    public static Target ALL_PRIVATE_TARGET = Target.the("All private target")
            .located(By.cssSelector("div.popper-product-tag-select li:nth-child(3)"));

    public static Target SEARCH_BUTTON = Target.the("Search button")
            .located(By.cssSelector("button.search"));

    public static Target RESET_BUTTON = Target.the("Reset button")
            .located(By.cssSelector("button.reset"));

    public static Target PRODUCT_NAME = Target.the("Product Name")
            .located(By.cssSelector("div.el-table__body-wrapper .el-table__row .name a.name"));

    public static Target PRODUCT_CARD = Target.the("Product Card")
            .located(By.cssSelector("div.el-table__body-wrapper .el-table__row .name .info"));

    public static Target DELETE_BUTTON = Target.the("Remove button")
            .located(By.cssSelector("div.el-table__body-wrapper .el-table__row button.el-button:nth-child(2)"));

    public static Target DELETE_BUTTON(String name) {
        return Target.the("Remove button")
                .located(By.xpath("//a[normalize-space()='" + name + "']/ancestor::tr//td[contains(@class,'action')]//button[2]"));

    }

    public static Target DELETE_BUTTON_IN_DETAIL = Target.the("Delete button in detail")
            .locatedBy("//div[@class='page-header']//button[@class='el-button el-button--danger']");

    public static Target I_UNDERSTAND_AND_CONTINUE_BUTTON = Target.the("I Understand and continue button")
            .located(By.cssSelector("div.el-message-box .el-message-box__btns .el-button--primary"));

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));
    public static Target CREATE_BUTTON = Target.the("Create button")
            .located(By.xpath("//button[@type='button']//span//span[contains(text(),'Create')]"));
    public static Target NO_DATA = Target.the("No data")
            .located(By.xpath("//span[@class='el-table__empty-text']"));

    public static Target DYNAMIC_TABLE(String prdName, String col) {
        return Target.the("").locatedBy("//*[contains(text(),'" + prdName + "')]/ancestor::tr//td[contains(@class,'" + col + "')]/div");
    }

    public static Target PRODUCT_NAME(String prdName) {
        return Target.the("").locatedBy("//*[contains(text(),'" + prdName + "')]");
    }

    public static Target TAG_NAME_LIST_PRODUCT(int i) {
        return Target.the("")
                .locatedBy("(//span[@class='product-tag-stamp']/span[@class='name'])[" + i + "]");
    }

    public static Target TAG_EXPIRE_LIST_PRODUCT(int i) {
        return Target.the("")
                .locatedBy("(//span[@class='product-tag-stamp']/span[@class='expiry_date'])[" + i + "]");
    }

}
