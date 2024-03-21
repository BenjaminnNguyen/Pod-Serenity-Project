package cucumber.user_interface.admin.store;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AdminStoreTypePage {

    /**
     * Create store type
     */
    public static Target CREATE_STORE_TYPE_BUTTON = Target.the("Create store type button")
            .locatedBy("//div[@class='page-header']//button//span[text()='Create']");

    public static Target CREATE_STORE_TYPE_POPUP = Target.the("Create store type popup")
            .locatedBy("//div[@role='dialog']//span[text()='Create new Store Type']");

    public static Target CREATE_STORE_TYPE_NAME_TEXTBOX = Target.the("Create store type name textbox")
            .locatedBy("//div[@role='dialog']//input");

    public static Target CREATE_STORE_TYPE_NAME_ERROR = Target.the("Create store type name error message")
            .locatedBy("//div[@role='dialog']//input/parent::div/following-sibling::div");

    /**
     * Store type result
     */

    public static Target STORE_TYPE_NAME_RESULT(String name) {
        return Target.the("Store type name result")
                .locatedBy("(//table//div[text()='" + name + "'])[1]");
    }

    public static Target STORE_TYPE_EDIT_BUTTON(String name) {
        return Target.the("Store type edit button")
                .locatedBy("(//div[@class='el-table__fixed-right']//div[text()='" + name + "']/ancestor::td/following-sibling::td//button)[1]");
    }

    public static Target STORE_TYPE_DELETE_BUTTON(String name) {
        return Target.the("Store type delete button")
                .locatedBy("(//div[@class='el-table__fixed-right']//div[text()='" + name + "']/ancestor::td/following-sibling::td//button)[2]");
    }

    /**
     * Edit store type
     */

    public static Target EDIT_STORE_TYPE_POPUP(String name) {
        return Target.the("Edit store type type popup")
                .locatedBy("//div[@role='dialog']//span[contains(text(),'" + name + "')]");
    }
}
