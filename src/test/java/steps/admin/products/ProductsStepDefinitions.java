package steps.admin.products;

import cucumber.tasks.common.CommonFile;
import io.cucumber.java.en.*;
import cucumber.models.web.Admin.Products.*;
import cucumber.questions.CommonQuestions;
import cucumber.questions.PageTitleQuestions;
import cucumber.singleton.GVs;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.products.HandleProductAdmin;
import cucumber.tasks.admin.products.HandleProductDetail;
import cucumber.tasks.admin.products.HandleFilterProduct;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.products.*;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;

import java.util.List;
import java.util.Map;

import static cucumber.user_interface.admin.products.AdminCreateAProductPage.*;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class ProductsStepDefinitions {
    @And("Search the product by info then system show result")
    public void search_the_product_by_full_name_field(List<SearchProduct> infos) {
        for (SearchProduct info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleFilterProduct.resetFilter(),
                    HandleFilterProduct.filter(info)
            );
            Serenity.setSessionVariable("productName").to(info.getTerm());
        }
    }
    @And("Admin search product with info")
    public void search_the_product_by_full_name_field(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleFilterProduct.resetFilter(),
                    HandleFilterProduct.filter(info)
            );
        }
    }

    @And("Admin edit visibility search product")
    public void edit_visibility_search_field(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
            theActorInTheSpotlight().attemptsTo(
                    HandleFilterProduct.editVisibility(infos.get(0))
            );

    }

    @And("Admin verify search product field not visible")
    public void admin_verify_field_search_uncheck_in_edit_visibility(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleFilterProduct.searchFieldUnVisible(infos.get(0))
        );
    }
    @And("Admin verify search product field visible")
    public void admin_verify_field_search_visibility(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleFilterProduct.searchFieldVisible(infos.get(0))
        );
    }
    @And("Admin check list of product after searching")
    public void checkProductList(List<SearchProduct> infos) {
        for (SearchProduct info : infos) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(info.getTerm(), "name")), containsString(info.getTerm())),
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(info.getTerm(), "brand")), containsString(info.getBrandName())),
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(info.getTerm(), "type")), containsString(info.getProductType())),
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(info.getTerm(), "available-in")), containsString(info.getAvailableIn())),
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(info.getTerm(), "tags")), containsString(info.getTags()))
            );
        }
    }

    @And("Admin verify list tags of product on all product page")
    public void checkTagsProduct(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.TAG_NAME_LIST_PRODUCT(i + 1)), containsString(list.get(i).get("tag"))),
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.TAG_EXPIRE_LIST_PRODUCT(i + 1)), containsString(CommonHandle.setDate2(list.get(i).get("expireDate"), "MM/dd/yy")))
            );
        }
    }

    @And("Admin remove the product on first record")
    public void remove_the_product() {
        String name = Serenity.sessionVariableCalled("productName");
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(AdminAllProductsPage.PRODUCT_NAME)).andIfSo(
                        Click.on(AdminAllProductsPage.DELETE_BUTTON),
                        Click.on(AdminAllProductsPage.I_UNDERSTAND_AND_CONTINUE_BUTTON),
                        CommonWaitUntil.isNotVisible(AllBrandsPage.LOADING_ICON)
                )
        );
    }

    @And("Admin go to product detail from just searched")
    public void go_to_product_detail() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminAllProductsPage.PRODUCT_NAME),
                JavaScriptClick.on(AdminAllProductsPage.PRODUCT_NAME),
                CommonWaitUntil.isNotVisible(AdminAllProductsPage.LOADING_ICON)
        );
    }

    @And("Admin go to detail of product {string}")
    public void go_to_product_detail2(String name) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminAllProductsPage.PRODUCT_NAME(name)),
                Click.on(AdminAllProductsPage.PRODUCT_NAME(name)),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(AdminAllProductsPage.LOADING_ICON)
        );
    }

    @And("Admin check product detail")
    public void check_product_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminProductDetailPage.STATE_STATUS),
                Ensure.that(AdminProductDetailPage.STATE_STATUS).text().contains(list.get(0).get("stateStatus")),
                Ensure.that(AdminProductDetailPage.PRODUCT_NAME).text().contains(list.get(0).get("productName")),
                Ensure.that(AdminProductDetailPage.BRAND_NAME).text().contains(list.get(0).get("brand")),
                Ensure.that(AdminProductDetailPage.VENDOR_COMPANY).text().contains(list.get(0).get("vendorCompany")),
                Ensure.that(AdminProductDetailPage.SAMPLEABLE).text().contains(list.get(0).get("sampleable")),
                Ensure.that(AdminProductDetailPage.PACKAGE_SIZE).text().contains(list.get(0).get("packageSize")),
                Ensure.that(AdminProductDetailPage.UNIT_LWH).text().contains(list.get(0).get("unitLWH")),
                Ensure.that(AdminProductDetailPage.CASE_LWH).text().contains(list.get(0).get("caseLWH")),
                Ensure.that(AdminProductDetailPage.CASE_WEIGHT).text().contains(list.get(0).get("caseWight")),
                Ensure.that(AdminProductDetailPage.UNIT_SIZE).text().contains(list.get(0).get("unitSize")),
                Ensure.that(AdminProductDetailPage.ADDITIONAL_FEE).text().contains(list.get(0).get("additionalFee")),
                Ensure.that(AdminProductDetailPage.CATEGORIES_OF_PRODUCT).text().contains(list.get(0).get("category")),
                Ensure.that(AdminProductDetailPage.TYPE_OF_PRODUCT).text().contains(list.get(0).get("type")),
                Ensure.that(AdminProductDetailPage.CASE_PER_PALLET).text().contains(list.get(0).get("casePerPallet")),
                Ensure.that(AdminProductDetailPage.CASE_PER_LAYER).text().contains(list.get(0).get("casePerLayer")),
                Ensure.that(AdminProductDetailPage.LAYER_PER_PALLET).text().contains(list.get(0).get("layerPerPallet")),
                Ensure.that(AdminProductDetailPage.MASTER_CARTON_PER_PALLET).text().contains(list.get(0).get("masterCarton")),
                Ensure.that(AdminProductDetailPage.CASE_PER_MASTER_CARTON).text().contains(list.get(0).get("caseMaster")),
                Ensure.that(AdminProductDetailPage.MASTER_CASE_WEIGHT).text().contains(list.get(0).get("masterCaseWeight"))
        );
        if (list.get(0).containsKey("stateFee")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.STATE_FEES), containsString(list.get(0).get("stateFee")))
            );
        }
        if (list.get(0).containsKey("tags")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.CURRENT_TAGS), containsString(list.get(0).get("tags"))),
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.CURRENT_TAGS), containsString(CommonHandle.setDate2(list.get(0).get("expiryTag"), "MM/dd/yy")))
            );
        }
        if (list.get(0).containsKey("isBeverage")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.IS_BEVERAGE), containsString(list.get(0).get("isBeverage")))
            );
        }
        if (list.get(0).containsKey("containerType")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.CONTAINER_TYPE), containsString(list.get(0).get("containerType")))
            );
        }
    }

    @And("Admin check Case pack photos")
    public void checkCasePack(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            if (!list.get(i).get("casePackPhoto").isEmpty())
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(AdminProductDetailPage.CASE_PACK_PHOTO("Case Pack Photo", i + 1)), equalToIgnoringCase(list.get(i).get("casePackPhoto")))
                );
            else
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlUnDisplay(AdminProductDetailPage.CASE_PACK_PHOTO("Case Pack Photo", i + 1)))
                );
    }

    @And("Admin edit Is beverage")
    public void editIsBeverage(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminProductDetailPage.IS_BEVERAGE),
                Click.on(AdminProductDetailPage.IS_BEVERAGE),
                CommonWaitUntil.isVisible(AdminProductDetailPage.IS_BEVERAGE_INPUT_TOOLTIP),
                CommonTask.chooseItemInDropdown(AdminProductDetailPage.IS_BEVERAGE_INPUT_TOOLTIP, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(list.get(0).get("isBeverage"))),
                Check.whether(list.get(0).get("containerType").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminProductDetailPage.CONTAINER_TYPE_INPUT_TOOLTIP, list.get(0).get("containerType")
                                , CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(list.get(0).get("containerType")))

                )
        );
    }

    @And("Admin remove Case pack photos")
    public void removeCasePack(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            if (!list.get(i).get("file").isEmpty())
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(AdminProductDetailPage.REMOVE_MASTER_CASE_PHOTO("Case Pack Photo", list.get(i).get("file"))).then(
                                Click.on(AdminProductDetailPage.REMOVE_MASTER_CASE_PHOTO("Case Pack Photo", list.get(i).get("file")))
                        ).then(
                                Click.on(AdminProductDetailPage.SAVE_MASTER_CASE_PHOTO("Case Pack Photo"))
                        ).then(
                                CommonWaitUntil.isNotVisible(AdminProductDetailPage.SAVE_MASTER_CASE_PHOTO("Case Pack Photo"))
                        )
                );
            else theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminProductDetailPage.REMOVE_MASTER_CASE_PHOTO("Case Pack Photo", "Select a photo")).then(
                            Click.on(AdminProductDetailPage.REMOVE_MASTER_CASE_PHOTO("Case Pack Photo", "Select a photo"))
                    ).then(
                            Click.on(AdminProductDetailPage.SAVE_MASTER_CASE_PHOTO("Case Pack Photo"))
                    ).then(
                            CommonWaitUntil.isNotVisible(AdminProductDetailPage.SAVE_MASTER_CASE_PHOTO("Case Pack Photo"))
                    )
            );
    }

    @And("Admin remove Master Carton photos")
    public void removeMasterCarton(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            if (!list.get(i).get("file").isEmpty())
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(AdminProductDetailPage.REMOVE_MASTER_CASE_PHOTO("Master Carton Photo", list.get(i).get("file"))).then(
                                Click.on(AdminProductDetailPage.REMOVE_MASTER_CASE_PHOTO("Master Carton Photo", list.get(i).get("file")))
                        ).then(
                                Click.on(AdminProductDetailPage.SAVE_MASTER_CASE_PHOTO("Master Carton Photo"))
                        ).then(
                                CommonWaitUntil.isNotVisible(AdminProductDetailPage.SAVE_MASTER_CASE_PHOTO("Master Carton Photo"))
                        )
                );
            else theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminProductDetailPage.REMOVE_MASTER_CASE_PHOTO("Master Carton Photo", "Select a photo")).then(
                            Click.on(AdminProductDetailPage.REMOVE_MASTER_CASE_PHOTO("Master Carton Photo", "Select a photo"))
                    ).then(
                            Click.on(AdminProductDetailPage.SAVE_MASTER_CASE_PHOTO("Master Carton Photo"))
                    ).then(
                            CommonWaitUntil.isNotVisible(AdminProductDetailPage.SAVE_MASTER_CASE_PHOTO("Master Carton Photo"))
                    )
            );
    }

    @And("Admin check Master carton photos")
    public void checkMasterCase(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            if (!list.get(i).get("masterPhoto").isEmpty())
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(AdminProductDetailPage.CASE_PACK_PHOTO("Master Carton Photo", i + 1)), equalToIgnoringCase(list.get(i).get("masterPhoto")))
                );
            else
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlUnDisplay(AdminProductDetailPage.CASE_PACK_PHOTO("Master Carton Photo", i + 1)))
                );
    }

    @And("Admin regional MOQS")
    public void check_regional(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(AdminProductDetailPage.CENTRAL_MOQ), equalToIgnoringCase(list.get(0).get("central"))),
                seeThat(CommonQuestions.targetText(AdminProductDetailPage.EAST_MOQ), equalToIgnoringCase(list.get(0).get("east"))),
                seeThat(CommonQuestions.targetText(AdminProductDetailPage.WEST_MOQ), equalToIgnoringCase(list.get(0).get("west")))
        );
    }

    @And("Admin check SKU info")
    public void check_SKU_Info(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(CommonQuestions.isControlDisplay(AdminProductDetailPage.ACTIVE_SKU_NAME)).andIfSo(
                            CommonQuestions.AskForTextEquals(AdminProductDetailPage.NAME_OF_AN_SKU(list.get(i).get("skuName")), list.get(i).get("skuName")),
                            CommonQuestions.AskForTextEquals(AdminProductDetailPage.UNIT_UPC_OF_AN_SKU(list.get(i).get("skuName")), list.get(i).get("unitUpc")),
                            CommonQuestions.AskForTextEquals(AdminProductDetailPage.CASE_UPC_OF_AN_SKU(list.get(i).get("skuName")), list.get(i).get("caseUpc")),
                            CommonQuestions.AskForTextEquals(AdminProductDetailPage.STATUS_OF_AN_SKU(list.get(i).get("skuName")), list.get(i).get("status"))
                    )
            );

        }
    }

    @And("Admin click {string} duplicate with images product {string}")
    public void duplicate(String action, String st) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.duplicateProduct(st, action)
        );
    }

    @And("Admin {string} duplicate product on detail")
    public void duplicate(String action) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.duplicateProductDetail(action)
        );
    }

    @And("Admin click Mass editing SKU")
    public void massEditing() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.massEditing()
        );
    }

    @And("Admin click update Mass editing SKU")
    public void updateMassEditing() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update all")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update all")),
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK"))).andIfSo(
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK"))
                ),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin Mass editing choose {string} SKU")
    public void chooseSKUMassEditing(String all, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (all.equalsIgnoreCase("all"))
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.chooseAllSKUMassEditing()
            );
        else
            for (Map<String, String> map : list)
                theActorInTheSpotlight().attemptsTo(
                        HandleProductDetail.chooseSKUMassEditing(map)
                );
    }

    @And("Admin check SKU on Mass editing")
    public void checkSKUMassEditing(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AdminProductDetailPage.MASS_EDIT_SKU_NAME(map.get("sku"), "image-stamp"), "style"), containsString(map.get("image")))
