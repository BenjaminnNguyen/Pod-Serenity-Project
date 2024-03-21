package steps.admin.products;

import io.cucumber.java.en.*;
import cucumber.constants.admin.Prop65Constant;
import cucumber.models.web.Admin.Products.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.products.HandleSKUAdmin;
import cucumber.tasks.admin.products.HandleProductDetail;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.products.*;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class SKUStepDefinitions {
    @And("Admin check message {word} showing of fields when create sku")
    public void checkMessage(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (type.equals("is")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AdminCreateAProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).text().isEqualToIgnoringCase(map.get("message"))
                );

            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AdminCreateAProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).isNotDisplayed()
                );
        }
    }

    @And("Admin check message {word} showing of fields")
    public void checkMessageField(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (type.equals("is")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AdminCreateAProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).text().isEqualToIgnoringCase(map.get("message"))
                );

            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AdminCreateAProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).isNotDisplayed()
                );
        }
    }

    @And("Admin check image invalid when create sku")
    public void checkImageError(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminCreateAProductPage.DYNAMIC_IMAGE_ERROR(map.get("field"))).text().isEqualToIgnoringCase(map.get("message"))
            );
        }
    }

    @And("Add new SKU")
    public void addNewSku(AdminCreateNewSKUModel adminCreateNewSKUModel) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.createNewSku(adminCreateNewSKUModel)
        );
//        Serenity.setSessionVariable("codeSKU").to(Admin_Create_New_SKU_Page.DYNAMIC_INPUT("Item code").resolveFor(theActorInTheSpotlight()).getValue().trim());
    }

    @And("Master Carton UPC")
    public void andMasterCartonUPC(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.masterCartonUPC(list.get(0))
        );
    }

    @And("{string} default pull threshold")
    public void defaultThreshold(String check) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(check.equalsIgnoreCase("Use")).andIfSo(
                        Check.whether(CommonQuestions.AskForAttributeContainText(AdminCreateNewSKUPage.DEFAULT_PULL_THRESHOLD, "class", "checked")).otherwise(
                                Click.on(AdminCreateNewSKUPage.DEFAULT_PULL_THRESHOLD),
                                CommonWaitUntil.isEnabled(AdminCreateNewSKUPage.DYNAMIC_INPUT("Pull threshold (days)"))
                        )
                ).otherwise(
                        Check.whether(CommonQuestions.AskForAttributeContainText(AdminCreateNewSKUPage.DEFAULT_PULL_THRESHOLD, "class", "checked")).andIfSo(
                                Click.on(AdminCreateNewSKUPage.DEFAULT_PULL_THRESHOLD)
                        )
                )
        );
    }

    @And("with Qualities")
    public void withQualities(List<String> qualities) {
        for (String q : qualities) {
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.chooseQualities(q)
            );
        }
    }

    @And("with Nutrition labels")
    public void withNutrition(List<NutritionLabel> nutrition) {
        for (int i = 0; i < nutrition.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.nutritionLabels(nutrition.get(i), i + 1)
            );
        }
    }

    @And("with Tags")
    public void withTags(List<Tags> tags) {
        for (int i = 0; i < tags.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.tags(tags.get(i))
            );
        }
    }

    @And("with region specific")
    public void withRegion(List<RegionSpecificModel> region) {
        for (RegionSpecificModel r : region)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.addRegionsSpecific(r)
            );
    }

    @And("Add new Region specific on Mass editing")
    public void withRegionMassEdit(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> r : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.addRegionsSpecificMassEdit(r)
            );
    }

    @And("date for region specific")
    public void dateRegion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> r : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.addDateForRegion(r)
            );
    }

    @And("Edit date for region specific mass editing")
    public void dateRegionMassEdit(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> r : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.addDateForRegionMassEdit(r)
            );
    }

    @And("Admin edit region specific")
    public void editRegion(List<RegionSpecificModel> region) {
        for (RegionSpecificModel r : region)
            theActorInTheSpotlight().attemptsTo(
                    HandleSKUAdmin.editRegionSpecific(r)
            );
    }

    @And("Check Prop65 is {string} when select region {string}")
    public void checkProp(String status, String region, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleProductDetail.addRegionNotInfo(region)
        );
        if (status.equals("show")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminCreateNewSKUPage.PROP_65).isDisplayed(),
                    Ensure.that(AdminCreateNewSKUPage.PROP_65_OVERVIEW).text().containsIgnoringCase(Prop65Constant.OVERVIEW),
                    Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Product name")).value().isEqualTo(list.get(0).get("product")),
                    Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("First name")).value().isEqualTo(list.get(0).get("firstName")),
                    Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Last name")).value().isEqualTo(list.get(0).get("lastName")),
                    Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Email")).value().isEqualTo(list.get(0).get("email")),
                    Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Company Name")).value().isEqualTo(list.get(0).get("company")),
                    Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Today's Date")).value().isEqualTo(CommonHandle.setDate2(list.get(0).get("today"), "MM/dd/yy"))
