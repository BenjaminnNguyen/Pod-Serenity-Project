package cucumber.tasks.admin.orders;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.CreateMultipleOrderPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Upload;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.questions.JavaScript;
import net.serenitybdd.screenplay.targets.Target;
import net.thucydides.core.webdriver.javascript.JavascriptExecutorFacade;
import org.openqa.selenium.Keys;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

public class HandleMultipleOrder {
    public static Task goToCreate() {
        return Task.where("Go to create multiple order",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Create")),
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.UPLOAD_CSV_FILE_POPUP)
        );
    }

    public static Task uploadFile(String fileName) {
        return Task.where("Go to create multiple order",
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.UPLOAD_CSV_FILE_POPUP),
                CommonFile.upload1(fileName, CreateMultipleOrderPage.UPLOAD_CSV_BUTTON),
                CommonWaitUntil.isNotVisible(CreateMultipleOrderPage.UPLOAD_CSV_FILE_POPUP)
        );
    }

    public static Task uploadCSVFile(String fileName) {
        return Task.where("Go to create multiple order",
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.UPLOAD_CSV_FILE_POPUP),
                CommonFile.upload1("multipleOrder/" + fileName, CreateMultipleOrderPage.UPLOAD_CSV_BUTTON),
                CommonWaitUntil.isNotVisible(CreateMultipleOrderPage.UPLOAD_CSV_FILE_POPUP),
                WindowTask.threadSleep(1000)
        );
    }

    public static Performable editInstruction(String text) {
        String str = "Auto random " + Utility.getRandomString(5);
        Serenity.setSessionVariable("Instruction multiple order").to(str);
        return Task.where("Go to create multiple order",
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.EDIT_INSTRUCTION_BUTTON),
                Click.on(CreateMultipleOrderPage.EDIT_INSTRUCTION_BUTTON),
                WindowTask.threadSleep(1000),
                WindowTask.addTextToCodeMirror(str, CreateMultipleOrderPage.EDIT_INSTRUCTION_TEXT),
                WindowTask.threadSleep(1000),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update"))
        );
    }

    public static Task goToDetail() {
        return Task.where("Go to detail of multiple order",
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.UPLOADED_FIRST_ITEM),
                Click.on(CreateMultipleOrderPage.UPLOADED_FIRST_ITEM),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task deleteMultipleOrder(String name) {
        return Task.where("delete Multiple Order " + name,
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.MULTI_ORDER_NAME_DELETE(name)),
                Click.on(CreateMultipleOrderPage.MULTI_ORDER_NAME_DELETE(name)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable chooseLineItem(List<Map<String, String>> infos) {
        return Task.where("Go to detail of multiple order",
                actor -> {
                    int size = infos.size();
                    for (int i = 0; i < size; i++) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CreateMultipleOrderPage.LINE_ITEM_CHECKBOX(infos.get(i).get("sku"))),
                                Check.whether(infos.get(i).get("quantity").equals(""))
                                        .otherwise(
//                                                Clear.field(CreateMultipleOrderPage.LINE_ITEM_QUANTITY(infos.get(i).get("sku"))),
                                                Enter.theValue(infos.get(i).get("quantity")).into(CreateMultipleOrderPage.LINE_ITEM_QUANTITY(infos.get(i).get("sku"))).thenHit(Keys.TAB),
                                                WindowTask.threadSleep(1000)),
                                Click.on(CreateMultipleOrderPage.LINE_ITEM_CHECKBOX(infos.get(i).get("sku")))
                        );
                    }
                }
        );
    }

    public static Performable chooseAllLineItem() {
        return Task.where("Go to detail of multiple order",
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.LINE_ITEM_SELECT_ALL),
                Click.on(CreateMultipleOrderPage.LINE_ITEM_SELECT_ALL),
                WindowTask.threadSleep(1000)
        );
    }

    public static Performable resolveItem(List<Map<String, String>> infos) {
        return Task.where("Go to detail of multiple order",
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.RESOLVE_UPC(infos.get(0).get("oldSKU"))),
                Click.on(CreateMultipleOrderPage.RESOLVE_UPC(infos.get(0).get("oldSKU"))),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_SPAN_TEXT("UPC / EAN " + infos.get(0).get("upc"))),
                Click.on(CreateMultipleOrderPage.RESOLVE_UPC_NEW(infos.get(0).get("newSKU"))),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Resolve")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Resolve")),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task createOrderFromDetail() {
        return Task.where("Create Order from multiple order detail",
                CommonWaitUntil.isClickable(CommonAdminForm.DYNAMIC_BUTTON("Create order")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create order")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Selected items have been converted successfully!")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Create order"))
        );
    }

    public static Task createOrderFromDetailWithPO() {
        return Task.where("Create Order from multiple order detail with po",
                CommonWaitUntil.isClickable(CommonAdminForm.DYNAMIC_BUTTON("Create order")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create order")),
                WindowTask.threadSleep(500),
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG("The customer PO number was used by the order(s) listed below. Do you still want to continue?")))
                        .andIfSo(
                                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue"))
                        ),
                // popup custom po
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Selected items have been converted successfully!"))
//                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Create order"))
        );
    }

    public static Task searchMultiple(Map<String, String> map) {
        return Task.where("Admin search multiple order",
                CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_INPUT("Creator"), map.get("creator"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(map.get("creator"))),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Search")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Search")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

}
