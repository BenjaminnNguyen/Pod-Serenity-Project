package cucumber.user_interface.flowspace;

import net.serenitybdd.screenplay.targets.Target;

public class FSOutboundOrdersPage {

    public static final Target FILTER_BUTTON = Target.the("Filter button")
            .locatedBy("(//button[contains(@class,'btn btn-filter')])[2]");

    /**
     * Popup filter
     */

    public static final Target FILTER_POPUP = Target.the("Filter popup")
            .locatedBy("//ul[contains(@class,'dropdown-menu filter-menu')]");


    public static Target TEXTBOX_FILTER_POPUP(String title) {
        return Target.the("Textbox in filter popup")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static final Target FILTER_APPLY_BUTTON = Target.the("Button apply in filter popup")
            .locatedBy("//ul[contains(@class,'dropdown-menu filter-menu')]//button[contains(text(),'Apply')]");

    /**
     * Outbound orders list
     */

    public static Target DROP_NUMBER_IN_LIST(String dropNumber) {
        return Target.the("Order/PO in list")
                .locatedBy("//tr//p[contains(text(),'" + dropNumber + "')]");
    }

    public static Target DEPARTURE_IN_LIST(String dropNumber) {
        return Target.the("Departure in list")
                .locatedBy("(//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/preceding-sibling::td)[2]");
    }

    public static Target CUSTOMER_IN_LIST(String dropNumber) {
        return Target.the("Customer in list")
                .locatedBy("(//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td)[1]");
    }

    public static Target MODE_IN_LIST(String dropNumber) {
        return Target.the("Mode in list")
                .locatedBy("(//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td)[2]");
    }

    public static Target TAG_IN_LIST(String dropNumber) {
        return Target.the("Tag in list")
                .locatedBy("//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td[contains(@class,'tag-cell')]//div[@data-content]");
    }

    public static Target STATUS_IN_LIST(String dropNumber) {
        return Target.the("Status in list")
                .locatedBy("//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td[@name='status']/span");
    }

    public static Target FROM_IN_LIST(String dropNumber) {
        return Target.the("From in list")
                .locatedBy("//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td[@name='warehouse']/a/p");
    }

    public static Target FROM_ADDRESS_IN_LIST(String dropNumber) {
        return Target.the("From address in list")
                .locatedBy("//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td[@name='warehouse']/p");
    }

    public static Target TO_IN_LIST(String dropNumber) {
        return Target.the("To in list")
                .locatedBy("(//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td[@name='customer']/p)[1]");
    }

    public static Target TO_ADDRESS_IN_LIST(String dropNumber) {
        return Target.the("To address in list")
                .locatedBy("(//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td[@name='customer']/p)[2]");
    }

    public static Target SHIPPED_IN_LIST(String dropNumber) {
        return Target.the("Shipped in list")
                .locatedBy("(//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td)[2]");
    }

    public static Target SKU_COUNT_IN_LIST(String dropNumber) {
        return Target.the("SKU count in list")
                .locatedBy("(//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td)[8]");
    }

    public static Target ITEM_COUNT_IN_LIST(String dropNumber) {
        return Target.the("Item count in list")
                .locatedBy("//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td[contains(@name,'item-count')]");
    }

    public static Target VIEW_IN_LIST(String dropNumber) {
        return Target.the("Item count in list")
                .locatedBy("//tr//p[contains(text(),'" + dropNumber + "')]/parent::td/following-sibling::td//a[contains(@class,'btn')]");
    }

    /**
     * Navigation bar
     */
    public static final Target NAV_BAR = Target.the("Nav bar in header")
            .locatedBy("//div[@class='navbar-menu']//div[contains(text(),'Pod Foods')]");

    /**
     * Setting dropdown
     */

    public static final Target ROLE_SELECT = Target.the("Role select dropdown")
            .locatedBy("//ul[contains(@class,'dropdown-menu')]//label[text()='Switch To']/following-sibling::div/select");

    public static final Target ROLE_SELECT_OPTION(String role) {
        return Target.the("Role select dropdown")
                .locatedBy("//ul[contains(@class,'dropdown-menu')]//label[text()='Switch To']/following-sibling::div/select/option[contains(text(),'" + role + "')]");
    }

    /**
     * Begin picking
     */

    public static final Target BEGIN_PICKING_BUTTON = Target.the("Begin picking button")
            .locatedBy("//a[contains(@class,'begin-picking')]");

    public static final Target FINISH_PICKING_BUTTON = Target.the("Finish picking button")
            .locatedBy("//a[contains(@class,'finish-picking')]");

    public static final Target CONFIRM_PICKING_BUTTON = Target.the("Confirm picking button")
            .locatedBy("//a[contains(@class,'confirm-picking')]");

    /**
     * Pack
     */

    public static final Target PACK_BUTTON = Target.the("Pack button")
            .locatedBy("//a[contains(@class,'pack-order')]");

    public static final Target LENGTH_TEXTBOX = Target.the("Length textbox")
            .locatedBy("//input[contains(@id,'length-input')]");

    public static final Target WIDTH_TEXTBOX = Target.the("Width textbox")
            .locatedBy("//input[contains(@id,'width-input')]");

    public static final Target HEIGHT_TEXTBOX = Target.the("Height textbox")
            .locatedBy("//input[contains(@id,'height-input')]");

    public static final Target WEIGHT_TEXTBOX = Target.the("Weight textbox")
            .locatedBy("//input[contains(@id,'weight-input')]");

    public static final Target NUMBER_PALLET_TEXTBOX = Target.the("Number pallet textbox")
            .locatedBy("//input[contains(@id,'numberOfPallets-input')]");

    public static final Target PACK_ORDER_BUTTON = Target.the("Pack order button")
            .locatedBy("//button[contains(text(),'Pack Order')]");

    /**
     * Ship
     */

    public static final Target SHIP_BUTTON = Target.the("Ship button")
            .locatedBy("//div[@class='page-heading']//div/a[contains(text(),'Ship')]");

    public static final Target SHIP_ORDER_BUTTON = Target.the("Ship order button")
            .locatedBy("//input[@value='Ship Order']");

    public static final Target BILL_OF_LADING_TEXTBOX = Target.the("Bill of lading textbox")
            .locatedBy("//label[text()='Bill of Lading *']//following-sibling::input");

}
