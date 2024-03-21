package cucumber.tasks.vendor.payments;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.payments.VendorPaymentPage;
import cucumber.user_interface.lp.CommonLPPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;

public class HandleVendorPayments {

    public static Task goToMonthlyStatement(String date) {
        return Task.where("Go to monthly statements",
                CommonWaitUntil.isVisible(VendorPaymentPage.MONTHLY_STATEMENT),
                Click.on(VendorPaymentPage.MONTHLY_STATEMENT),
                CommonWaitUntil.isVisible(VendorPaymentPage.MONTH(date)),
                Click.on(VendorPaymentPage.MONTH(date)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your"))
        );
    }
}
