package steps.admin.orders;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.orders.HandleMultipleOrder;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.CreateMultipleOrderPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.targets.Target;

import java.util.List;
import java.util.Map;

import static cucumber.constants.vendor.WebsiteConstants.INSTRUCTIONS_TEXAS;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminCreateMultipleOrderStepDefinitions {

    @And("Admin go to create new multiple order")
    public void admin_go_to_create_new_multiple_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.goToCreate()
        );
    }

    @And("Admin upload CSV file {string} to create multiple order")
    public void admin_upload_csv_file_to_create_multiple_order(String file) {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.uploadFile(file)
        );
    }

    @And("Admin create multiple order with upload CSV file {string}")
    public void admin_upload_csv_file_to_create_multiple_order2(String file) {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.uploadCSVFile(file)
        );
    }

    @And("Admin edit instruction create multiple order")
    public void admin_edit_instruction_multiple_order(String text) {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.editInstruction(text)
        );
    }

    @And("Admin check instruction create multiple order")
    public void admin_check_instruction_multiple_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CreateMultipleOrderPage.EDIT_INSTRUCTION_CONTENT).text().contains(infos.get(0).get("content").contains("random") ? Serenity.sessionVariableCalled("Instruction multiple order") : infos.get(0).get("content")),
                Ensure.that(CreateMultipleOrderPage.EDIT_INSTRUCTION_HISTORY).text().contains(infos.get(0).get("history")),
                Ensure.that(CreateMultipleOrderPage.EDIT_INSTRUCTION_HISTORY).text().contains(CommonHandle.setDate2(infos.get(0).get("date"), "MM/dd/yy"))
        );
    }

    @And("Admin verify order uploaded of file {string} in multi order")
    public void admin_verify_order_uploaded_in_multi_order(String file, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.CREATE_MULTI_ORDER_TITLE(file)),
                Ensure.that(CreateMultipleOrderPage.UPLOADED_STORE).text().contains(infos.get(0).get("store")),
                Ensure.that(CreateMultipleOrderPage.UPLOADED_CUSTOMER_PO).text().contains(infos.get(0).get("customerPO")),
                Ensure.that(CreateMultipleOrderPage.UPLOADED_LINE_ITEM).text().contains(infos.get(0).get("lineItem")),
                Ensure.that(CreateMultipleOrderPage.UPLOADED_STATUS).text().contains(infos.get(0).get("status")),
                Ensure.that(CreateMultipleOrderPage.UPLOADED_QUANTITY).text().contains(infos.get(0).get("quantity"))
        );
    }

    @And("Admin verify no order uploaded in multi order")
    public void admin_verify_no_order_uploaded_in_multi_order() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CreateMultipleOrderPage.UPLOADED_LINE_ITEM).isNotDisplayed()
        );
    }

    @And("Admin delete multi order record {string}")
    public void admin_delete_multi_order(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.deleteMultipleOrder(name)
        );
    }

    @And("Admin go to detail of multiple order")
    public void admin_go_to_detail_of_multiple_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.goToDetail()
        );
    }

    @And("Admin verify line item in multiple order detail")
    public void admin_verify_line_item_in_multiple_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        int size = infos.size();
        for (int i = 0; i < size; i++) {
            if (infos.get(i).get("sku").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CreateMultipleOrderPage.LINE_ITEM_PRODUCT()),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_SKU(infos.get(i).get("product"), i + 1)).isNotDisplayed(),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_SKU(infos.get(i).get("sku"), i + 1)).isNotDisplayed(),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_SKU(infos.get(i).get("upc"), i + 1)).isNotDisplayed(),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_SKU(infos.get(i).get("skuID"), i + 1)).isNotDisplayed()
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CreateMultipleOrderPage.LINE_ITEM_PRODUCT(i + 1)),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_PRODUCT(i + 1)).text().contains(infos.get(i).get("product")),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_SKU(i + 1)).text().contains(infos.get(i).get("sku")),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_SKU_ID(i + 1)).text().contains(infos.get(i).get("skuID")),
                        Check.whether(infos.get(i).get("state").isEmpty()).otherwise(
                                Ensure.that(CreateMultipleOrderPage.LINE_ITEM_STATE(i + 1)).text().contains(infos.get(i).get("state"))
                        ),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_UPC(i + 1)).text().contains(infos.get(i).get("upc")),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_STATUS(i + 1)).text().isEqualTo(infos.get(i).get("status")),
                        Check.whether(infos.get(i).get("error").isEmpty())
                                .otherwise(Ensure.that(CreateMultipleOrderPage.LINE_ITEM_ERROR(i + 1)).text().contains(infos.get(i).get("error"))),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_PRICE(i + 1)).text().isEqualTo(infos.get(i).get("price")),
                        Ensure.that(CreateMultipleOrderPage.LINE_ITEM_QUANTITY(i + 1)).attribute("value").contains(infos.get(i).get("quantity"))
                );
            }
        }
    }

    @And("Admin verify info of order number {int} in multiple order detail")
    public void admin_verify_order_multiple_order_detail(int number, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreateMultipleOrderPage.ORDER_INFO_NUMBER(number)),
                Click.on(CreateMultipleOrderPage.ORDER_INFO_NUMBER(number)),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                Ensure.that(CreateMultipleOrderPage.ORDER_INFO("order-number")).text().contains(CommonHandle.setDate2("currentDate", "yyMMdd")),
                Ensure.that(CreateMultipleOrderPage.ORDER_INFO("store")).text().isEqualTo(infos.get(0).get("store")),
                Ensure.that(CreateMultipleOrderPage.ORDER_INFO("customer-po")).text().contains(infos.get(0).get("customPO")),
                Ensure.that(CreateMultipleOrderPage.ORDER_INFO("line-item")).text().contains(infos.get(0).get("lineItems")),
                Ensure.that(CreateMultipleOrderPage.ORDER_INFO("status")).text().contains(infos.get(0).get("status")),
                Ensure.that(CreateMultipleOrderPage.ORDER_INFO("quantity")).text().isEqualTo(infos.get(0).get("quantity"))
        );

    }

    @And("Admin check line items not available in multiple order detail")
    public void admin_check_line_item_not_available_multiple_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        int size = infos.size();
        for (int i = 0; i < size; i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CreateMultipleOrderPage.LINE_ITEM_QUANTITY(infos.get(i).get("sku"))).isDisabled(),
                    Ensure.that(CreateMultipleOrderPage.LINE_ITEM_CHECKBOX_INPUT(infos.get(i).get("sku"))).isDisabled()
            );
        }
    }

    @And("Admin verify list multiple order")
    public void admin_verify_list_multiple_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            int j = i + 1;
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CreateMultipleOrderPage.MULTI_ORDER_LIST("id", j)),
                    Ensure.that(CreateMultipleOrderPage.MULTI_ORDER_LIST("id", j)).text().contains(infos.get(i).get("id")),
                    Ensure.that(CreateMultipleOrderPage.MULTI_ORDER_LIST("name", j)).text().contains(infos.get(i).get("name")),
                    Ensure.that(CreateMultipleOrderPage.MULTI_ORDER_LIST("creator", j)).text().contains(infos.get(i).get("creator")),
                    Ensure.that(CreateMultipleOrderPage.MULTI_ORDER_LIST("created-at", j)).text().contains(CommonHandle.setDate2(infos.get(i).get("date"), "MM/dd/yy")),
                    Ensure.that(CreateMultipleOrderPage.MULTI_ORDER_LIST("convert-state", j)).text().contains(infos.get(i).get("status"))
            );
        }
    }


    @And("Admin verify {string} in multiple order detail")
    public void admin_verify_in_multiple_order_detail(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        Target totalPayment = null;
        switch (type) {
            case "total":
                type = "tt";
                totalPayment = CreateMultipleOrderPage.TOTAL_PAYMENT;
                break;
            case "in stock":
                type = "in-stock";
                totalPayment = CreateMultipleOrderPage.TOTAL_PAYMENT_IN_STOCK;
                break;
            case "OOS or LS":
                type = "oos";
                totalPayment = CreateMultipleOrderPage.TOTAL_PAYMENT_OOS_LS;
                break;
        }

        int size = infos.size();
        for (int i = 0; i < size; i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CreateMultipleOrderPage.TOTAL_CASE_VALUE(type)),
                    Ensure.that(CreateMultipleOrderPage.TOTAL_CASE_VALUE(type)).text().contains(infos.get(i).get("totalCase")),
                    Ensure.that(CreateMultipleOrderPage.TOTAL_ORDER_VALUE(type)).text().contains(infos.get(i).get("totalOrderValue")),
                    Ensure.that(CreateMultipleOrderPage.TOTAL_DISCOUNT_VALUE(type)).text().contains(infos.get(i).get("discount")),
                    Ensure.that(CreateMultipleOrderPage.TOTAL_TAX_VALUE(type)).text().contains(infos.get(i).get("taxes")),
                    Ensure.that(CreateMultipleOrderPage.TOTAL_SPECIAL_DISCOUNT_VALUE(type)).text().contains(infos.get(i).get("specialDiscount")),
                    Ensure.that(totalPayment).text().contains(infos.get(i).get("totalPayment"))
            );
        }


    }

    @And("Admin choose line item to convert to order in multi")
    public void admin_choose_line_item_to_convert_to_order_in_multi(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.chooseLineItem(infos)
        );
    }

    @And("Admin choose all line item to convert multiple order")
    public void admin_choose_all_line_item_to_convert() {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.chooseAllLineItem()
        );
    }

    @And("Admin resolve UPC of item multiple order")
    public void admin_resolve_upc(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.resolveItem(infos)
        );
    }

    @And("Admin create multiple order from detail")
    public void admin_create_multiple_order_from_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.createOrderFromDetail()
        );
    }

    @And("Admin create multiple order from detail with customer PO")
    public void admin_create_multiple_order_from_detail_with_customer_PO() {
        theActorInTheSpotlight().attemptsTo(
                HandleMultipleOrder.createOrderFromDetailWithPO()
        );
    }

    @And("Admin search multiple order")
    public void admin_search_multiple(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                HandleMultipleOrder.searchMultiple(infos.get(0))
        );
    }
}
