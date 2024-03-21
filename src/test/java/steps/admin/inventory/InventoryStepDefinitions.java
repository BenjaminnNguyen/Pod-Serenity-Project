package steps.admin.inventory;

import cucumber.tasks.admin.products.HandleFilterProduct;
import cucumber.tasks.common.*;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.inventory.HandleInventory;
import cucumber.tasks.api.CommonHandle;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.AllInventoryPage;
import cucumber.user_interface.admin.inventory.InventoryDetailPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;

public class InventoryStepDefinitions {

    @And("Admin verify sku textbox in search all inventory")
    public void admin_verify_sku_textbox_in_search_all_inventory(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.showFilter(),
                    CommonTaskAdmin.resetFilter(),
                    Enter.theValue(info.get("searchValue")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_id")),
                    WindowTask.threadSleep(500),
                    CommonWaitUntil.isVisible(AllOrdersForm.BRAND_IN_SKU_POPUP_SEARCH(info.get("sku")))
            );
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllOrdersForm.BRAND_IN_SKU_POPUP_SEARCH(info.get("sku"))).text().isEqualTo(info.get("brand")),
                    Ensure.that(AllOrdersForm.PRODUCT_IN_SKU_POPUP_SEARCH(info.get("sku"))).text().isEqualTo(info.get("product")),
                    Ensure.that(AllOrdersForm.SKU_IN_SKU_POPUP_SEARCH(info.get("sku"))).text().isEqualTo(info.get("sku")),
                    Hit.the(Keys.ESCAPE).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_id"))
            );

        }
    }

    @And("Admin create new inventory")
    public void create_new_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "sku", Serenity.sessionVariableCalled("SKU inventory"));
        String Lot = "Lot code" + Utility.getRandomString(5);
        Serenity.setSessionVariable("Lot Code").to(Lot);
        info = CommonTask.setValueRandom(info, "lotCode", Lot);

        theActorInTheSpotlight().attemptsTo(
                HandleInventory.create(info)
        );
    }

    @And("Admin add image to create new inventory")
    public void add_image_to_create_new_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleInventory.addImageToCreate(item)
            );
        }
    }

    @And("Admin create new inventory success")
    public void create_new_inventory_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.createInventorySuccess()
        );
    }

    @And("Admin search inventory")
    public void search_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValue(map, "skuName", map.get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleInventory.search(info),
                    HandleInventory.sortSearch()
            );
        }
    }


    @And("Admin edit visibility search all inventory")
    public void edit_visibility_search_field(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleInventory.editVisibility(infos.get(0))
        );
    }

    @And("Admin verify search inventory field {string} visible")
    public void admin_verify_field_search_uncheck_in_edit_visibility(String state, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(state.equals("not")).andIfSo(
                        HandleInventory.searchFieldUnVisible(infos.get(0))
                ).otherwise(
                        HandleInventory.searchFieldVisible(infos.get(0))
                )
        );
    }

    @And("Admin search with invalid field {string}")
    public void enter_invalid_field(String type, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTask.enterInvalidToDropdown(CommonAdminForm.DYNAMIC_DIALOG_INPUT(type), item.get("value"))
            );
        }
    }

    @And("Admin reset filter")
    public void searchRecommendations() {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter()
        );
    }

    @And("Admin sort field {string} with {string}")
    public void adminSortField(String field, String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.sortField(field, type)
        );
    }

    @And("Verify result inventory")
    public void verify_result_inventory(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (int i = 0; i < expected.size(); i++) {
            // set sku nếu random
            info = CommonTask.setValue(expected.get(i), "skuName", expected.get(i).get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code"), "random");

            if (expected.get(i).get("lotCode").equals("randomInbound")) {
                info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("skuName") + " " + info.get("index")), "randomInbound");
                System.out.println("Lot Code " + info.get("skuName") + " " + info.get("index") + " : " + Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("skuName") + " " + info.get("index")));
            }
            if (expected.get(i).get("lotCode").equals("randomIndex")) {
                info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")), "randomIndex");
                System.out.println("Lot Code " + info.get("skuName") + " " + info.get("index") + " : " + Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")));
            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AllInventoryPage.D_PRODUCT_RESULT_IN_TABLE(info.get("lotCode"))),
                    Ensure.that(AllInventoryPage.D_PRODUCT_RESULT_IN_TABLE(info.get("lotCode"))).attribute("data-original-text").contains(expected.get(i).get("productName")),
                    Ensure.that(AllInventoryPage.D_SKU_RESULT_IN_TABLE(info.get("lotCode"))).attribute("data-original-text").contains(info.get("skuName")),
                    Ensure.that(AllInventoryPage.D_LOTCODE_RESULT_IN_TABLE(info.get("lotCode"))).isDisplayed(),
                    Ensure.that(AllInventoryPage.D_ORIGINAL_QUANTITY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("originalQuantity")),
                    Ensure.that(AllInventoryPage.D_CURRENT_QTY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("currentQuantity")),
                    Ensure.that(AllInventoryPage.D_END_QTY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("quantity").equalsIgnoreCase("End Quantity")
                            ? Serenity.sessionVariableCalled("End Quantity").toString() : expected.get(i).get("quantity").equalsIgnoreCase("End Quantity After")
                            ? Serenity.sessionVariableCalled("End Quantity After").toString() : expected.get(i).get("quantity")),
                    Ensure.that(AllInventoryPage.D_PULL_QTY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("pullQuantity")),
                    Ensure.that(AllInventoryPage.D_EXPIRE_DATE_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(i).get("expiryDate"), "yyyy-MM-dd")),
                    Check.whether(expected.get(i).get("pullDate").isEmpty())
                            .otherwise(Ensure.that(AllInventoryPage.D_PULL_DATE_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(i).get("pullDate"), "yyyy-MM-dd"))),
                    Check.whether(expected.get(i).get("dayUntilPullDate").isEmpty())
                            .otherwise(Ensure.that(AllInventoryPage.D_DAY_UNTIL_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("dayUntilPullDate"))),
                    Ensure.that(AllInventoryPage.D_RECEIVE_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(i).get("receiveDate"), "yyyy-MM-dd")),
                    Ensure.that(AllInventoryPage.D_WAREHOUSE_RESULT_IN_TABLE(info.get("lotCode"))).attribute("data-original-text").contains(expected.get(i).get("distributionCenter")),
                    Ensure.that(AllInventoryPage.D_VENDOR_COMPANY_RESULT_IN_TABLE(info.get("lotCode"))).attribute("data-original-text").contains(expected.get(i).get("vendorCompany")),
                    Ensure.that(AllInventoryPage.D_REGION_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("region")),
                    Ensure.that(AllInventoryPage.D_CREATED_BY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("createdBy"))
            );
        }
    }

    @And("Admin select {string} inventory")
    public void select_detail_inventory(String sl, DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        if (sl.equals("all"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AllInventoryPage.SELECT_ALL_INVENTORY),
                    Click.on(AllInventoryPage.SELECT_ALL_INVENTORY)
            );
        else {
            for (Map<String, String> map : expected)
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(AllInventoryPage.SELECT_A_INVENTORY(map.get("sku"))),
                        Click.on(AllInventoryPage.SELECT_A_INVENTORY(map.get("sku")))
                );
        }
    }

    @And("Admin move warehouse inventory to {string}")
    public void move_ware_house(String warehouse) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllInventoryPage.EDIT_WAREHOUSE),
                Click.on(AllInventoryPage.EDIT_WAREHOUSE),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT()),
                CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_DIALOG_INPUT(), warehouse, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(warehouse)),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Confirm"))
        );
    }

    @And("Admin see detail inventory")
    public void see_detail_inventory() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllInventoryPage.SKU_LINK),
                CommonWaitUntil.isVisible(InventoryDetailPage.DYNAMIC_INFO("region"))
        );
    }

    @And("Admin see detail inventory with lotcode {string}")
    public void see_detail_inventory_with_lot_code(String lotCode) {
        switch (lotCode) {
            case "random":
                lotCode = Serenity.sessionVariableCalled("Lot Code");
                break;
            case "randomInbound":
                lotCode = Serenity.sessionVariableCalled("Lot Code Inbound 1");
                break;
            default:
                break;
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllInventoryPage.LOTCODE_LINK(lotCode)),
                CommonWaitUntil.isVisible(InventoryDetailPage.DYNAMIC_INFO("region"))
        );
    }

    @And("Admin see detail inventory with lotcode")
    public void see_detail_inventory_with_lot_code(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "skuName", infos.get(0).get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");

        switch (infos.get(0).get("lotCode")) {
            case "random":
                info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code"), "random");
                break;
            case "randomInbound":
                info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("skuName") + " " + info.get("index")), "randomInbound");
                break;
            case "randomIndex":
                info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")), "randomIndex");
                break;
            default:
                break;
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllInventoryPage.LOTCODE_LINK(info.get("lotCode"))),
                CommonWaitUntil.isVisible(InventoryDetailPage.DYNAMIC_INFO("region"))
        );
    }

    @And("Verify inventory detail")
    public void verify_inventory_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(expected.get(0), "sku", expected.get(0).get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "random");
        info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code"), "random");
        if (info.get("lotCode").equals("randomInbound")) {
            info = CommonTask.setValue2(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("sku") + " " + info.get("index")).toString(), "randomInbound");
            System.out.println("Lot Code Inbound " + info.get("sku") + " " + info.get("index") + " : " + Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("sku") + " " + info.get("index")));
        }

        if (info.get("lotCode").equals("randomIndex")) {
            info = CommonTask.setValue2(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")).toString(), "randomIndex");
            System.out.println("Lot Code " + info.get("sku") + " " + info.get("index") + " : " + Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")));
        }

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(InventoryDetailPage.WAIT_DISTRIBUTION_CENTER(expected.get(0).get("distributionCenter"))),
                Ensure.that(InventoryDetailPage.PRODUCT_NAME).text().contains(expected.get(0).get("product")),
                Ensure.that(InventoryDetailPage.SKU_NAME).text().contains(info.get("sku")),
                Ensure.that(InventoryDetailPage.CREATED_BY).text().contains(expected.get(0).get("createdBy")),
                Ensure.that(InventoryDetailPage.DYNAMIC_INFO("region")).text().contains(expected.get(0).get("region")),
                Ensure.that(InventoryDetailPage.DISTRIBUTION_CENTER).text().contains(expected.get(0).get("distributionCenter")),
                Ensure.that(InventoryDetailPage.RECEIVE_DATE).text().contains(CommonHandle.setDate2(expected.get(0).get("receiveDate"), "MM/dd/yy")),
                Check.whether(expected.get(0).get("expireDate").equals(""))
                        .otherwise(Ensure.that(InventoryDetailPage.EXPIRY_DATE).text().contains(CommonHandle.setDate2(expected.get(0).get("expireDate"), "MM/dd/yy"))),
                Check.whether(expected.get(0).get("pullDate").equals(""))
                        .otherwise(Ensure.that(InventoryDetailPage.PULL_DATE).text().contains(CommonHandle.setDate2(expected.get(0).get("pullDate"), "MM/dd/yy"))),
                Ensure.that(InventoryDetailPage.LOT_CODE).text().contains(info.get("lotCode")),
                Ensure.that(InventoryDetailPage.DYNAMIC_INFO("original-quantity")).text().contains(expected.get(0).get("originalQty")),
                Ensure.that(InventoryDetailPage.DYNAMIC_INFO("current-quantity")).text().contains(expected.get(0).get("currentQty")),
                Ensure.that(InventoryDetailPage.DYNAMIC_INFO("end-quantity")).text().contains(expected.get(0).get("endQty"))
        );
        if (expected.get(0).containsKey("comment")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(InventoryDetailPage.DYNAMIC_INFO("comment")).text().contains(expected.get(0).get("comment"))
            );
        }
        ;
        if (expected.get(0).containsKey("storageShelfLife")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(InventoryDetailPage.D_FIELD("condition")).text().contains(expected.get(0).get("storageShelfLife"))
            );
        }
        ;
        if (expected.get(0).containsKey("temperature")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(InventoryDetailPage.D_FIELD("temperature")).text().contains(expected.get(0).get("temperature"))
            );
        }
    }

    @And("Verify subtraction item after ordered")
    public void verify_suctraction_item_after_ordered(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String idInvoice = expected.get(0).get("order");
        if (expected.get(0).get("order").equals("")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            idInvoice = idInvoice.substring(6);
        }
        if (expected.get(0).get("order").equals("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
        }

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(InventoryDetailPage.SUBTRACTION_DATE).text().contains(CommonHandle.setDate(expected.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(InventoryDetailPage.SUBTRACTION_QUANTITY).text().contains(expected.get(0).get("qty")),
                Check.whether(idInvoice.equals("No"))
                        .otherwise(Ensure.that(InventoryDetailPage.SUBTRACTION_ORDER).text().contains(idInvoice)),
                Ensure.that(InventoryDetailPage.SUBTRACTION_DESCRIPTION).text().contains(expected.get(0).get("description"))
        );
    }

    @And("Verify subtraction item on inventory")
    public void verify_subtraction_item(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_DATE(i + 1)), containsString(CommonHandle.setDate2(expected.get(i).get("date"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_QUANTITY(i + 1)), containsString(expected.get(i).get("quantity"))),
                    seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_ORDER(i + 1)), containsString(expected.get(i).get("order"))),
                    seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_CATEGORY(i + 1)), containsString(expected.get(i).get("category"))),
                    seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_DESCRIPTION(i + 1)), containsString(expected.get(i).get("description")))
            );
            if (expected.get(i).containsKey("comment"))
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_DESCRIPTION(i + 1)), containsString(expected.get(i).get("comment")))

                );
        }
    }

    @And("Verify subtraction item {string} on tab {string} of inventory")
    public void verify_subtraction_item(String show, String tab, DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(InventoryDetailPage.SUBTRACTION_TAB(tab)).then(
                        Click.on(InventoryDetailPage.SUBTRACTION_TAB(tab))
                ), WindowTask.threadSleep(500)
        );
        if (show.equals("show")) {
            for (int i = 0; i < expected.size(); i++) {
                String idInvoice = expected.get(i).get("order");
                if (expected.get(i).get("order").equals("create by api")) {
                    idInvoice = Serenity.sessionVariableCalled("ID Invoice");
                }
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_DATE(i + 1)), containsString(CommonHandle.setDate2(expected.get(i).get("date"), "MM/dd/yy"))),
                        seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_QUANTITY(i + 1)), containsString(expected.get(i).get("quantity"))),
                        seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_ORDER(i + 1)), containsString(idInvoice)),
                        seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_CATEGORY(i + 1)), containsString(expected.get(i).get("category"))),
                        seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_DESCRIPTION(i + 1)), containsString(expected.get(i).get("description"))),
                        seeThat(CommonQuestions.targetText(InventoryDetailPage.SUBTRACTION_DESCRIPTION(i + 1)), containsString(expected.get(i).get("comment")))
                );
            }
        } else {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlUnDisplay(InventoryDetailPage.SUBTRACTION_DATE(1))),
                    seeThat(CommonQuestions.isControlUnDisplay(InventoryDetailPage.SUBTRACTION_QUANTITY(1)))
            );
        }
    }

    @And("Admin edit fist subtraction on inventory")
    public void edit_subtraction_item(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : info) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_FIRST_SUBTRACTION),
                    CommonTask.setSessionVariable("Id first subtraction of inventory" + CommonHandle.getCurrentURL().split("inventories/")[1], CommonQuestions.getText(theActorInTheSpotlight(), InventoryDetailPage.ID_FIRST_SUBTRACTION)),
                    Click.on(InventoryDetailPage.EDIT_FIRST_SUBTRACTION),
                    CommonWaitUntil.isVisible(InventoryDetailPage.POPUP_CREATE_QUANTITY),
                    Check.whether(map.get("category").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdownWithValueInput(InventoryDetailPage.POPUP_CREATE_CATEGORY, map.get("category"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(map.get("category")))
                    ));
            if (map.containsKey("subCategory")) {
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(map.get("subCategory").isEmpty()).otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(InventoryDetailPage.POPUP_CREATE_SUB_CATEGORY, map.get("subCategory"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(map.get("subCategory")))
                        )
                );
            }
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(map.get("comment").isEmpty()).otherwise(
                            Enter.theValue(map.get("comment")).into(InventoryDetailPage.POPUP_CREATE_COMMENT)
                    ),
                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                    Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                    CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                    WindowTask.threadSleep(1000)
            );
        }
    }

    @And("Verify no inventory activities found")
    public void verify_no_inventory_activities_fount() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(InventoryDetailPage.NO_INVENTORY_ACTIVITIES))
        );
    }

    @And("Verify result inventory by lotcode")
    public void verify_result_inventory_by_lotcode(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(expected.get(0), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
        info = CommonTask.setValueRandom(info, "quantity", Serenity.sessionVariableCalled("SKU inventory"));
        info = CommonTask.setValueRandom(info, "lotCode", Serenity.sessionVariableCalled("Lot Code"));

        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.attributeText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE1(info.get("lotCode"), "product"), "data-original-text"), containsString(expected.get(0).get("productName"))),
                seeThat(CommonQuestions.attributeText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE1(info.get("lotCode"), "name"), "data-original-text"), containsString(expected.get(0).get("skuName"))),
                seeThat(CommonQuestions.attributeText(AllInventoryPage.LOT_CODE_IN_TABLE(info.get("lotCode")), "data-original-text"), containsString(expected.get(0).get("lotCode").contains("random") ? Serenity.sessionVariableCalled("Lot Code") : expected.get(0).get("lotCode"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE3(info.get("lotCode"), "original-quantity")), containsString(expected.get(0).get("originalQuantity"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE3(info.get("lotCode"), "current-quantity")), containsString(expected.get(0).get("currentQuantity"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE3(info.get("lotCode"), " quantity")), containsString(expected.get(0).get("quantity").equalsIgnoreCase("End Quantity")
                        ? Serenity.sessionVariableCalled("End Quantity").toString() : expected.get(0).get("quantity").equalsIgnoreCase("End Quantity After")
                        ? Serenity.sessionVariableCalled("End Quantity After").toString() : expected.get(0).get("quantity"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE3(info.get("lotCode"), "pull-quantity")), containsString(expected.get(0).get("pullQuantity"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE3(info.get("lotCode"), "expiry-date")), containsString(expected.get(0).get("expiryDate"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE3(info.get("lotCode"), "pull-date")), containsString(expected.get(0).get("pullDate"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE3(info.get("lotCode"), "receive-date")), containsString(CommonHandle.setDate2(expected.get(0).get("receiveDate"), "yyyy-MM-dd"))),
                seeThat(CommonQuestions.attributeText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE2(info.get("lotCode"), "warehouse"), "data-original-text"), containsString(expected.get(0).get("distributionCenter"))),
                seeThat(CommonQuestions.attributeText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE2(info.get("lotCode"), "vendor-company"), "data-original-text"), containsString(expected.get(0).get("vendorCompany"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE2(info.get("lotCode"), "region")), containsString(expected.get(0).get("region"))),
                seeThat(CommonQuestions.targetText(AllInventoryPage.DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE2(info.get("lotCode"), "created-by")), containsString(expected.get(0).get("createdBy")))
        );
    }

    @And("Search inventory with lotcode {string} in result table")
    public void verify_result_inventory_by_lotcode(String lotcote) {
        if (lotcote.equals("")) {
            lotcote = Serenity.sessionVariableCalled("Lot Code");
        }
        while (CommonQuestions.isControlUnDisplay(AllInventoryPage.LOT_CODE_IN_TABLE(lotcote)).answeredBy(theActorInTheSpotlight())) {
            theActorInTheSpotlight().attemptsTo(
                    Click.on(AllInventoryPage.NEXT_TAB_BUTTON)
            );
        }
    }

    @And("Admin create subtraction items")
    public void createSubtraction(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleInventory.goToCreateSubtraction(),
                    HandleInventory.createItem(map)
            );
            Serenity.setSessionVariable("Subtraction ID").to(InventoryDetailPage.SUBTRACTION_ID.resolveFor(theActorInTheSpotlight()).getText().toString().trim());
        }
    }

    @And("Admin create addition items")
    public void createAddition(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleInventory.goToCreateAddition(),
                    HandleInventory.createItem(map)
            );
            Serenity.setSessionVariable("Addition ID").to(InventoryDetailPage.SUBTRACTION_ID.resolveFor(theActorInTheSpotlight()).getText().toString().trim());
        }
    }

    @And("Admin delete first subtraction items with comment {string}")
    public void deleteSubtraction(String comment) {
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.deleteSubtraction(comment)
        );
    }

    @And("Admin edit general information of inventory")
    public void admin_edit_general_information_of_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);

        String lotCode = "Lot code" + Utility.getRandomString(5);
        Serenity.setSessionVariable("Lot Code").to(lotCode);
        HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "lotCode", lotCode);
        Serenity.setSessionVariable("Lot Code Inbound " + info.get("skuName") + " " + info.get("index")).to(lotCode);

        if (list.get(0).get("lotCode").equals("randomInbound")) {
            info = CommonTask.setValue2(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("skuName") + " " + info.get("index")).toString(), "randomInbound");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.editGeneralInformation(info)
        );
    }

    @And("Admin edit distribution of inventory to {string}")
    public void admin_edit_distribution_of_inventory(String distribution) {
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.editDistribution(distribution)
        );
    }

    @And("Admin go to product from inventory detail")
    public void admin_go_to_product_from_inventory_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.goToProduct()
        );
    }

    @And("Admin save image upload success")
    public void admin_save_inmage_upload_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.saveImageUpload()
        );
    }

    @And("Admin go to withdrawal request {string} from inventory detail")
    public void admin_go_to_withdrawal_request_from_inventory_detail(String id) {
        if (id.equals("")) {
            id = Serenity.sessionVariableCalled("Withdrawal Request ID");
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(InventoryDetailPage.WITHDRAWAL_ID_LINK),
                WindowTask.switchToChildWindowsByTitle("Withdrawal Request"),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin refresh inventory list")
    public void admin_refresh_list() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllInventoryPage.REFRESH_BUTTON),
                Click.on(AllInventoryPage.REFRESH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin check region when choose distribution center")
    public void check_region_when_choose_distribution_center(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleInventory.checkRegion(map)
            );
    }

    @And("Admin check quantity when create inventory")
    public void editQuantity(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleInventory.checkQuantity(map)
            );
    }

    @And("Admin click {string} delete inventory on detail")
    public void deleteInventory(String action) {
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.deleteInventory(action)
        );
    }

    @And("Admin refresh inventory on detail")
    public void refreshInventory() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.refreshInventory()
        );
    }

    @And("Admin edit general info of inventory")
    public void editInventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.editInventory(list.get(0))
        );
    }

    @And("Admin check validate edit general info of inventory")
    public void validateEditInventory() {
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.validateEditInventory()
        );
    }

    @And("Admin Export Inventory")
    public void exportInventory() {
        String fileName = "inventories-summary-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        theActorInTheSpotlight().attemptsTo(
                CommonFile.deleteFileToDownload(fileName)
        );
        theActorInTheSpotlight().attemptsTo(
                HandleInventory.exportInventory()
        );
    }

    @And("Admin check content file Export running low inventory")
    public void checkContentExportRunningLow(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        String path = System.getProperty("user.dir") + "/target/" + "inventories-summary-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        List<String[]> file = CommonFile.readDataLineByLine(path);
        List<Map<String, String>> acture = CommonHandle.convertListArrayStringToMapString(file);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(acture.get(i).get("SKU")).containsIgnoringCase(expected.get(i).get("sku")),
                    Ensure.that(acture.get(i).get("Product")).containsIgnoringCase(expected.get(i).get("product")),
                    Ensure.that(acture.get(i).get("Brand")).containsIgnoringCase(expected.get(i).get("brand")),
                    Ensure.that(acture.get(i).get("Unit UPC / EAN")).containsIgnoringCase(expected.get(i).get("unitUpc")),
                    Ensure.that(acture.get(i).get("Case UPC / EAN")).containsIgnoringCase(expected.get(i).get("caseUpc")),
                    Ensure.that(acture.get(i).get("Vendor company")).containsIgnoringCase(expected.get(i).get("vendorCompany")),
                    Ensure.that(acture.get(i).get("Region")).containsIgnoringCase(expected.get(i).get("region")),
                    Ensure.that(acture.get(i).get("Current quantity")).containsIgnoringCase(expected.get(i).get("currentQuantity")),
                    Ensure.that(acture.get(i).get("Original quantity")).containsIgnoringCase(expected.get(i).get("originalQuantity")),
                    Ensure.that(acture.get(i).get("End quantity")).containsIgnoringCase(expected.get(i).get("endQuantity"))
            );
        }
    }

    @And("Admin check content file Export About to expiry inventory")
    public void checkContentExportAboutExpiry(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        String path = System.getProperty("user.dir") + "/target/" + "inventories-summary-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        List<String[]> file = CommonFile.readDataLineByLine(path);
        List<Map<String, String>> acture = CommonHandle.convertListArrayStringToMapString(file);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(acture.get(i).get("Inventory ID")).containsIgnoringCase(expected.get(i).get("inventoryId").isEmpty() ? Serenity.sessionVariableCalled("Id Inventory api").toString() : expected.get(i).get("inventoryId")),
                    Ensure.that(acture.get(i).get("SKU")).containsIgnoringCase(expected.get(i).get("sku")),
                    Ensure.that(acture.get(i).get("Product")).containsIgnoringCase(expected.get(i).get("product")),
                    Ensure.that(acture.get(i).get("Brand")).containsIgnoringCase(expected.get(i).get("brand")),
                    Ensure.that(acture.get(i).get("Unit UPC / EAN")).containsIgnoringCase(expected.get(i).get("unitUpc")),
                    Ensure.that(acture.get(i).get("Case UPC / EAN")).containsIgnoringCase(expected.get(i).get("caseUpc")),
                    Ensure.that(acture.get(i).get("Vendor company")).containsIgnoringCase(expected.get(i).get("vendorCompany")),
                    Ensure.that(acture.get(i).get("Created by")).containsIgnoringCase(expected.get(i).get("createBy")),
                    Ensure.that(acture.get(i).get("Lot code")).containsIgnoringCase(expected.get(i).get("lotCode").contains("random") ? Serenity.sessionVariableCalled("Lot Code").toString() : expected.get(i).get("lotCode")),
                    Ensure.that(acture.get(i).get("Region")).containsIgnoringCase(expected.get(i).get("region")),
                    Ensure.that(acture.get(i).get("Distribution center")).containsIgnoringCase(expected.get(i).get("distribution")),
                    Ensure.that(acture.get(i).get("Current quantity")).containsIgnoringCase(expected.get(i).get("currentQuantity")),
                    Ensure.that(acture.get(i).get("Original quantity")).containsIgnoringCase(expected.get(i).get("originalQuantity")),
                    Ensure.that(acture.get(i).get("End quantity")).containsIgnoringCase(expected.get(i).get("endQuantity")),
                    Ensure.that(acture.get(i).get("Expiry date")).containsIgnoringCase(CommonHandle.setDate2(expected.get(i).get("expiryDate"), "MM/dd/yy")),
                    Ensure.that(acture.get(i).get("Receiving date")).containsIgnoringCase(CommonHandle.setDate2(expected.get(i).get("receivingDate"), "MM/dd/yy")),
                    Ensure.that(acture.get(i).get("Storage shelf life")).containsIgnoringCase(expected.get(i).get("storageShelfLife")),
                    Ensure.that(acture.get(i).get("Storage temperature")).containsIgnoringCase(expected.get(i).get("storageTemperature"))
            );
        }
    }

    @And("Admin check content file Export all inventory")
    public void checkContentExportAll(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        String path = System.getProperty("user.dir") + "/target/" + "inventories-summary-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        List<String[]> file = CommonFile.readDataLineByLine(path);
        List<Map<String, String>> acture = CommonHandle.convertListArrayStringToMapString(file);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(acture.get(i).get("Inventory ID")).containsIgnoringCase(expected.get(i).get("inventoryId").isEmpty() ? Serenity.sessionVariableCalled("Id Inventory api").toString() : expected.get(i).get("inventoryId")),
                    Ensure.that(acture.get(i).get("SKU")).containsIgnoringCase(expected.get(i).get("sku")),
                    Ensure.that(acture.get(i).get("Product")).containsIgnoringCase(expected.get(i).get("product")),
                    Ensure.that(acture.get(i).get("Brand")).containsIgnoringCase(expected.get(i).get("brand")),
                    Ensure.that(acture.get(i).get("Unit UPC / EAN")).containsIgnoringCase(expected.get(i).get("unitUpc")),
                    Ensure.that(acture.get(i).get("Case UPC / EAN")).containsIgnoringCase(expected.get(i).get("caseUpc")),
                    Ensure.that(acture.get(i).get("Vendor company")).containsIgnoringCase(expected.get(i).get("vendorCompany")),
                    Ensure.that(acture.get(i).get("Created by")).containsIgnoringCase(expected.get(i).get("createBy")),
                    Ensure.that(acture.get(i).get("Lot code")).containsIgnoringCase(expected.get(i).get("lotCode").equals("random") ? Serenity.sessionVariableCalled("Lot Code").toString() : expected.get(i).get("lotCode")),
                    Ensure.that(acture.get(i).get("Region")).containsIgnoringCase(expected.get(i).get("region")),
                    Ensure.that(acture.get(i).get("Distribution center")).containsIgnoringCase(expected.get(i).get("distribution")),
                    Ensure.that(acture.get(i).get("Current quantity")).containsIgnoringCase(expected.get(i).get("currentQuantity")),
                    Ensure.that(acture.get(i).get("Original quantity")).containsIgnoringCase(expected.get(i).get("originalQuantity")),
                    Ensure.that(acture.get(i).get("End quantity")).containsIgnoringCase(expected.get(i).get("endQuantity")),
                    Ensure.that(acture.get(i).get("Expiry date")).containsIgnoringCase(CommonHandle.setDate2(expected.get(i).get("expiryDate"), "MM/dd/yy")),
                    Ensure.that(acture.get(i).get("Receiving date")).containsIgnoringCase(CommonHandle.setDate2(expected.get(i).get("receivingDate"), "MM/dd/yy")),
                    Ensure.that(acture.get(i).get("Storage shelf life")).containsIgnoringCase(expected.get(i).get("storageShelfLife")),
                    Ensure.that(acture.get(i).get("Storage temperature")).containsIgnoringCase(expected.get(i).get("storageTemperature"))
            );
        }
    }


    @And("Admin verify delete inventory button on detail is disabled")
    public void delete_Inventory_disable() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(InventoryDetailPage.DELETE_BUTTON_DISABLE)
        );
    }
}
