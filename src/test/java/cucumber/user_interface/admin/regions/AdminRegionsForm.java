package cucumber.user_interface.admin.regions;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;


public class AdminRegionsForm {

    public static Target REGION_ALERT = Target.the("Alert of regions")
            .locatedBy("//p[@class='el-alert__description']//span");

    /**
     * Parent Region
     */
    public static Target NAME_REGION(String region) {
        return Target.the("Name of region")
                .locatedBy("//td[contains(@class,'name')]//a[text()='" + region + "']");
    }

    public static Target TYPE_REGION(String region) {
        return Target.the("Type of region")
                .locatedBy("//a[text()='" + region + "']/ancestor::td/following-sibling::td[contains(@class,'type')]//div");
    }

    public static Target PRICING_REGION(String region) {
        return Target.the("Type of region")
                .locatedBy("//a[text()='" + region + "']/ancestor::td/following-sibling::td[contains(@class,'pricing')]//span");
    }

    public static Target ABBREVIATED_REGION(String region) {
        return Target.the("Abbreviated of region")
                .locatedBy("//a[text()='" + region + "']/ancestor::td/following-sibling::td[contains(@class,'abbreviated')]//div");
    }

    public static Target DESCRIPTION_REGION(String region) {
        return Target.the("Description of region")
                .locatedBy("//a[text()='" + region + "']/ancestor::td/following-sibling::td[contains(@class,'description ')]//div[@class='description']/span");
    }

    /**
     * Region - Detail - General Information
     */
    public static Target NAME_GENERAL = Target.the("General info name")
            .locatedBy("//span[@class='name']");

    public static Target DESCRIPTION_GENERAL = Target.the("General info description")
            .locatedBy("//span[@class='description']");

    public static Target ABBREVIATED_GENERAL = Target.the("General info abbreviated")
            .locatedBy("//span[@class='abbreviated']");

    public static Target POD_CONSIGNMENT_GENERAL = Target.the("General info delivery method Pod Consignment")
            .locatedBy("//dt[text()='Delivery methods']/following-sibling::dd//div/span[text()='Pod Consignment']");

    public static Target SHIP_DIRECT_TO_STORE_GENERAL = Target.the("General info delivery method Ship direct to stores")
            .locatedBy("//span[text()='Ship direct to stores']");

    public static Target SELF_DELIVER_TO_STORE_GENERAL = Target.the("General info delivery method Self deliver to store")
            .locatedBy("//span[text()='Self deliver to store']");

    public static Target PRICING_GENERAL = Target.the("General info pricing")
            .locatedBy("//span[contains(@class,'el-tag--primary')]");

    public static Target CUT_OFF_TIME_GENERAL = Target.the("General info cut off time")
            .locatedBy("//span[contains(@class,'cutoff')]");
    /**
     * Region - Detail - Link
     */
    public static Target ALL_REGION_LINK(String title) {
        return Target.the("All region's order link")
                .locatedBy("//a[text()=\"" + title + "\"]");
    }

}
