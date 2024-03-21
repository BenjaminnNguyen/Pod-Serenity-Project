package cucumber.user_interface.beta.Buyer.orders;


import net.serenitybdd.screenplay.targets.Target;

public class BuyerOrderPage {

    //All tab
    public static Target ORDERED_HEADER = Target.the("Orders header")
            .locatedBy("//h1");

    public static Target ORDERED(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece ordered pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target NUMBER(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece number pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target NUMBER(String number) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[contains(@class,'number')]//div[contains(text(),'" + number + "')])");
    }

    public static Target STORE(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece store'])[" + i + "]/span");
    }

    public static Target CREATOR(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece creator pf-nowrap'])[" + i + "]/span");
    }

    public static Target PAYMENT(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece payment pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target FULLFILLMENT(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece fulfillment pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target TOTAL(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece total tr pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target CONFIRMED(int i) {
        return Target.the("")
                .locatedBy("(//i[@class='bx bxs-receipt'])[" + i + "]");
    }

    public static Target LOADING_ICON(String value) {
        return Target.the("Loading icon")
                .locatedBy("//div[@class='loading']//div[contains(text(),'" + value + "')]");
    }

    /**
     * Table result order
     */
    public static Target ORDERED(String orderID) {
        return Target.the("Ordered in result of orderID " + orderID)
                .locatedBy("//div[contains(text(),'" + orderID + "')]/parent::div/preceding-sibling::div//span");
    }

    public static Target STORE(String orderID) {
        return Target.the("Store in result of orderID " + orderID)
                .locatedBy("//div[contains(text(),'" + orderID + "')]/parent::div/following-sibling::div//div[text()='Store']/following-sibling::span");
    }

    public static Target CREATOR(String orderID) {
        return Target.the("Creator in result of orderID " + orderID)
                .locatedBy("//div[contains(text(),'" + orderID + "')]/parent::div/following-sibling::div//div[text()='Creator']/following-sibling::span");
    }

    public static Target PAYMENT(String orderID) {
        return Target.the("Payment in result of orderID " + orderID)
                .locatedBy("//div[contains(text(),'" + orderID + "')]/parent::div/following-sibling::div//div[text()='Payment']/following-sibling::div");
    }

    public static Target FULFILLMENT(String orderID) {
        return Target.the("Fulfillment in result of orderID " + orderID)
                .locatedBy("//div[contains(text(),'" + orderID + "')]/parent::div/following-sibling::div//div[text()='Fulfillment']/following-sibling::div");
    }

    public static Target TOTAL(String orderID) {
        return Target.the("Total in result of orderID " + orderID)
                .locatedBy("//div[contains(text(),'" + orderID + "')]/parent::div/following-sibling::div//div[text()='Total']/following-sibling::div/strong");
    }

    /**
     * Tab
     */
    public static Target TAB_SCREEN(String tab) {
        return Target.the("Tab " + tab)
                .locatedBy("//div[@class='tabs-input']//span[text()='" + tab + "']");
    }

    public static Target PAGE_SCREEN(String page) {
        return Target.the("Page " + page)
                .locatedBy("//div[@class='page__actions']//a[text()='" + page + "']");
    }

    /**
     * Tab All Order
     */

    public static final Target NO_RESULT = Target.the("No result found")
            .locatedBy("//span[text()='No results found...']");


    public static final Target ID_ORDER_IN_FIRST_ORDER = Target.the("ID of order in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'number')]/div)[2]");

    public static Target ID_ORDER_IN_FIRST_ORDER(String num) {
        return Target.the("Click to ID of order in tab Orders")
                .locatedBy("(//div[@class='content']//a//div[contains(@class,'number')]/div[contains(text(),'" + num + "')])");
    }

    public static final Target ORDER_DATE_IN_FIRST_ORDER = Target.the("Order date in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'ordered')]/div)[2]");

    public static final Target STORE_IN_FIRST_ORDER = Target.the("Store of order in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'store')]/span)[1]");

    public static final Target STORE_IN_FIRST_ORDER(String num) {
        return Target.the("Date order in tab Orders")
                .locatedBy("(//div[contains(text(),'" + num + "')]/ancestor::a//div[text()='Store']/following-sibling::span)");

    }

    public static final Target CREATE_IN_FIRST_ORDER = Target.the("Create of order in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'creator')]/span)[1]");

    public static final Target CREATE_IN_FIRST_ORDER(String num) {
        return Target.the("Date order in tab Orders")
                .locatedBy("(//div[contains(text(),'" + num + "')]/ancestor::a//div[text()='Creator']/following-sibling::span)");

    }

    public static final Target TOTAL_IN_FIRST_ORDER = Target.the("Total of order in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'total')]//strong)[1]");

    public static final Target TOTAL_IN_FIRST_ORDER(String num) {
        return Target.the("Date order in tab Orders")
                .locatedBy("(//div[contains(text(),'" + num + "')]/ancestor::a//div[text()='Total']/following-sibling::div)");

    }

    public static final Target PAYMENT_IN_FIRST_ORDER = Target.the("Payment of order in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'payment ')]/div)[2]");

    public static final Target FULFILLMENT_IN_FIRST_ORDER = Target.the("Fulfillment of order in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'fulfillment ')]/div)[2]");

    /**
     * Tab Pre Order
     */
    public static final Target DATE_IN_FIRST_ORDER = Target.the("Date order in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[text()='Pre-ordered']/following-sibling::div/span)[1]");

    public static final Target DATE_IN_FIRST_ORDER(String num) {
        return Target.the("Date order in tab Orders")
                .locatedBy("//div[contains(text(),'" + num + "')]/ancestor::a//div[text()='Pre-ordered']/following-sibling::div/span");

    }

    public static final Target TAG_PRE_IN_FIRST_ORDER(String num) {
        return Target.the("Date order in tab Orders")
                .locatedBy("(//div[contains(text(),'" + num + "')]/ancestor::a//div[text()='Pre-ordered']/following-sibling::div/span)[2]");

    }

    public static final Target TAG_PRE_IN_FIRST_ORDER = Target.the("Tag Pre in tab Orders")
            .locatedBy("(//div[@class='content']//a//div[text()='Pre-ordered']/following-sibling::div/span)[2]");

    public static final Target DATE_FIRST_ORDER_PRE = Target.the("Date order in tab Pre of Orders")
            .locatedBy("(//div[@class='content']//a/div[contains(@class,'pre-order')]//span)[1]");

    public static final Target DATE_FIRST_ORDER_PRE1 = Target.the("Date order in tab All of Orders")
            .locatedBy("(//div[@class='content']//a/div[contains(@class,'ordered')]//span)[1]");

    public static final Target TAG_PRE_FIRST_ORDER_PRE = Target.the("Tag Pre in tab Pre of Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'pre-order')]//span)[2]");

    public static final Target TAG_PRE_FIRST_ORDER_PRE1 = Target.the("Tag Pre in tab All of Orders")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'ordered')]//span)[2]");

    public static final Target STORE_IN_FIRST_ORDER_PRE = Target.the("Store of order in pre order")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'store')]/span)[1]");

    public static final Target CREATE_IN_FIRST_ORDER_PRE = Target.the("Create of order in pre order")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'creator')]/span)[1]");

    public static final Target TOTAL_IN_FIRST_ORDER_PRE = Target.the("Total of order in pre order")
            .locatedBy("(//div[@class='content']//a//div[contains(@class,'total')]/strong)[1]");

    public static final Target BRAND_ft = Target.the("Brand field")
            .locatedBy("//label[normalize-space()='Brand']/following-sibling::div//input");
    public static final Target CHECKOUT_AT_ft = Target.the("Checkout after")
            .locatedBy("//label[normalize-space()='Checkout after']/following-sibling::div//input");
    public static final Target CHECKOUT_BF_ft = Target.the("Checkout before")
            .locatedBy("//label[normalize-space()='Checkout before']/following-sibling::div//input");

    public static final Target ID_FIRST_ORDER = Target.the("Id first order")
            .locatedBy("(//div[text()='Number']/following-sibling::div)[1]");

    public static final Target PAYMENT_FIRST_ORDER = Target.the("Payment first order")
            .locatedBy("(//div[text()='Payment']/following-sibling::div)[1]");

    public static final Target FULFILLMENT_FIRST_ORDER = Target.the("Fulfillment first order")
            .locatedBy("(//div[text()='Fulfillment']/following-sibling::div)[1]");

    public static Target ORDER_BY_ID(String idOrder) {
        return Target.the("Order by ID")
                .locatedBy("//div[text()='Number']/following-sibling::div[text()='" + idOrder + "']");
    }
    /**
     * Tab Pre Order - last tab
     */
    public static final Target DATE_IN_FIRST_ORDER_PRE = Target.the("Date order in tab Pre-Order")
            .locatedBy("(//div[@class='content']//a/div[contains(@class,'pre-order ')]//span)[1]");
    public static final Target TAG_FIRST_ORDER_PRE = Target.the("Tag in tab Pre-Order")
            .locatedBy("(//div[@class='content']//a/div[contains(@class,'pre-order ')]//span)[2]");
    /**
     * Checkout date time picker
     */
    public static final Target AVAILABLE_TODAY_DATE_TIME_PICKER = Target.the("Available date in date time picker")
            .locatedBy("//div[contains(@x-placement,'start')]//td[contains(@class,'available today date')]");
    public static final Target PREVIOUS_MONTH_BUTTON = Target.the("Previous month button in date time picker")
            .locatedBy("//div[contains(@x-placement,'start')]//button[@aria-label='Previous Month']");
    public static final Target PREVIOUS_YEAR_BUTTON = Target.the("Previous month button in date time picker")
            .locatedBy("//div[contains(@x-placement,'start')]//button[@aria-label='Previous Year']");
    public static final Target NEXT_MONTH_BUTTON = Target.the("Next month button in date time picker")
            .locatedBy("//div[contains(@x-placement,'start')]//button[@aria-label='Next Month']");
    public static final Target NEXT_YEAR_BUTTON = Target.the("Next month button in date time picker")
            .locatedBy("//div[contains(@x-placement,'start')]//button[@aria-label='Next Year']");
    public static final Target MONTH_LABEL = Target.the("Month label display in date time picker")
            .locatedBy("(//div[contains(@x-placement,'start')]//span[@class='el-date-picker__header-label'])[2]");

    public static final Target YEAR_LABEL = Target.the("Year label display in date time picker")
            .locatedBy("(//div[contains(@x-placement,'start')]//span[@class='el-date-picker__header-label'])[1]");

}
