package cucumber.tasks.admin.products;

import cucumber.models.web.Admin.Products.StateFees;
import cucumber.models.web.Admin.Products.Tags;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.admin.products.AdminAllProductsPage;
import cucumber.user_interface.admin.products.AdminCreateAProductPage;
import cucumber.user_interface.admin.products.AdminProductDetailPage;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static cucumber.user_interface.admin.products.AdminCreateAProductPage.*;

import static cucumber.user_interface.admin.products.AdminCreateAProductPage.D_DROPDOWN_VALUE;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleProductAdmin {

    public static Task check(Map<String, String> info) {
        return Task.where("Search product",
                Check.whether(valueOf(CommonAdminForm.SEARCH_BUTTON), isCurrentlyVisible())
                        .otherwise(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(!info.get("searchTerm").isEmpty())
                        .andIfSo(Enter.theValue(info.get("searchTerm")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("search_term"))),
                Check.whether(!info.get("brand").isEmpty())
                        .andIfSo(Enter.theValue(info.get("brand")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"))),
                Click.on(CommonAdminForm.SEARCH_BUTTON)
        );
    }

    public static Task createProduct(Map<String, String> product) {

        return Task.where("Create product",
                CommonWaitUntil.isVisible(BRAND_FIELD),
                Enter.theValue(product.get("brandName")).into(BRAND_FIELD),
                CommonWaitUntil.isVisible(THE_FIRST_SUGGESTION_OF_BRAND),
                CommonTask.ChooseValueFromSuggestions(product.get("brandName")),
                Enter.theValue(product.get("productName")).into(PRODUCT_NAME_FIELD),

                Enter.theValue(product.get("type")).into(PRODUCT_TYPE),
                CommonWaitUntil.isVisible(THE_FIRST_SUGGESTION_OF_PRODUCT_TYPE),
                Click.on(THE_FIRST_SUGGESTION_OF_PRODUCT_TYPE),
                Check.whether(product.get("allowRequestSamples").equals("No")).andIfSo(
                        Check.whether(CommonQuestions.isControlDisplay(ALLOW_SAMPLE)).otherwise(
                                Click.on(ALLOW_SAMPLE)
                        )
                ),
                Enter.theValue(product.get("unitWidth")).into(UNIT_WIDTH_FIELD),
                Enter.theValue(product.get("unitHeight")).into(UNIT_HEIGHT_FIELD),
                Enter.theValue(product.get("unitLength")).into(UNIT_LENGTH_FIELD),

                Enter.theValue(product.get("caseWidth")).into(CASE_WIDTH_FIELD),
                Enter.theValue(product.get("caseHeight")).into(CASE_HEIGHT_FIELD),
                Enter.theValue(product.get("caseLength")).into(CASE_LENGTH_FIELD),
                Enter.theValue(product.get("caseWeight")).into(CASE_WEIGHT_FIELD),

                Enter.theValue(product.get("packageSize")).into(PACKAGE_SIZE),
                CommonTask.ChooseValueFromSuggestions(product.get("packageSize")),

                Enter.theValue(product.get("unitSize")).into(UNIT_SIZE),
                Enter.theValue(product.get("casesPerPallet")).into(CASES_PER_PALLET_FIELD),
                Enter.theValue(product.get("casesPerLayer")).into(CASES_PER_LAYER_FIELD),
                Enter.theValue(product.get("layersPerFullPallet")).into(LAYERS_PER_FULL_PALLET_FIELD),

                Enter.theValue(product.get("masterCartonsPerPallet")).into(DYNAMIC_INPUT("Master Cartons per Pallet")),
                Enter.theValue(product.get("casesPerMasterCarton")).into(DYNAMIC_INPUT("Cases per Master Carton")),
                Enter.theValue(product.get("masterCaseDimensionsLength")).into(DYNAMIC_INPUT("Master carton L\" × W\" × H", 1)),
                Enter.theValue(product.get("masterCaseDimensionsWidth")).into(DYNAMIC_INPUT("Master carton L\" × W\" × H", 2)),
                Enter.theValue(product.get("masterCaseDimensionsHeight")).into(DYNAMIC_INPUT("Master carton L\" × W\" × H", 3)),
                Enter.theValue(product.get("masterCaseWeight")).into(DYNAMIC_INPUT("Master carton Weight")),
                Enter.theValue(product.get("microDescriptions")).into(DYNAMIC_INPUT("Micro-descriptions")),

                Click.on(CREATE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)

        );
    }

    public static Task inputGeneral(Map<String, String> product) {
        return Task.where("Create product",
                CommonWaitUntil.isVisible(BRAND_FIELD),
                Check.whether(product.get("brandName").isEmpty()).otherwise(
                        Enter.theValue(product.get("brandName")).into(BRAND_FIELD),
                        CommonTask.ChooseValueFromSuggestions(product.get("brandName"))
                ),
                Enter.theValue(product.get("productName").isEmpty() ? " " : product.get("productName")).into(PRODUCT_NAME_FIELD),
                Check.whether(product.get("allowRequestSamples").equals("No")).andIfSo(
                        Check.whether(CommonQuestions.isControlDisplay(ALLOW_SAMPLE)).otherwise(
                                Click.on(ALLOW_SAMPLE))
                ),
                Check.whether(product.get("isBeverage").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(IS_BEVERAGE, D_DROPDOWN_VALUE(product.get("isBeverage")))
                ),
                Check.whether(product.get("additionalFee").isEmpty()).otherwise(
                        Enter.theValue(product.get("additionalFee")).into(ADDITIONAL_FEE)),
                Check.whether(product.get("type").isEmpty()).otherwise(
                        Enter.theValue(product.get("type")).into(PRODUCT_TYPE),
                        CommonWaitUntil.isVisible(THE_FIRST_SUGGESTION_OF_PRODUCT_TYPE),
                        Click.on(THE_FIRST_SUGGESTION_OF_PRODUCT_TYPE)),
                Check.whether(product.get("containerType").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(CONTAINER_TYPE),
                        CommonTask.chooseItemInDropdownWithValueInput(CONTAINER_TYPE, product.get("containerType"), D_DROPDOWN_VALUE(product.get("containerType")))
                ),
                Check.whether(product.get("unitWidth").isEmpty()).otherwise(
                        Enter.theValue(product.get("unitWidth")).into(UNIT_WIDTH_FIELD)),
                Check.whether(product.get("unitHeight").isEmpty()).otherwise(
                        Enter.theValue(product.get("unitHeight")).into(UNIT_HEIGHT_FIELD)),
                Check.whether(product.get("unitLength").isEmpty()).otherwise(
                        Enter.theValue(product.get("unitLength")).into(UNIT_LENGTH_FIELD)),
                Check.whether(product.get("caseWidth").isEmpty()).otherwise(
                        Enter.theValue(product.get("caseWidth")).into(CASE_WIDTH_FIELD)),
                Check.whether(product.get("caseHeight").isEmpty()).otherwise(
                        Enter.theValue(product.get("caseHeight")).into(CASE_HEIGHT_FIELD)),
                Check.whether(product.get("caseLength").isEmpty()).otherwise(
                        Enter.theValue(product.get("caseLength")).into(CASE_LENGTH_FIELD)),
                Check.whether(product.get("caseWeight").isEmpty()).otherwise(
                        Enter.theValue(product.get("caseWeight")).into(CASE_WEIGHT_FIELD)),
                Check.whether(product.get("packageSize").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(PACKAGE_SIZE, product.get("packageSize"), D_DROPDOWN_VALUE(product.get("packageSize")))),
                Check.whether(product.get("unitSize").isEmpty()).otherwise(
                        Enter.theValue(product.get("unitSize")).into(UNIT_SIZE)),
                Check.whether(product.get("casesPerPallet").isEmpty()).otherwise(
                        Enter.theValue(product.get("casesPerPallet")).into(CASES_PER_PALLET_FIELD)),
                Check.whether(product.get("casesPerLayer").isEmpty()).otherwise(
                        Enter.theValue(product.get("casesPerLayer")).into(CASES_PER_LAYER_FIELD)),
                Check.whether(product.get("layersPerFullPallet").isEmpty()).otherwise(
                        Enter.theValue(product.get("layersPerFullPallet")).into(LAYERS_PER_FULL_PALLET_FIELD)),
                Check.whether(product.get("masterCartonsPerPallet").isEmpty()).otherwise(
                        Enter.theValue(product.get("masterCartonsPerPallet")).into(DYNAMIC_INPUT("Master Cartons per Pallet"))),
                Check.whether(product.get("casesPerMasterCarton").isEmpty()).otherwise(
                        Enter.theValue(product.get("casesPerMasterCarton")).into(DYNAMIC_INPUT("Cases per Master Carton"))),
                Check.whether(product.get("masterCaseDimensionsLength").isEmpty()).otherwise(
                        Enter.theValue(product.get("masterCaseDimensionsLength")).into(DYNAMIC_INPUT("Master carton L\" × W\" × H", 1))),
                Check.whether(product.get("masterCaseDimensionsWidth").isEmpty()).otherwise(
                        Enter.theValue(product.get("masterCaseDimensionsWidth")).into(DYNAMIC_INPUT("Master carton L\" × W\" × H", 2))),
                Check.whether(product.get("masterCaseDimensionsHeight").isEmpty()).otherwise(
                        Enter.theValue(product.get("masterCaseDimensionsHeight")).into(DYNAMIC_INPUT("Master carton L\" × W\" × H", 3))),
                Check.whether(product.get("masterCaseWeight").isEmpty()).otherwise(
                        Enter.theValue(product.get("masterCaseWeight")).into(DYNAMIC_INPUT("Master carton Weight"))),
                Check.whether(product.get("microDescriptions").isEmpty()).otherwise(
                        Enter.theValue(product.get("microDescriptions")).into(DYNAMIC_INPUT("Micro-descriptions")))
        );
    }

    public static Task addTags(Tags info) {
        return Task.where("add Tags",
                CommonWaitUntil.isVisible(DYNAMIC_INPUT("Tags")),
                CommonTask.chooseItemInDropdownWithValueInput(DYNAMIC_INPUT("Tags"), info.getTagName(), D_DROPDOWN_VALUE(info.getTagName())),
//                Enter.theValue(info.getTagName()).into(DYNAMIC_INPUT("Tags")),
//                CommonTask.ChooseValueFromSuggestions(info.getTagName()),
                CommonWaitUntil.isVisible(TAG_EXPIRY(info.getTagName())),
                Enter.theValue(CommonHandle.setDate2(info.getExpiryDate(), "MM/dd/yy")).into(TAG_EXPIRY(info.getTagName())).thenHit(Keys.TAB)

        );
    }

    public static Task addCasePackPhoto(Map<String, String> map) {
        return Task.where("add Case Pack Photos",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add case pack photo")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add case pack photo")).then(
                        CommonWaitUntil.isVisible(CommonAdminForm.ANY_TEXT("Select a photo"))
                ).then(
                        CommonFile.upload(map.get("fileName"), CASE_PACK_PHOTO)
                )
        );
    }

    public static Task addCasePackPhotoDetail(Map<String, String> map) {
        return Task.where("add Case Pack Photos",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add case pack photo")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add case pack photo")).then(
                        CommonWaitUntil.isVisible(CommonAdminForm.ANY_TEXT("Select a photo"))
                ).then(
                        CommonFile.upload(map.get("fileName"), CASE_PACK_PHOTO_DETAIL)
                ).then(
                        Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save"))
                )
        );
    }

    public static Task addMasterCartonPhotoDetail(Map<String, String> map) {
        return Task.where("Add master carton photo",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add master carton photo")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add master carton photo")).then(
                        CommonWaitUntil.isVisible(CommonAdminForm.ANY_TEXT("Select a photo"))
                ).then(
                        CommonFile.upload(map.get("fileName"), MASTER_CARTON_PHOTO_DETAIL)
                ).then(
                        Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save"))
                )
        );
    }

    public static Task addMasterCartonPhoto(Map<String, String> map) {
        return Task.where("Add master carton photo",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add master carton photo")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add master carton photo")).then(
                        CommonWaitUntil.isVisible(CommonAdminForm.ANY_TEXT("Select a photo"))
                ).then(
                        CommonFile.upload(map.get("fileName"), MASTER_CARTON_PHOTO)
                )
        );
    }

    public static Task addStateFees(StateFees info) {
        return Task.where("add State Fees",
                CommonWaitUntil.isVisible(ADD_STATE_FEE_BUTTON),
                Click.on(ADD_STATE_FEE_BUTTON),
                CommonWaitUntil.isVisible(ADD_STATE_FEE_INPUT),
                CommonTask.chooseItemInDropdownWithValueInput(ADD_STATE_FEE_INPUT, info.getStateFeeName(), D_DROPDOWN_VALUE(info.getStateFeeName())),
                Enter.theValue(info.getStateFeeValue()).into(ADD_STATE_FEE_VALUE)
        );
    }

    public static void removeStateFeesWhenCreate(StateFees info) {
        List<WebElementFacade> webElementFacades = ADD_STATE_FEE_INPUT2.resolveAllFor(theActorInTheSpotlight());
        List<String> fee = new ArrayList<>();
        for (WebElementFacade e : webElementFacades) {
            fee.add(e.getValue());
        }
        if (fee.size() > 0) {
            int i = fee.lastIndexOf(info.getStateFeeName());
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(DELETE_STATE_FEE(i + 1)),
                    Click.on(DELETE_STATE_FEE(i + 1))
            );
            webElementFacades = ADD_STATE_FEE_INPUT2.resolveAllFor(theActorInTheSpotlight());
            fee = new ArrayList<>();
            for (WebElementFacade e : webElementFacades) {
                fee.add(e.getValue());
            }
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(fee.contains(info.getStateFeeName())).isFalse()
            );
        }
    }

    public static Task editInfo(Map<String, String> map) {
        return Task.where("Edit info",
                Check.whether(map.get("name").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.PRODUCT_NAME, map.get("name").equals("blank") ? " " : map.get("name"))
                ),
                Check.whether(map.get("sampleable").isEmpty()).otherwise(
                        CommonTaskAdmin.changeSwitchValueFromTooltip(AdminProductDetailPage.SAMPLEABLE, map.get("sampleable"))
                ),
                Check.whether(map.get("packageSize").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipDropdown(AdminProductDetailPage.PACKAGE_SIZE, map.get("packageSize"))
                ),
                editInfoLWH(map, "unit"),
                editInfoLWH(map, "case"),
                Check.whether(map.get("caseWeight").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.CASE_WEIGHT, map.get("caseWeight"))
                ),
                Check.whether(map.get("unitSize").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.UNIT_SIZE, map.get("unitSize"))
                ),
                Check.whether(map.get("unitSizeType").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipDropdown(AdminProductDetailPage.UNIT_SIZE, map.get("unitSizeType"))
                ),
                Check.whether(map.get("additionalFee").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.ADDITIONAL_FEE, map.get("additionalFee"))
                ),
                Check.whether(map.get("categories").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(AdminProductDetailPage.CATEGORIES_OF_PRODUCT),
                        Click.on(AdminProductDetailPage.CATEGORIES_OF_PRODUCT),
                        CommonWaitUntil.isVisible(PRODUCT_TYPE),
                        Click.on(PRODUCT_TYPE),
                        CommonWaitUntil.isVisible(PRODUCT_CATEGORY(map.get("categories"))),
                        Scroll.to(PRODUCT_CATEGORY(map.get("categories"))),
                        Click.on(PRODUCT_CATEGORY(map.get("categories"))),
                        Check.whether(map.get("type").isEmpty()).otherwise(
                                CommonWaitUntil.isVisible(PRODUCT_CATEGORY(map.get("type"))),
                                Scroll.to(PRODUCT_CATEGORY(map.get("type"))),
                                Click.on(PRODUCT_CATEGORY(map.get("type")))
                        ),
                        CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                        CommonWaitUntil.isNotVisible(PRODUCT_TYPE)
//                        CommonTaskAdmin.changeValueTooltipDropdown(Admin_Product_Detail_Page.CATEGORIES_OF_PRODUCT, map.get("categories"))
                ),

                Check.whether(map.get("microDescription").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.MICRO_DESCRIPTION, map.get("microDescription"))
                )
        );
    }

    public static Task editPalletConfig(Map<String, String> map) {
        return Task.where("Edit info",
                Check.whether(map.get("casePerPallet").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.CASE_PER_PALLET, map.get("casePerPallet"))
                ),
                Check.whether(map.get("casePerLayer").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.CASE_PER_LAYER, map.get("casePerLayer"))
                ),
                Check.whether(map.get("layerPerPallet").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.LAYER_PER_PALLET, map.get("layerPerPallet"))
                )
        );
    }

    public static Task editMasterCaseConfig(Map<String, String> map) {
        return Task.where("Edit info",
                Check.whether(map.get("masterCartonPallet").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.MASTER_CARTON_PER_PALLET, map.get("masterCartonPallet"))
                ),
                Check.whether(map.get("casePerMasterCarton").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.CASE_PER_MASTER_CARTON, map.get("casePerMasterCarton"))
                ),
                Check.whether(map.get("masterCaseWeight").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.MASTER_CASE_WEIGHT, map.get("masterCaseWeight"))
                ),
                editInfoLWH(map, "master")
        );
    }

    public static Task editInfoLWH(Map<String, String> map, String field) {
        return Task.where("Edit info",
//                Check.whether(field.contains("unit")).andIfSo(
//                        Click.on(Admin_Product_Detail_Page.UNIT_LWH)
//                ).otherwise(
//                        Check.whether(field.contains("master")).andIfSo(
//                                Click.on(Admin_Product_Detail_Page.MASTER_CASE)
//                        ).otherwise(
//                                Click.on(Admin_Product_Detail_Page.CASE_LWH))
//                ),
                Check.whether(map.get(field + "Length").isEmpty()).otherwise(
                        Check.whether(field.contains("unit")).andIfSo(
                                Click.on(AdminProductDetailPage.UNIT_LWH)
                        ).otherwise(
                                Check.whether(field.contains("master")).andIfSo(
                                        Click.on(AdminProductDetailPage.MASTER_CASE)
                                ).otherwise(
                                        Click.on(AdminProductDetailPage.CASE_LWH))
                        ),
                        CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX(1)),
                        Enter.theValue(map.get(field + "Length").equals("blank") ? "" : map.get(field + "Length")).into(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX(1)),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                ),
                Check.whether(map.get(field + "Width").isEmpty()).otherwise(
                        Check.whether(field.contains("unit")).andIfSo(
                                Click.on(AdminProductDetailPage.UNIT_LWH)
                        ).otherwise(
                                Check.whether(field.contains("master")).andIfSo(
                                        Click.on(AdminProductDetailPage.MASTER_CASE)
                                ).otherwise(
                                        Click.on(AdminProductDetailPage.CASE_LWH))
                        ),
                        CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX(1)),
                        Enter.theValue(map.get(field + "Width").equals("blank") ? "" : map.get(field + "Width")).into(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX(2)),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                ),
                Check.whether(map.get(field + "Height").isEmpty()).otherwise(
                        Check.whether(field.contains("unit")).andIfSo(
                                Click.on(AdminProductDetailPage.UNIT_LWH)
                        ).otherwise(
                                Check.whether(field.contains("master")).andIfSo(
                                        Click.on(AdminProductDetailPage.MASTER_CASE)
                                ).otherwise(
                                        Click.on(AdminProductDetailPage.CASE_LWH))
                        ),
                        CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX(1)),
                        Enter.theValue(map.get(field + "Height").equals("blank") ? "" : map.get(field + "Height")).into(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX(3)),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                )
        );
    }

    public static void editStateFee(Map<String, String> map) {
        List<WebElementFacade> e = AdminProductDetailPage.STATE_FEE_COMBOBOX.resolveAllFor(theActorInTheSpotlight());
        List<String> fee = new ArrayList<>();
        for (WebElementFacade value : e) {
            fee.add(value.getValue());
        }
        if (fee.size() > 0) {
            int i = fee.lastIndexOf(map.get("oldStateFee"));
            theActorInTheSpotlight().attemptsTo(
//                    Enter.theValue(map.get("newStateFee")).into(Admin_Product_Detail_Page.STATE_FEE_COMBOBOX(i + 1)),
//                    CommonTask.ChooseValueFromSuggestions(map.get("newStateFee")),
                    CommonTask.chooseItemInDropdownWithValueInput(AdminProductDetailPage.STATE_FEE_COMBOBOX(i + 1), map.get("newStateFee"), D_DROPDOWN_VALUE(map.get("newStateFee"))),
                    Enter.theValue(map.get("value")).into(AdminProductDetailPage.STATE_FEE_VALUE(i + 1))
            );
            fee.remove(i);
        }
    }

    public static Task addStateFees(Map<String, String> map) {
        return Task.where("edit State Fees",
                Click.on(AdminProductDetailPage.ADD_STATE_FEE_BUTTON),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(AdminProductDetailPage.STATE_FEE_COMBOBOX_LAST),
                Check.whether(map.get("stateFee").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminProductDetailPage.STATE_FEE_COMBOBOX_LAST, map.get("stateFee"), AdminProductDetailPage.STATE_FEE_DROPDOWN(map.get("stateFee")))),
                        Enter.theValue(map.get("value")).into(AdminProductDetailPage.STATE_FEE_VALUE_LAST)
//                )

        );
    }

    public static Task editTags(Map<String, String> map) {
        return Task.where("edit Tags",
                Click.on(AdminProductDetailPage.CURRENT_TAGS),
                CommonWaitUntil.isVisible(AdminProductDetailPage.TAGS_COMBOBOX),
                Enter.theValue(CommonHandle.setDate2(map.get("expireDate"), "MM/dd/yy")).into(AdminProductDetailPage.TAGS_EXPIRYDATE(map.get("tag"))).thenHit(Keys.ENTER),
                Click.on(AdminProductDetailPage.ADD_STATE_FEE_UPDATE_BUTTON),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(AdminProductDetailPage.LOADING_ICON)
        );
    }

    public static Task inputMOQ(Map<String, String> map) {
        return Task.where("region MOQ",
                Enter.theValue(map.get("value")).into(AdminCreateAProductPage.DYNAMIC_INPUT_REGION_MOQ(map.get("region"))).thenHit(Keys.TAB)

        );
    }

    public static Task editMOQ(Map<String, String> map) {
        return Task.where("edit region MOQ",
                Scroll.to(AdminProductDetailPage.EDIT_REGION_MOQ(map.get("region"))),
                CommonTaskAdmin.changeValueTooltipTextbox(AdminProductDetailPage.EDIT_REGION_MOQ(map.get("region")), map.get("value"))
        );
    }

    public static Task confirmCreate() {
        return Task.where("confirmCreate",
                CommonWaitUntil.isVisible(CREATE_BUTTON),
                Click.on(CREATE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task goToCreate() {
        return Task.where("goToCreate",
                Check.whether(CommonQuestions.isControlDisplay(AdminAllProductsPage.CREATE_BUTTON)).andIfSo(
                        CommonWaitUntil.isVisible(AdminAllProductsPage.CREATE_BUTTON),
                        Click.on(AdminAllProductsPage.CREATE_BUTTON),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                        CommonWaitUntil.isVisible(BRAND_FIELD)
                )
        );
    }

    public static Task deleteProduct(String name) {
        return Task.where("delete product",
                CommonWaitUntil.isVisible(AdminAllProductsPage.DELETE_BUTTON(name)),
                Click.on(AdminAllProductsPage.DELETE_BUTTON(name)),
                CommonWaitUntil.isVisible(AdminAllProductsPage.I_UNDERSTAND_AND_CONTINUE_BUTTON),
                Click.on(AdminAllProductsPage.I_UNDERSTAND_AND_CONTINUE_BUTTON),
                CommonWaitUntil.isNotVisible(AllBrandsPage.LOADING_ICON)
        );
    }

    public static Task deleteProductInDetail() {
        return Task.where("Delete product in product detail",
                CommonWaitUntil.isVisible(AdminAllProductsPage.DELETE_BUTTON_IN_DETAIL),
                Click.on(AdminAllProductsPage.DELETE_BUTTON_IN_DETAIL),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this product. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(AllBrandsPage.LOADING_ICON)
        );
    }

}
