package cucumber.tasks.vendor;


import cucumber.models.web.Admin.Vendors.CreateNewSKUModel;
import cucumber.models.web.Admin.Vendors.RegionSpecificModel;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.regions.DistributionCenterForm;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.products.VendorCreateNewSKUPage;
import cucumber.user_interface.beta.Vendor.products.VendorCreateProductPage;
import cucumber.user_interface.beta.Vendor.products.VendorProductDetailPage;
import cucumber.user_interface.beta.Vendor.products.VendorProductForm;
import cucumber.user_interface.lp.CommonLPPage;
import net.serenitybdd.core.pages.ClearContents;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static cucumber.constants.vendor.WebsiteConstants.*;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class HandleVendorSKU {

    public static Task goToPage() {
        return Task.where("Go to Create sku page",
                WindowTask.threadSleep(3000),
                CommonWaitUntil.isVisible(VendorProductDetailPage.ADD_NEW_SKU_BUTTON),
                Click.on(VendorProductDetailPage.ADD_NEW_SKU_BUTTON).afterWaitingUntilEnabled(),
                Check.whether(CommonQuestions.isControlDisplay(VendorProductDetailPage.ADD_NEW_SKU_BUTTON)).andIfSo(
                        Click.on(VendorProductDetailPage.ADD_NEW_SKU_BUTTON)
                )
        );
    }

    public static Task create(CreateNewSKUModel create) {
        return Task.where("Create sku ",
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.DYNAMIC_INPUT("Name")),
                Check.whether(create.getSkuName().isEmpty()).otherwise(
                        Enter.theValue(create.getSkuName()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Name"))
                ),
                Check.whether(create.getMasterImage().isEmpty()).otherwise(
                        CommonFile.upload(create.getMasterImage(), VendorCreateNewSKUPage.SKU_IMAGE)
                ),
                Check.whether(create.getIngredient().isEmpty()).otherwise(
                        Enter.theValue(create.getIngredient()).into(VendorCreateNewSKUPage.DYNAMIC_FIELD_AREA("Ingredients"))
                ),
                Check.whether(create.getLeadTime().isEmpty()).otherwise(
                        Enter.theValue(create.getLeadTime()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Lead time"))
                ),
                Check.whether(create.getDescription().isEmpty()).otherwise(
                        Enter.theValue(create.getDescription()).into(VendorCreateNewSKUPage.DYNAMIC_FIELD_AREA("Description"))
                ),
                Check.whether(create.getUnitsCase().isEmpty()).otherwise(
                        Enter.theValue(create.getUnitsCase()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Units/case"))
                ),
                Check.whether(CommonQuestions.isControlDisplay(VendorCreateNewSKUPage.DYNAMIC_INPUT("Barcodes Type"))).andIfSo(
                        Check.whether(CommonQuestions.AskForAttributeContainText(VendorCreateNewSKUPage.DYNAMIC_INPUT("Barcodes Type"), "value", "EAN")).otherwise(
                                Check.whether(create.getUnitUpcImage().isEmpty()).otherwise(
                                        Scroll.to(VendorCreateNewSKUPage.UNITS_UPC_IMAGE),
                                        CommonFile.upload(create.getUnitUpcImage(), VendorCreateNewSKUPage.UNITS_UPC_IMAGE)
                                ),
                                Check.whether(create.getCaseUpcImage().isEmpty()).otherwise(
                                        Scroll.to(VendorCreateNewSKUPage.CASE_UPC_IMAGE),
                                        CommonFile.upload(create.getCaseUpcImage(), VendorCreateNewSKUPage.CASE_UPC_IMAGE)
                                ),
                                Check.whether(create.getIndividualUnitUPC().isEmpty()).otherwise(
                                        Enter.theValue(create.getIndividualUnitUPC()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Unit UPC"))
                                ),
                                Check.whether(create.getCaseUPC().isEmpty()).otherwise(
                                        Enter.theValue(create.getCaseUPC()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Case UPC"))
                                )
                        ).andIfSo(
                                Check.whether(create.getIndividualUnitUPC().isEmpty()).otherwise(
                                        Enter.theValue(create.getIndividualUnitUPC()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Unit EAN"))
                                ),
                                Check.whether(create.getUnitUpcImage().isEmpty()).otherwise(
                                        Scroll.to(VendorCreateNewSKUPage.UNITS_EAN_IMAGE),
                                        CommonFile.upload(create.getUnitUpcImage(), VendorCreateNewSKUPage.UNITS_EAN_IMAGE)
                                ),
                                Check.whether(create.getCaseUpcImage().isEmpty()).otherwise(
                                        Scroll.to(VendorCreateNewSKUPage.CASE_EAN_IMAGE),
                                        CommonFile.upload(create.getCaseUpcImage(), VendorCreateNewSKUPage.CASE_EAN_IMAGE)
                                ),
                                Check.whether(create.getCaseUPC().isEmpty()).otherwise(
                                        Enter.theValue(create.getCaseUPC()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Case EAN"))
                                )
                        )
                ),
                Check.whether(create.getCountry().isEmpty()).otherwise(
                        Scroll.to(VendorCreateNewSKUPage.COUNTRY),
                        Enter.theValue(create.getCountry()).into(VendorCreateNewSKUPage.COUNTRY_INPUT),
                        CommonTask.ChooseValueFromSuggestions(create.getCountry())
                ),
                Check.whether(create.getCity().isEmpty()).otherwise(
                        Scroll.to(VendorCreateNewSKUPage.DYNAMIC_INPUT("City")),
                        Enter.theValue(create.getCity()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("City"))
                ),
                Check.whether(create.getStateManufacture().isEmpty()).otherwise(
                        Click.on(VendorCreateNewSKUPage.STAGE_INPUT),
                        Enter.keyValues(create.getStateManufacture()).into(VendorCreateNewSKUPage.STAGE_INPUT),
                        CommonTask.ChooseValueFromSuggestions(create.getStateManufacture())
                ),
                Check.whether(create.getStorageShelfLife().isEmpty()).otherwise(
                        Enter.theValue(create.getStorageShelfLife()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Storage shelf life (days)"))
                ),
                Check.whether(create.getStorageCondition().isEmpty()).otherwise(
                        Scroll.to(VendorCreateNewSKUPage.STORAGE_CONDITION),
                        CommonTask.chooseItemInDropdown(VendorCreateNewSKUPage.STORAGE_CONDITION, VendorCreateNewSKUPage.CONDITION_VALUES(create.getStorageCondition()))
//                        Click.on(VendorCreateNewSKUPage.STORAGE_CONDITION),
//                        Click.on(String.format(VendorCreateNewSKUPage.CONDITION_VALUES, create.getStorageCondition()))
                ),
                Check.whether(create.getRetailShelfLife().isEmpty()).otherwise(
                        Enter.theValue(create.getRetailShelfLife()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Retail shelf life (days)"))
                ),
                Check.whether(create.getRetailCondition().isEmpty()).otherwise(
                        Scroll.to(VendorCreateNewSKUPage.RETAIL_CONDITION),
                        CommonTask.chooseItemInDropdown(VendorCreateNewSKUPage.RETAIL_CONDITION, VendorCreateNewSKUPage.CONDITION_VALUES(create.getRetailCondition()))
//                        Click.on(VendorCreateNewSKUPage.RETAIL_CONDITION),
//                        Click.on(String.format(VendorCreateNewSKUPage.CONDITION_VALUES, create.getRetailCondition()))
                ),
                Check.whether(create.getTempRequirementMin().isEmpty()).otherwise(
                        Enter.theValue(create.getTempRequirementMin()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Min temperature (F)"))
                ),
                Check.whether(create.getTempRequirementMax().isEmpty()).otherwise(
                        Enter.theValue(create.getTempRequirementMax()).into(VendorCreateNewSKUPage.DYNAMIC_INPUT("Max temperature (F)"))
                )
        );
    }

    public static Task addNutrition(String image, String des) {
        return Task.where("Add nutrition labels",
                Scroll.to(VendorCreateNewSKUPage.ADD_NUTRITION),
                Click.on(VendorCreateNewSKUPage.ADD_NUTRITION),
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.NUTRITION_DES),
                Check.whether(image.isEmpty()).otherwise(
                        CommonFile.upload(image, VendorCreateNewSKUPage.NUTRITION_IMAGE),
                        Enter.keyValues(des).into(VendorCreateNewSKUPage.NUTRITION_DES).thenHit(Keys.TAB)
                )

        );
    }

    public static Task uploadMasterCartonUPCImage(String image, String upc) {
        return Task.where("Add uploadMasterCartonUPCImage",
                Check.whether(image.isEmpty()).otherwise(
                        CommonFile.upload(image, VendorCreateNewSKUPage.MASTER_CARTON_UPC_IMAGE)
                ),
                Check.whether(upc.isEmpty()).otherwise(
                        Enter.theValue(upc).into(VendorCreateNewSKUPage.DYNAMIC_INPUT2("Master Carton UPC"))
                )
        );
    }

    public static Task uploadMasterCartonEANImage(String image, String EAN) {
        return Task.where("Add uploadMasterCartonEANImage",
                Check.whether(image.isEmpty()).otherwise(
                        CommonFile.upload(image, VendorCreateNewSKUPage.MASTER_CARTON_EAN_IMAGE)
                ),
                Check.whether(EAN.isEmpty()).otherwise(
                        Enter.theValue(EAN).into(VendorCreateNewSKUPage.DYNAMIC_INPUT2("Master Carton EAN"))
                )
        );
    }

    public static Task deleteNutrition(int i) {
        return Task.where("Delete nutrition labels",
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.DELETE_NUTRITION(i)),
                Scroll.to(VendorCreateNewSKUPage.DELETE_NUTRITION(i)),
                Click.on(VendorCreateNewSKUPage.DELETE_NUTRITION(i))
        );
    }

    public static Task setMain(String main) {
        return Task.where("set Main SKU",
                Check.whether(main.equals("is")).andIfSo(
                        Check.whether(CommonQuestions.AskForAttributeContainText(VendorCreateNewSKUPage.MAIN_SKU, "class", "checked")).otherwise(
                                Click.on(VendorCreateNewSKUPage.MAIN_SKU)
                        )
                ).otherwise(
                        Check.whether(CommonQuestions.AskForAttributeContainText(VendorCreateNewSKUPage.MAIN_SKU, "class", "checked")).andIfSo(
                                Click.on(VendorCreateNewSKUPage.MAIN_SKU)
                        )
                )
        );
    }


    public static Task checkQualities(String quality) {
        return Task.where("Check Qualities then Next",
                Click.on(VendorCreateNewSKUPage.QUALITIES_CHECKBOX(quality))
//                Click.on(VendorCreateNewSKUPage.NEXT_BUTTON2)
        );
    }

    public static Task confirmPublishSKU(String action) {
        return Task.where("confirmPublishSKU",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                Ensure.that(CommonVendorPage.DYNAMIC_P_ALERT(CONFIRM_PUBLISH_SKU)).isDisplayed(),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action))
        );
    }


    public static Task actionSKU(String action) {
        return Task.where("click " + action,
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON(action)),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON(action))
        );
    }

    public static Task goToPriceAvailability(String sku) {
        return Task.where("go To Price Availability",
                CommonWaitUntil.isVisible(VendorProductDetailPage.BUTTON_ON_SKU(sku, 1)),
                Click.on(VendorProductDetailPage.BUTTON_ON_SKU(sku, 1)),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Edit"))
        );
    }

    public static Task gotoInventory(String sku) {
        return Task.where("go to Inventory",
                CommonWaitUntil.isVisible(VendorProductDetailPage.BUTTON_ON_SKU(sku, 5)),
                Click.on(VendorProductDetailPage.BUTTON_ON_SKU(sku, 5)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your inventories."))
        );
    }

    public static Task duplicateSKU(String action, String sku) {
        return Task.where("duplicate SKU",
                CommonWaitUntil.isVisible(VendorProductDetailPage.BUTTON_ON_SKU(sku, 3)),
                Click.on(VendorProductDetailPage.BUTTON_ON_SKU(sku, 3)),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_MESSAGE).text().containsIgnoringCase(DUPLICATE_SKU),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action))
        );
    }

    public static Task deleteSKU(String action, String sku) {
        return Task.where("delete SKU " + sku,
                CommonWaitUntil.isVisible(VendorProductDetailPage.BUTTON_ON_SKU(sku, 4)),
                Click.on(VendorProductDetailPage.BUTTON_ON_SKU(sku, 4)),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                Ensure.that(CommonVendorPage.DYNAMIC_P_ALERT(DELETE_SKU)).isDisplayed(),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action))
        );
    }

    public static Task addRegion(String region) {
        return Task.where("ADD REGION  ",
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.REGION_OPTION(region)),
                Scroll.to(VendorCreateNewSKUPage.REGION_OPTION(region)),
                Click.on(VendorCreateNewSKUPage.REGION_OPTION(region))
        );
    }

    public static Task chooseOption(String text) {
        return Task.where("ADD REGION  ",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(text)),
                Click.on(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(text)),
                WindowTask.threadSleep(500)
        );
    }

    public static Task removeRegion(String region) {
        return Task.where("ADD REGION  ",
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.REMOVE_REGION(region)),
                Click.on(VendorCreateNewSKUPage.REMOVE_REGION(region)),
                CommonWaitUntil.isNotVisible(VendorCreateNewSKUPage.REMOVE_REGION(region))
        );
    }

    public static Task inputRegionInfo(RegionSpecificModel region) {
        return Task.where("Input region-specific info  ",
                Check.whether(region.getCasePrice().isEmpty()).otherwise(
                        Scroll.to(VendorCreateNewSKUPage.WHOLESALE_PRICE(region.getRegionName())),
                        Enter.theValue(region.getCasePrice()).into(VendorCreateNewSKUPage.WHOLESALE_PRICE(region.getRegionName()))
                ),
                Check.whether(region.getMSRPunit().isEmpty()).otherwise(
                        Scroll.to(VendorCreateNewSKUPage.MSRP_UNIT(region.getRegionName())),
                        Enter.theValue(region.getMSRPunit()).into(VendorCreateNewSKUPage.MSRP_UNIT(region.getRegionName()))
                ),
                Click.on(VendorCreateNewSKUPage.AVAILABILITY(region.getRegionName(), region.getAvailability())),
                Check.whether(region.getAvailability().equalsIgnoreCase("Launching soon") && !region.getExpectedDate().isEmpty()).andIfSo(
                        Enter.theValue(CommonHandle.setDate2(region.getExpectedDate(), "MM/dd/yy")).into(VendorCreateNewSKUPage.EXPECTED_INVENTORY_DATE(region.getRegionName())).thenHit(Keys.TAB)
                )
        );
    }

    public static Task goToTab(String tab) {
        return Task.where("Go to tab " + tab,
                WindowTask.threadSleep(500),
                Check.whether(Ensure.that(VendorCreateNewSKUPage.REGION_OPTION("Chicagoland Express")).isDisplayed().equals(tab)).otherwise(
                        CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Manage SKU price >")),
                        Click.on(CommonVendorPage.DYNAMIC_BUTTON("Manage SKU price >"))
                )
        );
    }

    public static Task activeSKU(String active, String region) {
        return Task.where("SKU" + region,
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.STATUS_REGION_SKU2(region)),
                Check.whether(active.equalsIgnoreCase("active")).andIfSo(
                        Check.whether(CommonQuestions.AskForAttributeContainText(VendorCreateNewSKUPage.STATUS_REGION_SKU(region), "class", "checked")).otherwise(
                                JavaScriptClick.on(VendorCreateNewSKUPage.STATUS_REGION_SKU2(region))
                        )
                ).otherwise(
                        Check.whether(CommonQuestions.AskForAttributeContainText(VendorCreateNewSKUPage.STATUS_REGION_SKU(region), "class", "checked")).andIfSo(
                                JavaScriptClick.on(VendorCreateNewSKUPage.STATUS_REGION_SKU2(region))
                        )
                )
        );
    }

    public static Task editField(Map<String, String> map) {
        return Task.where("Edit ",
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.DYNAMIC_FIELD(map.get("field"))),
                Scroll.to(VendorCreateNewSKUPage.DYNAMIC_FIELD(map.get("field"))),
                CommonTask.clearFieldByEnterKey(VendorCreateNewSKUPage.DYNAMIC_FIELD(map.get("field"))),
//                Enter.keyValues("a").into(VendorCreateNewSKUPage.DYNAMIC_FIELD(map.get("field"))).thenHit(Keys.BACK_SPACE).thenHit(Keys.TAB),
//                Enter.theValue(new  CharSequence[]{Keys.chord(new CharSequence[]{Keys.CONTROL, "a"}), Keys.DELETE}).into(VendorCreateNewSKUPage.DYNAMIC_FIELD(map.get("field"))),
                Check.whether(map.get("value").isEmpty()).otherwise(
                        Enter.theValue(map.get("value")).into(VendorCreateNewSKUPage.DYNAMIC_FIELD(map.get("field"))).thenHit(Keys.TAB)
                )
        );
    }

    public static Performable goToProductDetail(String product) {
        return Task.where("go to product detail",
                actor -> {
                    Boolean check = true;
                    int page = 1;
                    while (check) {
                        List<WebElementFacade> listDC = VendorProductForm.PRODUCT_NAME(product).resolveAllFor(actor);
                        if (listDC.size() > 0) {
                            actor.attemptsTo(
                                    CommonWaitUntil.isVisible(VendorProductForm.PRODUCT_NAME(product)),
                                    Click.on(VendorProductForm.PRODUCT_NAME(product)),
                                    CommonWaitUntil.isVisible(VendorCreateProductPage.PRODUCT_TITLE)
                            );
                            check = false;
                            break;
                        }
                        // nếu không có product thì next page
                        page = page + 1;

                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorProductForm.PAGE_NAVIGATOR(page)),
                                Click.on(VendorProductForm.PAGE_NAVIGATOR(page)),
                                CommonWaitUntil.isVisible(VendorProductForm.DELETE_BUTTON)
                        );
                    }
                }
        );
    }
}
