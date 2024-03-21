package steps.admin.financial;

import cucumber.tasks.admin.financial.HandleVendorAdjustmentTypes;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.AdjustmentTypePage;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class VendorAdjustmentTypeStepDefinitions {

    @And("Admin go to create vendor adjustment types")
    public void go_to_create_vendor_adjustment_types() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.goToCreate()
        );
    }

    @And("Admin fill info to create vendor adjustment type is {string}")
    public void fill_info_to_create_adjustment_type(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.fillInfoToCreate(name)
        );
    }

    @And("Admin create vendor adjustment type success")
    public void create_vendor_adjustment_type_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.createSuccess()
        );
    }

    @And("Admin verify field name in create vendor adjustment type")
    public void verify_field_name_in_create_vendor_adjustment_type() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                // verify
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_CREATE_ERROR),
                Ensure.that(AdjustmentTypePage.NAME_CREATE_ERROR).text().contains("Please input Financial Adjustment Type name")
        );
    }

    @And("Admin search vendor adjustment type with name {string}")
    public void search_vendor_adjustment_type_with_name(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.search(name)
        );
    }

    @And("Admin go to vendor adjustment types {string} detail")
    public void go_to_vendor_adjustment_types_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.goToDetail(name)
        );
    }

    @And("Admin verify vendor adjustment types {string} in detail")
    public void verify_vendor_adjustment_types_in_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_IN_RESULT(name)),
                Ensure.that(AdjustmentTypePage.NAME_IN_RESULT(name)).text().contains(name),
                Ensure.that(AdjustmentTypePage.NAME_CREATE_TEXTBOX).attribute("value").contains(name)
        );
    }

    @And("Admin edit vendor adjustment types to {string}")
    public void edit_vendor_adjustment_types(String nameEdit) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.edit(nameEdit)
        );
    }

    @And("Admin edit vendor adjustment types success")
    public void edit_vendor_adjustment_types_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.editSuccess()
        );
    }

    @And("Admin update vendor adjustment type with error {string}")
    public void edit_vendor_adjustment_types_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.editError(message)
        );
    }

    @And("Admin create vendor adjustment type with error {string}")
    public void create_vendor_adjustment_type_with_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.createError(message)
        );
    }

    @And("Admin close popup edit vendor adjustment")
    public void close_popup_edit_vendor_adjustment_types() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.close()
        );
    }

    @And("Admin delete vendor adjustment type with name {string}")
    public void delete_vendor_adjustment_type_with_name(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.delete(name)
        );
    }

    @And("Admin delete vendor adjustment type with name {string} and see message {string}")
    public void delete_vendor_adjustment_type_with_name(String name, String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.deleleError(name, message)
        );
    }
}
