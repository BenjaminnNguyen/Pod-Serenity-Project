package steps.admin.changeRequests;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.changeRequests.HandleChangeRequests;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.changeRequest.AdminChangeRequestPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;

public class AdminChangeRequestStepDefinitions {

    @And("Admin search change request by info")
    public void search_the_change_request(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "value", infos.get(0).get("value"), Serenity.sessionVariableCalled("SKU inventory"), "create by api");

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleChangeRequests.search(info)
        );
    }

    @And("Admin search change request by info1")
    public void search_the_change_request1(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "skuName", infos.get(0).get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "create by api");

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleChangeRequests.search(info)
        );
    }

    @And("Admin check list change request")
    public void checkList(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(AdminChangeRequestPage.DYNAMIC_TABLE("requested-date el")), containsString(CommonHandle.setDate2(list.get(0).get("requestedDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(AdminChangeRequestPage.DYNAMIC_TABLE("effective-date el")), containsString(CommonHandle.setDate2(list.get(0).get("effectiveDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.attributeText(AdminChangeRequestPage.DYNAMIC_TABLE2("submitted-by"), "data-original-text"), containsString(list.get(0).get("vendor"))),
                seeThat(CommonQuestions.attributeText(AdminChangeRequestPage.DYNAMIC_TABLE2("brand"), "data-original-text"), containsString(list.get(0).get("brand"))),
                seeThat(CommonQuestions.attributeText(AdminChangeRequestPage.DYNAMIC_TABLE2("product"), "data-original-text"), containsString(list.get(0).get("product"))),
                seeThat(CommonQuestions.attributeText(AdminChangeRequestPage.DYNAMIC_TABLE2("note"), "data-original-text"), containsString(list.get(0).get("note")))
        );
        if (list.get(0).containsKey("changesProduct"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetTextExceptString(AdminChangeRequestPage.DYNAMIC_TABLE("price el-table__cell"), "\""), containsString(list.get(0).get("changesProduct").replaceAll("\"", "")))
            );
        if (list.get(0).containsKey("changesSKU"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetTextExceptString(AdminChangeRequestPage.DYNAMIC_TABLE("update sku"), "\""), containsString(list.get(0).get("changesSKU").replaceAll("\"", "")))
            );
    }

    @And("Admin go to detail change request id {string}")
    public void go_to_detail_change_request_id(String number) {
        theActorInTheSpotlight().attemptsTo(
                HandleChangeRequests.goToDetail(number)
        );
    }

    @And("Admin get id change request first result")
    public void get_id_change_request() {
        String id = Text.of(AdminChangeRequestPage.DYNAMIC_TABLE("id")).answeredBy(theActorInTheSpotlight()).toString();
        Serenity.setSessionVariable("ID Change request").to(id);
    }

    @And("Admin verify info change request detail")
    public void verify_info_change_request(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminChangeRequestPage.EFFECT_DATE_TEXTBOX_DETAIL),
                Ensure.that(AdminChangeRequestPage.EFFECT_DATE_TEXTBOX_DETAIL).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("effectiveDate"), "MM/dd/yy")),
                Ensure.that(AdminChangeRequestPage.SIZE_L_TEXTBOX_DETAIL).attribute("value").contains(infos.get(0).get("sizeL")),
                Ensure.that(AdminChangeRequestPage.SIZE_W_TEXTBOX_DETAIL).attribute("value").contains(infos.get(0).get("sizeW")),
                Ensure.that(AdminChangeRequestPage.SIZE_H_TEXTBOX_DETAIL).attribute("value").contains(infos.get(0).get("sizeH")),
                Ensure.that(AdminChangeRequestPage.HISTORY_FROM_DETAIL).text().contains(infos.get(0).get("historyFrom")),
                Ensure.that(AdminChangeRequestPage.HISTORY_TO_DETAIL).text().contains(infos.get(0).get("historyTo"))
        );
    }

    @And("Admin update change request")
    public void update_change_request(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
            HandleChangeRequests.edit(infos.get(0))
        );
    }

    @And("Admin update change request success")
    public void update_change_request_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleChangeRequests.editSuccess()
        );
    }

    @And("Admin delete change request {string}")
    public void delete_change_request_success(String id) {
        if(id.equals("")) {
            id = Serenity.sessionVariableCalled("");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleChangeRequests.delete(id)
        );
    }
}
