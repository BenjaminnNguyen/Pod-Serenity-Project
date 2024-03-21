package cucumber.user_interface.admin.financial.storestatements;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class StoreStatementsDetailPage {

    /**
     * Header bar
     */

    public static Target HEADER_BAR = Target.the("Header bar")
            .located(By.xpath("//div[@class='title']//span"));

    /**
     * General Information
     */
    public static Target STORE_IN_GENERAL_INFO(String value) {
        return Target.the("Store in general information")
                .located(By.xpath("//div[@class='title']//span[contains(text(),'" + value + "')]"));
    }

    public static Target STATEMENT_IN_GENERAL_INFO = Target.the("Statement in general information")
            .located(By.xpath("//dt[text()='Statement month']//following-sibling::dd/div"));

    /**
     * General Information - Top section
     */
    public static Target BEGINNING_BALANCE_TOP = Target.the("Beginning balance in top section")
            .located(By.xpath("//dd[@class='begining-balance']/*"));

    public static Target DELIVERED_ORDERS_TOP = Target.the("Delivered orders in top section")
            .located(By.xpath("//dd[@class='delivered-order']"));

    public static Target PAYMENT_TOP = Target.the("Payment in top section")
            .located(By.xpath("//dd[@class='total-payment']"));

    public static Target CREDIT_TOP = Target.the("Credit in top section")
            .located(By.xpath("//dd[@class='total-memo']"));

    public static Target ENDING_BALANCE_TOP = Target.the("Ending balance in top section")
            .located(By.xpath("//dd[@class='ending-balance']/*"));

    /**
     * General Information - Top section - Electronic ACH
     */
    public static Target D_TOP_SECTION(String value) {
        return Target.the(value + " in top section")
                .located(By.xpath("//dd[@class='" + value + "']"));
    }

    public static Target INVOICE_RESULT(String type, String idInvoice) {
        return Target.the(idInvoice)
                .located(By.xpath("(//tbody[@class='" + type + "-section']//td[contains(@class,'id')]//span[text()='" + idInvoice + "'])[last()]"));
    }

    public static Target CHECKOUT_RESULT(String type, String idInvoice) {
        return Target.the("Checkout result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='checkout'])[last()]"));
    }

    public static Target DELIVERY_RESULT(String type, String idInvoice) {
        return Target.the("Delivery result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='delivery-date'])[last()]"));
    }

    public static Target BUYER_RESULT(String type, String idInvoice) {
        return Target.the("Buyer result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='buyer'])[last()]"));
    }

    public static Target STATUS_RESULT(String type, String idInvoice) {
        return Target.the("Status result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='status']/div)[last()]"));
    }

    public static Target AGING_RESULT(String type, String idInvoice) {
        return Target.the("Aging result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='aging'])[last()]"));
    }

    public static Target DESCRIPTION_RESULT(String type, String idInvoice) {
        return Target.the("Description result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='description'])[last()]"));
    }

    public static Target ORDERVALUE_RESULT(String type, String idInvoice) {
        return Target.the("Order value result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='tr order-value'])[last()]"));
    }

    public static Target DISCOUNT_RESULT(String type, String idInvoice) {
        return Target.the("Discount result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='tr discount'])[last()]"));
    }

    public static Target DEPOSIT_RESULT(String type, String idInvoice) {
        return Target.the("Deposit result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='tr deposit'])[last()]"));
    }

    public static Target FEE_RESULT(String type, String idInvoice) {
        return Target.the("Fee result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='tr fee'])[last()]"));
    }

    public static Target MEMO_RESULT(String type, String idInvoice) {
        return Target.the("Credit memo result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='tr memo'])[last()]"));
    }

    public static Target PAYMENT_RESULT(String type, String idInvoice) {
        return Target.the("Payment result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='tr payment'])[last()]"));
    }

    public static Target TOTAL_RESULT(String type, String idInvoice) {
        return Target.the("Total result")
                .located(By.xpath("(//tbody[@class='" + type + "-section']//span[text()='" + idInvoice + "']//parent::td/following-sibling::td[@class='tr total'])[last()]"));
    }

    /**
     * Row Payment after id paid
     */
    public static Target ROW_UNAPPLIED_PAYMENT(String idInvoice) {
        return Target.the("Row unapplied payment by id")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr/td[contains(@data-type,'Unapplied')]/parent::tr"));
    }

    public static Target ROW_UNAPPLIED_PAYMENT_PREVIOUS(String idInvoice) {
        return Target.the("Row unapplied payment by id of previous month")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/preceding-sibling::tr[1]"));
    }

    public static Target D_ROW_RESULT(String idInvoice, String index) {
        return Target.the("Result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='id']/span"));
    }

    public static Target D_CHECKOUT_RESULT(String idInvoice, String index) {
        return Target.the("Checkout result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='checkout']"));
    }

    public static Target D_DELIVERY_RESULT(String idInvoice, String index) {
        return Target.the("Payment delivery result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='delivery-date']"));
    }

    public static Target D_BUYER_RESULT(String idInvoice, String index) {
        return Target.the("Buyer result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='buyer']"));
    }

    public static Target D_STATUS_RESULT(String idInvoice, String index) {
        return Target.the("Atatus result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='status']"));
    }

    public static Target D_AGING_RESULT(String idInvoice, String index) {
        return Target.the("Payment aging result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='aging']"));
    }

    public static Target D_DESCRIPTION_RESULT(String idInvoice, String index) {
        return Target.the("Description result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='description']"));
    }

    public static Target D_ORDER_VALUE_RESULT(String idInvoice, String index) {
        return Target.the("Payment order value result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='tr order-value']"));
    }

    public static Target D_DISCOUNT_RESULT(String idInvoice, String index) {
        return Target.the("Discount result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='tr discount']"));
    }

    public static Target D_DEPOSIT_RESULT(String idInvoice, String index) {
        return Target.the("Deposit result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='tr deposit']"));
    }

    public static Target D_FEE_RESULT(String idInvoice, String index) {
        return Target.the("Fee result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='tr fee']"));
    }

    public static Target D_MEMO_RESULT(String idInvoice, String index) {
        return Target.the("Credit memo result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='tr memo']"));
    }

    public static Target D_PAYMENT_RESULT(String idInvoice, String index) {
        return Target.the("Payment result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='tr payment']"));
    }

    public static Target D_TOTAL_RESULT(String idInvoice, String index) {
        return Target.the("Total result")
                .located(By.xpath("//tbody[@class='bottom-section']//span[text()='" + idInvoice + "']/ancestor::tr/following-sibling::tr[" + index + "]/td[@class='tr total']"));
    }

    /**
     * Row Unapplied payment after id paid
     */

    public static Target UNAPPLIED_RESULT_MIDDLE(String type, String idRow, String value) {
        return Target.the("Result " + value + " of unapplied payment in " + type + " line")
                .located(By.xpath("//tbody[@class='" + type + "-section']//tr[@data-id='" + idRow + "']//td[@class='" + value + "']/span"));
    }

    public static Target UNAPPLIED_RESULT_MIDDLE_2(String type, String idRow, String value) {
        return Target.the("Result " + value + " of unapplied payment in " + value + " line")
                .located(By.xpath("//tbody[@class='" + type + "-section']//tr[@data-id='" + idRow + "']//td[@class='" + value + "']"));
    }

    public static Target UNAPPLIED_RESULT_MIDDLE_3(String type, String idRow, String value) {
        return Target.the("Result " + value + " of unapplied payment in " + type + " line")
                .located(By.xpath("//tbody[@class='" + type + "-section']//tr[@data-id='" + idRow + "']//td[@class='" + value + "']/div"));
    }

    /**
     * Popup Add an adjustment
     */

    public static Target CREATE_ADJUSTMENT = Target.the("Create Adjustment button")
            .located(By.xpath("//button//span[text()='Create']"));

    public static Target UPDATE_ADJUSTMENT = Target.the("Update Adjustment button")
            .located(By.xpath("//button//span[text()='Update']"));

    /**
     * Popup Record payment
     */
    public static Target D_CHECKBOX(String value) {
        return Target.the("Checkbox " + value + " in record payment")
                .located(By.xpath("(//div[@role='dialog']//span[text()='" + value + "']/parent::td/preceding-sibling::td/input)[last()]"));
    }

    /**
     * Summary price
     */
    public static Target ADJUSTMENT_IN_SUM = Target.the("Adjustment(s) selected in summary")
            .located(By.xpath("//dd[@class='adjustment-amount']"));

    public static Target SUBINVOICE_IN_SUM = Target.the("Sub-invoice(s) selected in summary")
            .located(By.xpath("//dd[@class='sub-invoice-amount']"));

    public static Target CREDIT_MEMO_IN_SUM = Target.the("Credit memo(s) selected in summary")
            .located(By.xpath("//dd[@class='memo-amount']"));

    public static Target UNAPPLIED_PAYMENT_IN_SUM = Target.the("Unapplied payment(s) selected in summary")
            .located(By.xpath("(//dd[@class='unapplied-payment-amount'])[1]"));

    public static Target PAYMENT_IN_SUM = Target.the("Payment(s) selected in summary")
            .located(By.xpath("(//dd[@class='unapplied-payment-amount'])[2]"));

    public static Target TOTAL_IN_SUM = Target.the("Unapplied payment(s) selected in summary")
            .located(By.xpath("//dd[@class='total-net']"));


    /**
     * list element to sum price
     */
    public static Target LIST_VALUE(String type, String value) {
        return Target.the("List price")
                .located(By.xpath("//tbody[@class='" + type + "-section']//parent::td/following-sibling::td[@class='tr " + value + "']"));
    }

    public static Target LIST_TOTAL_VALUE(String type, String value) {
        return Target.the("List total price")
                .located(By.xpath("//tbody[@class='" + type + "-section']//parent::td/following-sibling::td[@class='total-" + value + " tr']"));
    }

    /**
     * Row is disable in middle line of previous month
     */

    public static Target ROW_DISABLE(String position, String idInvoice) {
        return Target.the(idInvoice)
                .located(By.xpath("(//tbody[@class='" + position + "-section']//span[text()='" + idInvoice + "'])[last()]/ancestor::tr[@class='store-item disabled']"));
    }

    public static Target D_PREVIOUS(String position, String type, String title) {
        return Target.the(title + " in row of previous month")
                .located(By.xpath("(//tbody[@class='" + position + "-section']//td[contains(@data-type,'" + type + "')]/following-sibling::td[@class='" + title + "'])[last()]"));
    }

    public static Target UNAPPLIED_ID_PREVIOUS(String position, String type) {
        return Target.the("Type in row of previous month")
                .located(By.xpath("(//tbody[@class='" + position + "-section']//td[contains(@data-type,'" + type + "')]/span)[last()]"));
    }

    public static Target STATUS_ID_PREVIOUS(String position, String type) {
        return Target.the("Type in row of previous month")
                .located(By.xpath("(//tbody[@class='" + position + "-section']//td[contains(@data-type,'" + type + "')]/following-sibling::td[@class='status']/div)[last()]"));
    }

    /**
     * Adjustment by description
     */

    public static Target ADJUSTMENT_BY_DESCRIPTION_RESULT(String description) {
        return Target.the("Description result")
                .located(By.xpath("//td[text()='" + description + "']"));
    }
}
