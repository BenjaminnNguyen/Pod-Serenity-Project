package steps.admin.store;

import cucumber.tasks.admin.store.HandleStoreType;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.store.AdminStoreTypePage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.af.En;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminStoreTypeStepDefinitions {

    @And("Admin fill info to {word} store type")
    public void admin_fill_info_to_create_store_type(String type, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleStoreType.fillInfoToCreate(infos.get(0))
        );
    }

    @And("Admin go to create store type")
    public void admin_go_to_create_store_type() {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreType.goToCreate()
        );
    }

    @And("Admin verify when blank file in create store type")
    public void admin_verify_blank_field_create_store_type() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                // Verify
                CommonWaitUntil.isVisible(AdminStoreTypePage.CREATE_STORE_TYPE_NAME_ERROR),
                Ensure.that(AdminStoreTypePage.CREATE_STORE_TYPE_NAME_ERROR).text().contains("Please input Store Type name")

                );
    }

    @And("Admin {word} store type success")
    public void admin_create_store_type_success(String action) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreType.createSuccess(action)
        );
    }

    @And("Admin verify store type")
    public void admin_verify_store_type(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminStoreTypePage.STORE_TYPE_NAME_RESULT(infos.get(0).get("name"))),
                Ensure.that(AdminStoreTypePage.STORE_TYPE_NAME_RESULT(infos.get(0).get("name"))).isDisplayed()
        );
    }

    @And("Admin go to edit store type {string}")
    public void admin_go_to_edit_store_type(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreType.goToEdit(name)
        );
    }

    @And("Admin verify store type in popup detail")
    public void admin_verify_store_type_in_popup_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminStoreTypePage.EDIT_STORE_TYPE_POPUP(infos.get(0).get("name"))),
                Ensure.that(AdminStoreTypePage.EDIT_STORE_TYPE_POPUP(infos.get(0).get("name"))).isDisplayed(),
                Ensure.that(AdminStoreTypePage.CREATE_STORE_TYPE_NAME_TEXTBOX).attribute("value").contains(infos.get(0).get("name"))
        );
    }

    @And("Admin delete store type {string}")
    public void admin_delete_store_type(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreType.delete(name)
        );
    }

    @And("Admin verify no found store type {string} in result")
    public void admin_verify_no_found_store_type(String storeType) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(AdminStoreTypePage.STORE_TYPE_NAME_RESULT(storeType))
        );
    }

}
