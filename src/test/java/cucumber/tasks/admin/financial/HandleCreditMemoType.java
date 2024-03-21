package cucumber.tasks.admin.financial;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.AdjustmentTypePage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;

public class HandleCreditMemoType {

    public static Task goToCreate() {
        return Task.where("Go to create credit memo type",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.TITLE_POPUP)
        );
    }

    public static Task delete(String name) {
        return Task.where("Delete adjustment type with name " + name,
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_IN_RESULT(name)),
                JavaScriptClick.on(AdjustmentTypePage.DELETE_IN_RESULT(name)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(AdjustmentTypePage.MESSAGE_UPDATE)
        );
    }
}
