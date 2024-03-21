package cucumber.user_interface.beta.Vendor.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AllInventoryPage {

    /**
     * @param regions
     * @return
     */
    public static Target TAB_REGIONS(String regions) {
        return Target.the("Region " + regions)
                .locatedBy("//div[@class='label']/span[text()='" + regions + "']");
    }

    public static Target DYNAMIC_SEARCH_TEXTBOX(String title) {
        return Target.the("")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target SEARCH_RESULTS(String class_, String status, int i) {
        return Target.the(class_)
                .located(By.xpath("(//div[@class='inventories-list']//div[@class='edt-row record" + status + "']//div[@class='" + class_ + "'])[" + i + "]"));
    }

    public static Target SEARCH_RESULTS_ZERO_QUANTITY(String class_, int i) {
        return Target.the(class_)
                .located(By.xpath("(//div[@class='inventories-list']//div[@class='edt-row record zero-quantity']//div[@class='" + class_ + "'])[" + i + "]"));
    }

    public static Target PRODUCT_NAME_IN_RESULT(String lotCode) {
        return Target.the("Product name in result by lotcode")
                .locatedBy("//span[text()='" + lotCode + "']//ancestor::div/preceding-sibling::div//div[@class='product']/span");
    }

    public static Target SKU_IN_RESULT(String lotCode) {
        return Target.the("SKU in result by lotcode")
                .locatedBy("//span[text()='" + lotCode + "']//ancestor::div/preceding-sibling::div//div[@class='sku']/span[2]");
    }

    public static Target REGION_IN_RESULT(String lotCode) {
        return Target.the("Region in result by lotcode")
                .locatedBy("//span[text()='" + lotCode + "']//ancestor::div/preceding-sibling::div//div[@class='sku']/span[1]");
    }

    public static Target SKU_ID_IN_RESULT(String lotCode) {
        return Target.the("Sku id in result by lotcode")
                .locatedBy("//span[text()='" + lotCode + "']//ancestor::div/preceding-sibling::div//div[@class='sku']/div//div[contains(@class,'id')]");
    }


    public static Target LOT_CODE_IN_RESULT(String lotCode) {
        return Target.the("Lot code in result by lotcode")
                .locatedBy("//div[@class='edt-row record']//div[contains(@class,'lot-code')]//span[text()='" + lotCode + "']");
    }

    public static Target RECEIVED_QTY_IN_RESULT(String lotCode) {
        return Target.the("Received Qty in result by lotcode")
                .locatedBy("(//span[text()='" + lotCode + "']//ancestor::div/following-sibling::div[@class='edt-piece received-quantity']/div)[2]");
    }

    public static Target RECEIVED_IN_RESULT(String lotCode) {
        return Target.the("Received in result by lotcode")
                .locatedBy("(//span[text()='" + lotCode + "']//ancestor::div/following-sibling::div[@class='edt-piece received']/div)[2]");
    }

    public static Target CURRENT_QTY_IN_RESULT(String lotCode) {
        return Target.the("Current Qty in result by lotcode")
                .locatedBy("(//span[text()='" + lotCode + "']//ancestor::div/following-sibling::div[@class='edt-piece current-quantity']/div)[2]");
    }

    public static Target PULLED_QTY_IN_RESULT(String lotCode) {
        return Target.the("Pulled Qty in result by lotcode")
                .locatedBy("(//span[text()='" + lotCode + "']//ancestor::div/following-sibling::div[@class='edt-piece pulled-quantity']/div)[2]");
    }

    public static Target END_QTY_IN_RESULT(String lotCode) {
        return Target.the("End Qty in result by lotcode")
                .locatedBy("(//span[text()='" + lotCode + "']//ancestor::div/following-sibling::div[@class='edt-piece end-quantity']/div)[2]");
    }

    public static Target EXPIRY_DATE_IN_RESULT(String lotCode) {
        return Target.the("Expiry date in result by lotcode")
                .locatedBy("(//span[text()='" + lotCode + "']//ancestor::div/following-sibling::div[@class='edt-piece expiry']/div)[2]");
    }


    public static Target PULL_DATE_IN_RESULT(String lotCode) {
        return Target.the("Pull date in result by lotcode")
                .locatedBy("(//span[text()='" + lotCode + "']//ancestor::div/following-sibling::div[@class='edt-piece pull-date']/div)[2]");
    }


}
