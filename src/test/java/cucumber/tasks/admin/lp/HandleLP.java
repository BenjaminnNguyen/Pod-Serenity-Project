package cucumber.tasks.admin.lp;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.LP.LPDetailPage;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.List;
import java.util.Map;

public class HandleLP {

    public static Task search(Map<String, String> info) {
        return Task.where("Search lp company",
                Check.whether(info.get("fullName").isEmpty()).otherwise(
                        Enter.theValue(info.get("fullName")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("full_name"))
                ),
                Check.whether(info.get("lpCompany").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[logistics_company_id]"), info.get("lpCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("lpCompany")))
                ),
                Check.whether(info.get("email").isEmpty()).otherwise(
                        Enter.theValue(info.get("email")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email"))
                ),
                Check.whether(info.get("contactNumber").isEmpty()).otherwise(
                        Enter.theValue(info.get("contactNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("contact_number"))
                ),
                Check.whether(info.get("status").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("active_state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("status")))
                ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String lp) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(VendorCompaniesPage.NAME_RESULT(lp)),
                Click.on(VendorCompaniesPage.NAME_RESULT(lp)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task createLP(List<Map<String, String>> info) {
        return Task.where("create lp",
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_INPUT_PLACEHOLDER("First name"))).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                        Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create"))
                ),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT("Name")),
                Check.whether(info.get(0).get("firstName").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("firstName")).into(CommonAdminForm.DYNAMIC_INPUT_PLACEHOLDER("First name"))
                ),
                Check.whether(info.get(0).get("lastName").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("lastName")).into(CommonAdminForm.DYNAMIC_INPUT_PLACEHOLDER("Last name"))
                ),
                Check.whether(info.get(0).get("email").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("email")).into(CommonAdminForm.DYNAMIC_INPUT("Email"))
                ),
                Check.whether(info.get(0).get("contactNumber").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("contactNumber")).into(CommonAdminForm.DYNAMIC_INPUT("Contact number"))
                ),
                Check.whether(info.get(0).get("password").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("password")).into(CommonAdminForm.DYNAMIC_INPUT("Password"))
                ),
                Check.whether(info.get(0).get("lpCompany").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_INPUT("LP company"), info.get(0).get("lpCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get(0).get("lpCompany")))
                ),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable editGeneralInfo(Map<String, String> info) {
        return Task.where("Edit general info",
                actor -> {
                    actor.attemptsTo(Check.whether(info.get("email").equals(""))
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(LPDetailPage.DYNAMIC_DETAIL("Email"), info.get("email"))),
                            Check.whether(info.get("firstName").equals(""))
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(LPDetailPage.DYNAMIC_DETAIL("First name"), info.get("firstName"))),
                            Check.whether(info.get("lastName").equals(""))
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(LPDetailPage.DYNAMIC_DETAIL("Last name"), info.get("lastName"))),
                            Check.whether(info.get("lpCompany").equals(""))
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(LPDetailPage.DYNAMIC_DETAIL("LP company"), info.get("lpCompany"))),
                            Check.whether(info.get("contactNumber").equals(""))
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(LPDetailPage.DYNAMIC_DETAIL("Contact number"), info.get("contactNumber")))
                    );
                }
        );
    }
}
