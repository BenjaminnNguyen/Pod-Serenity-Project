package cucumber.tasks.admin.products;

import cucumber.models.web.Admin.Products.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.products.*;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;

import java.util.Map;

import static cucumber.user_interface.admin.products.AdminCreateAProductPage.D_DROPDOWN_VALUE;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static org.hamcrest.CoreMatchers.not;

public class HandleProductDetail {

    /*
     * Check product detail
     * */
    public static Task checkProductDetail(AdminCreateNewProduct productDetail) {
        return Task.where("Check product detail",
                Ensure.that(AdminProductDetailPage.PRODUCT_NAME).text().isEqualTo(productDetail.getProductName()),
                Ensure.that(AdminProductDetailPage.STATE_STATUS).text().isEqualTo(productDetail.getStatus()),
                Ensure.that(AdminProductDetailPage.PRODUCT_NAME).text().isEqualTo(productDetail.getProductName()),
                Ensure.that(AdminProductDetailPage.BRAND_NAME).text().isEqualTo(productDetail.getBrandName()),
                Ensure.that(AdminProductDetailPage.VENDOR_COMPANY).text().isEqualTo(productDetail.getVendorCompany()),
                Ensure.that(AdminProductDetailPage.SAMPLEABLE).text().isEqualTo(productDetail.getAllowRequestSamples()),
                Ensure.that(AdminProductDetailPage.PACKAGE_SIZE).text().isEqualTo(productDetail.getPackageSize()),
                Ensure.that(AdminProductDetailPage.UNIT_LWH).text().isEqualTo(productDetail.getUnitLength() + "\"×" + productDetail.getUnitWidth() + "\"×" + productDetail.getUnitHeight() + "\""),
                Ensure.that(AdminProductDetailPage.CASE_LWH).text().isEqualTo(productDetail.getCaseLength() + "\"×" + productDetail.getCaseWidth() + "\"×" + productDetail.getCaseHeight() + "\""),
                Ensure.that(AdminProductDetailPage.CASE_WEIGHT).text().contains(productDetail.getCaseWeight()),
                Ensure.that(AdminProductDetailPage.ADDITIONAL_FEE).text().contains(productDetail.getAdditionalFee()),
                Ensure.that(AdminProductDetailPage.CATEGORIES_OF_PRODUCT).text().contains(productDetail.getCategory()),
                Ensure.that(AdminProductDetailPage.TYPE_OF_PRODUCT).text().contains(productDetail.getType()),
                Ensure.that(AdminProductDetailPage.CASE_PER_PALLET).text().isEqualTo(productDetail.getCasesPerPallet()),
                Ensure.that(AdminProductDetailPage.CASE_PER_LAYER).text().isEqualTo(productDetail.getCasesPerLayer()),
                Ensure.that(AdminProductDetailPage.LAYER_PER_PALLET).text().isEqualTo(productDetail.getLayersPerFullPallet()),
                Ensure.that(AdminProductDetailPage.MASTER_CARTON_PER_PALLET).text().isEqualTo(productDetail.getMasterCartonsPerPallet()),
                Ensure.that(AdminProductDetailPage.CASE_PER_MASTER_CARTON).text().isEqualTo(productDetail.getCasesPerMasterCarton()),
                Ensure.that(AdminProductDetailPage.MASTER_CASE_WEIGHT).text().contains(productDetail.getMasterCaseWeight())
        );
    }

    /*
     * Check k co SKU nao
     * */
    public static Task checkNoHaveSku() {
        return Task.where("Check product not have sku",
                Ensure.that(AdminProductDetailPage.ACTIVE_SKU_NAME).isNotDisplayed()

        );
    }

    public static Task changeState(String state) {
        return Task.where("Changes state product to " + state,
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON(state + " this product")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON(state + " this product")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                Check.whether(state.equalsIgnoreCase("Deactivate")).andIfSo(
                        Ensure.that(CommonAdminForm.DYNAMIC_DIALOG("This will deactivate current product. Continue?")).isDisplayed(),
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                        WindowTask.threadSleep(1000),
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Activate this product"))
                ).otherwise(
                        Ensure.that(CommonAdminForm.DYNAMIC_DIALOG("This will activate current product. Activating this product will automatically activate its brand and vendor company. Are you sure you want to continue?")).isDisplayed(),
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                        WindowTask.threadSleep(1000),
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this product"))
                )


        );
    }

