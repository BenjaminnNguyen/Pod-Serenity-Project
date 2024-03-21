package steps.admin.financial;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.buyers.HandleBuyerCompanies;
import cucumber.tasks.admin.financial.HandleCreditLimit;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.financial.CreditLimitPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.af.En;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import net.serenitybdd.screenplay.ui.Button;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class CreditLimitStepDefinitions {

    @And("Admin search buyer company in credit limit")
    public void admin_search_buyer_company_in_credit_limit(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleCreditLimit.search(infos.get(0))
        );
    }

    @And("Admin go to buyer company {string} credit limit")
    public void admin_go_to_buyer_company_credit_limit(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditLimit.goToDetail(buyerCompany)
        );
    }

    @And("Admin set buyer company credit limit is {string}")
    public void admin_set_buyer_company_credit_limit(String amount) {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditLimit.set(amount)
        );
    }

    @And("Admin verify credit limit of buyer company in result")
    public void admin_verify_credit_limit_of_buyer_company_in_result(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreditLimitPage.BUYER_COMPANY_IN_RESULT(infos.get(0).get("buyerCompany"))),
                Ensure.that(CreditLimitPage.CREDIT_LIMIT_IN_RESULT(infos.get(0).get("buyerCompany"))).text().contains(infos.get(0).get("creditLimit")),
                Ensure.that(CreditLimitPage.ENDING_BALANCE_IN_RESULT(infos.get(0).get("buyerCompany"))).text().contains(infos.get(0).get("endingBalance")),
                Ensure.that(CreditLimitPage.UNFULFILL_ORDER_IN_RESULT(infos.get(0).get("buyerCompany"))).text().contains(infos.get(0).get("unfulfilledOrder")),
                Ensure.that(CreditLimitPage.DIFF_IN_RESULT(infos.get(0).get("buyerCompany"))).text().contains(infos.get(0).get("diff"))
        );
    }

    @And("Admin verify search buyer company {string} deleted in credit limit")
    public void admin_search_buyer_company_deleted_in_credit_limit(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleCreditLimit.searchInvalid(buyerCompany)
        );
    }

    @And("Admin get unfulfill orders value of buyer company {string} in credit limit")
    public void admin_get_unfulfill_orders_value_of_credit_limit(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreditLimitPage.UNFULFILL_ORDER_IN_RESULT(buyerCompany))
        );
        String value = Text.of(CreditLimitPage.UNFULFILL_ORDER_IN_RESULT(buyerCompany)).answeredBy(theActorInTheSpotlight()).toString().substring(1);
        Serenity.setSessionVariable("Credit limit unfulfill orders").to(value);
    }

    @And("Admin verify unfulfill orders after order in credit limit")
    public void admin_verify_unfulfill_orders_value_of_credit_limit(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String temp = Serenity.sessionVariableCalled("Credit limit unfulfill orders");
        double oldValue = Double.parseDouble(temp);

        String temp1 = Text.of(CreditLimitPage.UNFULFILL_ORDER_IN_RESULT(infos.get(0).get("buyerCompany"))).answeredBy(theActorInTheSpotlight()).toString().substring(1);
        double newValue = Double.parseDouble(temp1);

        double amountOrder = newValue - oldValue;
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(amountOrder).isEqualTo(Double.parseDouble(infos.get(0).get("amountOrder")))
        );
    }

    @And("Admin add temporary credit limit of buyer company")
    public void admin_add_temporary_credit_limit(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleCreditLimit.fillInfoTemporary(infos.get(0))
        );
    }

    @And("Admin update credit limit")
    public void admin_add_temporary_credit_limit() {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditLimit.update()
        );
    }

    @And("Admin go to add temporary credit limit")
    public void admin_go_to_add_temporary_credit_limit_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditLimit.goToAddTemporary()
        );
    }

    @And("Admin verify temporary credit limit of buyer company")
    public void admin_verify_temporary_credit_limit(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreditLimitPage.TEMPORARY_CREDIT_LIMIT_TEXTBOX),
                Ensure.that(CreditLimitPage.TEMPORARY_CREDIT_LIMIT_TEXTBOX).attribute("value").contains(infos.get(0).get("temporary")),
                Ensure.that(CreditLimitPage.TEMPORARY_START_DATE_TEXTBOX).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("startDate"), "MM/dd/yy")),
                Ensure.that(CreditLimitPage.TEMPORARY_END_DATE_TEXTBOX).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("endDate"), "MM/dd/yy"))
        );
    }

    @And("Admin see message {string} of credit limit")
    public void admin_set_message_credit_limit(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin remove temporary credit limit of buyer company")
    public void admin_remove_temporary_credit_limit_of_buyer_company() {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditLimit.removeTemporary()
        );
    }

}