//                    seeThat(CommonQuestions.targetText(Admin_Product_Detail_Page.MASS_EDIT_SKU_NAME(map.get("sku"), "upc-tag")), containsString(map.get("upc")))
//                    seeThat(CommonQuestions.targetText(Admin_Product_Detail_Page.MASS_EDIT_END_QTY(map.get("sku"))), containsString(map.get("endQty")))
            );
    }

    @And("Admin check end quantity of SKU {string} on Mass editing")
    public void checkEndQtySKUMassEditing(String sku, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.MASS_EDIT_END_QTY(map.get("region"), sku)), containsString(map.get("endQty")))
            );
    }

    @And("Admin check SKU info on tab {string}")
    public void check_SKU_Info(String tab, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminProductDetailPage.TAB_SKU(tab)),
                Click.on(AdminProductDetailPage.TAB_SKU(tab)),
                WindowTask.threadSleep(1000)
        );
        for (int i = 0; i < list.size(); i++) {
            String id = list.get(i).get("codeSKU").isEmpty() ? Serenity.sessionVariableCalled("itemCode" + list.get(i).get("skuName")) : list.get(i).get("codeSKU");
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminProductDetailPage.NAME_OF_AN_SKU(list.get(i).get("skuName"))).text().contains(list.get(i).get("skuName")),
                    Ensure.that(AdminProductDetailPage.UNIT_UPC_OF_AN_SKU(list.get(i).get("skuName"))).text().contains(list.get(i).get("unitUpc")),
                    Ensure.that(AdminProductDetailPage.STATUS_OF_AN_SKU(list.get(i).get("skuName"))).text().contains(list.get(i).get("status")),
                    Ensure.that(AdminProductDetailPage.UNIT_PER_OF_AN_SKU(list.get(i).get("skuName"))).text().contains(list.get(i).get("unitPerCase")),
                    Ensure.that(AdminProductDetailPage.REGIONS_OF_AN_SKU(list.get(i).get("skuName"))).text().contains(list.get(i).get("regions"))
            );
            if (!list.get(i).get("caseUpc").isEmpty())
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AdminProductDetailPage.CASE_UPC_OF_AN_SKU(list.get(i).get("skuName"))).text().contains(list.get(i).get("caseUpc"))
                );
            if (!id.equalsIgnoreCase("not check"))
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.AskForContainValue(id, CommonQuestions.getText(theActorInTheSpotlight(), AdminProductDetailPage.CODE_OF_AN_SKU(list.get(i).get("skuName")))))
                );
        }
    }

    @And("Admin check tags of SKU {string} on list SKU")
    public void check_tag_SKU_list(String sku, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(AdminProductDetailPage.TAGS_OF_AN_SKU(sku, list.get(i).get("tagName")))));
            if (!list.get(i).get("expiry").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(AdminProductDetailPage.TAGS_EXPIRY_OF_AN_SKU(sku, list.get(i).get("tagName"))), containsString(CommonHandle.setDate2(list.get(i).get("expiry"), "MM/dd/yy")))
                );
            }
        }
    }

    @And("Admin check message of sku {string} is {string}")
    public void check_message_of_sku(String skuName, String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message), 60),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
        String c2 = AdminCreateNewSKUPage.DYNAMIC_INPUT("Item code").resolveFor(theActorInTheSpotlight()).getAttribute("value").trim();
        String id = CommonHandle.getCurrentURL().split("variants/")[1].trim();
        Serenity.setSessionVariable("itemCode" + skuName).to(c2);
        Serenity.setSessionVariable("SKU ID " + skuName).to(id);
        Serenity.setSessionVariable("ID SKU Admin").to(id);

    }

    @And("Admin check SKU Inactive info")
    public void check_SKU_Inactive_Info(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.NAME_OF_AN_SKU(list.get(i).get("skuName"))), equalToIgnoringCase(list.get(i).get("skuName"))),
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.UNIT_UPC_OF_AN_SKU(list.get(i).get("skuName"))), equalToIgnoringCase(list.get(i).get("unitUpc"))),
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.STATUS_OF_AN_SKU(list.get(i).get("skuName"))), equalToIgnoringCase(list.get(i).get("status")))
            );
        }
    }

    @And("Admin go to SKU detail {string}")
    public void go_to_sku_detail(String skuName) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.seeDetailSKU(skuName)
        );
    }

    @And("Create new Product")
    public void admin_create_new_product(DataTable table) {
        List<Map<String, String>> product = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminAllProductsPage.CREATE_BUTTON),
                Click.on(AdminAllProductsPage.CREATE_BUTTON),
                HandleProductAdmin.createProduct(product.get(0))
