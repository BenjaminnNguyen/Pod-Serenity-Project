package cucumber.tasks.admin.products;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.products.AdminProductRecommendationsPage;
import cucumber.user_interface.admin.products.AdminAllProductsPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleProductRecommendations {


    public static Task filter(String buyer) {
        return Task.where("Search",
                Check.whether(CommonQuestions.isControlUnDisplay(AdminAllProductsPage.SEARCH_BUTTON)).andIfSo(
                        Click.on(AdminAllProductsPage.SHOW_FILTERS)
                ),
                Check.whether(buyer.isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")),
                        Enter.theValue(buyer).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")),
                        CommonTask.ChooseValueFromSuggestions(buyer)
                ),
                Click.on(AdminAllProductsPage.SEARCH_BUTTON),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(AdminAllProductsPage.LOADING_ICON)
        );
    }

    public static Task resetFilter() {
        return Task.where("Reset filter",
                CommonWaitUntil.isVisible(AdminAllProductsPage.RESET_BUTTON),
                Click.on(AdminAllProductsPage.RESET_BUTTON),
                CommonWaitUntil.isNotVisible(AllBrandsPage.LOADING_ICON)

        );
    }

    public static Task create(List<Map<String, String>> list) {
        return Task.where("Input create info",
//                openCreate(),
//                Ensure.that(AdminProductRecommendationsPage.DYNAMIC_FIELD("Product")).isDisabled(),
                Check.whether(list.get(0).get("buyer").isEmpty()).otherwise(
                        Enter.theValue(list.get(0).get("buyer")).into(AdminProductRecommendationsPage.DYNAMIC_FIELD("Buyer")),
                        CommonTask.ChooseValueFromSuggestionsWithJS(list.get(0).get("buyer"))
                ),
                Check.whether(list.get(0).get("product").isEmpty()).otherwise(
                        CommonWaitUntil.isEnabled(AdminProductRecommendationsPage.DYNAMIC_FIELD("Product")),
                        Enter.theValue(list.get(0).get("product")).into(AdminProductRecommendationsPage.DYNAMIC_FIELD("Product")),
                        CommonTask.ChooseValueFromSuggestionsWithJS(list.get(0).get("product"))
                ),
                Check.whether(list.get(0).get("comment").isEmpty()).otherwise(
                        Enter.theValue(list.get(0).get("comment")).into(AdminProductRecommendationsPage.DYNAMIC_FIELD("Comment"))
                )
        );
    }

    public static Task openCreate() {
        return Task.where("Open create",
                CommonWaitUntil.isVisible(AdminAllProductsPage.CREATE_BUTTON),
                Click.on(AdminAllProductsPage.CREATE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AdminProductRecommendationsPage.DYNAMIC_FIELD("Buyer")),
                Ensure.that(AdminProductRecommendationsPage.DYNAMIC_FIELD("Product")).isDisabled()

        );
    }

    public static Task openEdit(String name) {
        return Task.where("Open edit",
                CommonWaitUntil.isVisible(AdminAllProductsPage.DYNAMIC_TABLE(name, "name")),
                Click.on(AdminAllProductsPage.DYNAMIC_TABLE(name, "name")),
                CommonWaitUntil.isVisible(AdminProductRecommendationsPage.DYNAMIC_FIELD("Buyer")));
    }

    public static Task clickEdit(String name) {
        return Task.where("Click edit",
                CommonWaitUntil.isVisible(AdminProductRecommendationsPage.EDIT_BUTTON(name)),
                Click.on(AdminProductRecommendationsPage.EDIT_BUTTON(name)),
                CommonWaitUntil.isVisible(AdminProductRecommendationsPage.DYNAMIC_FIELD("Buyer")));
    }

    public static Task delete(String name, String type) {
        return Task.where("Delete create",
                CommonWaitUntil.isVisible(AdminProductRecommendationsPage.DELETE_BUTTON(name)),
                Click.on(AdminProductRecommendationsPage.DELETE_BUTTON(name)),
                WindowTask.threadSleep(1000),
//                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this record. Continue?")).isDisabled(),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(type)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(type)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)

                );
    }

    public static Task confirmCreate() {
        return Task.where("Confirm create",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task confirmUpdate() {
        return Task.where("Confirm create",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }
}
