package cucumber.tasks.admin.financial;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.AdjustmentTypePage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class HandleStoreAdjustmentTypes {

    public static Task goToCreate() {
        return Task.where("Go to create store adjustment type",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.TITLE_POPUP)
        );
    }

    public static Task fillInfoToCreate(String name) {
        return Task.where("Fill info to create",
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_CREATE_TEXTBOX),
                Enter.theValue(name).into(AdjustmentTypePage.NAME_CREATE_TEXTBOX)
        );
    }

    public static Task createSuccess() {
        return Task.where("Create store adjustment type success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create"))
        );
    }

    public static Task createError(String message) {
        return Task.where("Create adjustment type success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Name has already been taken"))
        );
    }

    public static Performable search(String name) {
        return Task.where("Search adjustment type",
                actor -> {
                    int count = 0;
                    while (CommonQuestions.isControlUnDisplay(AdjustmentTypePage.NAME_IN_RESULT(name)).answeredBy(theActorInTheSpotlight())) {
                        actor.attemptsTo(
                                Click.on(AdjustmentTypePage.NEXT_TAB_BUTTON),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                                WindowTask.threadSleep(1000)
                        );
                        count = count + 1;
                        if (count < 5) {
                            // không tìm thấy
                            break;
                        }
                    }
                }
        );
    }

    public static Task goToDetail(String name) {
        return Task.where("Go to adjustment type detail",
                CommonWaitUntil.isVisible(AdjustmentTypePage.NAME_IN_RESULT(name)),
                Click.on(AdjustmentTypePage.NAME_IN_RESULT(name)),
                CommonWaitUntil.isVisible(AdjustmentTypePage.TITLE_POPUP_DETAIL(name))
        );
    }


    public static Task edit(String nameEdit) {
        return Task.where("Edit Adjustment type",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Enter.theValue(nameEdit).into(AdjustmentTypePage.NAME_CREATE_TEXTBOX)
        );
    }

    public static Task editSuccess() {
        return Task.where("Edit adjustment type success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(AdjustmentTypePage.MESSAGE_UPDATE)
        );
    }

    public static Task editError(String message) {
        return Task.where("Edit adjustment type success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Name has already been taken"))
        );
    }

    public static Task close() {
        return Task.where("Close popup adjustment type",
                CommonWaitUntil.isVisible(CommonAdminForm.CLOSE_POPUP1),
                Click.on(CommonAdminForm.CLOSE_POPUP1)
        );
    }

    public static Task delete(String name) {
        return Task.where("Delete adjustment type with name " + name,
                CommonWaitUntil.isVisible(AdjustmentTypePage.DELETE_IN_RESULT(name)),
                Click.on(AdjustmentTypePage.DELETE_IN_RESULT(name)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(AdjustmentTypePage.MESSAGE_UPDATE)
        );
    }


    public static Task deleleError(String name, String message) {
        return Task.where("Delete adjustment type with name " + name,
                CommonWaitUntil.isVisible(AdjustmentTypePage.DELETE_IN_RESULT(name)),
                Click.on(AdjustmentTypePage.DELETE_IN_RESULT(name)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }
}
