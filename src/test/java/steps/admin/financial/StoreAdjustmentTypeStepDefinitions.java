package steps.admin.financial;

import cucumber.tasks.admin.financial.HandleStoreAdjustmentTypes;
import cucumber.tasks.admin.financial.HandleVendorAdjustmentTypes;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.AdjustmentTypePage;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class StoreAdjustmentTypeStepDefinitions {

    @And("Admin go to create store adjustment types")
    public void go_to_create_adjustment_types() {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.goToCreate()
        );
    }

    @And("Admin fill info to create store adjustment type is {string}")
    public void fill_info_to_create_adjustment_type(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.fillInfoToCreate(name)
        );
    }

    @And("Admin create store adjustment type success")
    public void create_adjustment_type_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.createSuccess()
        );
    }

    @And("Admin verify field name in create store adjustment type")
    public void verify_field_name_in_create_adjustment_type() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                // verify
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_CREATE_ERROR),
                Ensure.that(AdjustmentTypePage.NAME_CREATE_ERROR).text().contains("Please input Store Financial Adjustment Type name")
        );
    }

    @And("Admin search store adjustment type with name {string}")
    public void search_store_adjustment_type_with_name(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.search(name)
        );
    }

    @And("Admin go to store adjustment types {string} detail")
    public void go_to_store_adjustment_types_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.goToDetail(name)
        );
    }

    @And("Admin verify store adjustment types {string} in detail")
    public void verify_store_adjustment_types_in_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_IN_RESULT(name)),
                Ensure.that(AdjustmentTypePage.NAME_IN_RESULT(name)).text().contains(name),
                Ensure.that(AdjustmentTypePage.NAME_CREATE_TEXTBOX).attribute("value").contains(name)
                );
    }

    @And("Admin edit store adjustment types to {string}")
    public void edit_store_adjustment_types(String nameEdit) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.edit(nameEdit)
        );
    }

    @And("Admin edit store adjustment types success")
    public void edit_store_adjustment_types_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.editSuccess()
        );
    }

    @And("Admin update store adjustment type with error {string}")
    public void edit_store_adjustment_types_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.editError(message)
        );
    }

    @And("Admin create store adjustment type with error {string}")
    public void create_store_adjustment_type_with_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.createError(message)
        );
    }

    @And("Admin close popup edit adjustment")
    public void close_popup_edit_store_adjustment_types() {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.close()
        );
    }

    @And("Admin delete store adjustment type with name {string}")
    public void delete_store_adjustment_type_with_name(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreAdjustmentTypes.delete(name)
        );
    }

    @And("Admin delete store adjustment type with name {string} and see message {string}")
    public void delete_store_adjustment_type_with_name(String name, String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorAdjustmentTypes.deleleError(name, message)
        );
    }
}