//                    Click.on(Admin_Create_New_SKU_Page.Submit_PROP_65),
//                    CommonWaitUntil.isNotVisible(Admin_Create_New_SKU_Page.Submit_PROP_65)
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminCreateNewSKUPage.PROP_65).isNotDisplayed());
        }
    }

    @And("Admin check Prop65 popup")
    public void checkProp(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AdminCreateNewSKUPage.PROP_65).isDisplayed(),
                Ensure.that(AdminCreateNewSKUPage.PROP_65_OVERVIEW).text().containsIgnoringCase(Prop65Constant.OVERVIEW),
                Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Product name")).value().isEqualTo(list.get(0).get("product")),
                Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("First name")).value().isEqualTo(list.get(0).get("firstName")),
                Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Last name")).value().isEqualTo(list.get(0).get("lastName")),
                Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Email")).value().isEqualTo(list.get(0).get("email")),
                Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Company Name")).value().isEqualTo(list.get(0).get("company")),
                Ensure.that(AdminCreateNewSKUPage.DYNAMIC_INPUT("Today's Date")).value().isEqualTo(CommonHandle.setDate2(list.get(0).get("today"), "MM/dd/yy"))
        );

    }

    @And("Admin check Prop65 info on general SKU")
    public void checkProp65(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.GENERAL_PROP_65_TYPE), equalToIgnoringCase(list.get(0).get("type"))),
                seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.DYNAMIC_PROP65_INFO("First name")), equalToIgnoringCase(list.get(0).get("firstName"))),
                seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.DYNAMIC_PROP65_INFO("Last name")), equalToIgnoringCase(list.get(0).get("lastName"))),
                seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.DYNAMIC_PROP65_INFO("Email")), equalToIgnoringCase(list.get(0).get("email"))),
                seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.DYNAMIC_PROP65_INFO("Date")), equalToIgnoringCase(CommonHandle.setDate2(list.get(0).get("date"), "MM/dd/yy")))

        );
        if (list.get(0).containsKey("listAllChemicals")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.DYNAMIC_PROP65_INFO("List all applicable chemicals")), equalToIgnoringCase(list.get(0).get("listAllChemicals"))),
                    seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.GENERAL_PROP_65_ITEM), equalToIgnoringCase(list.get(0).get("item")))
            );
        }
        if (list.get(0).containsKey("warning")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.DYNAMIC_PROP65_INFO("List all applicable chemicals")), equalToIgnoringCase(list.get(0).get("listAllChemicals")))
            );
        }
    }

    @And("Admin check have no Prop65 info on general SKU")
    public void checkNoProp65() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateNewSKUPage.GENERAL_PROP_65_TYPE)),
                seeThat(CommonQuestions.isControlUnDisplay(AdminCreateNewSKUPage.GENERAL_PROP_65_ITEM))

        );
    }

    @And("Admin check have no images on SKU")
    public void checkNoImageSKU() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.NO_MASTER_IMAGE)),
                seeThat(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.CASE_IMAGE_VALUE)),
                seeThat(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.UPC_IMAGE_VALUE))
        );
        List<WebElementFacade> nutritionLabels = AdminCreateNewSKUPage.NO_NUTRITION_IMAGE2.resolveAllFor(theActorInTheSpotlight());
        for (WebElementFacade e : nutritionLabels) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.webElementFacadeAttributeText(e, "style"), containsString("no_img"))
            );
        }
    }

    @And("Admin submit Prop65")
    public void submitProp65() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.Submit_PROP_65),
                Click.on(AdminCreateNewSKUPage.Submit_PROP_65),
                CommonWaitUntil.isNotVisible(AdminCreateNewSKUPage.Submit_PROP_65)
        );
    }

    @And("Admin choose option {string} on Prop65")
    public void chooseOptionProp65(String text) {
        theActorInTheSpotlight().attemptsTo(
                HandleSKUAdmin.chooseOption(text)
        );
    }

    @And("Admin enter info of Prop65")
    public void enterInfoProp65(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (list.get(0).containsKey("listAllChemicals")) {
            theActorInTheSpotlight().attemptsTo(
                    Enter.theValue(list.get(0).get("listAllChemicals")).into(AdminCreateNewSKUPage.DYNAMIC_INPUT("List all applicable chemicals")),
                    Click.on(AdminCreateNewSKUPage.DYNAMIC_INPUT("If Your Product Contains Chemicals on the Prop 65 List, Please Check One")),
                    CommonTask.ChooseValueFromSuggestions(list.get(0).get("item")));
        }
        if (list.get(0).containsKey("warning")) {
            theActorInTheSpotlight().attemptsTo(
                    Click.on(CommonAdminForm.DYNAMIC_SPAN_TEXT(list.get(0).get("warning"))));
        }
        theActorInTheSpotlight().attemptsTo(
                Check.whether(list.get(0).get("firstName").isEmpty()).otherwise(
                        Enter.theValue(list.get(0).get("firstName")).into(AdminCreateNewSKUPage.DYNAMIC_INPUT("First name"))),
                Check.whether(list.get(0).get("lastName").isEmpty()).otherwise(
                        Enter.theValue(list.get(0).get("lastName")).into(AdminCreateNewSKUPage.DYNAMIC_INPUT("Last name"))),
                Check.whether(list.get(0).get("email").isEmpty()).otherwise(
                        Enter.theValue(list.get(0).get("email")).into(AdminCreateNewSKUPage.DYNAMIC_INPUT("Email name"))),
                WindowTask.threadSleep(500)
        );
    }


    @And("Go to {string} tab")
    public void goRegion(String tab) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.SPECIFIC_TAB(tab)),
                Click.on(AdminCreateNewSKUPage.SPECIFIC_TAB(tab)),
                WindowTask.threadSleep(500)
