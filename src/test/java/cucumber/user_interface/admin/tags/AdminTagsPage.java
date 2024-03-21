package cucumber.user_interface.admin.tags;

import net.serenitybdd.screenplay.targets.Target;

public class AdminTagsPage {

    public static final Target TAGS_SIDEBAR = Target.the("Tags menu in side bar")
            .locatedBy("//ul[@role='menubar']//span[text()='Products']");


    public static final Target TAG_DETAIL(String name) {
        return Target.the("Tags detail")
                .locatedBy("//span[contains(text(),'" + name + "')]/ancestor::td/following-sibling::td[contains(@class,'action')]/div/button[1]");
    }

    public static final Target TAG_ASSIGN(String name) {
        return Target.the("Tags assign")
                .locatedBy("//span[contains(text(),'" + name + "')]/ancestor::td/following-sibling::td[contains(@class,'action')]/div/button[2]");
    }

    public static final Target TAG_ASSIGN_TARGET(String name) {
        return Target.the("Tags assign")
                .locatedBy("//div[@id='tab-" + name + "']");
    }

    public static final Target TAG_ASSIGN_TARGET_EXPIRY() {
        return Target.the("Tags assign")
                .locatedBy("(//div[@class='section product-target-section']//div[contains(@class,'el-input--small')]/input)[1]");
    }

    public static final Target TAG_ASSIGN_TARGET_VALUE() {
        return Target.the("Tags assign")
                .locatedBy("(//div[@class='section product-target-section']//div[contains(@class,'el-input--small')]/input)[2]");
    }

    public static final Target TAG_VISIBILITY(String name) {
        return Target.the("Tags detail")
                .locatedBy("//label[contains(@class,'el-radio-button is-active')]//span[contains(text(),'" + name + "')]");
    }

    public static final Target TAG_TARGET(String name) {
        return Target.the("Tags detail")
                .locatedBy("//label[@class='el-checkbox is-checked']//span[text()='" + name + "']");
    }

    public static final Target TAG_TARGET_SECTION_NAME(int i) {
        return Target.the("Tags detail")
                .locatedBy("(//div[contains(@class,'entity-card')])[" + i + "]/div[1]");
    }
    public static final Target TAG_TARGET_SECTION_EXPIRY(int i) {
        return Target.the("Tags detail")
                .locatedBy("(//div[contains(@class,'entity-card')])[" + i + "]/div[2]//input");
    }

}
