package steps.vendor.product;

import cucumber.user_interface.beta.Vendor.products.VendorCreateProductPage;
import io.cucumber.java.en.*;
import cucumber.constants.vendor.WebsiteConstants;
import cucumber.models.web.Admin.Vendors.CreateNewSKUModel;
import cucumber.models.web.Admin.Vendors.RegionSpecificModel;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.Utility;
import cucumber.tasks.vendor.HandleVendorProduct;
import cucumber.tasks.vendor.HandleVendorSKU;
import cucumber.tasks.vendor.VendorDashboardProductsSKUsTask;
import cucumber.tasks.vendor.VendorDashboardTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.products.VendorCreateNewSKUPage;
import cucumber.user_interface.beta.Vendor.products.VendorProductDetailPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class VendorSKUStepDefinition {
    @And("Vendor input info new SKU")
    public void create_new_sku(CreateNewSKUModel createNewSKUModel) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.create(createNewSKUModel)
        );
    }

    @And("Vendor verify tab {string} is active")
    public void verify_tab(String tab) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorCreateNewSKUPage.CREATE_YOUR_FIRST_SKU(tab)).attribute("class").contains("is-active")
        );
    }

    @And("Vendor upload {string} image for new SKU")
    public void upload_UPC_EAN(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (type.equals("UPC"))
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.uploadMasterCartonUPCImage(list.get(0).get("image"), list.get(0).get("masterCarton"))
            );
        if (type.equals("EAN"))
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.uploadMasterCartonEANImage(list.get(0).get("image"), list.get(0).get("masterCarton"))
            );
    }

    @And("Vendor set {word} main SKU")
    public void setMainSKU(String main) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.setMain(main)
        );
    }

    @And("Vendor set UPC-EAN {string} of SKU")
    public void setUPCMainSKU(String main) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.setMain(main)
        );
    }

    @And("Vendor go to create a new SKU")
    public void go_to_create_new_sku() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.goToPage()
        );
    }

    @And("Vendor go to SKUs tap")
    public void go_to_SKUs_tap() {
        theActorInTheSpotlight().attemptsTo(
                VendorDashboardProductsSKUsTask.goToSKUsTab()
        );
    }

    @And("Vendor check SKU {string} on {word} SKUs")
    public void check_SKUs_tap(String show, String tab, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (show.equalsIgnoreCase("show")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlDisplay(VendorProductDetailPage.SKU_NAME(tab, map.get("skuName"))))
                );
                if (map.containsKey("image")) {
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(VendorProductDetailPage.SKU_IMAGE(map.get("skuName")), "style"), containsString(map.get("image")))
                    );
                }
                if (tab.equalsIgnoreCase("Published")) {
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetText(VendorProductDetailPage.CASE_UNIT(map.get("skuName"))), containsString(map.get("caseUnit"))),
                            seeThat(CommonQuestions.targetText(VendorProductDetailPage.CASE_UPC(map.get("skuName"))), containsString(map.get("caseUPC"))),
                            seeThat(CommonQuestions.targetText(VendorProductDetailPage.UNIT_UPC(map.get("skuName"))), containsString(map.get("unitUPC")))
                    );
                }
            } else {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlUnDisplay(VendorProductDetailPage.SKU_NAME(tab, map.get("skuName"))))
                );
            }
        }
    }

    @And("Vendor check SKU general detail")
    public void checkSKUGeneralDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                VendorDashboardProductsSKUsTask.checkTapGeneralSKU(list.get(0))
        );
        if (list.get(0).containsKey("isMain")) {
            if (!list.get(0).get("isMain").isEmpty())
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.attributeText(VendorCreateNewSKUPage.MAIN_SKU, "class"), containsString("checked"))
                );
            else theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.AskForAttributeContainText(VendorCreateNewSKUPage.MAIN_SKU, "class", "checked"), equalTo(false))

            );
        }
        if (list.get(0).containsKey("storageCondition")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCreateNewSKUPage.STORAGE_CONDITION).value().contains(list.get(0).get("storageCondition"))
            );
        }
        if (list.get(0).containsKey("retailCondition")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCreateNewSKUPage.RETAIL_CONDITION).value().contains(list.get(0).get("retailCondition"))
            );
        }
    }

    @And("Vendor go to detail of SKU {string}")
    public void checkSKUDetail(String sku) {
        theActorInTheSpotlight().attemptsTo(
                VendorDashboardProductsSKUsTask.goToSKUDetail(sku)
        );
    }

    @And("Vendor check SKU have no images")
    public void checkSKUNoImage() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.attributeText(VendorCreateNewSKUPage.DYNAMIC_IMAGE("SKU Image"), "style"), containsString("no_img_product.png")),
                seeThat(CommonQuestions.attributeText(VendorCreateNewSKUPage.DYNAMIC_IMAGE("Unit UPC Image"), "style"), containsString("no_img_product.png")),
                seeThat(CommonQuestions.attributeText(VendorCreateNewSKUPage.DYNAMIC_IMAGE("Case UPC Image"), "style"), containsString("no_img_product.png"))
        );
    }

    @And("Vendor check value of field on SKU detail")
    public void checkStorageSKU(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.DYNAMIC_INPUT(map.get("field"))), containsString(map.get("value")))
            );
    }

    @And("{word} check value of field")
    public void checkValuesSKU(String actor, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateNewSKUPage.DYNAMIC_INPUT(map.get("field"))),
                    Ensure.that(VendorCreateNewSKUPage.DYNAMIC_INPUT(map.get("field"))).value().isEqualTo(CommonHandle.setDate2(map.get("value"), "MM/dd/yy"))
            );
    }

    @And("Vendor change Barcodes type of SKU to {word}")
    public void checkStorageSKU(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonTask.chooseItemInDropdown(VendorCreateNewSKUPage.DYNAMIC_FIELD("Barcodes Type"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(type))
        );
    }

    @And("Vendor check Nutrition info of SKU")
    public void checkNutritionSKU(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCreateNewSKUPage.NUTRITION_IMAGE(i + 1)).attribute("style").contains(list.get(i).get("image")),
                    Ensure.that(VendorCreateNewSKUPage.NUTRITION_DES(i + 1)).attribute("value").contains(list.get(i).get("description"))
            );

        }
    }

    @And("Vendor check Region-Specific of SKU")
    public void checkRegionSpecificTap(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateNewSKUPage.WHOLESALE_PRICE(list.get(i).get("regionName"))),
                    Ensure.that(VendorCreateNewSKUPage.WHOLESALE_PRICE(list.get(i).get("regionName"))).attribute("value").isEqualToIgnoringCase(list.get(i).get("casePrice")),
                    Ensure.that(VendorCreateNewSKUPage.MSRP_UNIT(list.get(i).get("regionName"))).attribute("value").isEqualToIgnoringCase(list.get(i).get("msrpUnit")),
                    Ensure.that(VendorCreateNewSKUPage.AVAILABILITY_CHECKED(list.get(i).get("regionName"), list.get(i).get("availability"))).isDisplayed()
            );
            if (list.get(i).containsKey("arriving")) {
                if (!list.get(i).get("arriving").isEmpty())
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(VendorCreateNewSKUPage.ARRIVING(list.get(i).get("regionName")), "value"), equalToIgnoringCase(CommonHandle.setDate2(list.get(i).get("arriving"), "MM/dd/yy")))
                    );
            }
        }
    }

    @And("Vendor check specific price of SKU")
    public void checkSpecificPrice(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.SPECIFIC_PRICE(list.get(i).get("regionName"))), equalToIgnoringCase(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.SPECIFIC_PRICE_AVAILABILITY(list.get(i).get("regionName"))), equalToIgnoringCase(list.get(i).get("availability")))
            );
        }
    }

    @And("Vendor check Buyer-Company Specific tap")
    public void checkBuyerCompanySpecificTap(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_BUYER_SPECIFIC_FIELD("Case Price", list.get(i).get("buyerCompany"), list.get(i).get("region"))), containsString(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_BUYER_SPECIFIC_FIELD("MSRP/unit", list.get(i).get("buyerCompany"), list.get(i).get("region"))), containsString(list.get(i).get("msrpUnit"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_BUYER_SPECIFIC_FIELD("Start date", list.get(i).get("buyerCompany"), list.get(i).get("region"))), containsString(CommonHandle.setDate2(list.get(i).get("startDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_BUYER_SPECIFIC_FIELD("End date", list.get(i).get("buyerCompany"), list.get(i).get("region"))), containsString(CommonHandle.setDate2(list.get(i).get("endDate"), "MM/dd/yy"))),
//                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_BUYER_SPECIFIC_FIELD(list.get(i).get("buyerCompany"))), containsString(list.get(i).get("availability"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_BUYER_SPECIFIC_FIELD("Availability", list.get(i).get("buyerCompany"), list.get(i).get("region"))), containsString(list.get(i).get("availability")))
            );
            if (list.get(i).containsKey("inventoryArrivingAt")) {
                if (!list.get(i).get("inventoryArrivingAt").isEmpty())
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_BUYER_SPECIFIC_FIELD("Inventory arriving at", list.get(i).get("buyerCompany"), list.get(i).get("region"))), containsString(CommonHandle.setDate2(list.get(i).get("inventoryArrivingAt"), "MM/dd/yy")))
                    );
            }
        }
    }

    @And("Vendor check Store Specific tap")
    public void checkStoreSpecificTap(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.STORE_SPECIFIC_FIELD(list.get(i).get("region"))), containsString(list.get(i).get("store"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.DYNAMIC_STORE_SPECIFIC_FIELD("Store-specific price", list.get(i).get("region"))), containsString(list.get(i).get("price"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.DYNAMIC_STORE_SPECIFIC_FIELD("Start date", list.get(i).get("region"))), containsString(CommonHandle.setDate2(list.get(i).get("startDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.DYNAMIC_STORE_SPECIFIC_FIELD("End date", list.get(i).get("region"))), containsString(CommonHandle.setDate2(list.get(i).get("endDate"), "MM/dd/yy")))
            );
        }
    }

    @And("Vendor check Store Specific of SKU")
    public void checkStoreSpecific(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.STORE_SPECIFIC_FIELD(list.get(i).get("region"))), containsString(list.get(i).get("store"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.DYNAMIC_STORE_SPECIFIC_FIELD("Store-specific price", list.get(i).get("region"))), containsString(list.get(i).get("price"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.DYNAMIC_STORE_SPECIFIC_FIELD("Start date", list.get(i).get("region"))), containsString(CommonHandle.setDate2(list.get(i).get("startDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateNewSKUPage.DYNAMIC_STORE_SPECIFIC_FIELD("End date", list.get(i).get("region"))), containsString(CommonHandle.setDate2(list.get(i).get("endDate"), "MM/dd/yy")))
            );
        }
    }

    @And("Vendor check {string} prop65 of SKU")
    public void vendorCheckProp65(String show, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (show.equalsIgnoreCase("show")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(VendorCreateNewSKUPage.GENERAL_PROP_65_TYPE(list.get(0).get("type")))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_PROP65_INFO("First name")), containsString(list.get(0).get("firstName"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_PROP65_INFO("Last name")), containsString(list.get(0).get("lastName"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_PROP65_INFO("Email")), containsString(list.get(0).get("email"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_PROP65_INFO("Submitted date")), containsString(CommonHandle.setDate2(list.get(0).get("date"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.DYNAMIC_PROP65_INFO("Company name")), containsString(list.get(0).get("company")))

            );
            if (list.get(0).containsKey("listAllChemicals")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlDisplay(VendorCreateNewSKUPage.GENERAL_PROP_65_TYPE(list.get(0).get("listAllChemicals")))),
                        seeThat(CommonQuestions.isControlDisplay(VendorCreateNewSKUPage.GENERAL_PROP_65_TYPE(list.get(0).get("item"))))
                );
            }
            if (list.get(0).containsKey("warning")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(VendorCreateNewSKUPage.GENERAL_PROP_65_TYPE(list.get(0).get("warning"))))
                );
            }
        } else
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlUnDisplay(VendorCreateNewSKUPage.GENERAL_PROP_65_TYPE(list.get(0).get("type"))))
            );

    }

    @And("Vendor choose qualities of SKU")
    public void choose_quantities_sku(List<String> quantities) {
        for (String q : quantities) {
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.checkQualities(q)
            );
        }
    }

    @And("Vendor check Qualities of SKU")
    public void check_qualities_sku(List<String> quantities) {
        for (String q : quantities) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(VendorCreateNewSKUPage.QUALITIES_CHECKBOX(q), "class"), containsString("checked"))

            );
        }
    }

    @And("Vendor add nutrition labels of SKU")
    public void nutrition_new_sku(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.addNutrition(map.get("image"), map.get("description"))
            );
        }
    }

    @And("Vendor delete nutrition labels number {int}")
    public void nutrition_new_sku(Integer num) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.deleteNutrition(num)
        );
    }

    @And("Vendor choose region {string} for SKU")
    public void add_region(String region) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.addRegion(region)
        );
    }

    @And("Vendor choose option on confirm add region")
    public void confirm_add_region(List<String> option) {
        List<WebElementFacade> webElementFacades = VendorCreateNewSKUPage.CONFIRM_OPTION().resolveAllFor(theActorInTheSpotlight());
        for (String o : option) {
            for (WebElementFacade e : webElementFacades) {
                if (e.getText().contains(o))
                    theActorInTheSpotlight().attemptsTo(
                            JavaScriptClick.on(e)
                    );
            }
        }
    }

    @And("Vendor check content of confirm when add region {string}")
    public void check_confirm_add_region(String region) {
        if (region.equalsIgnoreCase("Express"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_DIALOG_TEXT(WebsiteConstants.CONFIRM_ADD_REGION_EP_SUB_TITLE))),
                    seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_DIALOG_TEXT(WebsiteConstants.CONFIRM_ADD_REGION_EP_TITLE)))
            );
        else
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_DIALOG_TEXT(WebsiteConstants.CONFIRM_ADD_REGION_PD_SKU_SUB_TITLE))),
                    seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_DIALOG_TEXT(WebsiteConstants.CONFIRM_ADD_REGION_PD_SKU_TITLE)))
            );
    }

    @And("Vendor check {string} content of Prop65")
    public void check_prop65_add_region(String show) {
        if (show.equalsIgnoreCase("show"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(VendorCreateNewSKUPage.PROP65_TITLE)),
                    seeThat(CommonQuestions.textContains(VendorCreateNewSKUPage.PROP65_DES, WebsiteConstants.PROP65_DESCRIPTION))
            );
        else
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlUnDisplay(VendorCreateNewSKUPage.PROP65_TITLE)),
                    seeThat(CommonQuestions.isControlUnDisplay(VendorCreateNewSKUPage.PROP65_DES))
            );
    }

    @And("Vendor choose option {string} on Prop65")
    public void chooseOptionProp65(String text) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.chooseOption(text)
        );
    }

    @And("Vendor enter info of Prop65")
    public void enterInfoProp65(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (list.get(0).containsKey("listAllChemicals")) {
            theActorInTheSpotlight().attemptsTo(
                    Enter.theValue(list.get(0).get("listAllChemicals")).into(CommonVendorPage.DYNAMIC_INPUT("List all applicable chemicals")),
                    CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_INPUT_AFTER_DIV("If Your Product Contains Chemicals on the Prop 65 List, Please Check One")
                            , CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(list.get(0).get("item")))
            );
        }
        if (list.get(0).containsKey("warning")) {
            theActorInTheSpotlight().attemptsTo(
                    Click.on(CommonVendorPage.DYNAMIC_ANY_TEXT(list.get(0).get("warning"))));
        }
        theActorInTheSpotlight().attemptsTo(
                Check.whether(list.get(0).get("firstName").isEmpty()).otherwise(
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT("First Name")).attribute("value").isEqualToIgnoringCase(list.get(0).get("firstName"))
                ),
                Check.whether(list.get(0).get("lastName").isEmpty()).otherwise(
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Last Name")).attribute("value").isEqualToIgnoringCase(list.get(0).get("lastName"))
                ),
                Check.whether(list.get(0).get("email").isEmpty()).otherwise(
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Email")).attribute("value").isEqualToIgnoringCase(list.get(0).get("email"))
                ),
                Check.whether(list.get(0).get("companyName").isEmpty()).otherwise(
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Company name")).attribute("value").isEqualToIgnoringCase(list.get(0).get("companyName"))),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Today's Date")).attribute("value").isEqualToIgnoringCase(Utility.getTimeNow("MM/dd/yy"))
        );
    }

    @And("Vendor remove region of SKU")
    public void removeRegion(List<String> regions) {
        for (String region : regions) {
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.removeRegion(region)
            );
        }
    }

    @And("Vendor input Region-Specific info of SKU")
    public void inputRegionInfo(List<RegionSpecificModel> regionSpecificModel) {
        for (RegionSpecificModel regionSpecificModel1 : regionSpecificModel)
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.inputRegionInfo(regionSpecificModel1)
            );
    }

    @And("Vendor add regions for SKU")
    public void add_regions_for_sku(List<RegionSpecificModel> regions) {
        for (RegionSpecificModel regionSpecificModel : regions) {
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.addRegion(regionSpecificModel.getRegionName())
            );

            if (VendorCreateNewSKUPage.CONFIRM_OPTION.resolveAllFor(theActorInTheSpotlight()).size() != 0) {
                for (int i = 0; i < VendorCreateNewSKUPage.CONFIRM_OPTION.resolveAllFor(theActorInTheSpotlight()).size(); i++) {
                    theActorInTheSpotlight().attemptsTo(
                            JavaScriptClick.on(VendorCreateNewSKUPage.CONFIRM_OPTION.resolveAllFor(theActorInTheSpotlight()).get(i))
                    );
                }
            }
            if (regionSpecificModel.getRegionName().equalsIgnoreCase("North California Express") || regionSpecificModel.getRegionName().equalsIgnoreCase("South California Express")
                    || regionSpecificModel.getRegionName().equalsIgnoreCase("Pod Direct West")) {
                for (int i = 0; i < VendorCreateNewSKUPage.CHEMICALS_PROP_65.resolveAllFor(theActorInTheSpotlight()).size(); i++) {
                    theActorInTheSpotlight().attemptsTo(
                            Click.on(VendorCreateNewSKUPage.CHEMICALS_PROP_65));
                }
            }
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(CommonQuestions.isControlDisplay(VendorCreateNewSKUPage.ADD_CONFIRM)).andIfSo(
                            Click.on(VendorCreateNewSKUPage.ADD_CONFIRM))
            );
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.inputRegionInfo(regionSpecificModel)
            );
        }
    }

    @And("Vendor go to {string} tab on SKU detail")
    public void go_to_tab_sku(String tab) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.DYNAMIC_SKU_TAB(tab)),
                Click.on(VendorCreateNewSKUPage.DYNAMIC_SKU_TAB(tab))
        );
    }

    @And("Vendor go to Manage SKU price tab")
    public void go_to_tab_sku_price() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.goToTab("Manage SKU price >")
        );
    }

    @And("Vendor go back to Manage SKU info tab")
    public void go_to_tab_sku_info() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.SKU_INFO),
                Click.on(VendorCreateNewSKUPage.SKU_INFO)
        );
    }

    @And("Vendor {word} confirm publish SKU")
    public void confirmPublishSKU(String action) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.confirmPublishSKU(action)
        );
    }

    @And("Wait for create product successfully")
    public void waitCreateSuccess() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT("Created successfully"), 90),
                CommonWaitUntil.isNotVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT("Created successfully"))
        );
    }

    @And("Wait for create SKU successfully")
    public void waitCreateSKUSuccess() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT("Product SKU created successfully."), 60),
                CommonWaitUntil.isNotVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT("Product SKU created successfully."))
        );
    }

    @And("Wait for update SKU successfully")
    public void waitUpdateSKUSuccess() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT("Product SKU updated successfully."), 60),
                CommonWaitUntil.isNotVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT("Product SKU updated successfully."))
        );
    }

    @And("Vendor click {string} new SKU")
    public void actionSKU(String action) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.actionSKU(action)
        );
    }

    @And("{word} check help text tooltip")
    public void checkHelpText(String actor, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    VendorDashboardTask.checkHelpTooltip(map.get("field"), map.get("text"))
            );
    }

    @And("Vendor {word} region {string} of SKU")
    public void changeStateOfRegion(String state, String region) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.activeSKU(state, region)
        );
    }

    @And("Vendor edit field on SKU detail")
    public void edit_sku(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorSKU.editField(map)
            );
    }
}
