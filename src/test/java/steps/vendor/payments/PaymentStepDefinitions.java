package steps.vendor.payments;

import io.cucumber.java.en.*;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.vendor.payments.HandleVendorPayments;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.beta.Vendor.payments.VendorPaymentPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class PaymentStepDefinitions {

    @And("Vendor check payment in tab summary")
    public void vendor_check_payment_in_tab_summary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = null;
        if(list.get(0).get("number").equals("create by admin")) {
            info = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("ID Invoice"), "create by admin");
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorPaymentPage.NUMBER(info.get("number"))).text().contains(info.get("number")),
                Ensure.that(VendorPaymentPage.STORE(info.get("number"))).text().contains(list.get(0).get("store")),
                Ensure.that(VendorPaymentPage.ORDER_VALUE(info.get("number"))).text().contains(list.get(0).get("orderValue")),
                Ensure.that(VendorPaymentPage.PAID(info.get("number"))).text().contains(list.get(0).get("paid")),
                Ensure.that(VendorPaymentPage.CREATE_DATE(info.get("number"))).text().contains(CommonHandle.setDate(list.get(0).get("datePayment"), "MM/dd/yy"))
        );
    }

    @And("Vendor go to month {string} of statements")
    public void vendor_go_to_monthly_statements(String date) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorPayments.goToMonthlyStatement(
                        CommonHandle.setDate2(date, "MM/yyyy"))
        );
    }

    @And("Vendor verify payment in monthly statements detail")
    public void vendor_verify_payment_in_month_statement_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorPaymentPage.NUMBER(list.get(0).get("number"))).text().contains(list.get(0).get("number")),
                Ensure.that(VendorPaymentPage.STORE(list.get(0).get("number"))).text().contains(list.get(0).get("store")),
                Ensure.that(VendorPaymentPage.ORDER_VALUE(list.get(0).get("number"))).text().contains(list.get(0).get("orderValue")),
                Ensure.that(VendorPaymentPage.PAID(list.get(0).get("number"))).text().contains(list.get(0).get("paid")),
                Ensure.that(VendorPaymentPage.CREATE_DATE(list.get(0).get("number"))).text().contains(list.get(0).get("datePayment"))
        );
    }
}
