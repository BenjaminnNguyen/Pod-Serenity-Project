package steps.admin.lp;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.lp.HandleLPCompanies;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.LP.LPCompaniesPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminLPCompaniesStepDefinitions {

    @And("Admin search LP company")
    public void admin_search_LP_company(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleLPCompanies.search(info.get(0))
        );
    }

    @And("Admin check LP company list")
    public void admin_check_LP_company(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        for (int i = 0; i < info.size(); i++) {
            HashMap<String, String> hashMap = CommonTask.setValue(info.get(i), "id", info.get(i).get("id"), Serenity.sessionVariableCalled("LP Company id api" + info.get(i).get("businessName")), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(LPCompaniesPage.D_RESULT("business_name", i + 1)),
                    Ensure.that(LPCompaniesPage.D_RESULT("id el-table__cell", i + 1)).text().contains(hashMap.get("id")),
                    Ensure.that(LPCompaniesPage.D_RESULT("business_name", i + 1)).text().contains(hashMap.get("businessName")),
                    Ensure.that(LPCompaniesPage.D_RESULT("roles", i + 1)).text().contains(hashMap.get("roles")),
                    Ensure.that(LPCompaniesPage.D_RESULT("contact-number", i + 1)).text().contains(hashMap.get("contactNumber"))
            );
        }
    }

    @And("Admin refresh LP company list")
    public void admin_refresh_LP_company() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPCompaniesPage.REFRESH_PAGE_BUTTON),
                Click.on(LPCompaniesPage.REFRESH_PAGE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin {string} delete LP company {string}")
    public void admin_delete_LP_company(String action, String lp) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPCompaniesPage.DELETE_LP_COMPANY(lp)),
                Click.on(LPCompaniesPage.DELETE_LP_COMPANY(lp)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Deleting this LP company will also delete all its lps. Are you sure you want to continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
//                WindowTask.threadSleep(2000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin check LP company {string} not show on list")
    public void admin_check_LP_company(String lp) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(LPCompaniesPage.DELETE_LP_COMPANY(lp))
        );
    }

    @And("Admin create LP company")
    public void admin_create_LP_company(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Business name"))).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                        Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Business name"))
                ),
                Check.whether(info.get(0).get("businessName").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("businessName")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Business name"))
                ),
                Check.whether(info.get(0).get("roles").contains("Driver")).andIfSo(
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_SPAN_TEXT("Driver"))
                ),
                Check.whether(info.get(0).get("roles").contains("Warehousing")).andIfSo(
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_SPAN_TEXT("Warehousing"))
                ),
                Check.whether(info.get(0).get("contactNumber").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("contactNumber")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Contact number"))
                ),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin check create LP company {string} success and {string}")
    public void admin_check_LP_company_success(String lp, String action) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Success")),
                Ensure.that(CommonAdminForm.DIALOG_MESSAGE_TEXT).text().contains("LP company " + lp + " has been created successfully. Please select an option bellow to continue?"),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Back to LP companies list")).isDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create logistics partner for this LP company")).isDisplayed(),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)

        );
    }

    @And("Admin go to detail of LP company and check information")
    public void admin_go_detail_LP_company(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Business name"))).otherwise(
                        CommonWaitUntil.isVisible(LPCompaniesPage.DETAIL_LP_COMPANY(info.get(0).get("businessName"))),
                        Click.on(LPCompaniesPage.DETAIL_LP_COMPANY(info.get(0).get("businessName"))),
                        CommonWaitUntil.isVisible(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Business name"))
                ),
                WindowTask.threadSleep(1000),
                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Business name")).text().contains(info.get(0).get("businessName")),
                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Contact number")).text().contains(info.get(0).get("contactNumber")),
                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Roles")).text().contains(info.get(0).get("roles"))
        );
    }

    @And("Admin click on field {string}")
    public void admin_click_field(String field) {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isClickable(LPCompaniesPage.DETAIL_LP_COMPANY_INFO(field)),
                Click.on(LPCompaniesPage.DETAIL_LP_COMPANY_INFO(field))
        );
    }

    @And("Admin clear field tooltip")
    public void admin_clear_field() {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                Clear.field(CommonAdminForm.TOOLTIP_TEXTBOX).then(
                        Click.on(CommonAdminForm.TOOLTIP_TEXTBOX)
                ),
                Enter.theValue("1").into(CommonAdminForm.TOOLTIP_TEXTBOX).thenHit(Keys.BACK_SPACE).thenHit(Keys.TAB),
                Click.on(CommonAdminForm.TOOLTIP_TEXTBOX)

        );
    }

    @And("Admin enter text {string} on text box tooltip")
    public void admin_edit_text_box_tooltip(String value) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                Enter.theValue(value).into(CommonAdminForm.TOOLTIP_TEXTBOX)
        );
    }

    @And("Admin choose value {string} on text box dropdown tooltip")
    public void admin_edit_text_box_dropdown_tooltip(String value) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                CommonTask.chooseItemInDropdown(CommonAdminForm.TOOLTIP_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(value))
        );
    }

    @And("Admin choose value {string} on text box dropdown input tooltip")
    public void admin_edit_text_box_dropdown_input_tooltip(String value) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.TOOLTIP_TEXTBOX, value, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(value))
        );
    }

    @And("Admin remove value {string} on text box dropdown tooltip")
    public void admin_remove_text_box_dropdown_tooltip(String value) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                Click.on(CommonAdminForm.ICON_CIRCLE_DELETE(value)),
                Click.on(CommonAdminForm.TOOLTIP_TEXTBOX)
        );
    }

    @And("Admin upload documents for LP company")
    public void admin_upload_documents(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        for (int i = 0; i < info.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                    Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                    CommonFile.upload(info.get(i).get("document"), LPCompaniesPage.LP_COMPANY_DOCS(i + 1)),
                    Enter.theValue(info.get(i).get("documentName")).into(LPCompaniesPage.LP_COMPANY_DOCS("Document name", i + 1)),
                    Enter.theValue(CommonHandle.setDate2(info.get(i).get("startDate"), "MM/dd/yy")).into(LPCompaniesPage.LP_COMPANY_DOCS("Start date", i + 1)).thenHit(Keys.TAB),
                    Enter.theValue(CommonHandle.setDate2(info.get(i).get("expiryDate"), "MM/dd/yy")).into(LPCompaniesPage.LP_COMPANY_DOCS("Expiry date", i + 1)).thenHit(Keys.TAB),
                    Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                    CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
            );
        }
    }

    @And("Admin check documents for LP company")
    public void admin_check_documents(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        for (int i = 0; i < info.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(LPCompaniesPage.LP_COMPANY_DOCS_INFO(i + 1)).text().contains(info.get(i).get("document")),
                    Ensure.that(LPCompaniesPage.LP_COMPANY_DOCS("Document name", i + 1)).value().contains(info.get(i).get("documentName")),
                    Ensure.that(LPCompaniesPage.LP_COMPANY_DOCS("Start date", i + 1)).value().contains(CommonHandle.setDate2(info.get(i).get("startDate"), "MM/dd/yy")),
                    Ensure.that(LPCompaniesPage.LP_COMPANY_DOCS("Expiry date", i + 1)).value().contains(CommonHandle.setDate2(info.get(i).get("expiryDate"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check logistics partner of LP company")
    public void admin_check_lp(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        for (Map<String, String> map : info) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(LPCompaniesPage.LP_SECTION_EMAIL(map.get("lpName"))).text().contains(map.get("email")),
                    Ensure.that(LPCompaniesPage.LP_SECTION_CONTACT(map.get("lpName"))).text().contains(map.get("contact"))
            );
        }
    }

    @And("Admin remove documents for LP company")
    public void admin_remove_documents() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPCompaniesPage.REMOVE_LP_COMPANY_DOCS),
                Click.on(LPCompaniesPage.REMOVE_LP_COMPANY_DOCS),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin download documents {string} of LP company")
    public void admin_download_documents(String docs) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPCompaniesPage.LP_COMPANY_DOCS_DOWNLOAD(docs)),
                Click.on(LPCompaniesPage.LP_COMPANY_DOCS_DOWNLOAD(docs)),
                WindowTask.threadSleep(1000),
                WindowTask.switchToChildWindowsByTitle(docs)
        );
    }
}
