package steps.admin.orders;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.orders.HandlePreOrders;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.orders.PreordersPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;

public class PreOrdersStepDefinition {

    @And("Admin search Pre order with info")
    public void admin_search_pre_order_with_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), Serenity.sessionVariableCalled("ID Pre-Order"), "");
        theActorInTheSpotlight().attemptsTo(
                HandlePreOrders.check(info)
        );
    }

    @And("Admin verify result search pre order")
    public void admin_verify_result_search_pre_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String idPre = Serenity.sessionVariableCalled("ID Pre-Order");
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(PreordersPage.ID_IN_RESULT_TABLE(idPre))),
                seeThat(CommonQuestions.targetText(PreordersPage.BUYER_IN_RESULT_TABLE(idPre)), containsString(infos.get(0).get("buyer"))),
                seeThat(CommonQuestions.targetText(PreordersPage.STORE_IN_RESULT_TABLE(idPre)), containsString(infos.get(0).get("store"))),
                seeThat(CommonQuestions.targetText(PreordersPage.STARTDATE_IN_RESULT_TABLE(idPre)), containsString(CommonHandle.setDate(infos.get(0).get("createDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(PreordersPage.STATUS_IN_RESULT_TABLE(idPre)), containsString(infos.get(0).get("status")))
        );
    }

    @And("Admin go to create order in pre order")
    public void go_to_create_order_in_pre_order() {
        String idPre = Serenity.sessionVariableCalled("ID Pre-Order");
        theActorInTheSpotlight().attemptsTo(
                HandlePreOrders.goToCreateOrder(idPre)
        );
    }

    @And("Admin create order in pre order")
    public void create_order_in_pre_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String idPre = Serenity.sessionVariableCalled("ID Pre-Order");
        theActorInTheSpotlight().attemptsTo(
                HandlePreOrders.createOrder(infos.get(0))
        );
    }

    @And("Verify price {string} in create new order")
    public void verify_summary_in_create_new_order(String type, DataTable dt) {
        String index = "1";
        if(type.equals("in stock")) {
            index = "2";
        }
        if(type.equals("OOS or LS")) {
            index = "3";
        }

        theActorInTheSpotlight().attemptsTo(
                Scroll.to(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Total cases", index)),
                WindowTask.threadSleep(3000)
        );
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(infos.get(0).get("totalCase").equals(""))
                            .otherwise(Ensure.that(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Total cases", index)).text().contains(infos.get(0).get("totalCase"))),
                Check.whether(infos.get(0).get("totalOrderValue").equals(""))
                        .otherwise(Ensure.that(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Total Order Value", index)).text().contains(infos.get(0).get("totalOrderValue"))),
                Check.whether(infos.get(0).get("discount").equals(""))
                        .otherwise(Ensure.that(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Discount", index)).text().contains(infos.get(0).get("discount"))),
                Check.whether(infos.get(0).get("taxes").equals(""))
                        .otherwise(Ensure.that(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Taxes", index)).text().contains(infos.get(0).get("taxes"))),
                Check.whether(infos.get(0).get("smallOrderSurcharge").equals(""))
                        .otherwise(Ensure.that(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Small order surcharge", index)).text().contains(infos.get(0).get("smallOrderSurcharge"))),
                Check.whether(infos.get(0).get("logisticsSurcharge").equals(""))
                        .otherwise(Ensure.that(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Logistics surcharge", index)).text().contains(infos.get(0).get("logisticsSurcharge"))),
                Check.whether(infos.get(0).get("specialDiscount").equals(""))
                        .otherwise(Ensure.that(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Special discount", index)).text().contains(infos.get(0).get("specialDiscount"))),
                Check.whether(infos.get(0).get("specialDiscount").equals(""))
                        .otherwise(Ensure.that(PreordersPage.DYNAMIC_PRICE_IN_SUMMARY("Total payment", index)).text().contains(infos.get(0).get("totalPayment")))
        );
    }

    @And("Admin verify general info of pre-order detail")
    public void admin_verify_general_info_of_pre_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(PreordersPage.GENERAL_INFO_HEADER),

                Ensure.that(PreordersPage.DATE_FIELD).text().contains(CommonHandle.setDate2(infos.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(PreordersPage.STORE_FIELD).text().contains(infos.get(0).get("store")),
                Ensure.that(PreordersPage.TOTAL_VALUE_FIELD).text().contains(infos.get(0).get("total")),
                Ensure.that(PreordersPage.STATE_FIELD).text().contains(infos.get(0).get("state")),
                Ensure.that(PreordersPage.ADDRESS_FIELD).text().contains(infos.get(0).get("address"))
        );
    }

    @And("Admin go to detail pre-order {string}")
    public void admin_go_to_detail_order_in_pre_order(String idPre) {
        if (idPre.equals("")) {
            idPre = Serenity.sessionVariableCalled("ID Pre-Order");
        }
        theActorInTheSpotlight().attemptsTo(
                HandlePreOrders.goToDetail(idPre)
        );
    }

    @And("Admin verify line item in pre-order detail")
    public void admin_verify_line_item_in_pre_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(PreordersPage.SKU_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("sku")),
                Ensure.that(PreordersPage.PRODUCT_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("product")),
                Ensure.that(PreordersPage.BRAND_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("brand")),
                Ensure.that(PreordersPage.CASE_PRICE_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("casePrice")),
                Ensure.that(PreordersPage.UNIT_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("unit")),
                Ensure.that(PreordersPage.QUANTITY_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("quantity")),
                Ensure.that(PreordersPage.STATE_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("state")),
                Ensure.that(PreordersPage.AVAILABILITY_DETAIL(infos.get(0).get("sku"))).text().contains(infos.get(0).get("availability"))
        );
    }
}
