package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;

public class CreateMultipleOrderPage {

    public static final Target UPLOAD_CSV_FILE_POPUP = Target.the("Upload CSV file popup")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Upload your CSV file']");

    public static final Target UPLOAD_CSV_BUTTON = Target.the("Upload CSV file popup")
            .locatedBy("//div[@id='global-dialogs']//input[@type='file']");

    public static final Target EDIT_INSTRUCTION_BUTTON = Target.the("Edit instruction")
            .locatedBy("//div[@class='how-to-use-body bordered']//div[@class='action']");

    public static final Target EDIT_INSTRUCTION_TEXT = Target.the("Edit instruction")
            .locatedBy(".el-dialog .CodeMirror");

    public static final Target EDIT_INSTRUCTION_CONTENT = Target.the("Edit instruction content")
            .locatedBy("//div[@class='how-to-use-body bordered']//div[@class='content']/div");

    public static final Target EDIT_INSTRUCTION_HISTORY = Target.the("Edit instruction history")
            .locatedBy("//div[@class='how-to-use-body bordered']//div[@class='history']");

    public static final Target MULTI_ORDER_ID = Target.the("Edit instruction history")
            .locatedBy("//div[@class='title']/span[1]");

    public static final Target CREATE_MULTI_ORDER_TITLE(String fileName) {
        return Target.the("Create multi order title")
                .locatedBy("(//div[@class='title']/span[contains(text(),'" + fileName + "')])[1]");
    }

    /**
     * List multiple order
     */
    public static final Target MULTI_ORDER_LIST(String class_, int i) {
        return Target.the("Create multi order title")
                .locatedBy("(//tbody//td[contains(@class,'" + class_ + "')])[" + i + "]");
    }

    public static final Target MULTI_ORDER_NAME_DELETE(String name) {
        return Target.the("Create multi order title")
                .locatedBy("(//tbody//td[contains(@class,'name')]//span[contains(text(),'" + name + "')])/ancestor::td/following-sibling::td[contains(@class,'actions')]/div/button");
    }

    /**
     * After upload file
     */

    public static final Target UPLOADED_FIRST_ITEM = Target.the("Upload file first item")
            .locatedBy("(//a[@class='number'])[1]");

    public static final Target UPLOADED_STORE = Target.the("Store in csv uploaded")
            .locatedBy("//div[@class='lst-row active']//div[contains(@class,'lst-item store')]");

    public static final Target UPLOADED_CUSTOMER_PO = Target.the("Customer PO in csv uploaded")
            .locatedBy("//div[@class='lst-row active']//div[contains(@class,'lst-item customer-po')]");

    public static final Target UPLOADED_LINE_ITEM = Target.the("Line item in csv uploaded")
            .locatedBy("//div[@class='lst-row active']//div[contains(@class,'lst-item line-item')]");


    public static final Target UPLOADED_STATUS = Target.the("Status in csv uploaded")
            .locatedBy("//div[contains(@class,'status')]/span");

    public static final Target UPLOADED_QUANTITY = Target.the("Quantity in csv uploaded")
            .locatedBy("//div[@class='lst-row active']//div[contains(@class,'quantity')]");

    /**
     * line item
     */
    public static final Target LINE_ITEM_PRODUCT(int index) {
        return Target.the("Line item product " + index)
                .locatedBy("(//div[contains(@class,'line-item')]/div[@class='product'])[" + index + "]");
    }

    public static final Target LINE_ITEM_PRODUCT() {
        return Target.the("Line item product ")
                .locatedBy("(//div[contains(@class,'line-item')])");
    }

    public static final Target LINE_ITEM_SKU(int index) {
        return Target.the("Line item sku " + index)
                .locatedBy("(//div[contains(@class,'line-item')]//div[contains(@class,'sku-name')])[" + index + "]");
    }

    public static final Target ORDER_INFO(String class_) {
        return Target.the("Line item sku " + class_)
                .locatedBy("//div[@class='table-items order-list']/div[1]/following-sibling::div[contains(@class,'lst-row active')]/div[contains(@class,'" + class_ + "')]");
    }

    public static final Target ORDER_INFO_NUMBER(int indexOrder) {
        return Target.the("Line item sku " + indexOrder)
                .locatedBy("//div[@class='table-items order-list']/div[1]/following-sibling::div[@class='lst-row' or @class='lst-row active'][" + indexOrder + "]/div[contains(@class,'order-number')]//span");
    }

    public static final Target LINE_ITEM_SKU(String sku, int index) {
        return Target.the("Line item sku " + sku)
                .locatedBy("//div[@class='table-items order-list']/div[1]/following-sibling::div[contains(@class,'lst-row')][" + index + "]//div[contains(@class,'line-item')]//div[contains(text(),'" + sku + "')]");
    }

