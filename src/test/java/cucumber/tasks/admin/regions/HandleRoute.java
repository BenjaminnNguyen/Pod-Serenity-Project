package cucumber.tasks.admin.regions;

import cucumber.actions.GoBack;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.regions.AdminRouteForm;
import cucumber.user_interface.beta.Buyer.cart.CheckoutPage;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleRoute {

    public static Task goToCreateForm() {
        return Task.where("go to create form",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(AdminRouteForm.CREATE_FORM_LABEL)
        );
    }

    public static Performable fillInfo(List<Map<String, String>> infos) {
        return Task.where("fill info to create",
                actor -> {
                    actor.attemptsTo(
                            Enter.theValue(infos.get(0).get("name")).into(AdminRouteForm.D_TEXT("Name")),
                            CommonTask.chooseItemInDropdownWithValueInput4(AdminRouteForm.D_TEXT("Region"), infos.get(0).get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("region")))
                    );
                    // choose weekday
                    if (infos.get(0).get("weekdays").equals("Within 7 business days")) {
                        actor.attemptsTo(
                                Click.on(AdminRouteForm.WITHIN_7_DAY_CHECKBOX)
                        );
                    } else {
                        actor.attemptsTo(
                                Click.on(AdminRouteForm.SELECT_WEEKDAY_TEXTBOX)
                        );
                        for (Map<String, String> item : infos) {
                            actor.attemptsTo(
                                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(item.get("weekdays"))),
                                    Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(item.get("weekdays")))
                            );
                        }
                        actor.attemptsTo(
                                Click.on(AdminRouteForm.CREATE_FORM_LABEL)
                        );
                    }
                    // choose store
                    actor.attemptsTo(
                            CommonTask.chooseItemInDropdownWithValueInput1(AdminRouteForm.D_TEXT("Stores"), infos.get(0).get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("store"))),
                            Check.whether(infos.get(0).get("deliveryCost").equals(""))
                                    .otherwise(Enter.theValue(infos.get(0).get("deliveryCost")).into(AdminRouteForm.D_TEXT("Delivery cost"))),
                            Check.whether(infos.get(0).get("casePickFee").equals(""))
                                    .otherwise(Enter.theValue(infos.get(0).get("casePickFee")).into(AdminRouteForm.D_TEXT("Case Pick Fee")))
                    );
                }
        );
    }

    public static Task createSuccess() {
        return Task.where("create success",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(AdminRouteForm.CREATE_FORM_LABEL),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Route has been created successfully!")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)
        );
    }

    public static Task search(Map<String, String> info) {
        return Task.where("search",
                Check.whether(info.get("name").isEmpty())
                        .otherwise(Enter.theValue(info.get("name")).into(AdminRouteForm.NAME_SEARCH_TEXTBOX)),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput4(AdminRouteForm.REGION_SEARCH_TEXTBOX, info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Search"))
        );
    }

    public static Task editSuccess() {
        return Task.where("Edit success",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(AdminRouteForm.CREATE_FORM_LABEL),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Route has been updated successfully!")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)
        );
    }

    public static Task goToDetail(String name) {
        return Task.where("Go to detail ",
                Click.on(AdminRouteForm.NAME_RESULT(name)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable edit(List<Map<String, String>> infos) {
        return Task.where("Edit form",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(infos.get(0).get("name").equals(""))
                                    .otherwise(Enter.theValue(infos.get(0).get("name")).into(AdminRouteForm.D_TEXT("Name"))),
                            Check.whether(infos.get(0).get("region").equals(""))
                                    .otherwise(CommonTask.chooseItemInDropdownWithValueInput4(AdminRouteForm.D_TEXT("Region"), infos.get(0).get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("region"))))
                    );

                    // edit weekdays
                    if (infos.get(0).get("weekdays").equals("Within 7 business days")) {
                        actor.attemptsTo(
                                Check.whether(valueOf(AdminRouteForm.WITHIN_7_DAY_CHECKED), isCurrentlyVisible())
                                        .otherwise(Click.on(AdminRouteForm.WITHIN_7_DAY_CHECKBOX))
                        );
                    } else {
                        if (infos.get(0).get("weekdays").equals("Within 7 business days")) {
                            actor.attemptsTo(
                                    Check.whether(valueOf(AdminRouteForm.WITHIN_7_DAY_CHECKED), isCurrentlyVisible())
                                            .andIfSo(Click.on(AdminRouteForm.WITHIN_7_DAY_CHECKBOX)),
                                    Click.on(AdminRouteForm.SELECT_WEEKDAY_TEXTBOX)
                            );

                            for (Map<String, String> info : infos) {
                                actor.attemptsTo(
                                        Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("weekdays")))
                                );
                            }
                            actor.attemptsTo(
                                    Click.on(AdminRouteForm.EDIT_LABEL(infos.get(0).get("name")))
                            );
                        }
                    }
                    // edit store - add store
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput4(AdminRouteForm.D_TEXT("Stores"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))
                        );
                    }
                    // edit Delivery cost, case pick fee
                    actor.attemptsTo(
                            Enter.theValue(infos.get(0).get("deliveryCost")).into(AdminRouteForm.D_TEXT("Delivery cost")),
                            Enter.theValue(infos.get(0).get("casePickFee")).into(AdminRouteForm.D_TEXT("Case Pick Fee"))
                    );
                }
        );
    }

    public static Task closePopup() {
        return Task.where("Close popup",
                Click.on(CommonAdminForm.CLOSE_POPUP1),
                WindowTask.threadSleep(1000)
        );
    }
}