    /*
     * Nhap thong tin cua SKU
     *
     * */
    public static Task createNewSku(AdminCreateNewSKUModel adminCreateNewSKUModel) {
        return Task.where("Create new sku",
                Check.whether(CommonQuestions.isControlUnDisplay(AdminProductDetailPage.ADD_NEW_SKU_BUTTON)).otherwise(
                        CommonWaitUntil.isVisible(AdminProductDetailPage.ADD_NEW_SKU_BUTTON),
                        Click.on(AdminProductDetailPage.ADD_NEW_SKU_BUTTON)
                ),
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.SKU_NAME_FIELD),
                Check.whether(adminCreateNewSKUModel.getSkuName().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getSkuName()).into(AdminCreateNewSKUPage.SKU_NAME_FIELD)
                ),
                Check.whether(adminCreateNewSKUModel.getState().isEmpty()).otherwise(
                        Click.on(AdminCreateNewSKUPage.popup_STATE_FIELD),
                        CommonTask.ChooseValueFromSuggestions(adminCreateNewSKUModel.getState())
                ),
                Check.whether(adminCreateNewSKUModel.getMainSKU().equalsIgnoreCase("Yes")).andIfSo(
                        Click.on(AdminCreateNewSKUPage.MAIN_SKU)
                ),
                Check.whether(adminCreateNewSKUModel.getUnitsCase().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getUnitsCase()).into(AdminCreateNewSKUPage.UNITS_CASE)
                ),
                Check.whether(adminCreateNewSKUModel.getMasterImage().isEmpty()).otherwise(
                        CommonFile.upload(adminCreateNewSKUModel.getMasterImage(), AdminCreateNewSKUPage.MASTER_IMAGE)
                ),
                Check.whether(adminCreateNewSKUModel.getIndividualUnitEANType().isEmpty()).otherwise(
                        Check.whether(adminCreateNewSKUModel.getIndividualUnitEANType().equalsIgnoreCase("yes")).andIfSo(
                                Click.on(AdminCreateNewSKUPage.INDIVIDUAL_UNIT_EAN_DROP),
                                CommonTask.ChooseValueFromSuggestions("EAN")
                        ).otherwise(
                                Click.on(AdminCreateNewSKUPage.INDIVIDUAL_UNIT_EAN_DROP),
                                CommonTask.ChooseValueFromSuggestions("UPC")
                        )
                ),
                Check.whether(adminCreateNewSKUModel.getIndividualUnitUPC().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getIndividualUnitUPC()).into(AdminCreateNewSKUPage.INDIVIDUAL_UNIT_UPC)
                ),
                Check.whether(adminCreateNewSKUModel.getCaseUPC().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getCaseUPC()).into(AdminCreateNewSKUPage.CASE_UPC)
                ),
                Check.whether(adminCreateNewSKUModel.getUnitUpcImage().isEmpty()).otherwise(
                        CommonFile.upload(adminCreateNewSKUModel.getUnitUpcImage(), AdminCreateNewSKUPage.UPC_IMAGE)
                ),
                Check.whether(adminCreateNewSKUModel.getCaseUpcImage().isEmpty()).otherwise(
                        CommonFile.upload(adminCreateNewSKUModel.getCaseUpcImage(), AdminCreateNewSKUPage.CASE_IMAGE)
                ),
                Check.whether(adminCreateNewSKUModel.getStorageShelfLife().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getStorageShelfLife()).into(AdminCreateNewSKUPage.STORAGE_FIELD)
                ),
                Check.whether(adminCreateNewSKUModel.getStorageCondition().isEmpty()).otherwise(
                        Click.on(AdminCreateNewSKUPage.STORAGE_CONDITION),
                        CommonTask.ChooseValueFromSuggestions(adminCreateNewSKUModel.getStorageCondition())
                ),
                Check.whether(adminCreateNewSKUModel.getRetailShelfLife().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getRetailShelfLife()).into(AdminCreateNewSKUPage.RETAIL_FIELD)
                ),
                Check.whether(adminCreateNewSKUModel.getRetailCondition().isEmpty()).otherwise(
                        Click.on(AdminCreateNewSKUPage.RETAIL_CONDITION),
                        CommonTask.ChooseValueFromSuggestions(adminCreateNewSKUModel.getRetailCondition())
                ),
                Check.whether(adminCreateNewSKUModel.getTempRequirementMin().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getTempRequirementMin()).into(AdminCreateNewSKUPage.MIN_TEMPERATURE_FIELD)
                ),
                Check.whether(adminCreateNewSKUModel.getTempRequirementMax().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getTempRequirementMax()).into(AdminCreateNewSKUPage.MAX_TEMPERATURE_FIELD)
                ),
                Check.whether(adminCreateNewSKUModel.getCity().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getCity()).into(AdminCreateNewSKUPage.CITY_FIELD)
                ),
                Check.whether(adminCreateNewSKUModel.getStateManufacture().isEmpty()).otherwise(
                        Click.on(AdminCreateNewSKUPage.STATE_ADDRESS_FIELD),
                        Enter.theValue(adminCreateNewSKUModel.getStateManufacture()).into(AdminCreateNewSKUPage.STATE_ADDRESS_FIELD),
                        CommonTask.ChooseValueFromSuggestions(adminCreateNewSKUModel.getStateManufacture())
                ),
