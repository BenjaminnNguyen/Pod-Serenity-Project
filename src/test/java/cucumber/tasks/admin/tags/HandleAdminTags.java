package cucumber.tasks.admin.tags;

import cucumber.singleton.GVs;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.tags.AdminTagsPage;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.matchers.WebElementStateMatchers;
import net.serenitybdd.screenplay.questions.WebElementQuestion;
import net.serenitybdd.screenplay.targets.Target;
import net.serenitybdd.screenplay.waits.WaitUntil;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyEnabled;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.stateOf;

public class HandleAdminTags {

    public static Task navigate() {
        return Task.where("Navigate to Tags in sidebar",
                CommonWaitUntil.isVisible(AdminTagsPage.TAGS_SIDEBAR),
                Click.on(AdminTagsPage.TAGS_SIDEBAR),
                WaitUntil.the(CommonAdminForm.LOADING_SPINNER, WebElementStateMatchers.isNotVisible()).forNoMoreThan(GVs.HTTP_TIMEOUT).seconds(),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task goToCreate() {
        return Task.where("Go to create tags",
                CommonWaitUntil.isVisible(CommonAdminForm.CREATE_BUTTON_ON_HEADER),
                Click.on(CommonAdminForm.CREATE_BUTTON_ON_HEADER)
        );
    }


    public static Task confirmCreate() {
        return Task.where("Go to create tags",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task supportTarget(String target) {
        return Task.where("Go to create tags with target  " + target,
                Check.whether(target.isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_SPAN_TEXT(target)),
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_SPAN_TEXT(target))
                )
        );
    }

    public static Task createInfo(List<Map<String, String>> info) {
        return Task.where("Go to create tag",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name")),
                Check.whether(info.get(0).get("name").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("name")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name"))
                ),
                Check.whether(info.get(0).get("description").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("description")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Description"))
                ),
                Check.whether(info.get(0).get("visibility").isEmpty()).otherwise(
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_SPAN_TEXT(info.get(0).get("visibility")))
                )
        );
    }

    public static Task search(Map<String, String> info) {
        String[] target = info.get("target").split(",");
        return Task.where("Search tags",
                Check.whether(info.get("term").isEmpty()).otherwise(
                        Enter.theValue(info.get("term")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[any_text]"))
                ),
                Check.whether(info.get("target").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown4(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[tag_target_ids]"), target)
                ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task deleteTag(String name) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(CommonAdminForm.DELETE(name)),
                Click.on(CommonAdminForm.DELETE(name)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String name) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(VendorCompaniesPage.NAME_RESULT(name)),
                Click.on(VendorCompaniesPage.NAME_RESULT(name)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }
    public static Task assignTab(String target) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(AdminTagsPage.TAG_ASSIGN_TARGET(target)),
                Click.on(AdminTagsPage.TAG_ASSIGN_TARGET(target)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AdminTagsPage.TAG_ASSIGN_TARGET_EXPIRY())
        );
    }

    public static Performable assignTag(String name, List<Map<String, String>> list) {
        return Task.where("Go to detail",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(AdminTagsPage.TAG_ASSIGN(name)),
                            Click.on(AdminTagsPage.TAG_ASSIGN(name)),
                            WindowTask.threadSleep(2000),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                    );
                    for (Map<String, String> map : list) {
                        actor.attemptsTo(
                                assignTab(map.get("target")),
                                Check.whether(map.get("expiryDate").isEmpty()).otherwise(
                                        Enter.theValue(CommonHandle.setDate2(map.get("expiryDate"), "MM/dd/yy")).into(AdminTagsPage.TAG_ASSIGN_TARGET_EXPIRY())
                                ),
                                Check.whether(map.get("value").isEmpty()).otherwise(
                                        CommonTask.chooseItemInDropdownWithValueInput(AdminTagsPage.TAG_ASSIGN_TARGET_VALUE(), map.get("value"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("value")))
                                ),
                                WindowTask.threadSleep(1000),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                        );
                    }
                }
        );
    }

    public static Performable checkTarget(String... value) {
        return Task.where("Check tag targets",
                actor -> {
                    for (String target : value) {
                        actor.attemptsTo(
                                Ensure.that(AdminTagsPage.TAG_TARGET(target)).isDisplayed()
                        );
                    }
                }
        );
    }
}
