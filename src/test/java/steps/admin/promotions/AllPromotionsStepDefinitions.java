package steps.admin.promotions;

import cucumber.tasks.common.*;
import cucumber.tasks.vendor.promotion.PromotionVendorTask;
import cucumber.user_interface.beta.Vendor.promotion.VendorPromotionPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.promotions.HandlePromotions;
import cucumber.tasks.api.CommonHandle;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.HomePageForm;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.promotion.AllPromotionsPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.CommonEnsure;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.apache.xmlbeans.impl.xb.xsdschema.All;
import org.hamcrest.CoreMatchers;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class AllPromotionsStepDefinitions {

    @And("Create promotion")
    public void create_buy_in_promotion(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.create(list.get(0))
        );
    }

    @And("Choose regions to promo")
    public void choose_region_to_promo(DataTable infos) {
        List<Map<String, String>> actuals = infos.asMaps(String.class, String.class);
        for (int i = 0; i < actuals.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    HandlePromotions.chooseRegion(actuals.get(i).get("region"))
            );
        }
    }

    @And("Choose stores and buyer company to promotion")
    public void choose_stores_to_promo(DataTable infos) {
        List<Map<String, String>> actuals = infos.asMaps(String.class, String.class);
        for (int i = 0; i < actuals.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    HandlePromotions.applyStore(actuals.get(i))
            );
        }
    }

    @And("Add SKU to promo")
    public void add_sku(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "specSKU", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    HandlePromotions.addSKUs(info.get("specSKU"))
            );
        }
    }

    @And("Add Inventory lot to promo")
    public void add_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.addInventoryLot(list.get(0).get("lotCode"))
        );
    }

    @And("Admin search SKU to add promotion popup")
    public void search_add_sku_popup(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "sku", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    HandlePromotions.searchSKUCreatePromotion(info)
            );
        }
    }

    @And("Admin add SKU to promotion")
    public void add_sku_popup(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "specSKU", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    HandlePromotions.addSKUs2(info.get("specSKU"))
            );
        }
    }

    @And("Admin add case stack deal to promotion")
    public void add_case_stack(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.attributeText(AllPromotionsPage.STACK_DEAL_CHECKED, "class"), containsString("checked"))
                        .otherwise(
                                Click.on(AllPromotionsPage.STACK_DEAL_CHECKED).then(
                                        Ensure.that(AllPromotionsPage.STACK_DEAL_CHECKED).attribute("class").contains("checked")
                                )
                        )
        );
        if (list.size() > 1)
            for (int i = 0; i < list.size() - 1; i++) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add case stack")),
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add case stack")),
                        WindowTask.threadSleep(500));
            }
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(list.get(i).get("minQuantity").isEmpty()).otherwise(
                            CommonWaitUntil.isVisible(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Min quantity")),
                            Enter.theValue(list.get(i).get("minQuantity")).into(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Min quantity"))
                    ),
                    Check.whether(list.get(i).get("amount").isEmpty()).otherwise(
                            CommonWaitUntil.isVisible(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Amount")),
                            Enter.theValue(list.get(i).get("amount")).into(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Amount"))
                    )
            );
        }
    }

    @And("Admin edit case stack deal on promotion")
    public void edit_case_stack(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(list.get(i).get("minQuantity").isEmpty()).otherwise(
                            CommonWaitUntil.isVisible(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Min quantity")),
                            Enter.theValue(list.get(i).get("minQuantity")).into(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Min quantity"))
                    ),
                    Check.whether(list.get(i).get("amount").isEmpty()).otherwise(
                            CommonWaitUntil.isVisible(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Amount")),
                            Enter.theValue(list.get(i).get("amount")).into(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Amount"))
                    )
            );
        }
    }

    @And("{word} promo success")
    public void create_or_update_promo_success(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.createOrUpdate(type)
        );
    }

    @And("Admin process non SKU promotion")
    public void process_non_sku() {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.processNonSku()
        );
    }

    @And("Admin process overlap promotion")
    public void process_overlap() {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.processOverlapSku()
        );
    }

    @And("Search promotion by info")
    public void search_promotion_by_infop(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                HandlePromotions.search(list.get(0))
        );
    }

    @And("Admin verify no data in result after search promotion")
    public void admin_verify_no_data_in_result_after_search_promotion() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllPromotionsPage.NO_DATA_RESULT).isDisplayed()
        );
    }

    @And("Verify promotion show in All promotion page")
    public void create_or_update_promo_success(DataTable infos) {
        List<Map<String, String>> actuals = infos.asMaps(String.class, String.class);
        for (int i = 0; i < actuals.size(); i++) {
            String startAt = CommonHandle.setDate2(actuals.get(i).get("startAt"), "yyyy-MM-dd");
            String expireAt = CommonHandle.setDate2(actuals.get(i).get("expireAt"), "yyyy-MM-dd");
            CommonVerify commonVerify = new CommonVerify();
            commonVerify.verifyTargetTextContain(AllPromotionsPage.TYPE_IN_RESULT(actuals.get(i).get("name")), actuals.get(i), "type")
                    .verifyTargetTextContain(AllPromotionsPage.REGION_IN_RESULT(actuals.get(i).get("name")), actuals.get(i), "region")
                    .verifyTargetTextContain(AllPromotionsPage.START_IN_RESULT(actuals.get(i).get("name")), actuals.get(i), "startAt", startAt)
                    .verifyTargetTextContain(AllPromotionsPage.EXPIRE_IN_RESULT(actuals.get(i).get("name")), actuals.get(i), "expireAt", expireAt)
                    .verifyTargetTextContain(AllPromotionsPage.MANAGED_IN_RESULT(actuals.get(i).get("name")), actuals.get(i), "managedBy")
            ;
//            theActorInTheSpotlight().should(
//                    seeThat(CommonQuestions.isControlDisplay(AllPromotionsPage.PROMOTION_NAME_IN_RESULT(actuals.get(i).get("name")))),
//                    seeThat(CommonQuestions.targetText(AllPromotionsPage.TYPE_IN_RESULT(actuals.get(i).get("name"))), containsString(actuals.get(i).get("type"))),
//                    seeThat(CommonQuestions.targetText(AllPromotionsPage.REGION_IN_RESULT(actuals.get(i).get("name"))), containsString(actuals.get(i).get("region"))),
//                    seeThat(CommonQuestions.targetText(AllPromotionsPage.START_IN_RESULT(actuals.get(i).get("name"))), containsString(startAt)),
//                    seeThat(CommonQuestions.targetText(AllPromotionsPage.EXPIRE_IN_RESULT(actuals.get(i).get("name"))), containsString(expireAt))
//            );
        }

    }

    @And("Verify promotion info in Promotion detail")
    public void verify_promotion_info_in_promotion_detail(DataTable infos) {
        List<Map<String, String>> expected = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.PROMOTION_NAME_IN_RESULT(expected.get(0).get("name"))),
                Click.on(AllPromotionsPage.PROMOTION_NAME_IN_RESULT(expected.get(0).get("name"))),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllPromotionsPage.PROMO_NAME)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.attributeText(AllPromotionsPage.PROMO_NAME, "value"), containsString(expected.get(0).get("name"))),
                seeThat(CommonQuestions.attributeText(AllPromotionsPage.FROM_DATE, "value"), containsString(CommonHandle.setDate2(expected.get(0).get("fromDate"), "MM/dd/yy")))
        );
        if (expected.get(0).containsKey("toDate") && !expected.get(0).get("toDate").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.TO_DATE, "value"), containsString(CommonHandle.setDate2(expected.get(0).get("toDate"), "MM/dd/yy")))
            );
        }
        if (expected.get(0).containsKey("store") && !expected.get(0).get("store").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AllPromotionsPage.SKU_DETAILS(expected.get(0).get("store"))), containsString(expected.get(0).get("store")))
            );
        }
        if (expected.get(0).containsKey("caseLimit") && !expected.get(0).get("caseLimit").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.CASE_LIMIT, "value"), containsString(expected.get(0).get("caseLimit")))
            );
        }
        if (expected.get(0).containsKey("caseMinimum") && !expected.get(0).get("caseMinimum").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("Case minimum"), "value"), containsString(expected.get(0).get("caseMinimum")))
            );
        }
        if (expected.get(0).containsKey("usageLimit") && !expected.get(0).get("usageLimit").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.USAGE_LIMIT, "value"), containsString(expected.get(0).get("usageLimit")))
            );
        }
        if (!expected.get(0).get("showVendor").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.SHOW_VENDOR_SWITCH, "class"), containsString(expected.get(0).get("showVendor")))
            );
        }
        if (expected.get(0).containsKey("createdBy") && expected.get(0).containsKey("createdOn")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AllPromotionsPage.CREATE_BY), containsString(expected.get(0).get("createdBy") + " " + CommonHandle.setDate2(expected.get(0).get("createdOn"), "MM/dd/yy")))
            );
        }
    }

    @And("Admin go to promotion detail {string}")
    public void go_to_promotion_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllPromotionsPage.PROMOTION_NAME_IN_RESULT(name)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Name"))
        );
    }

    @And("Admin delete submission promotion name {string}")
    public void delete_promotion_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.DELETE_PROMOTION_NAME(name)),
                Click.on(AllPromotionsPage.DELETE_PROMOTION_NAME(name)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin check delete submission promotion name {string} is disabled")
    public void disabled_delete_promotion_detail(String name) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.DELETE_PROMOTION_NAME(name)),
                Ensure.that(AllPromotionsPage.DELETE_PROMOTION_NAME(name)).isDisabled()
        );
    }

    @And("Admin check approved submission promotion detail")
    public void check_approved_submission_promotion(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Name")),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Name")).value().contains(expected.get(0).get("name")),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Name")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("From")).value().contains(CommonHandle.setDate2(expected.get(0).get("fromDate"), "MM/dd/yy")),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("From")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("To")).value().contains(CommonHandle.setDate2(expected.get(0).get("toDate"), "MM/dd/yy")),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("To")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTAREA("Note")).value().contains(expected.get(0).get("note")),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTAREA("Note")).isDisabled(),
                Ensure.that(AllPromotionsPage.PROMOTION_TYPE(expected.get(0).get("type"))).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Case limit")).value().contains(expected.get(0).get("caseLimit")),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Case limit")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Case minimum")).value().contains(expected.get(0).get("caseMinimum")),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Case minimum")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Usage limit")).value().contains(expected.get(0).get("usageLimit")),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Usage limit")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Included stores")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Excluded stores")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Excluded buyer companies")).isDisabled(),
                Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Amount")).isDisabled(),
                Ensure.that(AllPromotionsPage.UPDATE_BUTTON).isDisabled()
        );
        if (expected.get(0).containsKey("approvedBy") && !expected.get(0).get("approvedBy").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.APPROVED_BY).text().contains(expected.get(0).get("approvedBy") + " on")
            );
        }
        if (expected.get(0).containsKey("approvedOn") && !expected.get(0).get("approvedOn").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.APPROVED_BY).text().contains(CommonHandle.setDate2(expected.get(0).get("approvedOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check {string} applied region of approved submission promotion")
    public void check_region_approved_submission_promotion(String applied, DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        if (applied.contains("not")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.REGIONAL_PROMOTION).attribute("class").doesNotContain("checked")
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.REGIONAL_PROMOTION).attribute("class").contains("checked")
            );
            for (Map<String, String> map : expected)
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AllPromotionsPage.APPLIED_REGION(map.get("region"))).attribute("class").contains(map.get("apply")),
                        Ensure.that(AllPromotionsPage.APPLIED_REGION(map.get("region"))).attribute("class").contains("disabled")
                );
        }
    }

    @And("Admin verify promotion detail")
    public void verify_promotion_detail(DataTable infos) {
        List<Map<String, String>> expected = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Name"))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("Name"), "value"), containsString(expected.get(0).get("name"))),
                seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("From"), "value"), containsString(CommonHandle.setDate2(expected.get(0).get("fromDate"), "MM/dd/yy")))
        );
        if (expected.get(0).containsKey("toDate") && !expected.get(0).get("toDate").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("To"), "value"), containsString(CommonHandle.setDate2(expected.get(0).get("toDate"), "MM/dd/yy")))
            );
        }
        if (expected.get(0).containsKey("store") && !expected.get(0).get("store").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AllPromotionsPage.SKU_DETAILS(expected.get(0).get("store"))), containsString(expected.get(0).get("store")))
            );
        }
        if (expected.get(0).containsKey("caseLimit") && !expected.get(0).get("caseLimit").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("Case limit"), "value"), containsString(expected.get(0).get("caseLimit")))
            );
        }
        if (expected.get(0).containsKey("caseMinimum") && !expected.get(0).get("caseMinimum").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("Case minimum"), "value"), containsString(expected.get(0).get("caseMinimum")))
            );
        }
        if (expected.get(0).containsKey("usageLimit") && !expected.get(0).get("usageLimit").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("Usage limit"), "value"), containsString(expected.get(0).get("usageLimit")))
            );
        }
        if (!expected.get(0).get("showVendor").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.SHOW_VENDOR_SWITCH, "class"), containsString(expected.get(0).get("showVendor")))
            );
        }
        if (expected.get(0).containsKey("skuExpiryDate")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("SKU expiry date"), "value"), containsString(CommonHandle.setDate2(expected.get(0).get("skuExpiryDate"), "MM/dd/yy")))
            );
        }
        if (expected.get(0).containsKey("inventoryLot")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("Inventory lot"), "value"), containsString(expected.get(0).get("inventoryLot")))
            );
        }
        if (expected.get(0).containsKey("note")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTAREA("Note"), "value"), containsString(expected.get(0).get("note")))
            );
        }
    }

    @And("Verify amount of promotion with {string} stack deal")
    public void amountStackDeal(String stack, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (stack.equalsIgnoreCase("no")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.DYNAMIC_TEXTBOX("Amount"), "value"), containsString(list.get(0).get("amount"))),
                    seeThat(CommonQuestions.targetText(AllPromotionsPage.AMOUNT_TYPE), containsString(list.get(0).get("type")))
            );
        } else {
            for (int i = 0; i < list.size(); i++) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetValue(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Min quantity")), equalToIgnoringCase(list.get(i).get("minQuantity"))),
                        seeThat(CommonQuestions.targetValue(AllPromotionsPage.STACK_DEAL_INFO(i + 1, "Amount")), equalToIgnoringCase(list.get(i).get("amount")))
                );
            }
        }
    }

    @And("Verify amount stack deal description")
    public void amountStackDealDescription(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AllPromotionsPage.STACK_DEAL_DES(i + 1)), equalToIgnoringCase(list.get(i).get("description")))
            );
        }
    }

    @And("Verify help stack deal description")
    public void helpStackDealDescription(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.STACK_DEAL_HELP(i + 1)).text().contains(list.get(i).get("help"))
            );
        }
    }

    @And("Delete stack deal number {string}")
    public void deleteStackDeal(String number) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.STACK_DEAL_DELETE(number)).then(
                        Click.on(AllPromotionsPage.STACK_DEAL_DELETE(number))
                )
        );
    }

    @And("Check item on Promotion detail")
    public void checkItems(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AllPromotionsPage.ITEM(map.get("sku"), "product"), "data-original-text"), containsString(map.get("product")))
            );
            if (map.containsKey("brand")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.attributeText(AllPromotionsPage.ITEM(map.get("sku"), "brand"), "data-original-text"), containsString(map.get("brand")))
                );
            }
        }
    }

    @And("Check applied regions of Promotion detail")
    public void checkRegion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.REGION_CHECKBOX(map.get("region"))).attribute("class").contains("checked")
            );
        }
    }

    @And("Check applied buyer company of Promotion detail")
    public void checkBuyerCompany(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.INCLUDED_BUYER_COMPANY(map.get("buyerCompany"))).isDisplayed());
        }
    }

    @And("Check included stores of promotion")
    public void checkIncludedStore(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.INCLUDED_STORE(map.get("store"))).isDisplayed());
        }
    }

    @And("Check excluded stores of promotion")
    public void checkExcludedStore(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.EXCLUDED_STORE(map.get("store"))).isDisplayed());
        }
    }

    @And("Check excluded buyer companies of promotion")
    public void checkExcludedBuyer(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.EXCLUDED_BUYER_COMPANY(map.get("buyerCompany"))).isDisplayed());
        }
    }

    @And("Admin go to inventory on promotion form and check info")
    public void goToInventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.INVENTORY_LINK(list.get(0).get("lotCode"))),
                Click.on(AllPromotionsPage.INVENTORY_LINK(list.get(0).get("lotCode"))),
                WindowTask.threadSleep(1000)
        );
    }

    @And("{word} verify price promo in order details of Admin is {string}")
    public void verify_price_promo_in_order_details_of_admin(String user, String promoPrice) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(AllOrdersForm.DISCOUNT_PRICE), CoreMatchers.containsString(promoPrice))
        );
    }

    @And("Admin verify price promo in sku {string} of order")
    public void verify_price_promo_in_sku_of_order(String skuName, DataTable infos) {
        List<Map<String, String>> expected = infos.asMaps(String.class, String.class);
        if (skuName.equals("random")) {
            skuName = Serenity.sessionVariableCalled("SKU inventory");
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllOrdersForm.ID_SUB_INVOICE),
                CommonWaitUntil.isNotVisible(HomePageForm.LOADING_ICON),
                Scroll.to(AllOrdersForm.END_QUANTITY_TOTAL)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(AllOrdersForm.END_QUANTITY_TOTAL), CoreMatchers.containsString(expected.get(0).get("endQuantity"))),
                seeThat(CommonQuestions.targetText(AllOrdersForm.TOTAL_PRICE_IN_LINE(skuName)), CoreMatchers.containsString(expected.get(0).get("total")))
        );
    }

    @And("Admin edit info of promo")
    public void admin_edit_info_promo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : infos)
            theActorInTheSpotlight().attemptsTo(
                    HandlePromotions.editField(item.get("field"), item.get("value"))
            );
    }

    @And("Admin verify pagination function")
    public void admin_verify_pagination_function() {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(Integer.parseInt(CommonQuestions.targetText(AllPromotionsPage.NUMBER_TOTAL).answeredBy(theActorInTheSpotlight())) < 12).otherwise(
                        CommonWaitUntil.isVisible(AllPromotionsPage.PREVIOUS_PAGE_BUTTON),
                        Ensure.that(AllPromotionsPage.PREVIOUS_PAGE_BUTTON).isDisplayed(),
                        Ensure.that(AllPromotionsPage.NEXT_PAGE_BUTTON).isDisplayed(),
                        Click.on(AllPromotionsPage.NUMBER_PAGE("2")),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                        Ensure.that(AllPromotionsPage.PREVIOUS_PAGE_BUTTON).isDisplayed(),
                        Ensure.that(AllPromotionsPage.NEXT_PAGE_BUTTON).isDisplayed(),
                        Ensure.that(AllPromotionsPage.NUMBER_ACTIVE).text().contains("2"),
                        Click.on(AllPromotionsPage.NUMBER_PAGE("1")),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                )
        );
    }

    @And("Admin verify field in Create New Promotion form")
    public void verify_field_in_create_new_promotion_form(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        String actual = null;
        String expected = null;
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.CREATE_BUTTON),
                Click.on(AllPromotionsPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Name"))
        );
        for (Map<String, String> item : list) {
            actual = item.get("name");
            expected = item.get("value");

            if (item.get("name").equals("1000")) {
                actual = Utility.getRandomString(1000);
                expected = actual;
            }
            theActorInTheSpotlight().attemptsTo(
                    Enter.keyValues(actual).into(AllPromotionsPage.DYNAMIC_TEXTBOX("Name")),
                    Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX("Name")).attribute("value").contains(expected)
            );
        }
    }

    @And("Admin verify type field in Create New Promotion form")
    public void verify_type_field_in_create_new_promotion_form() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllPromotionsPage.TYPE_PROMO_ACTIVE).isDisplayed()
        );

    }

    @And("Admin verify value of field in Create New Promotion form")
    public void verify_value_field_in_create_new_promotion_form(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX(item.get("field"))),
                    Check.whether(item.get("field").contains("date") || item.get("field").contains("From") || item.get("field").contains("To")).andIfSo(
                            Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX(item.get("field"))).attribute("value").isEqualToIgnoringCase(CommonHandle.setDate2(item.get("value"), "MM/dd/yy"))
                    ).otherwise(
                            Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX(item.get("field"))).attribute("value").isEqualToIgnoringCase(item.get("value"))
                    )
            );
            if (item.containsKey("status")) {
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(item.get("status").equalsIgnoreCase("disable")).andIfSo(
                                        Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX(item.get("field"))).isDisabled())
                                .otherwise(Ensure.that(AllPromotionsPage.DYNAMIC_TEXTBOX(item.get("field"))).isEnabled())
                );
            }
        }
    }

    @And("Admin click Create New Promotion to show form")
    public void clickToShowForm() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.CREATE_BUTTON),
                Click.on(AllPromotionsPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Name"))
        );
    }

    @And("Admin choose type of promotion is {string}")
    public void choosePromotionType(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Name")),
                Click.on(AllPromotionsPage.DYNAMIC_TYPE_PROMO(type))
        );
    }

    @And("Admin choose {string} of promotion is {string}")
    public void chooseSKUExpireDate(String type, String date) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.chooseDateFromTooltipDateTime(AllPromotionsPage.DYNAMIC_TEXTBOX(type), CommonHandle.setDate2(date, "M-d-yyyy"))
        );
    }

    @And("Admin Clear field {string}")
    public void adminClearField(String field) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX(field)),
                Clear.field(AllPromotionsPage.DYNAMIC_TEXTBOX(field)).then(
                        Click.on(AllPromotionsPage.DYNAMIC_TEXTBOX(field))
                ),
                Enter.theValue("1").into(AllPromotionsPage.DYNAMIC_TEXTBOX(field)).thenHit(Keys.BACK_SPACE).thenHit(Keys.TAB),
                Click.on(AllPromotionsPage.DYNAMIC_TEXTBOX(field)).then(Hit.the(Keys.TAB).into(AllPromotionsPage.DYNAMIC_TEXTBOX(field)))
        );
    }

    @And("{word} remove value on Input {string}")
    public void adminRemoveValue(String actor, String field) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.removeInputValue(CommonAdminForm.DYNAMIC_INPUT(field))
        );
    }

    @And("Admin click Update")
    public void clickUpdate() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllPromotionsPage.UPDATE_BUTTON),
                Click.on(AllPromotionsPage.UPDATE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin check message {word} showing of field {string}")
    public void checkMessage(String type, String field, String message) {
        if (type.equals("is")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.DYNAMIC_TEXT_BOX_ERROR(field)).text().isEqualToIgnoringCase(message)
            );
        } else
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.DYNAMIC_TEXT_BOX_ERROR(field)).isNotDisplayed()
            );
    }

    @And("Admin check message showing of field")
    public void checkMessage2(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllPromotionsPage.DYNAMIC_INFO_ERROR(item.get("field"))).text().isEqualToIgnoringCase(item.get("message"))
            );
        }

    }

    @And("Admin Close the Create promotion form")
    public void close() {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.closeCreateForm()
        );
    }

    @And("Admin delete store {string} in create promotion form")
    public void deleteStore(String st) {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.deleteStore(st)
        );
    }

    @And("Admin delete {string} name {string} in create promotion form")
    public void deleteExcluedStore(String field, String st) {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.deleteExcludedStore(field, st)
        );
    }

    @And("Admin click duplicate promotion {string}")
    public void duplicate(String st) {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.duplicatePromo(st)
        );
    }

    @And("Admin confirm duplicate promotion")
    public void confirmDuplicate() {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.confirmDuplicatePromo()
        );
    }

    @And("Admin delete promotion name {string}")
    public void deletePromo(String promo) {
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.deletePromo(promo)
        );
    }

    @And("Admin select an Inventory Lot for Promotion")
    public void selectInventoryCreatePromotion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandlePromotions.selectInventoryPromotion(list.get(0))
        );
    }

}
