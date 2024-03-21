package cucumber.tasks.admin.store;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.store.AdminStoreTypePage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;

import java.util.Map;

public class HandleStoreType {

    public static Task goToCreate() {
        return Task.where("Create store type",
                CommonWaitUntil.isVisible(AdminStoreTypePage.CREATE_STORE_TYPE_BUTTON),
                Click.on(AdminStoreTypePage.CREATE_STORE_TYPE_BUTTON),
                CommonWaitUntil.isVisible(AdminStoreTypePage.CREATE_STORE_TYPE_POPUP)
                );
    }

    public static Task fillInfoToCreate(Map<String, String> info) {
        return Task.where("Fill info to create",
                CommonWaitUntil.isVisible(AdminStoreTypePage.CREATE_STORE_TYPE_NAME_TEXTBOX),
                Enter.theValue(info.get("name")).into(AdminStoreTypePage.CREATE_STORE_TYPE_NAME_TEXTBOX)
        );
    }

    public static Task createSuccess(String action) {
        return Task.where("Create or update success",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                CommonWaitUntil.isNotVisible(AdminStoreTypePage.CREATE_STORE_TYPE_POPUP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Sync completed at"))
        );
    }

    public static Task goToEdit(String name) {
        return Task.where("Go to edit store type " + name,
                Click.on(AdminStoreTypePage.STORE_TYPE_EDIT_BUTTON(name)),
                CommonWaitUntil.isVisible(AdminStoreTypePage.EDIT_STORE_TYPE_POPUP(name))
        );
    }

    public static Task delete(String name) {
        return Task.where("Delete store type " + name,
                CommonWaitUntil.isVisible(AdminStoreTypePage.STORE_TYPE_DELETE_BUTTON(name)),
                Click.on(AdminStoreTypePage.STORE_TYPE_DELETE_BUTTON(name)),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Sync completed at"))
        );
    }

}