//                CommonWaitUntil.isVisible(Admin_Create_New_SKU_Page.ADD_A_REGION)
        );
    }

    @And("Remove region {string}")
    public void removeRegion(String region) {
        theActorInTheSpotlight().attemptsTo(
                HandleSKUAdmin.removeRegion(region)
        );
    }

    @And("Remove region {string} of buyer company-specific {string}")
    public void removeBuyer(String region, String buyer) {
        theActorInTheSpotlight().attemptsTo(
                HandleSKUAdmin.removeBuyerCompanySpecific(buyer, region)
        );
    }

    //Check default region specific tab
    @And("Check default {string} specific tab")
    public void checkDefaultRegion(String tab, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.REGION_SPECIFIC_TAB_PANE(tab)), equalToIgnoringCase(list.get(0).get("alert")))
//                seeThat(CommonQuestions.targetText(Admin_Create_New_SKU_Page.REGION_SPECIFIC_EMPTY(tab)), equalToIgnoringCase(list.get(0).get("empty")))
        );
        if (list.get(0).containsKey("error")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.REGION_SPECIFIC_ERROR), equalToIgnoringCase(list.get(0).get("error")))
            );
        }
        if (tab.contains("store")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.REGION_SPECIFIC_EMPTY(tab)), equalToIgnoringCase(list.get(0).get("empty"))),
                    seeThat(CommonQuestions.attributeText(StoreSpecificTab.ADD_REGION_COMBO, "value"), containsString("")),
                    seeThat(CommonQuestions.attributeText(StoreSpecificTab.SEARCH_STORE, "value"), containsString(""))
