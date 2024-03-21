package cucumber.user_interface.admin.LP;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class LPCompaniesPage {

    public static Target SHOW_FILTER = Target.the("Show Filters")
            .located(By.xpath("//button/span[text()='Show filters']"));

    public static Target REFRESH_PAGE_BUTTON = Target.the("Refresh page")
            .located(By.xpath("(//header//div[@class='actions']//button)[1]"));

    public static Target DYNAMIC_SEARCH_TEXTBOX(String fieldName) {
        return Target.the("Textbox " + fieldName)
                .located(By.xpath("//div[contains(@data-field,'q[" + fieldName + "]')]//input"));
    }

    public static Target PREPAY_ITEM_DROPDOWN(String value) {
        return Target.the("Item in prepayment dropdown")
                .located(By.xpath("//div[contains(@class,'pay-early')]//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target ACH_ITEM_DROPDOWN(String value) {
        return Target.the("Item in ach dropdown")
                .located(By.xpath("//div[contains(@class,'ach')]//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    /**
     * Result table
     */
    public static Target D_RESULT(String value, int i) {
        return Target.the(value + " in result table")
                .located(By.xpath("(//td[contains(@class,'" + value + "')])[" + i + "]"));
    }

    public static Target DELETE_LP_COMPANY(String name) {
        return Target.the(name + " delete")
                .located(By.xpath("(//span[contains(text(),'" + name + "')]/ancestor::td/following-sibling::td//button)[2]"));
    }

    public static Target DETAIL_LP_COMPANY(String name) {
        return Target.the(name + " DETAIL_LP_COMPANY")
                .located(By.xpath("(//span[contains(text(),'" + name + "')]/ancestor::td/following-sibling::td//button)[1]"));
    }

    public static Target DETAIL_LP_COMPANY_INFO(String field) {
        return Target.the(field)
                .located(By.xpath("//dt[normalize-space()='" + field + "']/following-sibling::dd[1]//span"));
    }

    public static Target LP_COMPANY_DOCS(int i) {
        return Target.the("LP_COMPANY_DOCS")
                .located(By.xpath("(//input[@type=\"file\"])[" + i + "]"));
    }

    public static Target LP_COMPANY_DOCS_INFO(int i) {
        return Target.the("LP_COMPANY_DOCS")
                .located(By.xpath("(//label[@class=\"preview\"])[" + i + "]"));
    }

    public static Target LP_COMPANY_DOCS(String field, int i) {
        return Target.the("LP_COMPANY_DOCS")
                .locatedBy("(//label[normalize-space()='" + field + "']/following-sibling::div//input)[" + i + "]");
    }

    public static Target LP_COMPANY_DOCS_DOWNLOAD(String field) {
        return Target.the("LP_COMPANY_DOCS")
                .locatedBy("//div[contains(text(),'" + field + "')]/ancestor::div[@class='item']//span[text()='Download']");
    }

    public static Target LP_SECTION_EMAIL(String lp) {
        return Target.the("LP_COMPANY_DOCS")
                .locatedBy("//div[normalize-space()='Logistics partners']/following-sibling::section//a[contains(text(),'" + lp + "')]/ancestor::td/following-sibling::td[1]");
    }
    public static Target LP_SECTION_CONTACT(String lp) {
        return Target.the("LP_COMPANY_DOCS")
                .locatedBy("//div[normalize-space()='Logistics partners']/following-sibling::section//a[contains(text(),'" + lp + "')]/ancestor::td/following-sibling::td[2]");
    }

    public static Target REMOVE_LP_COMPANY_DOCS = Target.the("REMOVE_LP_COMPANY_DOCS")
            .located(By.xpath("//section[@class='documents']//span[text()='Remove']"));

}