//                Check.whether(adminCreateNewSKUModel.getStateManufacture().isEmpty()).otherwise(
//                        Enter.theValue(adminCreateNewSKUModel.getStateManufacture()).into(Admin_Create_New_SKU_Page.STATE_ADDRESS_FIELD),
//                        Click.on(Target.the("Stage of Manufacture").located(By.xpath(String.format(Admin_Create_New_SKU_Page.STAGE_OPTION, adminCreateNewSKUModel.getStateManufacture()))))
//                ),
                Check.whether(adminCreateNewSKUModel.getLeadTime().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getLeadTime()).into(AdminCreateNewSKUPage.LEAD_TIME_FIELD)
                ),
                Check.whether(adminCreateNewSKUModel.getIngredient().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getIngredient()).into(AdminCreateNewSKUPage.INGREDIENTS_FIELD)
                ),
                Check.whether(adminCreateNewSKUModel.getDescription().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getDescription()).into(AdminProductDetailPage.DESCRIPTION_FIELD)
                ),

//                Click.on(Admin_Product_Detail_Page.ADD_NUTRITION_BUTTON),
//                UploadFile.upload(adminCreateNewSKUModel.getNutritionLabel().getNutritionLabel(), Admin_Create_New_SKU_Page.NUTRITION_IMAGE),
//                Enter.theValue(adminCreateNewSKUModel.getNutritionLabel().getNutritionLabelDescription()).into(Admin_Create_New_SKU_Page.NUTRITION_IMAGE_DES(1)),
                Check.whether(adminCreateNewSKUModel.getExpireDayThreshold().isEmpty()).otherwise(
                        Enter.theValue(adminCreateNewSKUModel.getExpireDayThreshold()).into(AdminCreateNewSKUPage.EXPIRY_DAY_THRESHOLD)),
                Ensure.that(AdminCreateNewSKUPage.LOW_QUANTITY_THRESHOLD).isDisabled()
        );
    }

    /*
     * Add Nutrition labels
     *
     * */
    public static Task nutritionLabels(NutritionLabel nutritionLabel, int num) {
        return Task.where("Nutrition labels",
                Click.on(AdminProductDetailPage.ADD_NUTRITION_BUTTON),
                CommonFile.upload(nutritionLabel.getNutritionLabel(), AdminCreateNewSKUPage.NUTRITION_IMAGE(num)),
                Enter.theValue(nutritionLabel.getNutritionLabelDescription()).into(AdminCreateNewSKUPage.NUTRITION_IMAGE_DES(num))
        );

    }

    public static Task masterCartonUPC(Map<String, String> map) {
        return Task.where("Master Carton UPC",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.MASTER_CARTON_UPC),
                Check.whether(map.get("masterCarton").isEmpty()).otherwise(
                        Enter.theValue(map.get("masterCarton")).into(AdminCreateNewSKUPage.MASTER_CARTON_UPC)
                ),
                Check.whether(map.get("masterCartonImage").isEmpty()).otherwise(
                        CommonFile.upload(map.get("masterCartonImage"), AdminCreateNewSKUPage.MASTER_CARTON_UPC_IMAGE)
                )
        );

    }

    public static Task tags(Tags tags) {
        return Task.where("Nutrition labels",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.SELECT_TAG),
//                Enter.theValue(tags.getTagName()).into(Admin_Create_New_SKU_Page.SELECT_TAG),
//                CommonTask.ChooseValueFromSuggestions(tags.getTagName()),
                CommonTask.chooseItemInDropdownWithValueInput(AdminCreateNewSKUPage.SELECT_TAG, tags.getTagName(), D_DROPDOWN_VALUE(tags.getTagName())),
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.TAGS_EXPIRY_DATE(tags.getTagName())),
                Enter.theValue(CommonHandle.setDate2(tags.getExpiryDate(), "MM/dd/yy")).into(AdminCreateNewSKUPage.TAGS_EXPIRY_DATE(tags.getTagName())).thenHit(Keys.TAB)
        );

    }

    /*
     * Chon qualities
     *
     * */
    public static Task chooseQualities(String qualities) {
        return Task.where("Choose qualities",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.QUALITIES_VALUES(qualities)),
                Scroll.to(AdminCreateNewSKUPage.QUALITIES_VALUES(qualities)),
                Click.on(AdminCreateNewSKUPage.QUALITIES_VALUES(qualities)));

    }

    public static Task addRegionNotInfo(String region) {
        return Task.where("",
//                CommonTask.chooseItemInDropdown(Admin_Create_New_SKU_Page.ADD_A_REGION, Admin_Create_New_SKU_Page.REGION_OPTION(region)),
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.ADD_A_REGION),
//                Scroll.to(Admin_Create_New_SKU_Page.ADD_A_REGION),
                Click.on(AdminCreateNewSKUPage.ADD_A_REGION),
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.REGION_OPTION(region)),
                Click.on(AdminCreateNewSKUPage.REGION_OPTION(region)),
                WindowTask.threadSleep(1000)
        );
    }

    /*
     * Add region specific
     *
     * */
    public static Task addRegionsSpecific(RegionSpecificModel regionSpecificModel) {
        return Task.where("Add region specific",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.REGION_SPECIFIC_TAB),
                Click.on(AdminCreateNewSKUPage.REGION_SPECIFIC_TAB),
                Check.whether(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.CASE_PRICE_FIELD(regionSpecificModel.getRegionName())))
                        .otherwise(
                                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.ADD_A_REGION),
                                CommonTask.chooseItemInDropdown(AdminCreateNewSKUPage.ADD_A_REGION, AdminCreateNewSKUPage.REGION_OPTION(regionSpecificModel.getRegionName())),
                                Check.whether(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.PROP_65)).andIfSo(
                                        Click.on(AdminCreateNewSKUPage.Submit_PROP_65),
                                        CommonWaitUntil.isNotVisible(AdminCreateNewSKUPage.Submit_PROP_65)
                                )
                        ),
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.CASE_PRICE_FIELD(regionSpecificModel.getRegionName())),
                Check.whether(regionSpecificModel.getCasePrice().isEmpty()).otherwise(
                        Enter.theValue(regionSpecificModel.getCasePrice()).into(AdminCreateNewSKUPage.CASE_PRICE_FIELD(regionSpecificModel.getRegionName()))
                ),
                Check.whether(regionSpecificModel.getMsrpunit().isEmpty()).otherwise(
                        Enter.theValue(regionSpecificModel.getMsrpunit()).into(AdminCreateNewSKUPage.MSRP_FIELD(regionSpecificModel.getRegionName()))
                ),
                Check.whether(regionSpecificModel.getAvailability().isEmpty()).otherwise(
                        Click.on(AdminCreateNewSKUPage.AVAILABILITY_FIELD(regionSpecificModel.getRegionName())),
                        CommonTask.ChooseValueFromSuggestions(regionSpecificModel.getAvailability()),
                        Check.whether(regionSpecificModel.getAvailability().equalsIgnoreCase("Launching soon")).andIfSo(
                                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.ARRIVING_AT(regionSpecificModel.getRegionName())),
                                Enter.theValue(CommonHandle.setDate2(regionSpecificModel.getArriving(), "MM/dd/yy")).into(AdminCreateNewSKUPage.ARRIVING_AT(regionSpecificModel.getRegionName())).thenHit(Keys.TAB)
                        ),
                        Check.whether(regionSpecificModel.getAvailability().equalsIgnoreCase("Out of stock")).andIfSo(
                                Check.whether(regionSpecificModel.getArriving().isEmpty()).otherwise(
                                        CommonTask.chooseItemInDropdown(AdminCreateNewSKUPage.CATEGORY(regionSpecificModel.getRegionName()), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(regionSpecificModel.getArriving()))
                                )
                        ))
        );
    }

    public static Task addRegionsSpecificMassEdit(Map<String, String> map) {
        return Task.where("Add region specific",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.REGION_SPECIFIC_TAB),
                Click.on(AdminCreateNewSKUPage.REGION_SPECIFIC_TAB),
                Check.whether(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.CASE_PRICE_FIELD(map.get("regionName"))))
                        .otherwise(
                                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.ADD_A_REGION),
                                CommonTask.chooseItemInDropdown(AdminCreateNewSKUPage.ADD_A_REGION, AdminCreateNewSKUPage.REGION_OPTION(map.get("regionName"))),
                                Check.whether(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.PROP_65)).andIfSo(
                                        Click.on(AdminCreateNewSKUPage.Submit_PROP_65),
                                        CommonWaitUntil.isNotVisible(AdminCreateNewSKUPage.Submit_PROP_65)
                                )
                        ),
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.CASE_PRICE_FIELD(map.get("regionName"))),
                Check.whether(map.get("casePrice").isEmpty()).otherwise(
                        Enter.theValue(map.get("casePrice")).into(AdminCreateNewSKUPage.CASE_PRICE_FIELD(map.get("regionName")))
                ),
                Check.whether(map.get("msrpunit").isEmpty()).otherwise(
                        Enter.theValue(map.get("msrpunit")).into(AdminCreateNewSKUPage.MSRP_FIELD(map.get("regionName")))
                ),
                Check.whether(map.get("availability").isEmpty()).otherwise(
                        Click.on(AdminCreateNewSKUPage.AVAILABILITY_FIELD(map.get("regionName"))),
                        CommonTask.ChooseValueFromSuggestions(map.get("availability")),
                        Check.whether(map.get("availability").equalsIgnoreCase("Launching soon")).andIfSo(
                                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.ARRIVING_AT(map.get("regionName"))),
                                Enter.theValue(CommonHandle.setDate2(map.get("arriving"), "MM/dd/yy")).into(AdminCreateNewSKUPage.ARRIVING_AT(map.get("regionName"))).thenHit(Keys.TAB)
                        ),
                        Check.whether(map.get("availability").equalsIgnoreCase("Out of stock")).andIfSo(
                                Check.whether(map.get("arriving").isEmpty()).otherwise(
                                        CommonTask.chooseItemInDropdown(AdminCreateNewSKUPage.CATEGORY(map.get("regionName")), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("arriving")))
                                )

                        )),
                Check.whether(map.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy")).into(AdminCreateNewSKUPage.START_DATE_REGION_MASS_EDIT2(map.get("regionName"))).thenHit(Keys.ENTER)
                ), Check.whether(map.get("endDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")).into(AdminCreateNewSKUPage.END_DATE_REGION_MASS_EDIT2(map.get("regionName"))).thenHit(Keys.ENTER)
                )
        );
    }

    public static Task addDateForRegion(Map<String, String> map) {
        return Task.where("",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.START_DATE(map.get("region"))),
                Check.whether(map.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy")).into(AdminCreateNewSKUPage.START_DATE(map.get("region"))).thenHit(Keys.ENTER)
                ), Check.whether(map.get("endDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")).into(AdminCreateNewSKUPage.END_DATE(map.get("region"))).thenHit(Keys.ENTER)
                )
        );
    }

    public static Task addDateForRegionMassEdit(Map<String, String> map) {
        return Task.where("",
                Check.whether(map.get("startDate").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(AdminCreateNewSKUPage.START_DATE_REGION_MASS_EDIT(map.get("region"))),
                        Enter.theValue(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy")).into(AdminCreateNewSKUPage.START_DATE_REGION_MASS_EDIT(map.get("region"))).thenHit(Keys.ENTER),
                        WindowTask.threadSleep(1000)
                ),
                Check.whether(map.get("endDate").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(AdminCreateNewSKUPage.END_DATE_REGION_MASS_EDIT(map.get("region"))),
                        Enter.theValue(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")).into(AdminCreateNewSKUPage.END_DATE_REGION_MASS_EDIT(map.get("region"))).thenHit(Keys.TAB),
                        WindowTask.threadSleep(1000)
                )
        );
    }

    public static Task addBuyerCompanySpecific(Map<String, String> map) {
        return Task.where("Add buyer company specific",
                CommonWaitUntil.isVisible(BuyerCompanySpecificTap.CASE_PRICE_FIELD),
                Check.whether(map.get("casePrice").isEmpty()).otherwise(
                        Enter.theValue(map.get("casePrice")).into(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "case-price"))
                ),
                Check.whether(map.get("msrpUnit").isEmpty()).otherwise(
                        Enter.theValue(map.get("msrpUnit")).into(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "msrp"))
                ),
                Check.whether(map.get("availability").isEmpty()).otherwise(
                        Click.on(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "availability")),
                        CommonTask.ChooseValueFromSuggestions(map.get("availability"))
                ),
                Check.whether(map.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy")).into(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "start-date")).thenHit(Keys.ENTER)
                ),
                Check.whether(map.get("endDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")).into(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "end-date")).thenHit(Keys.ENTER)
                ),
                Check.whether(map.containsKey("inventoryArrivingAt")).andIfSo(
                        Check.whether(map.get("inventoryArrivingAt").isEmpty()).otherwise(
                                Enter.theValue(CommonHandle.setDate2(map.get("inventoryArrivingAt"), "MM/dd/yy")).into(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "inventory")).thenHit(Keys.ENTER)
                        )
                ),
                Check.whether(map.containsKey("category")).andIfSo(
                        Check.whether(map.get("category").isEmpty()).otherwise(
                                CommonTask.chooseItemInDropdown(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "out-of-stock"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("category")))
//                                Click.on(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "out-of-stock")),
//                                CommonTask.ChooseValueFromSuggestions(map.get("category"))
                        )
                )
        );
    }

    public static Task searchAddStoreSpecific(Map<String, String> map) {
        return Task.where("Add buyer company specific",
                CommonTask.chooseItemInDropdownWithValueInput(StoreSpecificTab.ADD_REGION_COMBO, map.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(map.get("region"))),
                Click.on(StoreSpecificTab.SEARCH_STORE),
                Enter.theValue(map.get("store")).into(StoreSpecificTab.SEARCH_STORE),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("store"))),
                Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("store"))),