    public static final Target LINE_ITEM_SKU_ID(int index) {
        return Target.the("Line item sku id " + index)
                .locatedBy("(//div[contains(@class,'line-item')]//span[contains(@class,'item-code')])[" + index + "]");
    }

    public static final Target LINE_ITEM_STATE(int index) {
        return Target.the("Line item state " + index)
                .locatedBy("(//div[@class='lst-row item']//div[contains(@class,'upc')])[" + index + "]//div[contains(@class,'status-tag')]");
    }

    public static final Target LINE_ITEM_UPC(int index) {
        return Target.the("Line item upc " + index)
                .locatedBy("(//div[contains(@class,'upc')]//span[contains(@class,'upc-tag')])[" + index + "]");
    }

    public static final Target LINE_ITEM_STATUS(int index) {
        return Target.the("Line item status " + index)
                .locatedBy("(//div[@class='lst-row item']//div[@class='lst-item status']//div[@class='status-tag'])[" + index + "]");
    }

    public static final Target LINE_ITEM_ERROR(int index) {
        return Target.the("Line item error " + index)
                .locatedBy("(//div[@class='lst-row item']//div[@class='lst-item error'])[" + index + "]");
    }

    public static final Target LINE_ITEM_PRICE(int index) {
        return Target.the("Line item price " + index)
                .locatedBy("(//div[@class='lst-row item']//div[@class='lst-item price'])[" + index + "]");
    }

    public static final Target LINE_ITEM_QUANTITY(int index) {
        return Target.the("Line item price " + index)
                .locatedBy("(//div[@class='lst-row item']//div[@class='lst-item quantity']//input)[" + index + "]");
    }

    public static final Target LINE_ITEM_QUANTITY(String sku) {
        return Target.the("Line item price " + sku)
                .locatedBy("//div[text()='" + sku + "']/ancestor::div[@class='lst-row item']/div[@class='lst-item quantity']//input");
    }

    public static final Target LINE_ITEM_CHECKBOX_INPUT(String sku) {
        return Target.the("Line item price " + sku)
                .locatedBy("//div[text()='" + sku + "']/ancestor::div[@class='lst-row item']/div[@class='lst-item action']//input");
    }

    public static final Target LINE_ITEM_CHECKBOX(String sku) {
        return Target.the("Line item checkbox select " + sku)
                .locatedBy("//div[text()='" + sku + "']/ancestor::div[@class='lst-row item']/div[@class='lst-item action']/label/span");
    }

    public static final Target RESOLVE_UPC(String sku) {
        return Target.the("Line item checkbox select " + sku)
                .locatedBy("//*[text()='" + sku + "']/ancestor::div[@class='lst-row item']//a[normalize-space()='Click here to resolve']");
    }

    public static final Target RESOLVE_UPC_NEW(String sku) {
        return Target.the("Line item checkbox select " + sku)
                .locatedBy("//div[@role='dialog']//*[text()='" + sku + "']/ancestor::tr/td[@class='radio']//span");
    }

    public static final Target LINE_ITEM_SELECT_ALL = Target.the("Line item select all checkbox")
            .locatedBy("//span[@class='el-checkbox__label']");

    /**
     * Total summary
     */
    public static final Target TOTAL_CASE_VALUE(String type) {
        return Target.the("Total case value of " + type)
                .locatedBy("//td[contains(@class,'" + type + " total-cases')]");
    }

    public static final Target TOTAL_ORDER_VALUE(String type) {
        return Target.the("Total order value of " + type)
                .locatedBy("//td[contains(@class,'" + type + " total-value')]");
    }

    public static final Target TOTAL_DISCOUNT_VALUE(String type) {
        return Target.the("Total discount value of " + type)
                .locatedBy("//td[contains(@class,'" + type + " discount')]");
    }

    public static final Target TOTAL_TAX_VALUE(String type) {
        return Target.the("Total tax value of " + type)
                .locatedBy("//td[contains(@class,'" + type + " crv')]");
    }

    public static final Target TOTAL_SPECIAL_DISCOUNT_VALUE(String type) {
        return Target.the("Total special discount value of " + type)
                .locatedBy("//td[contains(@class,'" + type + " special-discount')]");
    }

    public static final Target TOTAL_PAYMENT = Target.the("Total payment value")
            .locatedBy("//td[@class='tt total tr']");

    public static final Target TOTAL_PAYMENT_IN_STOCK = Target.the("Total payment in stock value")
            .locatedBy("//td[contains(@class,'in-stock total-instock')]");

    public static final Target TOTAL_PAYMENT_OOS_LS = Target.the("Total payment OOS or LS value")
            .locatedBy("//td[contains(@class,'oos total-oos')]");
}