//                ProductDetail.checkProductDetail(product)
        );
        WebDriver driver = BrowseTheWeb.as(theActorInTheSpotlight()).getDriver();
        String[] link = driver.getCurrentUrl().split("products/");
        String id = link[link.length - 1].replaceAll("/", "");
        Serenity.setSessionVariable("product_id").to(id);
    }

    @And("Check product not have SKU")
    public void checkNotHaveSku() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.checkNoHaveSku()
        );
    }

    @And("Admin {string} this product")
    public void deactiveProduct(String state) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.changeState(state)
        );
    }

    @And("Click Create")
    public void clickCreate() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.submitCreate(),
                HandleProductDetail.checkActivatingSKU()
        );
    }

    @And("Admin accept activating SKU")
    public void activatingSKU() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.checkActivatingSKU()
        );
    }

    @And("Go to {word} SKU tab")
    public void goToInactiveTab(String tab) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(AdminProductDetailPage.SKU_TAB(tab))
        );
    }

    @And("Change availability of SKU {string} in product {string}")
    public void change_availability_of_sku(String skuName, String product, List<RegionSpecificModel> regionSpecificModel) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.seeDetail(),
                HandleProductDetail.seeDetailSKU(skuName),
                HandleProductDetail.goToRegionSpecific(),
                HandleProductDetail.changeAvailabity(regionSpecificModel.get(0))
        );
    }

    @And("Admin go to region-specific of SKU then verify")
    public void goToRegionSpecific(List<RegionSpecificModel> regionSpecificModel) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.goToRegionSpecific()
        );
        for (RegionSpecificModel item : regionSpecificModel) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.DYNAMIC_FIELD(item.getRegionName(), "case-price"), "value"), equalTo(item.getCasePrice())),
                    seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.DYNAMIC_FIELD(item.getRegionName(), "msrp"), "value"), equalTo(item.getMsrpunit())),
                    seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.DYNAMIC_FIELD(item.getRegionName(), "availability"), "value"), equalTo(item.getAvailability()))
            );
        }
    }

    @And("Click Update")
    public void click_update() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.update()
        );
    }

    @And("Admin verify page title is {string}")
    public void admin_verify_page_title(String pageTitle) {
        theActorInTheSpotlight().should(
                seeThat(PageTitleQuestions.value(), containsString(pageTitle))
        );
    }

    @And("Admin create new product with general info")
    public void createNewProductGeneralInfo(DataTable table) {
        List<Map<String, String>> product = table.asMaps(String.class, String.class);
        goToCreateProduct();
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.inputGeneral(product.get(0))
        );
    }

    @And("Admin go to create new product page")
    public void goToCreateProduct() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.goToCreate()
        );
    }

    @And("Admin create new product with tags")
    public void addTags(List<Tags> tags) {
        for (Tags tag : tags)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.addTags(tag)
            );
    }

    @And("Admin add case pack photo")
    public void addCasePackPhoto(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.addCasePackPhoto(map)
            );
    }

    @And("Admin add case pack photo on product detail")
    public void addCasePackPhotoDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.addCasePackPhotoDetail(map)
            );
    }

    @And("Admin add master carton photo")
    public void addMasterCartonPhoto(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.addMasterCartonPhoto(map)
            );
    }

    @And("Admin add master carton photo on product detail")
    public void addMasterCartonPhotoDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.addMasterCartonPhotoDetail(map)
            );
    }

    @And("Admin create new product with state fees")
    public void addFees(List<StateFees> fees) {
        for (StateFees fee : fees)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.addStateFees(fee)
            );
    }
    @And("Admin check state fees added")
    public void addFeesAdded(String fees) {
       theActorInTheSpotlight().attemptsTo(
               CommonWaitUntil.isVisible(ADD_STATE_FEE_BUTTON),
               Click.on(ADD_STATE_FEE_BUTTON),
               CommonWaitUntil.isVisible(ADD_STATE_FEE_INPUT),
               Click.on(ADD_STATE_FEE_INPUT),
               Enter.theValue(fees).into(ADD_STATE_FEE_INPUT),
               CommonWaitUntil.isVisible(D_DROPDOWN_VALUE(fees)),
               Ensure.that(D_DROPDOWN_VALUE_DISABLE(fees)).attribute("class").contains("disable")
       );
    }

    @And("Admin confirm create new product")
    public void create() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.confirmCreate()
        );
    }

    @And("Admin edit info of product")
    public void edit(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.editInfo(list.get(0))
        );
    }

    @And("Admin edit pallet configuration of product")
    public void editPalletConfig(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.editPalletConfig(list.get(0))
        );
    }

    @And("Admin edit master case configuration of product")
    public void editMasterCaseConfig(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.editMasterCaseConfig(list.get(0))
        );
    }

    @And("Admin edit state fees of product")
    public void editStateFee(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(AdminProductDetailPage.STATE_FEES),
                CommonWaitUntil.isVisible(AdminProductDetailPage.ADD_STATE_FEE_BUTTON)
        );
        for (Map<String, String> map : list) {
            HandleProductAdmin.editStateFee(map);
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(AdminProductDetailPage.ADD_STATE_FEE_UPDATE_BUTTON),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin add state fees of product")
    public void addStateFee(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(AdminProductDetailPage.STATE_FEES),
                CommonWaitUntil.isVisible(AdminProductDetailPage.ADD_STATE_FEE_BUTTON)
        );
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.addStateFees(map)
            );
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(AdminProductDetailPage.ADD_STATE_FEE_UPDATE_BUTTON),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin edit tags of product")
    public void editTags(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.editTags(list.get(0))
        );
    }

    @And("{word} go to product {string} with sku {string} by link")
    public void admin_go_to_product_and_sku_by_link(String actor, String productID, String skuID) {
        if (skuID.isEmpty()) {
            skuID = Serenity.sessionVariableCalled("ID SKU Admin");
        }
        theActorCalled(actor).attemptsTo(
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                Open.url(GVs.URL_ADMIN + "products/" + productID + "/variants/" + skuID),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin check message {word} showing of fields when create product")
    public void checkMessage(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (type.equals("is")) {
                if (map.get("field").equalsIgnoreCase("category")) {
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetText(AdminCreateAProductPage.CATEGORY_ERROR), containsString(map.get("message")))
                    );
                } else
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(AdminCreateAProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).text().isEqualToIgnoringCase(map.get("message"))
                    );

            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AdminCreateAProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).isNotDisplayed()
                );
        }
    }

    @And("Admin Clear field {string} when create product")
    public void adminClearField(String field) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateAProductPage.DYNAMIC_INPUT(field)),
                Scroll.to(AdminCreateAProductPage.DYNAMIC_INPUT(field)),