//                CommonTask.chooseItemInDropdownWithValueInput(StoreSpecificTab.SEARCH_STORE, map.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("store"))),
                Click.on(StoreSpecificTab.ADD_BUTTON)
        );
    }

    public static Task addStoreSpecific(Map<String, String> map) {
        return Task.where("Add buyer company specific",
                Check.whether(CommonQuestions.isControlDisplay(StoreSpecificTab.STORE_NAME(map.get("store")))).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(StoreSpecificTab.ADD_REGION_COMBO, map.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(map.get("region"))),
                        CommonTask.chooseItemInDropdownWithValueInput2(StoreSpecificTab.SEARCH_STORE, map.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("store"))),
                        Click.on(StoreSpecificTab.ADD_BUTTON)
                ),
                Check.whether(map.get("casePrice").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(StoreSpecificTab.DYNAMIC_FIELD_INPUT(map.get("store"), "case-price")),
                        Enter.theValue(map.get("casePrice")).into(StoreSpecificTab.DYNAMIC_FIELD_INPUT(map.get("store"), "case-price"))
                ),
                Check.whether(map.get("msrp").isEmpty()).otherwise(
                        Enter.theValue(map.get("msrp")).into(StoreSpecificTab.DYNAMIC_FIELD_INPUT(map.get("store"), "msrp"))
                ),
                Check.whether(map.get("availability").isEmpty()).otherwise(
                        Click.on(StoreSpecificTab.DYNAMIC_FIELD_INPUT(map.get("store"), "availability")),
                        CommonTask.ChooseValueFromSuggestions(map.get("availability"))
                ),
                Check.whether(map.get("arriving").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("arriving"), "MM/dd/yy")).into(StoreSpecificTab.DYNAMIC_FIELD_INPUT(map.get("store"), "receiving")).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("start").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("start"), "MM/dd/yy")).into(StoreSpecificTab.DYNAMIC_FIELD_INPUT(map.get("store"), "start")).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("end").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("end"), "MM/dd/yy")).into(StoreSpecificTab.DYNAMIC_FIELD_INPUT(map.get("store"), "end-date")).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("category").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(StoreSpecificTab.DYNAMIC_FIELD_INPUT(map.get("store"), "out-of-stock-reason"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("category")))
                ),
                WindowTask.threadSleep(500)
        );
    }

    public static Task addMultipleStoreSpecific(Map<String, String> map) {
        return Task.where("Add buyer company specific",
//                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add multiple stores of a buyer company")),
//                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add multiple stores of a buyer company")),
                CommonWaitUntil.isVisible(BuyerCompanySpecificTap.MULYIPLE_BUYER_COMPANY_FIELD),
                Check.whether(map.get("buyer").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(BuyerCompanySpecificTap.MULYIPLE_BUYER_COMPANY_FIELD, map.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("buyer")))
//                        Enter.theValue(map.get("buyer")).into(BuyerCompanySpecificTap.MULYIPLE_BUYER_COMPANY_FIELD),
//                        CommonTask.ChooseValueFromSuggestions(map.get("buyer"))
                ),
                Check.whether(map.get("casePrice").isEmpty()).otherwise(
                        Enter.theValue(map.get("casePrice")).into(BuyerCompanySpecificTap.CASE_PRICE_FIELD)
                ),
                Check.whether(map.get("msrp").isEmpty()).otherwise(
                        Enter.theValue(map.get("msrp")).into(BuyerCompanySpecificTap.MSRP_UNIT_FIELD)
                ),
                Check.whether(map.get("availability").isEmpty()).otherwise(
                        Click.on(BuyerCompanySpecificTap.AVAILABILITY),
                        CommonTask.ChooseValueFromSuggestions(map.get("availability"))
                ),
                Check.whether(map.get("arriving").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("arriving"), "MM/dd/yy")).into(BuyerCompanySpecificTap.ARRIVING).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("start").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("start"), "MM/dd/yy")).into(BuyerCompanySpecificTap.START_DATE).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("end").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("end"), "MM/dd/yy")).into(BuyerCompanySpecificTap.END_DATE).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("category").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(BuyerCompanySpecificTap.CATEGORY, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("category")))
