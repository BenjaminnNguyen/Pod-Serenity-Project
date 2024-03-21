package cucumber.user_interface.flowspace;

import net.serenitybdd.screenplay.targets.Target;

public class FSOutboundOrderDetailPage {

    /**
     * Order detail
     */
    public static final Target PO_NUMBER_DETAIL = Target.the("PO number in order detail")
            .locatedBy("//dd[contains(@class,'qa-po-number')]");

    public static final Target CUSTOMER_DETAIL = Target.the("Customer in order detail")
            .locatedBy("//dd[contains(@class,'qa-customer description-list__description')]");

    public static final Target WAREHOUSE_DETAIL = Target.the("Warehouse in order detail")
            .locatedBy("//dd[contains(@class,'qa-warehouse description-list__description')]");

    public static final Target ITEMS_ORDERED_DETAIL = Target.the("Items ordered in order detail")
            .locatedBy("//dd[contains(@class,'qa-items-ordered description-list__description')]");

    public static final Target CREATION_SOURCE_DETAIL = Target.the("Creation source in order detail")
            .locatedBy("//dd[contains(@class,'qa-creation-source description-list__description')]");

    public static Target SKU_ID_DETAIL(String id) {
        return Target.the("SKU id in order detail")
                .locatedBy("//dd[@name='sku']//span[@data-title='" + id + "']");
    }

    public static Target UPC_SKU_DETAIL(String id) {
        return Target.the("UPC of SKU in order detail")
                .locatedBy("(//span[@data-title='" + id + "']/parent::dd/following-sibling::dt[text()='UPC']/following-sibling::dd)[1]");
    }

    public static Target DESCRIPTION_SKU_DETAIL(String id) {
        return Target.the("Description of SKU in order detail")
                .locatedBy("(//span[@data-title='" + id + "']/parent::dd/following-sibling::dt[text()='Description']/following-sibling::dd)[1]");
    }

    public static Target ORDERED_SKU_DETAIL(String id) {
        return Target.the("Ordered of SKU in order detail")
                .locatedBy("(//span[@data-title='" + id + "']/ancestor::dl/following-sibling::dl//dt[contains(text(),'Ordered')]/following-sibling::dd)[1]");
    }
}
