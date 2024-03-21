package steps.admin.financial;

import cucumber.tasks.admin.financial.HandleCreditMemoType;
import cucumber.tasks.admin.financial.HandleVendorAdjustmentTypes;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.AdjustmentTypePage;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class CreditMemoTypesStepDefinitions {

    @And("Admin go to create credit memo types")
    public void go_to_create_credit_memo_types() {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemoType.goToCreate()
        );
    }

    @And("Admin verify field name in create credit memo type")
    public void verify_field_name_in_create_vendor_adjustment_type() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                // verify
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_CREATE_ERROR),
                Ensure.that(AdjustmentTypePage.NAME_CREATE_ERROR).text().contains("Please input Credit memo type name")
        );
    }

    @And("Admin fill info to create credit memo type is {string}")
    public void fill_info_to_create_credit_memo_type(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.fillInfoToCreate(name)
        );
    }

    @And("Admin create credit memo type success")
    public void create_credit_memo_type_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.createSuccess()
        );
    }

    @And("Admin search credit memo type with name {string}")
    public void search_credit_memo_type_with_name(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.search(name)
        );
    }

    @And("Admin go to credit memo types {string} detail")
    public void go_to_credit_memo_types_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.goToDetail(name)
        );
    }

    @And("Admin verify credit memo types {string} in detail")
    public void verify_credit_memo_in_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_IN_RESULT(name)),
                Ensure.that(AdjustmentTypePage.NAME_IN_RESULT(name)).text().contains(name),
                Ensure.that(AdjustmentTypePage.NAME_CREATE_TEXTBOX).attribute("value").contains(name)
        );
    }

    @And("Admin edit credit memo types to {string}")
    public void edit_credit_memo_types(String nameEdit) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.edit(nameEdit)
        );
    }

    @And("Admin edit credit memo types success")
    public void edit_credit_memo_types_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.editSuccess()
        );
    }

    @And("Admin delete credit memo type with name {string}")
    public void delete_credit_memo_type_with_name(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemoType.delete(name)
        );
    }

}