//                Enter.theValue(" ").into(Admin_Create_A_Product_Page.DYNAMIC_INPUT(field)),
                CommonTask.clearFieldByEnterKey(AdminCreateAProductPage.DYNAMIC_INPUT(field)),
//                Clear.field(Admin_Create_A_Product_Page.DYNAMIC_INPUT(field)),
                Hit.the(Keys.ESCAPE).keyIn(AdminCreateAProductPage.DYNAMIC_INPUT(field))
        );
    }

    @And("Admin verify alert when create product")
    public void adminVerifyAlertCreateProduct(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateAProductPage.ERROR_ALERT),
                Ensure.that(AdminCreateAProductPage.ERROR_ALERT).text().containsIgnoringCase(message)
        );
    }

    @And("Admin input field values")
    public void adminInputField(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Enter.theValue(map.get("value").equalsIgnoreCase("blank") ? " " : map.get("value")).into(AdminCreateAProductPage.DYNAMIC_INPUT(map.get("field"))).thenHit(Keys.TAB)
            );
        }
    }

    @And("Admin check Unit size type {string}")
    public void checkUnitSizeType(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateAProductPage.UNIT_SIZE_TYPE),
                Click.on(AdminCreateAProductPage.UNIT_SIZE_TYPE),
                CommonTask.ChooseValueFromSuggestionsWithJS(type)
        );
    }

    @And("Admin create new product with Region MOQs")
    public void regionMOQ(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.inputMOQ(map)
            );
    }

    @And("Admin check Region MOQs error")
    public void checkRegionMOQ(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminCreateAProductPage.REGION_MOQ_ERROR(map.get("region"))), equalToIgnoringCase(map.get("message")))
            );
    }

    @And("Admin check have no Region MOQs")
    public void checkNoRegionMOQ() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Chicagoland Express"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("New York Express"))),
