package steps.vendor;

import cucumber.actions.GoBack;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.promotion.AllPromotionsPage;
import cucumber.user_interface.beta.HomePageForm;
import io.cucumber.java.en.*;
import cucumber.models.web.Admin.Vendors.SearchVendor;
import cucumber.models.web.Vendor.CreateNewBrand;
import cucumber.questions.CommonQuestions;
import cucumber.questions.Admin.Brands.BrandCatalogInfo;
import cucumber.tasks.buyer.addtocart.AddToCart;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.tasks.vendor.*;
import cucumber.user_interface.admin.VendorPageForm;
import cucumber.user_interface.beta.Vendor.products.VendorCreateNewSKUPage;
import cucumber.user_interface.beta.Vendor.products.VendorProductForm;
import cucumber.user_interface.beta.Vendor.products.VendorProductDetailPage;
import cucumber.user_interface.beta.Vendor.*;
import cucumber.user_interface.beta.CatalogForm;
import cucumber.user_interface.beta.Vendor.brands.VendorDetailBrandCatalogPage;
import cucumber.user_interface.beta.Vendor.brands.VendorDetailBrandDashboardPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.checkerframework.checker.units.qual.C;
import org.openqa.selenium.Keys;

import java.nio.file.Path;
import java.util.List;
import java.util.Map;

import static cucumber.user_interface.beta.Vendor.VendorDashboardPage.*;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;

import static net.serenitybdd.screenplay.actors.OnStage.*;
import static org.hamcrest.Matchers.*;