//                        Click.on(BuyerCompanySpecificTap.CATEGORY),
//                        CommonTask.ChooseValueFromSuggestions(map.get("category"))
                )
        );
    }


    public static Task submitCreate() {
        return Task.where("Add region specific",
                Click.on(AdminCreateNewSKUPage.SUBMIT_BUTTON),
                WindowTask.threadSleep(200)
//                checkActivatingSKU()
        );
    }

    public static Task removeBuyerSpecific(Map<String, String> map) {
        return Task.where("remove buyer company specific specific",
                Click.on(BuyerCompanySpecificTap.DYNAMIC_REMOVE_BUYER_SPECIFIC(map.get("buyer"), map.get("region"))),
                CommonWaitUntil.isNotVisible(BuyerCompanySpecificTap.DYNAMIC_REMOVE_BUYER_SPECIFIC(map.get("buyer"), map.get("region")))
        );
    }

    public static Task checkActivatingSKU() {
        return Task.where("Check activating sku",
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK"))).andIfSo(
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK"))
                ),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER, 60),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task duplicateProduct(String st, String action) {
        return Task.where("",
                CommonWaitUntil.isVisible(AdminProductDetailPage.DUPLICATE(st)),
                Click.on(AdminProductDetailPage.DUPLICATE(st)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON(action)),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON(action)),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER, 60)
        );
    }

    public static Task duplicateProductDetail(String action) {
        return Task.where("",
                CommonWaitUntil.isVisible(AdminProductDetailPage.DUPLICATE_ON_DETAIL),
                Scroll.to(AdminProductDetailPage.DUPLICATE_ON_DETAIL),
                Click.on(AdminProductDetailPage.DUPLICATE_ON_DETAIL),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task massEditing() {
        return Task.where("",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Mass editing")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Mass editing")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.SELECT_TAG)
        );
    }

    public static Task chooseSKUMassEditing(Map<String, String> map) {
        return Task.where("",
                CommonWaitUntil.isVisible(AdminProductDetailPage.MASS_EDIT_SKU_CHECKBOX(map.get("sku"))),
                Click.on(AdminProductDetailPage.MASS_EDIT_SKU_CHECKBOX(map.get("sku"))),
                WindowTask.threadSleep(200)
        );
    }

    public static Task chooseAllSKUMassEditing() {
        return Task.where("",
                CommonWaitUntil.isVisible(AdminProductDetailPage.MASS_EDIT_ALL_SKU),
                Click.on(AdminProductDetailPage.MASS_EDIT_ALL_SKU),
                WindowTask.threadSleep(200)
        );
    }

    public static Task goToRegionSpecific() {
        return Task.where("Go to Region-specific",
                CommonWaitUntil.isVisible((AdminCreateNewSKUPage.REGION_SPECIFIC_TAB)),
                Click.on(AdminCreateNewSKUPage.REGION_SPECIFIC_TAB)
        );
    }

    public static Task seeDetail() {
        return Task.where("See product detail",
                CommonWaitUntil.isVisible(AdminAllProductsPage.PRODUCT_NAME),
                Click.on(AdminAllProductsPage.PRODUCT_NAME),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task seeDetailSKU(String skuName) {
        return Task.where("See SKU detail",
                CommonWaitUntil.isVisible(AdminProductDetailPage.NAME_OF_AN_SKU(skuName)),
                Click.on(AdminProductDetailPage.NAME_OF_AN_SKU(skuName)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task changeAvailabity(RegionSpecificModel regionSpecificModel) {
        return Task.where("Change availabity",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.CASE_PRICE_FIELD(regionSpecificModel.getRegionName())),
                Enter.theValue(regionSpecificModel.getCasePrice()).into(AdminCreateNewSKUPage.CASE_PRICE_FIELD(regionSpecificModel.getRegionName())),
                Enter.theValue(regionSpecificModel.getMsrpunit()).into(String.format(AdminCreateNewSKUPage.MSRP_FIELD, regionSpecificModel.getRegionName())),
                Click.on(By.xpath(String.format(AdminCreateNewSKUPage.AVAILABILITY_FIELD, regionSpecificModel.getRegionName()))),
                CommonWaitUntil.isVisible(Target.the("").located(By.xpath(String.format(AdminCreateNewSKUPage.AVAILABILITY_OPTION, regionSpecificModel.getAvailability())))),
                Click.on(By.xpath(String.format(AdminCreateNewSKUPage.AVAILABILITY_OPTION, regionSpecificModel.getAvailability())))
        );
    }

    public static Task update() {
        return Task.where("Update",
                Click.on(AdminCreateNewSKUPage.UPDATE_BUTTON("Update"))
        );
    }

}