//                seeThat(CommonQuestions.isControlUnDisplay(Admin_Create_A_Product_Page.DYNAMIC_INPUT_REGION_MOQ("Texas Express"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Dallas Express"))),
//                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Pod Direct Southeast"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Florida Express"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("North California Express"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Pod Direct Central"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Pod Direct East"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Mid Atlantic Express"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("South California Express"))),
//                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Pod Direct Northeast"))),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ("Pod Direct West")))
        );
    }

    @And("Admin remove state fee when create product")
    public void removeStateFee(List<StateFees> fees) {
        for (StateFees fee : fees)
            HandleProductAdmin.removeStateFeesWhenCreate(fee);
    }

    @And("Admin delete product {string} from list product")
    public void deleteProductFromList(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.deleteProduct(name)
        );
    }

    @And("Admin delete product from product detail")
    public void admin_delete_product_from_product_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductAdmin.deleteProductInDetail()
        );
    }

    @And("Admin check no data found")
    public void checkNoData() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminAllProductsPage.NO_DATA)
        );
    }

    @And("Admin cancel edit field")
    public void cancelEdit() {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.cancelEdit()
        );
    }

    @And("Admin edit Region MOQs")
    public void editRegionMOQ(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductAdmin.editMOQ(map)
            );
    }

    @And("Admin check help text tooltip1")
    public void checkHelpText(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.checkHelpTooltip(map.get("field"), map.get("text"))
            );
    }

    @And("Admin check Bottle Deposit Label")
    public void check_Bottle_Deposit_Label() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateAProductPage.BOTTLE_DEPOSIT_LABEL),
                MoveMouse.to(AdminCreateAProductPage.BOTTLE_DEPOSIT_LABEL),
                Ensure.that(AdminCreateAProductPage.BOTTLE_DEPOSIT_LABEL_IMAGE).isDisplayed()
        );
    }

    @And("Admin upload Bottle Deposit Label {string}")
    public void upload_Bottle_Deposit_Label(String file) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateAProductPage.BOTTLE_DEPOSIT_LABEL),
                CommonFile.upload(file, AdminCreateAProductPage.BOTTLE_DEPOSIT_LABEL_UPLOAD_IMAGE)
        );
    }

    @And("Admin check dialog help text tooltip of field {string}")
    public void checkDialogHelpText(String field, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.checkDialogHelpTooltip(CommonAdminForm.DYNAMIC_INPUT2(field), list.get(0).get("field"), list.get(0).get("text"))
        );
    }

    @And("Admin {word} field number tooltip {int} times")
    public void checkFieldNumber(String type, int time, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        CommonTaskAdmin.changeTextboxNumberIncreaseDecreaseValue(AdminCreateAProductPage.DYNAMIC_INPUT(list.get(0).get("field")), type, time);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetValue(AdminCreateAProductPage.DYNAMIC_INPUT(list.get(0).get("field"))), equalToIgnoringCase(list.get(0).get("text")))
        );
    }

    @And("Admin check upc tag of SKU")
    public void clickUPC(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateAProductPage.UPC_TAG("unit")),
                Ensure.that(AdminCreateAProductPage.UPC_TAG("unit")).text().isEqualToIgnoringCase(list.get(0).get("unitUPC")),
                Click.on(AdminCreateAProductPage.UPC_TAG("unit")).then(
                        CommonWaitUntil.isVisible(AdminCreateAProductPage.UPC_TAG_POPUP).then(
                                Ensure.that(AdminCreateAProductPage.UPC_TAG_POPUP).text().contains("\"" + list.get(0).get("unitUPC") + "\" is not a valid input for UPC / EAN barcode.")
                        )
                ),
                Ensure.that(AdminCreateAProductPage.UPC_TAG("case")).text().isEqualToIgnoringCase(list.get(0).get("caseUPC")),
                Click.on(AdminCreateAProductPage.UPC_TAG("case")).then(
                        CommonWaitUntil.isVisible(AdminCreateAProductPage.UPC_TAG_POPUP).then(
                                Ensure.that(AdminCreateAProductPage.UPC_TAG_POPUP).text().contains("\"" + list.get(0).get("caseUPC") + "\" is not a valid input for UPC / EAN barcode.")
                        )
                )
        );
    }

    @And("Admin check region-specific of SKU {string} on mass editing")
    public void checkRegionMassEdit(String sku, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminProductDetailPage.MASS_REGION_INFO(sku, map.get("region"))),
                    Check.whether(map.get("status").contains("is-checked")).andIfSo(
                            Ensure.that(AdminProductDetailPage.MASS_REGION_INFO(sku, map.get("region"))).attribute("class").contains("is-checked")
                    ).otherwise(
                            Ensure.that(AdminProductDetailPage.MASS_REGION_INFO(sku, map.get("region"))).attribute("class").doesNotContain("is-checked")
                    ),
                    Ensure.that(AdminProductDetailPage.MASS_REGION_INVENTORY_COUNT(sku, map.get("region"))).text().isEqualTo(map.get("inventoryCount")),
                    Ensure.that(AdminProductDetailPage.MASS_REGION_CASE_PRICE(sku, map.get("region"))).attribute("value").contains(map.get("casePrice"))
            );
    }

    @And("Admin check buyer company-specific of SKU {string} on Mass editing")
    public void checkBuyerSpecific(String sku, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.MASS_BUYER_INVENTORY_COUNT(sku, map.get("buyerCompany"), map.get("region"), "inventory-count")), equalToIgnoringCase(map.get("inventoryCount"))),
                    seeThat(CommonQuestions.targetValue(AdminProductDetailPage.MASS_BUYER_CASE_PRICE(sku, map.get("buyerCompany"), map.get("region"), "usd-to-cents-input")), equalToIgnoringCase(map.get("casePrice"))),
                    seeThat(CommonQuestions.targetValue(AdminProductDetailPage.MASS_BUYER_CASE_PRICE(sku, map.get("buyerCompany"), map.get("region"), "start-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetValue(AdminProductDetailPage.MASS_BUYER_CASE_PRICE(sku, map.get("buyerCompany"), map.get("region"), "end-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")))
            );
        }
    }

    @And("Admin check store-specific of SKU {string} on Mass editing")
    public void checkStoreSpecific(String sku, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductDetailPage.MASS_STORE_INVENTORY_COUNT(sku, map.get("store"), map.get("region"), "inventory-count")), equalToIgnoringCase(map.get("inventoryCount"))),
                    seeThat(CommonQuestions.targetValue(AdminProductDetailPage.MASS_STORE_CASE_PRICE(sku, map.get("store"), map.get("region"), "usd-to-cents-input")), equalToIgnoringCase(map.get("casePrice"))),
                    seeThat(CommonQuestions.targetValue(AdminProductDetailPage.MASS_STORE_CASE_PRICE(sku, map.get("store"), map.get("region"), "start-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetValue(AdminProductDetailPage.MASS_STORE_CASE_PRICE(sku, map.get("store"), map.get("region"), "end-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")))
            );
        }
    }
}