public class VendorsStepDefinitions {
    @And("Search the vendor by info then system show result")
    public void search_the_vendor_by_full_name_field(List<SearchVendor> infos) {
        for (SearchVendor info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CheckFilter.resetFilter(),
                    CheckFilter.check(info)
            );
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(VendorPageForm.FULL_NAME_RESULT(info.getFullName())), equalTo(true))
            );
        }
    }

    @Given("{word} Navigate to {string} by sidebar")
    public void navigateTo(String actor, String title) {
        theActorCalled(actor).attemptsTo(
                VendorDashboardTask.navigate(title, VendorDashboardPage.OPTION(title))
        );
    }

    @Given("Vendor navigate to {string} by sidebar")
    public void vendor_navigateTo(String title) {
        theActorInTheSpotlight().attemptsTo(
                VendorDashboardTask.navigate(title, VendorDashboardPage.OPTION(title))
        );
    }

    @And("{word} Navigate to Dashboard")
    public void navigateToDashboard(String actor) {
        theActorCalled(actor).attemptsTo(
                VendorDashboardTask.navigate(null, VendorDashboardPage.DASHBOARD),
                CommonWaitUntil.isVisible(ORDERS)
        );
    }

    @And("Create an new Brand")
    public void create_an_new_brand(CreateNewBrand infos) {
        Serenity.setSessionVariable("brandName").to(infos.getName());
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.create(infos),
                WindowTask.threadSleep(2000)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorDetailBrandDashboardPage.BRAND_NAME), equalTo(infos.getName())),
                seeThat(CommonQuestions.targetText(VendorDetailBrandDashboardPage.BRAND_CITY), equalTo(infos.getCity())),
                seeThat(CommonQuestions.targetText(VendorDetailBrandDashboardPage.BRAND_STATE), equalTo(infos.getStage())),
                seeThat(CommonQuestions.targetText(VendorDetailBrandDashboardPage.BRAND_COUNTRY), equalTo(infos.getCountry())),
                seeThat(CommonQuestions.targetText(VendorDetailBrandDashboardPage.BRAND_DESCRIPTION), equalTo(infos.getDescription()))

        );
    }

    @And("Vendor go to all brands page")
    public void goToAllBrandsPage() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorDashboardPage.allBrands),
                CommonWaitUntil.isVisible(VendorDashboardPage.allBrandsTitle)
        );
    }

    @And("Vendor search products with brand just created")
    public void vendor_search_brand() {
        String brandName = Serenity.sessionVariableCalled("brandName").toString();
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("product", brandName)
//                Enter.keyValues(brandName).into(VendorDashboardPage.SEARCH_BOX).thenHit(Keys.ENTER),
//                CommonWaitUntil.isNotVisible(VendorDashboardPage.BRANDS_GRID)
        );
    }

    @And("Vendor search brand on catalog")
    public void vendor_search_brand_catalog(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Enter.keyValues(list.get(0).get("brandName")).into(HomePageForm.SEARCH_FIELD),
                CommonWaitUntil.isVisible(HomePageForm.TYPE_SEARCH_BRAND),
                Click.on(HomePageForm.TYPE_SEARCH_BRAND),
                CommonWaitUntil.isNotVisible(VendorDashboardPage.BRANDS_GRID)
//                CommonWaitUntil.isPresent(VendorCatalogPage.brandName(list.get(0).get("brandName")))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(VendorCatalogPage.BRANDS_NAME(list.get(0).get("brandName")))),
                seeThat(CommonQuestions.targetText(VendorCatalogPage.BRANDS_ADDRESS), equalToIgnoringCase(list.get(0).get("city") + ", " + list.get(0).get("state")))
        );
    }

    @And("Vendor search product {string} on catalog")
    public void vendor_search_product_catalog(String item) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(HomePageForm.SEARCH_FIELD),
                Enter.theValue(item).into(HomePageForm.SEARCH_FIELD).thenHit(Keys.ENTER)
        );
    }

    @And("Vendor Go to product detail")
    public void vendorGoToProductDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCatalogPage.PRODUCT_NAME(list.get(0).get("productName"))),
                MoveMouse.to(VendorCatalogPage.PRODUCT_NAME(list.get(0).get("productName"))),
                WindowTask.threadSleep(500),
                Click.on(VendorCatalogPage.PRODUCT_NAME(list.get(0).get("productName"))),
                CommonWaitUntil.isNotVisible(VendorDetailBrandCatalogPage.LOADING_PRODUCT)
        );
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorProductDetailPage.PRODUCT_NAME).text().contains(list.get(0).get("productName")),
                Ensure.that(VendorProductDetailPage.UNIT_DIMENSIONS).text().isEqualTo(list.get(0).get("unitDimension")),
                Ensure.that(VendorProductDetailPage.CASE_DIMENSIONS).text().isEqualTo(list.get(0).get("caseDimension")),
                Ensure.that(VendorProductDetailPage.UNIT_SIZE).text().isEqualTo(list.get(0).get("unitSize")),
                Ensure.that(VendorProductDetailPage.CASE_PACK).text().isEqualTo(list.get(0).get("casePack"))
        );
        if (list.get(0).containsKey("minOrder")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.MIN_ORDER_QTY).text().isEqualTo(list.get(0).get("minOrder"))
            );
        }
    }

    @And("Vendor check product detail")
    public void vendorCheckProductDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorProductDetailPage.PRODUCT_NAME),
                Ensure.that(VendorProductDetailPage.PRODUCT_NAME).text().contains(list.get(0).get("productName")));

        if (list.get(0).containsKey("casePack")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.CASE_PACK).text().isEqualTo(list.get(0).get("casePack"))
            );
        }
        if (list.get(0).containsKey("unitDimension")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.UNIT_DIMENSIONS).text().isEqualTo(list.get(0).get("unitDimension"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.UNIT_DIMENSIONS).isNotDisplayed()
            );
        }
        if (list.get(0).containsKey("caseDimension")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.CASE_DIMENSIONS).text().isEqualTo(list.get(0).get("caseDimension"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.CASE_DIMENSIONS).isNotDisplayed()
            );
        }
        if (list.get(0).containsKey("unitSize")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.UNIT_SIZE).text().isEqualTo(list.get(0).get("unitSize"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.UNIT_SIZE).isNotDisplayed()
            );
        }
        if (list.get(0).containsKey("minOrder")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.MIN_ORDER_QTY).text().isEqualTo(list.get(0).get("minOrder"))
            );
        }
        if (list.get(0).containsKey("unitUPC")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.UNIT_UPC).text().contains(list.get(0).get("unitUPC"))
            );
        }
    }

    @And("Vendor check master image info")
    public void vendorCheckMasterImage(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(1000),
                Ensure.that(VendorProductDetailPage.MASTER_IMAGE).attribute("style").contains(list.get(0).get("masterImage")),
                Ensure.that(VendorProductDetailPage.MASTER_IMAGE_SKU_NAME).text().contains(list.get(0).get("skuName")),
                Ensure.that(VendorProductDetailPage.MASTER_IMAGE_SKU_NUMBER).text().contains(list.get(0).get("numberSKU"))
        );
    }

    @And("Vendor copy link share product")
    public void vendorShareProduct() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorProductDetailPage.COPY_ICON),
                Click.on(VendorProductDetailPage.COPY_ICON),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("Link copied!"))
        );
    }

    @And("Vendor check copy link share product")
    public void vendorShareProduct2() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CommonHandle.getStringOnClipboard()).contains(CommonHandle.getCurrentURL())
        );
    }

    @And("{word} check tags of sku on catalog")
    public void vendorCheckTags(String actor, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.SKU_TAG(i + 1)).text().contains(list.get(i).get("tag"))
            );
        }
    }

    @And("Vendor check available in of sku on catalog")
    public void vendorCheckTagsRegion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.SKU_TAG_AVAILABLE(i + 1)).text().contains(list.get(i).get("region"))
            );
        }
    }

    @And("{word} click {string} from list SKU on Product detail catalog")
    public void vendorNextSKU(String actor, String action) {
        if (action.equals("next"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorProductDetailPage.LIST_SKU_BUTTON_NEXT),
                    Click.on(VendorProductDetailPage.LIST_SKU_BUTTON_NEXT)
            );
        else
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorProductDetailPage.LIST_SKU_BUTTON_PREVIOUS),
                    Click.on(VendorProductDetailPage.LIST_SKU_BUTTON_PREVIOUS)
            );
    }

    @And("Vendor check regions detail")
    public void check_region_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorProductDetailPage.REGION_INFO(list.get(i).get("region"), "price")), containsString(list.get(i).get("price"))),
                    seeThat(CommonQuestions.targetText(VendorProductDetailPage.REGION_INFO(list.get(i).get("region"), "case-price")), containsString(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(VendorProductDetailPage.REGION_INFO(list.get(i).get("region"), "msrp")), containsString(list.get(i).get("msrp"))),
                    seeThat(CommonQuestions.targetText(VendorProductDetailPage.REGION_INFO(list.get(i).get("region"), "pd-availability")), containsString(list.get(i).get("availability")))
            );
            if (!list.get(i).get("moq").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(VendorProductDetailPage.REGION_INFO(list.get(i).get("region"), "moq")), containsString(list.get(i).get("moq")))
                );
            }
            if (list.get(i).containsKey("margin")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(VendorProductDetailPage.REGION_INFO(list.get(i).get("region"), "margin")), containsString(list.get(i).get("margin")))
                );
            }
        }
    }

    @And("and check details information")
    public void check_details_information(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorProductDetailPage.TAP_PRODUCT_DETAIL),
                Click.on(VendorProductDetailPage.TAP_PRODUCT_DETAIL),
                CommonWaitUntil.isVisible(VendorProductDetailPage.BRAND_LOCATION),
                Ensure.that(VendorProductDetailPage.BRAND_LOCATION).text().isEqualTo(list.get(0).get("brandLocation")),
                Ensure.that(VendorProductDetailPage.STORAGE_SELF_LIFE).text().isEqualTo(list.get(0).get("storage")),
                Ensure.that(VendorProductDetailPage.RETAIL_SELF_LIFE).text().isEqualTo(list.get(0).get("retail")),
                Ensure.that(VendorProductDetailPage.INGREDIENTS).text().isEqualTo(list.get(0).get("ingredients"))
        );
        if (list.get(0).containsKey("temperatureRequirements")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.TEMPERATURER_EQUIREMENTS).text().isEqualTo(list.get(0).get("temperatureRequirements"))
            );
        }
    }

    @And("and check product description")
    public void check_product_description(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorProductDetailPage.TAP_PRODUCT_DESCRIPTION),
                Click.on(VendorProductDetailPage.TAP_PRODUCT_DESCRIPTION),
                CommonWaitUntil.isVisible(VendorProductDetailPage.PRODUCT_DESCRIPTION),
                Ensure.that(VendorProductDetailPage.PRODUCT_DESCRIPTION).text().isEqualTo(list.get(0).get("description"))
        );
    }

    @And("and product qualities")
    public void andProductQuantity(List<String> qualities) {
        List<WebElementFacade> list = VendorProductDetailPage.PRODUCT_QUALITIES.resolveAllFor(theActorInTheSpotlight());
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.webElementFacadeText(list.get(i)), equalToIgnoringCase(qualities.get(i)))
            );
        }

    }

    @And("Check nutrition labels")
    public void check_nutrition_labels(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorProductDetailPage.NUTRITION_IMAGE).attribute("style").contains(map.get("image")),
                    Scroll.to(VendorProductDetailPage.NUTRITION_IMAGE),
                    CommonTask.swipeTarget(VendorProductDetailPage.NUTRITION_IMAGE, VendorProductDetailPage.RETAIL_SELF_LIFE),
                    WindowTask.threadSleep(1000)
            );
        }
    }

    @And("Go to request information change")
    public void go_to_request_information_change() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.REQUEST_INFO_CHANGE),
                Click.on(VendorCreateNewSKUPage.REQUEST_INFO_CHANGE)
        );
    }

    @And("Change info of SKU {string}")
    public void change_info_of_SKU(String nameSKU, DataTable data) {
        List<Map<String, String>> list = data.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorCreateNewSKUPage.SKU_IN_REQUEST_CHANGE(nameSKU)),
                HandleVendorProduct.changeInfoSKU(list.get(0))
        );
    }

    @And("Search {word} in dashboard by name {string}")
    public void search_on_dashboard(String typeSearch, String searchValue) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(typeSearch.equalsIgnoreCase("Brands"))
                        .andIfSo(
                                CommonTask.chooseItemInDropdown(CatalogForm.TYPE_SEARCH_BUTTON, CatalogForm.TYPE_SEARCH(typeSearch)))
                        .otherwise(CommonTask.chooseItemInDropdown(CatalogForm.TYPE_SEARCH_BUTTON, CatalogForm.TYPE_SEARCH("Products"))),
                Enter.theValue(searchValue).into(CatalogForm.SEARCH_TEXTBOX),
                Click.on(CatalogForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(VendorCatalogPage.PRODUCTS_GRID)
        );
    }

    @And("Vendor see product detail name {string}")
    public void see_to_product_detail_by_name(String productName) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorProductForm.PREVIEW_PRODUCT_BY_NAME(productName))
        );
    }

    @And("Check no result found")
    public void checkNoResult() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(VendorCatalogPage.NO_RESULTS_FOUND))
        );
    }

    @And("Vendor Check Brand on Dashboard")
    public void vendor_check_brand_on_dashboard(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDashboardPage.NEW_BRAND_BUTTON),
                // Verify info
                Ensure.that(VendorDashboardPage.DASH_BRAND_NAME(list.get(0).get("brandName"))).isDisplayed(),
                Check.whether(list.get(0).get("city").equals(""))
                        .otherwise(Ensure.that(VendorDashboardPage.DASH_BRAND_ADDRESS(list.get(0).get("brandName"))).text().contains(list.get(0).get("city"))),
                Check.whether(list.get(0).get("description").equals(""))
                        .otherwise(Ensure.that(VendorDashboardPage.DASH_BRAND_DESCRIPTION(list.get(0).get("brandName"))).text().contains(list.get(0).get("description")))
        );
    }

    @And("Vendor check brand on Dashboard is not visible")
    public void vendor_check_brand_on_dashboard_is_not_visible(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDashboardPage.NEW_BRAND_BUTTON),
                // Verify info
                Ensure.that(VendorDashboardPage.DASH_BRAND_NAME(list.get(0).get("brandName"))).isNotDisplayed()
        );
    }

    @And("Vendor check brand in detail")
    public void vendor_check_brand_in_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(DASH_BRAND_NAME(list.get(0).get("brandName"))),
                CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.BUTTON_REMOVE),
                // Verify info
                Ensure.that(VendorDetailBrandDashboardPage.BRAND_NAME).text().contains(list.get(0).get("brandName")),
                Check.whether(list.get(0).get("city").equals(""))
                        .otherwise(Ensure.that(VendorDetailBrandDashboardPage.BRAND_CITY).text().contains(list.get(0).get("city"))),
                Check.whether(list.get(0).get("state").equals(""))
                        .otherwise(Ensure.that(VendorDetailBrandDashboardPage.BRAND_STATE).text().contains(list.get(0).get("state"))),
                Check.whether(list.get(0).get("country").equals(""))
                        .otherwise(Ensure.that(VendorDetailBrandDashboardPage.BRAND_COUNTRY).text().contains(list.get(0).get("country"))),
                Check.whether(list.get(0).get("description").equals(""))
                        .otherwise(Ensure.that(VendorDetailBrandDashboardPage.BRAND_DESCRIPTION).text().contains(list.get(0).get("description")))
        );
    }

    @And("Vendor clear field {string}")
    public void adminClearField(String field) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT(field)),
                Clear.field(CommonVendorPage.DYNAMIC_INPUT(field)).then(
                        Click.on(CommonVendorPage.DYNAMIC_INPUT(field))
                ),
                Enter.theValue("1").into(CommonVendorPage.DYNAMIC_INPUT(field)).thenHit(Keys.BACK_SPACE).thenHit(Keys.TAB),
                Click.on(CommonVendorPage.DYNAMIC_INPUT(field))
        );
    }

    @And("{string} go to breadcrumb navigation title {string}")
    public void checkBreadCrumb(String actor, String title) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorProductDetailPage.BREADCRUMB(title)),
                Click.on(VendorProductDetailPage.BREADCRUMB(title)),
                WindowTask.threadSleep(1000)
        );
    }

    @And("{word} go back by browser")
    public void admin_go_back_by_browser(String actor) {
        theActorInTheSpotlight().attemptsTo(
                GoBack.theBrowser()
        );
    }

    @And("Check any text {string} showing on screen")
    public void checkShowing(String type, List<String> texts) {
        for (String text : texts) {
            if (type.contains("is")) {
                if (type.contains("date")) {
                    theActorInTheSpotlight().attemptsTo(
                            CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(CommonHandle.setDate2(text, "MM/dd/yy")))
                    );
                } else
                    theActorInTheSpotlight().attemptsTo(
                            CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(text))
                    );
            } else
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(text))
                );
        }
    }

    @And("Check text {string} showing on screen")
    public void checkTextShowing(String type, List<String> texts) {
        for (String text : texts) {
            if (type.contains("is")) {
                if (type.contains("date")) {
                    theActorInTheSpotlight().attemptsTo(
                            CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT(CommonHandle.setDate2(text, "MM/dd/yy")))
                    );
                } else
                    theActorInTheSpotlight().attemptsTo(
                            CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT(text))
                    );
            } else
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_ANY_TEXT(text))
                );
        }
    }

    @And("Check any button {string} showing on screen")
    public void checkButtonShowing(String type, List<String> texts) {
        for (String text : texts) {
            if (type.contains("is")) {
                if (type.contains("date")) {
                    theActorInTheSpotlight().attemptsTo(
                            CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON2(CommonHandle.setDate2(text, "MM/dd/yy")))
                    );
                } else
                    theActorInTheSpotlight().attemptsTo(
                            CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON2(text))
                    );
            } else
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_BUTTON2(text))
                );
        }
    }

    @And("Hover on any text on screen")
    public void checkShowing(String text) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT(text)),
                MoveMouse.to(CommonVendorPage.DYNAMIC_ANY_TEXT(text)),
                WindowTask.threadSleep(500)
        );
    }

    @And("Click on button {string}")
    public void clickButton(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON(type)),
                Scroll.to(CommonVendorPage.DYNAMIC_BUTTON(type)),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON(type)));
    }

    @And("Click on any text {string}")
    public void clickAnyText(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(type)),
                Click.on(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(type))
        );
    }

    @And("Switch to tab by title {string}")
    public void switchToTab(String title) {
        theActorInTheSpotlight().attemptsTo(
//                CommonWaitUntil.waitToLoadingNewWindow(title),
                WindowTask.switchToChildWindowsByTitle(title)
        );
    }

    @And("Switch to default tab")
    public void switchToDefaultTab() {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.switchToDefaultWindow()
        );
    }

    @And("Verify URL of current site")
    public void verifyURL(String url) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.thatTheCurrentPage().currentUrl().containsIgnoringCase(url)
        );
    }

    @And("Click on dialog button {string}")
    public void dialogButton(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(type)),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(type))
        );
    }

    @And("Scroll to dialog button {string}")
    public void scrollDialogButton(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(type)),
                Scroll.to(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(type))
        );
    }

    @And("Click on tooltip button {string}")
    public void tooltipButton(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP(type)),
                JavaScriptClick.on(CommonAdminForm.D_BUTTON_TOOLTIP(type))
        );
    }

    @And("Check button {string} is {word}")
    public void checkButton(String button, String type) {
        if (type.contains("disable"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON2(button)),
                    Check.whether(CommonQuestions.AskForAttributeContainText(CommonVendorPage.DYNAMIC_BUTTON2(button), "class", "disabled")).andIfSo(
                            Ensure.that(CommonVendorPage.DYNAMIC_BUTTON2(button)).attribute("class").contains("disabled")
                    ).otherwise(
                            Ensure.that(CommonVendorPage.DYNAMIC_BUTTON2(button)).isDisabled()
                    )

            );
        else theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON2(button)),
                Ensure.that(CommonVendorPage.DYNAMIC_BUTTON2(button)).isEnabled()
        );
    }

    @And("Check field {string} is {word}")
    public void checkField(String field, String type) {
        switch (type) {
            case "disabled":
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT(field)),
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT(field)).isDisabled()
                );
                break;
            case "visible":
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT(field))
                );
                break;
            case "invisible":
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_INPUT(field))
                );
                break;
            case "enable":
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT(field)),
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT(field)).isEnabled()
                );
                break;
            default:
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT(field)),
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT(field)).isDisabled()
                );
        }
    }

    @And("Check text area {string} is {word}")
    public void checkArea(String field, String type) {
        if (type.contains("disabled"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_TEXT_AREA2(field)),
                    Ensure.that(CommonVendorPage.DYNAMIC_TEXT_AREA2(field)).isDisabled()
            );
        else theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_TEXT_AREA2(field)),
                Ensure.that(CommonVendorPage.DYNAMIC_TEXT_AREA2(field)).isEnabled()
        );
    }

    @And("Check current URL")
    public void checkURL(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.waitToLoadingNewWindow3(list.get(0).get("title")),
                Ensure.that(CommonHandle.getCurrentURL()).contains(list.get(0).get("url")));
    }

}