//                    seeThat(CommonQuestions.isDisabled(StoreSpecificTab.ADD_BUTTON))
            );
        }
        if (tab.contains("buyer")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.REGION_SPECIFIC_EMPTY(tab)), equalToIgnoringCase(list.get(0).get("empty"))),
                    seeThat(CommonQuestions.attributeText(BuyerCompanySpecificTap.BUYER_COMPANY_FIELD, "value"), containsString("")),
                    seeThat(CommonQuestions.attributeText(BuyerCompanySpecificTap.REGION_FIELD, "value"), containsString("")),
                    seeThat(CommonQuestions.isDisabled(BuyerCompanySpecificTap.ADD_BUYER_COMPANY))
            );
        }
        if (tab.contains("region")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminCreateNewSKUPage.REGION_SPECIFIC_EMPTY), equalToIgnoringCase(list.get(0).get("empty")))
            );
        }
    }

    @And("Admin check general info of SKU")
    public void checkTapGeneralSKU(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.SKU_NAME_FIELD), containsString(list.get(0).get("skuName"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.popup_STATE_FIELD), equalToIgnoringCase(list.get(0).get("state"))),
                seeThat(list.get(0).get("mainSKU").equalsIgnoreCase("Yes") ? CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.MAIN_SKU_CHECKED) : CommonQuestions.isControlUnDisplay(AdminCreateNewSKUPage.MAIN_SKU_CHECKED)),
                seeThat(CommonQuestions.attributeText(AdminCreateNewSKUPage.UNITS_CASE, "aria-valuenow"), containsString(list.get(0).get("unitsCase"))),
                seeThat(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.MASTER_IMAGE)),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.INDIVIDUAL_UNIT_EAN_DROP), containsString(list.get(0).get("individualUnitEANType").equalsIgnoreCase("Yes") ? "EAN" : list.get(0).get("individualUnitEANType").equalsIgnoreCase("EAN") ? "EAN" : "UPC")),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.INDIVIDUAL_UNIT_UPC), containsString(list.get(0).get("individualUnitUPC"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.CASE_UPC), containsString(list.get(0).get("caseUPC"))),
                seeThat(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.UPC_IMAGE)),
                seeThat(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.CASE_IMAGE)),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.STORAGE_FIELD), containsString(list.get(0).get("storageShelfLife"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.STORAGE_CONDITION), containsString(list.get(0).get("storageCondition"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.RETAIL_FIELD), containsString(list.get(0).get("retailShelfLife"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.RETAIL_CONDITION), containsString(list.get(0).get("retailCondition"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.MIN_TEMPERATURE_FIELD), containsString(list.get(0).get("tempRequirementMin"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.MAX_TEMPERATURE_FIELD), containsString(list.get(0).get("tempRequirementMax"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.CITY_FIELD), containsString(list.get(0).get("city"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.STATE_ADDRESS_FIELD), containsString(list.get(0).get("stateManufacture"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.LEAD_TIME_FIELD), containsString(list.get(0).get("leadTime"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.INGREDIENTS_FIELD), containsString(list.get(0).get("ingredient"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.DESCRIPTION_FIELD), containsString(list.get(0).get("description"))),
                seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.EXPIRY_DAY_THRESHOLD), containsString(list.get(0).get("expireDayThreshold")))
        );
        if (!list.get(0).get("itemCode").equalsIgnoreCase("not check")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.DYNAMIC_INPUT("Item code")), equalToIgnoringCase(list.get(0).get("itemCode").isEmpty() ? Serenity.sessionVariableCalled("itemCode" + list.get(0).get("skuName")) : list.get(0).get("itemCode")))
            );
        }
    }

    @And("check Nutrition info of SKU")
    public void checkNutritionSKU(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Scroll.to(AdminCreateNewSKUPage.NUTRITION_IMAGE(i + 1))
            );
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.NUTRITION_IMAGE(i + 1))),
                    seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.NUTRITION_IMAGE_DES(i + 1)), equalToIgnoringCase(list.get(i).get("nutritionLabelDescription"))));
        }
    }

    @And("check qualities info of SKU")
    public void checkQualities(List<String> qualities) {
        for (String q : qualities) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AdminCreateNewSKUPage.QUALITIES_VALUES_CHECKED(q), "class"), containsString("checked"))
            );
        }
    }

    @And("check Tags info of SKU")
    public void checkTags(List<Tags> tags) {
        for (int i = 0; i < tags.size(); i++) {
            if (!tags.get(i).getTagName().isEmpty())
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlDisplay(AdminCreateNewSKUPage.TAGS_NAME(tags.get(i).getTagName()))),
                        seeThat(CommonQuestions.targetValue(AdminCreateNewSKUPage.TAGS_NAME(tags.get(i).getTagName())), equalToIgnoringCase(CommonHandle.setDate2(tags.get(i).getExpiryDate(), "MM/dd/yy")))
                );
        }
    }

    @And("with Buyer Company-specific")
    public void withCompany(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.addBuyerCompanySpecific(map)
            );

    }

    @And("Remove Buyer Company-specific")
    public void removeBuyer(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.removeBuyerSpecific(map)
            );

    }

    @And("Admin search Buyer Company specific {string}")
    public void addBuyerCompany(String buyer) {
        theActorInTheSpotlight().attemptsTo(
                HandleSKUAdmin.searchBuyerCompanySpecific(buyer)
        );
    }

    @And("Admin choose regions and add to Buyer Company specific")
    public void addRegionsBuyerCompany(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(BuyerCompanySpecificTap.REGION_FIELD)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTask.ChooseValueFromSuggestions(list.get(i).get("regions"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(BuyerCompanySpecificTap.REGION_FIELD),
                Click.on(BuyerCompanySpecificTap.ADD_BUYER_COMPANY),
                CommonWaitUntil.isVisible(BuyerCompanySpecificTap.CASE_PRICE_FIELD)
        );
    }

    @And("with Store-specific")
    public void withStore(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.addStoreSpecific(map)
            );
    }

    @And("Search and add Store-specific")
    public void searchAddStore(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.searchAddStoreSpecific(map)
            );
    }

    @And("Add multiple stores of Buyer company with info")
    public void addMultipleBuyer(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleProductDetail.addMultipleStoreSpecific(map)
            );
    }

    @And("Choose check, uncheck {string} stores of Buyer company")
    public void addMultipleBuyer(String all, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (all.equalsIgnoreCase("all")) //Chọn all store
        {
            theActorInTheSpotlight().attemptsTo(
                    HandleSKUAdmin.chooseAllStoreSpecific());
        } else {//Chọn từng store
            for (Map<String, String> map : list)
                theActorInTheSpotlight().attemptsTo(
                        HandleSKUAdmin.chooseMultipleStoreSpecific(map));
        }
    }

    @And("Confirm add multiple store")
    public void confirmAddMuliple() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(StoreSpecificTab.ADD_MULTIPLE_BUTTON),
                WindowTask.threadSleep(500)

        );
    }

    @And("Admin edit general info of SKU")
    public void editGeneralInfoSKU(AdminCreateNewSKUModel adminCreateNewSKUModel) {
//        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleSKUAdmin.editInfoSKU(adminCreateNewSKUModel)

        );
    }

    @And("Admin edit field general of SKU")
    public void editGeneralInfoSKU(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleSKUAdmin.editInfoSKU(list.get(0))

        );
    }

    @And("Admin check region-specific of SKU")
    public void checkRegionSpecific(List<RegionSpecificModel> regionSpecificModel) {
        for (RegionSpecificModel r : regionSpecificModel) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.DYNAMIC_FIELD(r.getRegionName(), "case-price"), "value"), containsString(r.getCasePrice())),
                    seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.DYNAMIC_FIELD(r.getRegionName(), "msrp"), "value"), containsString(r.getMsrpunit())),
                    seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.DYNAMIC_FIELD(r.getRegionName(), "availability"), "value"), containsString(r.getAvailability()))
            );
            if (r.getAvailability().equalsIgnoreCase("Launching soon")) {
                if (!r.getArriving().isEmpty()) {
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.DYNAMIC_FIELD(r.getRegionName(), "receiving-date"), "value"), containsString(CommonHandle.setDate2(r.getArriving(), "MM/dd/yy")))
                    );
                }
            }
            if (r.getAvailability().equalsIgnoreCase("Out of stock"))
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.DYNAMIC_FIELD(r.getRegionName(), "out-of-stock-reason"), "value"), containsString(r.getCategory()))
                );
            if (!r.getInventoryCount().equals(null)) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(AdminSKUDetailPage.INVENTORY_COUNT(r.getRegionName(), "inventory-count")), containsString(r.getInventoryCount()))
                );
            }

        }
    }

    @And("Admin check date of region-specific of SKU")
    public void checkDateRegionSpecific(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> r : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminCreateNewSKUPage.START_DATE(r.get("region"))).value().isEqualToIgnoringCase(CommonHandle.setDate2(r.get("startDate"), "MM/dd/yy")),
                    Ensure.that(AdminCreateNewSKUPage.END_DATE(r.get("region"))).value().isEqualToIgnoringCase(CommonHandle.setDate2(r.get("endDate"), "MM/dd/yy"))
            );
            if (r.containsKey("state")) {
                if (r.get("state").equals("active"))
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(AdminSKUDetailPage.STATE_REGION(r.get("region")), "class"), containsString("is-checked"))
                    );
                else theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AdminSKUDetailPage.STATE_REGION(r.get("region"))).attribute("class").doesNotContain("is-checked")
                );
            }
        }
    }

    @And("Admin check state history of region {string} of SKU")
    public void checkHistoryRegionSpecific(String region, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_ICON(region)),
                MoveMouse.to(AdminCreateNewSKUPage.HISTORY_ICON(region)),
                WindowTask.threadSleep(1000)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_TOOLTIP()),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_STATE(i + 1)).text().contains(list.get(i).get("state")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_BY(i + 1)).text().contains(list.get(i).get("updateBy")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_ON(i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check availability history of region {string} of SKU")
    public void checkHistoryAvailabilityRegionSpecific(String region, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_AVAILABILITY_ICON(region)),
                MoveMouse.to(AdminCreateNewSKUPage.HISTORY_AVAILABILITY_ICON(region)),
                WindowTask.threadSleep(1000)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_TOOLTIP()),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_STATE(i + 1)).text().contains(list.get(i).get("availability")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_BY(i + 1)).text().contains(list.get(i).get("updateBy")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_ON(i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check availability history of buyer company {string} and region {string} of SKU")
    public void checkHistoryAvailabilityBuyerSpecific(String buyer, String region, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_AVAILABILITY_ICON_BUYER_COMPANY(buyer, region)),
                MoveMouse.to(AdminCreateNewSKUPage.HISTORY_AVAILABILITY_ICON_BUYER_COMPANY(buyer, region)),
                WindowTask.threadSleep(1000)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_TOOLTIP()),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_STATE(i + 1)).text().contains(list.get(i).get("availability")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_BY(i + 1)).text().contains(list.get(i).get("updateBy")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_ON(i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check state history of buyer company {string} and region {string} of SKU")
    public void checkHistoryStateBuyerSpecific(String buyer, String region, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_STATE_ICON_BUYER_COMPANY(buyer, region)),
                MoveMouse.to(AdminCreateNewSKUPage.HISTORY_STATE_ICON_BUYER_COMPANY(buyer, region)),
                WindowTask.threadSleep(1000)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_TOOLTIP()),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_STATE(i + 1)).text().contains(list.get(i).get("state")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_BY(i + 1)).text().contains(list.get(i).get("updateBy")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_ON(i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check state history of store specific {string} of SKU")
    public void checkHistoryStateStoreSpecific(String store, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_STATE_ICON_STORE(store)),
                MoveMouse.to(AdminCreateNewSKUPage.HISTORY_STATE_ICON_STORE(store)),
                WindowTask.threadSleep(1000)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_TOOLTIP()),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_STATE(i + 1)).text().contains(list.get(i).get("state")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_BY(i + 1)).text().contains(list.get(i).get("updateBy")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_ON(i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check availability history of store specific {string} of SKU")
    public void checkHistoryAvailabilityStoreSpecific(String store, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_AVAILABILITY_ICON_STORE(store)),
                MoveMouse.to(AdminCreateNewSKUPage.HISTORY_AVAILABILITY_ICON_STORE(store)),
                WindowTask.threadSleep(1000)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AdminCreateNewSKUPage.HISTORY_TOOLTIP()),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_STATE(i + 1)).text().contains(list.get(i).get("availability")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_BY(i + 1)).text().contains(list.get(i).get("updateBy")),
                    Ensure.that(AdminCreateNewSKUPage.HISTORY_TOOLTIP_UPDATED_ON(i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin check buyer company-specific of SKU")
    public void checkRegionSpecific(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "case-price")), equalToIgnoringCase(map.get("casePrice"))),
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "msrp")), equalToIgnoringCase(map.get("msrpUnit"))),
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "availability")), equalToIgnoringCase(map.get("availability"))),
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "start-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "end-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")))
            );
            if (map.containsKey("inventoryArrivingAt")) {
                if (!map.get("inventoryArrivingAt").isEmpty())
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "inventory")), containsString(CommonHandle.setDate2(map.get("inventoryArrivingAt"), "MM/dd/yy")))
                    );
            }
            if (map.containsKey("category")) {
                if (!map.get("category").isEmpty())
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"), "out-of-stock")), containsString(map.get("category")))
                    );
                else
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetText(BuyerCompanySpecificTap.OSS_CATEGORY_BUYER_SPECIFIC(map.get("buyerCompany"), map.get("region"))), equalToIgnoringCase(map.get("category")))
                    );
            }
            if (map.containsKey("inventoryCount")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC2(map.get("buyerCompany"), map.get("region"), "inventory-count")), equalToIgnoringCase(map.get("inventoryCount")))
                );
            }
            if (map.containsKey("status")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC2(map.get("buyerCompany"), map.get("region"), "status-tag")), equalToIgnoringCase(map.get("status")))
                );
            }
        }
    }

    @And("Admin check store-specific of SKU")
    public void checkStoreSpecific(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_STORE_SPECIFIC(map.get("store"), "case-price")), equalToIgnoringCase(map.get("casePrice"))),
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_STORE_SPECIFIC(map.get("store"), "msrp")), equalToIgnoringCase(map.get("msrp"))),
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_STORE_SPECIFIC(map.get("store"), "availability")), equalToIgnoringCase(map.get("availability"))),
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_STORE_SPECIFIC(map.get("store"), "start-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("start"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_STORE_SPECIFIC(map.get("store"), "end-date")), equalToIgnoringCase(CommonHandle.setDate2(map.get("end"), "MM/dd/yy")))
            );
            if (map.containsKey("arriving")) {
                if (!map.get("arriving").isEmpty())
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_STORE_SPECIFIC(map.get("store"), "inventory")), containsString(CommonHandle.setDate2(map.get("arriving"), "MM/dd/yy")))
                    );
            }
            if (map.containsKey("category")) {
                if (!map.get("category").isEmpty())
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetValue(BuyerCompanySpecificTap.DYNAMIC_INPUT_STORE_SPECIFIC(map.get("store"), "out-of-stock")), containsString(map.get("category")))
                    );
            }
            if (map.containsKey("inventoryCount")) {
                if (!map.get("inventoryCount").isEmpty())
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetText(BuyerCompanySpecificTap.DYNAMIC_INPUT_STORE_SPECIFIC2(map.get("store"), "inventory-count")), containsString(map.get("inventoryCount")))
                    );
            }
//            if (map.containsKey("status")) {
//                if (!map.get("status").isEmpty())
//                    theActorInTheSpotlight().should(
//                            seeThat(CommonQuestions.targetText(BuyerCompanySpecificTap.DYNAMIC_INPUT_BUYER_SPECIFIC2(map.get("store"), "inventory-count")), containsString(map.get("inventoryCount")))
//                    );
//            }
        }
    }

    @And("Admin check error on buyer company-specific of buyer: {string}")
    public void checkErrorBuyerSpecific(String buyer, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerCompanySpecificTap.DYNAMIC_ERROR_BUYER_SPECIFIC(buyer, map.get("region"), map.get("field"))), containsString(map.get("error")))

            );
    }

    @And("Admin {string} duplicate SKU {string} on list")
    public void duplicateOnList(String action, String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminProductDetailPage.DUPLICATE_SKU_BUTTON(sku)),
                Click.on(AdminProductDetailPage.DUPLICATE_SKU_BUTTON(sku)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Yes")),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG("Duplicate sku " + sku)).isDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG("Do you want to duplicate images as well? Note that image duplication may take additional time.")).isDisplayed(),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.threadSleep(1000)
        );
    }

}
