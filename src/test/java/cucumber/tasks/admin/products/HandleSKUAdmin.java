package cucumber.tasks.admin.products;

import cucumber.models.web.Admin.Products.AdminCreateNewSKUModel;
import cucumber.models.web.Admin.Products.RegionSpecificModel;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.products.AdminCreateNewSKUPage;
import cucumber.user_interface.admin.products.AdminProductDetailPage;
import cucumber.user_interface.admin.products.BuyerCompanySpecificTap;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleSKUAdmin {
    public static Task editInfoSKU(AdminCreateNewSKUModel adminCreateNewSKUModel) {
        return Task.where("Edit general info of SKU",
//                Check.whether(CommonQuestions.isControlUnDisplay(Admin_Product_Detail_Page.ADD_NEW_SKU_BUTTON)).otherwise(
//                        CommonWaitUntil.isVisible(Admin_Product_Detail_Page.ADD_NEW_SKU_BUTTON),
//                        Click.on(Admin_Product_Detail_Page.ADD_NEW_SKU_BUTTON)
//                ),
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
                        Enter.theValue(adminCreateNewSKUModel.getExpireDayThreshold()).into(AdminCreateNewSKUPage.EXPIRY_DAY_THRESHOLD))

        );
    }

    public static Task editInfoSKU(Map<String, String> map) {
        return Task.where("",
                Check.whether(map.get("field").equalsIgnoreCase("Pull threshold (days)")).andIfSo(
                        CommonWaitUntil.isVisible(AdminCreateNewSKUPage.DYNAMIC_INPUT(map.get("field"))),
                        Clear.field(AdminCreateNewSKUPage.DYNAMIC_INPUT(map.get("field"))),
                        Enter.theValue(map.get("value")).into(AdminCreateNewSKUPage.DYNAMIC_INPUT(map.get("field"))).thenHit(Keys.TAB)

                ).otherwise(
                        Check.whether(map.get("field").equalsIgnoreCase("state")).andIfSo(
                                Click.on(AdminCreateNewSKUPage.DYNAMIC_INPUT2(map.get("field"))),
                                CommonTask.ChooseValueFromSuggestions(map.get("value"))
                        ).otherwise(
                                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.DYNAMIC_INPUT2(map.get("field"))),
                                Clear.field(AdminCreateNewSKUPage.DYNAMIC_INPUT2(map.get("field"))),
                                Enter.theValue(map.get("value")).into(AdminCreateNewSKUPage.DYNAMIC_INPUT2(map.get("field"))).thenHit(Keys.TAB)
                        )
                )
        );
    }

    public static Task editRegionSpecific(RegionSpecificModel regionSpecificModel) {
        return Task.where("Edit region specific",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.CASE_PRICE_FIELD(regionSpecificModel.getRegionName())),
                Check.whether(regionSpecificModel.getCasePrice().isEmpty()).otherwise(
                        Enter.theValue(regionSpecificModel.getCasePrice()).into(AdminCreateNewSKUPage.CASE_PRICE_FIELD(regionSpecificModel.getRegionName()))
                ),
                Check.whether(regionSpecificModel.getMsrpunit().isEmpty()).otherwise(
                        Enter.theValue(regionSpecificModel.getMsrpunit()).into(String.format(AdminCreateNewSKUPage.MSRP_FIELD, regionSpecificModel.getRegionName()))
                ),
                Check.whether(regionSpecificModel.getAvailability().isEmpty()).otherwise(
                        Click.on(By.xpath(String.format(AdminCreateNewSKUPage.AVAILABILITY_FIELD, regionSpecificModel.getRegionName()))),
                        CommonTask.ChooseValueFromSuggestions(regionSpecificModel.getAvailability()),
                        Check.whether(regionSpecificModel.getAvailability().equalsIgnoreCase("Launching soon")).andIfSo(
                                CommonWaitUntil.isVisible(Target.the("").located(By.xpath(String.format(AdminCreateNewSKUPage.ARRIVING_AT, regionSpecificModel.getRegionName())))),
                                Enter.theValue(CommonHandle.setDate2(regionSpecificModel.getArriving(), "MM/dd/yy")).into(String.format(AdminCreateNewSKUPage.ARRIVING_AT, regionSpecificModel.getRegionName())).thenHit(Keys.TAB)
                        ),
                        Check.whether(regionSpecificModel.getAvailability().equalsIgnoreCase("Out of stock")).andIfSo(
                                Check.whether(regionSpecificModel.getArriving().isEmpty()).otherwise(
                                        CommonWaitUntil.isVisible(Target.the("").located(By.xpath(String.format(AdminCreateNewSKUPage.CATEGORY, regionSpecificModel.getRegionName())))),
                                        Click.on(String.format(AdminCreateNewSKUPage.CATEGORY, regionSpecificModel.getRegionName())),
                                        CommonTask.ChooseValueFromSuggestions(regionSpecificModel.getArriving()))
                        )
                )
        );
    }

    public static Task removeRegion(String region) {
        return Task.where("remove Region " + region,
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.REMOVE_REGION(region)),
                Scroll.to(AdminCreateNewSKUPage.REMOVE_REGION(region)),
                Click.on(AdminCreateNewSKUPage.REMOVE_REGION(region)),
                CommonWaitUntil.isNotVisible(AdminCreateNewSKUPage.REMOVE_REGION(region))
        );
    }

    public static Task chooseOption(String text) {
        return Task.where("ADD REGION  ",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SPAN_TEXT(text)),
                Click.on(CommonAdminForm.DYNAMIC_SPAN_TEXT(text)),
                WindowTask.threadSleep(500)
        );
    }

    public static Task removeBuyerCompanySpecific(String buyer, String region) {
        return Task.where("",
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.REMOVE_REGION_BUYERCOMPANY(buyer, region)),
                Click.on(AdminCreateNewSKUPage.REMOVE_REGION_BUYERCOMPANY(buyer, region)),
                CommonWaitUntil.isNotVisible(AdminCreateNewSKUPage.REMOVE_REGION_BUYERCOMPANY(buyer, region))
        );
    }

    public static Task chooseMultipleStoreSpecific(Map<String, String> map) {
        return Task.where("Add buyer company specific",
                Check.whether(map.get("store").isEmpty()).otherwise(
                        Check.whether(CommonQuestions.isChecked(BuyerCompanySpecificTap.DYNAMIC_STORE_CHECK(map.get("store")))).otherwise(
                                Click.on(BuyerCompanySpecificTap.DYNAMIC_STORE_CHECK(map.get("store")))
                        )
                )
        );
    }

    public static Task chooseAllStoreSpecific() {
        return Task.where("Add buyer company specific",
                Check.whether(CommonQuestions.isChecked(BuyerCompanySpecificTap.MULYIPLE_CHECK_ALL)).andIfSo(
                        Click.on(BuyerCompanySpecificTap.MULYIPLE_CHECK_ALL),
                        WindowTask.threadSleep(500)
                )
        );
    }

    public static Task unchooseAllStoreSpecific(String store) {
        return Task.where("Add buyer company specific",
                Check.whether(CommonQuestions.isChecked(BuyerCompanySpecificTap.DYNAMIC_STORE_CHECK(store))).otherwise(
                        Click.on(BuyerCompanySpecificTap.DYNAMIC_STORE_CHECK(store))
                )
        );
    }

    public static Task searchBuyerCompanySpecific(String name) {
        return Task.where("Add buyer company specific",
                Check.whether(name.isEmpty()).otherwise(
                        Enter.theValue(name).into(BuyerCompanySpecificTap.BUYER_COMPANY_FIELD),
                        CommonTask.ChooseValueFromSuggestions(name)
                ));
    }

    public static Task addRegionBuyerCompanySpecific(String name) {
        return Task.where("Add buyer company specific",
                Check.whether(name.isEmpty()).otherwise(
                        Enter.theValue(name).into(BuyerCompanySpecificTap.BUYER_COMPANY_FIELD),
                        CommonTask.ChooseValueFromSuggestions(name)
                ));
    }
}
