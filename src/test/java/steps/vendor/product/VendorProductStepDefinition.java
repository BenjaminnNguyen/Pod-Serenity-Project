package steps.vendor.product;

import io.cucumber.java.en.*;
import cucumber.constants.vendor.WebsiteConstants;
import cucumber.questions.CommonQuestions;
import cucumber.singleton.GVs;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.tasks.vendor.HandleVendorProduct;
import cucumber.tasks.vendor.HandleVendorSKU;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.User_Header;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.VendorDashboardPage;
import cucumber.user_interface.beta.Vendor.products.*;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.ui.Link;
import org.openqa.selenium.Keys;

import java.util.*;

import static cucumber.constants.vendor.WebsiteConstants.*;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActor;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;
import static org.hamcrest.Matchers.*;

public class VendorProductStepDefinition {

    @And("Vendor check product {string} on list")
    public void vendor_check_product_on_list(String show, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (show.equalsIgnoreCase("Show")) {
            for (Map<String, String> map : list) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(VendorProductForm.DYNAMIC_PRODUCT_INFO(map.get("product"), "brand")), containsString(map.get("brand"))),
                        seeThat(CommonQuestions.targetText(VendorProductForm.DYNAMIC_PRODUCT_INFO(map.get("product"), "department")), containsString(map.get("department")))
                );
                if (map.containsKey("image")) {
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(VendorProductForm.DYNAMIC_PRODUCT_IMAGE(map.get("product")), "style"), containsString(map.get("image")))
                    );
                }
            }

        } else
            for (Map<String, String> map : list)
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlUnDisplay(VendorProductForm.DYNAMIC_PRODUCT_INFO(map.get("product"), "brand"))),
                        seeThat(CommonQuestions.isControlUnDisplay(VendorProductForm.DYNAMIC_PRODUCT_INFO(map.get("product"), "department")))
                );
    }

    @And("Vendor check product Packaging detail on dashboard")
    public void vendor_check_product_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.PRODUCT_TITLE), containsString(map.get("product"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_TEXTBOX("Unit length")), containsString(map.get("unitLength"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_TEXTBOX("Unit width")), containsString(map.get("unitWidth"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_TEXTBOX("Unit height")), containsString(map.get("unitHeight"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Case length")), containsString(map.get("caseLength"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Case width")), containsString(map.get("caseWidth"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Case height")), containsString(map.get("caseHeight"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Case Weight")), containsString(map.get("caseWeight"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_TEXTBOX("Package size")), containsString(map.get("packageSize"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_TEXTBOX("Unit Size")), containsString(map.get("unitSize"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Unit")), containsString(map.get("unit")))
            );
    }

    @And("Vendor check Packaging and size {word}")
    public void vendor_check_size_detail(String status) {
        if (status.equalsIgnoreCase("disabled"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(VendorCreateProductPage.D_TEXTBOX2("Unit length"), "class"), containsString("is-disabled")),
                    seeThat(CommonQuestions.attributeText(VendorCreateProductPage.D_TEXTBOX2("Unit width"), "class"), containsString("is-disabled")),
                    seeThat(CommonQuestions.attributeText(VendorCreateProductPage.D_TEXTBOX2("Unit height"), "class"), containsString("is-disabled"))
            );
        else
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isDisabled(VendorCreateProductPage.D_TEXTBOX2("Unit length")), equalTo(false)),
                    seeThat(CommonQuestions.isDisabled(VendorCreateProductPage.D_TEXTBOX2("Unit width")), equalTo(false)),
                    seeThat(CommonQuestions.isDisabled(VendorCreateProductPage.D_TEXTBOX2("Unit height")), equalTo(false))
            );
    }

    @And("Vendor check status of field")
    public void vendor_check_size_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (map.get("status").equalsIgnoreCase("disabled"))
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.attributeText(VendorCreateProductPage.D_TEXTBOX(map.get("field")), "disabled"), containsString("true")),
                        seeThat(CommonQuestions.attributeText(VendorCreateProductPage.D_TEXTBOX(map.get("field")), "disabled"), containsString("true")),
                        seeThat(CommonQuestions.attributeText(VendorCreateProductPage.D_TEXTBOX(map.get("field")), "disabled"), containsString("true"))
                );
            else
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isDisabled(VendorCreateProductPage.D_TEXTBOX(map.get("field"))), equalTo(false)),
                        seeThat(CommonQuestions.isDisabled(VendorCreateProductPage.D_TEXTBOX(map.get("field"))), equalTo(false)),
                        seeThat(CommonQuestions.isDisabled(VendorCreateProductPage.D_TEXTBOX(map.get("field"))), equalTo(false))
                );
        }

    }

    @And("Vendor check product Organization detail on dashboard")
    public void vendor_check_o_product_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.DYNAMIC_FIELD("Brand")), equalToIgnoringCase(map.get("brand"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.DYNAMIC_FIELD("Category")), equalToIgnoringCase(map.get("category"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.DYNAMIC_FIELD("Product type")), equalToIgnoringCase(map.get("type"))),
                    seeThat(CommonQuestions.attributeText(VendorCreateProductPage.REQUEST_SAMPLE_LABEL, "class"), containsString(map.get("allowSampleRequest")))
            );
            if (map.containsKey("container")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetValue(VendorCreateProductPage.DYNAMIC_FIELD("Container Type")), equalToIgnoringCase(map.get("container")))
                );
            }
            if (map.containsKey("isBeverage")) {
                if (map.get("isBeverage").contains("Yes"))
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(VendorCreateProductPage.IS_BEVERAGE("Yes"), "class"), containsString("is-checked"))
                    );
            }
        }

    }

    @And("Vendor check {int} number record on pagination")
    public void vendor_check_pagination_product(Integer num) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.getNumElement(CommonVendorPage.RECORD), equalTo(num))
        );
    }

    @And("Vendor click {string} on pagination")
    public void vendor_click_pagination(String page) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(valueOf(CommonVendorPage.PAGE(page)), isCurrentlyVisible())
                        .andIfSo(
                                Scroll.to(CommonVendorPage.PAGE(page)),
                                Click.on(page.contains("next") ? CommonVendorPage.ARROW_RIGHT : page.contains("back") ? CommonVendorPage.ARROW_LEFT : CommonVendorPage.PAGE(page)),
                                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your"))
                        )
        );
    }

    @And("Vendor check product Pallet Configuration detail on dashboard")
    public void vendor_check_p_product_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.CASES_PER_PALLET), equalToIgnoringCase(map.get("casePerPallet"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.CASES_PER_LAYER), equalToIgnoringCase(map.get("casePerLayer"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.LAYERS_PER_FULL_PALLET_FIELD), equalToIgnoringCase(map.get("layerFullPallet")))
            );
        theActorInTheSpotlight().attemptsTo(
                Scroll.to(CommonVendorPage.DYNAMIC_ANY_TEXT("What is a pallet and master carton?")),
                Click.on(CommonVendorPage.DYNAMIC_ANY_TEXT("What is a pallet and master carton?")),
                WindowTask.threadSleep(500),
                Ensure.that(VendorCreateProductPage.INSTRUCTION_IMG).isDisplayed()
//                ,
//                Click.on(CommonVendorPage.DYNAMIC_ANY_TEXT("What is a pallet and master carton?")),
//                CommonWaitUntil.isNotVisible(VendorCreateProductPage.INSTRUCTION_IMG)
        );
    }

    @And("Vendor check product Master Case Configuration detail on dashboard")
    public void vendor_check_m_product_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Master Cartons per Pallet")), equalToIgnoringCase(map.get("masterCartonsPerPallet"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Cases per Master Carton")), equalToIgnoringCase(map.get("casesPerMasterCarton"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Master carton length")), equalToIgnoringCase(map.get("masterCartonLength"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Master carton width")), equalToIgnoringCase(map.get("masterCartonWidth"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Master carton height")), equalToIgnoringCase(map.get("masterCartonHeight"))),
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_2_TEXTBOX("Master carton Weight")), equalToIgnoringCase(map.get("masterCartonWeight")))
            );
    }

    @And("Vendor check Disclaimer {string} on product detail")
    public void vendor_check_disclaimer_product_detail(String show) {
        if (show.equalsIgnoreCase("show"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT(DISCLAIMER1))),
                    seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT(DISCLAIMER2)))
            );
        else
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlUnDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT(DISCLAIMER1))),
                    seeThat(CommonQuestions.isControlUnDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT(DISCLAIMER2)))
            );
    }

    @And("Vendor check Bottle Deposit product detail on dashboard")
    public void vendor_check_b_product_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_FIELD2("Bottle Deposit", i + 1)), equalToIgnoringCase(list.get(i).get("bottle"))),
                    seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_FIELD2("Bottle Deposit per unit (cents)", i + 1)), equalToIgnoringCase(list.get(i).get("perUnit")))
            );
    }

    @And("Vendor check product MOQs detail on dashboard")
    public void vendor_check_moq_product_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.MOQ_FIELD(map.get("region"))), equalToIgnoringCase(map.get("value")))
            );
    }

    @And("Vendor check SKUs on product detail with {string} active and {string} draft")
    public void vendor_check_SKU_product_detail(String active, String draft, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorCreateProductPage.NUMBER_SKUs).text().contains(active + " active, " + draft + " draft")
        );
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("image").isEmpty())
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.IMAGE_SKU_BEFORE(i + 1)).isNotDisplayed()
                );
            else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.IMAGE_SKU_BEFORE(i + 1)).attribute("style").contains(list.get(i).get("image"))
                );
        }
    }

    @And("Vendor check message on Dashboard product")
    public void vendorCheckMessage() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT(WebsiteConstants.MESSAGE_DASHBOARD_PRODUCT))
        );
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonVendorPage.DYNAMIC_ANY_TEXT(" See more..."))
        );
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT(WebsiteConstants.MESSAGE_DASHBOARD_PRODUCT2))
        );
    }

    @And("Vendor export summary product")
    public void exportSummary() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Summary Export")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Summary Export")),
                WindowTask.threadSleep(3000)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonFile.isFileDownloaded("Pod_Foods_products_" + Utility.getTimeNow("MMddyyyy") + ".csv"))
        );
    }

    @And("Vendor delete file export summary product")
    public void deleteExportSummary() {
        theActorInTheSpotlight().attemptsTo(
                CommonFile.deleteFileToDownload("Pod_Foods_products_" + Utility.getTimeNow("MMddyyyy") + ".csv")
        );
    }

    @And("Vendor check file export summary product")
    public void checkExportSummary(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        List<String[]> list2 = new ArrayList<>();
        for (Map<String, String> e : list) {
            Collection<String> values = e.values();
            String[] targetArray = values.toArray(new String[0]);
            list2.add(targetArray);
        }
        CommonFile.readDataLineByLine(System.getProperty("user.dir") + "/target/Pod_Foods_products_" + Utility.getTimeNow("MMddyyyy") + ".csv");
//        Object[] objectArray = list.get(0).entrySet().toArray();
//        List<String[]> list3 = Serenity.sessionVariableCalled("CSV File");

    }

    @And("Check file CSV exported {string}")
    public void checkExportCSV(String fileName, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (fileName.equalsIgnoreCase("download")) {
            fileName = System.getProperty("user.dir") + "/target/Pod_Foods_products_" + Utility.getTimeNow("MMddyyyy") + ".csv";
        } else fileName = "src/test/resources/files/data/" + fileName;
        //Doc file
        List<String[]> list2 = CommonFile.readDataLineByLine(fileName);
        List<String[]> list3 = new ArrayList<>();
        //add first row in data table
        list3.add(table.row(0).toArray(new String[0]));
        for (Map<String, String> e : list) {
            Collection<String> values = e.values();
            String[] targetArray = values.toArray(new String[0]);
            list3.add(targetArray);
        }
        for (String[] row : list2) {
            for (String cell : row) {
                System.out.print(cell + "\t");
            }
            System.out.println();
        }

        for (String[] row : list3) {
            for (String cell : row) {
                System.out.print(cell + "\t");
            }
            System.out.println();
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.AskForEqualValue(list2, list3))
        );
    }

    @And("{word} Create an new Product Success")
    public void create_an_new_product(String actor, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActor(actor).attemptsTo(
                HandleVendorProduct.inputName(list.get(0)),
                HandleVendorProduct.inputOrganization(list.get(0)));
        if (list.get(0).containsKey("isBeverage"))
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorProduct.isBeverage(list.get(0))
            );
        theActorInTheSpotlight().attemptsTo(
                HandleVendorProduct.inputPackagingSize(list.get(0)),
                HandleVendorProduct.inputPalletConfiguration(list.get(0)),
                HandleVendorProduct.inputMasterCaseConfiguration(list.get(0))
//                HandleVendorProduct.clickCreate()
        );
//        if (list.get(0).containsKey("allowSample"))
//            theActorInTheSpotlight().attemptsTo(
//                    HandleVendorProduct.allowSample(list.get(0).get("allowSample"))
//            );

    }

    @And("Vendor edit field on Product detail")
    public void edit_product(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorProduct.editField(map)
            );
    }

    @And("Vendor upload Master case photo")
    public void uploadMasterCasePhoto(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorProduct.uploadCasePhoto(map)
            );
    }

    @And("Vendor check Master carton photo")
    public void checkMasterCasePhoto(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCreateProductPage.MASTER_CARTON_PHOTO(i + 1)).text().contains(list.get(i).get("photo"))
            );
    }

    @And("Vendor check Case pack photo")
    public void checkCasePackPhoto(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCreateProductPage.CASE_PACK_PHOTO(i + 1)).text().contains(list.get(i).get("photo"))
            );
    }

    @And("Vendor confirm {word} new Product")
    public void create_an_new_product(String action) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorProduct.clickCreate(action)
        );
//        WebDriver driver = BrowseTheWeb.as(theActorInTheSpotlight()).getDriver();
//        String[] link = driver.getCurrentUrl().split("products/");
//        String id = link[link.length - 1].replaceAll("/", "");
//        Serenity.setSessionVariable("product_id").to(id);
    }

    @And("Vendor preview Product {string}")
    public void preview_product(String product) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorProductForm.PREVIEW_PRODUCT_BY_NAME(product)),
                Click.on(VendorProductForm.PREVIEW_PRODUCT_BY_NAME(product)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Loading product..."))
        );
    }

    @And("Vendor add Bottle Deposits")
    public void add_bottle(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorProduct.addBottleDeposits(map)
            );
    }

    @And("Vendor add Bottle Deposits Label")
    public void add_bottle_label(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateProductPage.BOTTLE_DEPOSIT_LABEL_HELP),
                MoveMouse.to(VendorCreateProductPage.BOTTLE_DEPOSIT_LABEL_HELP),
                CommonWaitUntil.isVisible(VendorCreateProductPage.BOTTLE_DEPOSIT_LABEL_IMAGE),
                CommonFile.upload(list.get(0).get("file").toString(), VendorCreateProductPage.BOTTLE_DEPOSIT_LABEL)
        );
    }

    @And("Vendor delete Bottle Deposits {int}")
    public void delete_bottle(Integer i) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorProduct.deleteBottleDeposits(i)
        );
    }

    @And("Vendor {string} duplicate with images of Product {string}")
    public void duplicate_product(String action, String product) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorProductForm.DUPLICATE_PRODUCT_BY_NAME(product)),
                Click.on(VendorProductForm.DUPLICATE_PRODUCT_BY_NAME(product)),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_MESSAGE).text().containsIgnoringCase(DUPLICATE_PRODUCT),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action))
        );
        if (!action.equalsIgnoreCase("Cancel"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT("A duplicate is successfully created."), 60)
            );
    }

    @And("Vendor click {string} delete Product {string} on {string}")
    public void delete_product(String action, String product, String where) {
        if (where.contains("list")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorProductForm.DELETE_PRODUCT_BY_NAME(product)),
                    Click.on(VendorProductForm.DELETE_PRODUCT_BY_NAME(product)),
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                    Ensure.that(CommonVendorPage.DYNAMIC_P_ALERT("Are you sure you want to remove this product?")).isDisplayed(),
                    Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                    CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action))
            );
        }
        if (where.contains("detail")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorProductForm.PRODUCT_NAME(product)),
                    Click.on(VendorProductForm.PRODUCT_NAME(product)),
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON2("Remove")),
                    Click.on(CommonVendorPage.DYNAMIC_BUTTON2("Remove")),
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                    Ensure.that(CommonVendorPage.DYNAMIC_P_ALERT("Are you sure you want to remove this product?")).isDisplayed(),
                    Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                    CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action))
            );
        }
        if (!action.equalsIgnoreCase("Cancel"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT("Product deleted successfully."))
            );
    }

    @And("{word} check page missing")
    public void checkPageMissing(String actor) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("Uh-oh...")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("Look like this page is missing..."))
        );
    }

    @And("{word} check alert message")
    public void checkAlertMessage(String actor, String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT(message)),
                CommonWaitUntil.isNotVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT(message)),
                WindowTask.threadSleep(1000)
        );
    }

    @And("{word} check alert message after {int} seconds")
    public void checkAlertMessage(String actor, Integer seconds, String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT(message), seconds),
                CommonWaitUntil.isNotVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT(message))
        );
    }

    @And("{word} wait button {string} visible after {int} seconds")
    public void waitButton(String actor, String button, Integer seconds) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON(button), seconds)
        );
    }

    @And("{word} wait button {string} not visible after {int} seconds")
    public void waitButtonNotVisible(String actor, String button, Integer seconds) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_BUTTON(button), seconds)
        );
    }

    @And("{word} check dialog message")
    public void checkDialogMessage(String actor, String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_TEXT(message))
        );
    }

    @And("Vendor check message {word} showing of fields when create product")
    public void checkMessage(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (type.equals("is")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).text().isEqualToIgnoringCase(map.get("message"))
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).isNotDisplayed()
                );
        }
    }

    @And("{word} check error message {word} showing of fields")
    public void checkErrorMessage(String actor, String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (type.equals("is")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).text().isEqualToIgnoringCase(map.get("message"))
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.DYNAMIC_TEXT_BOX_ERROR(map.get("field"))).isNotDisplayed()
                );
        }
    }

    @And("{word} check error message {word} showing of fields on dialog")
    public void checkErrorMessageDialog(String actor, String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (type.equals("is")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.DYNAMIC_TEXT_BOX_ERROR_LABEL(map.get("field"))).text().isEqualToIgnoringCase(map.get("message"))
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.DYNAMIC_TEXT_BOX_ERROR_LABEL(map.get("field"))).isNotDisplayed()
                );
        }
    }

    @And("{word} input invalid {string}")
    public void enter_invalid_buyer(String actor, String field, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTask.enterInvalidToDropdown2(VendorCreateProductPage.D_TEXTBOX(field), item.get("value")),
                    Click.on(VendorCreateProductPage.D_TEXTBOX(field))
            );
        }
    }

    @And("{word} Check place holder of field")
    public void place_holder(String actor, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateProductPage.D_TEXTBOX(item.get("field"))),
                    Ensure.that(VendorCreateProductPage.D_TEXTBOX(item.get("field"))).attribute("placeholder").isEqualToIgnoringCase(item.get("placeHolder"))
            );
        }
    }

    @And("{word} check input {string} is {string}")
    public void check_input(String actor, String field, String status) {
        if (status.contains("disable"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateProductPage.D_TEXTBOX(field)),
                    Ensure.that(VendorCreateProductPage.D_TEXTBOX(field)).isDisabled()
            );
        else theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateProductPage.D_TEXTBOX(field)),
                Ensure.that(VendorCreateProductPage.D_TEXTBOX(field)).isEnabled()
        );
    }

    @And("Vendor check message {word} showing of fields MOQs")
    public void checkMessageMOQ(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (type.equals("is")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.DYNAMIC_TEXT_BOX_ERROR_MOQ(map.get("field"))).text().isEqualToIgnoringCase(map.get("message"))
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateProductPage.DYNAMIC_TEXT_BOX_ERROR_MOQ(map.get("field"))).isNotDisplayed()
                );
        }
    }

    @And("Vendor {word} field number tooltip {int} times")
    public void checkFieldNumber(String type, int time, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (list.get(0).get("field").contains("Pod Direct")) {
            CommonTaskAdmin.changeTextboxNumberIncreaseDecreaseValue(VendorCreateProductPage.MOQ_FIELD(list.get(0).get("field")), type, time);
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.MOQ_FIELD(list.get(0).get("field"))), equalToIgnoringCase(list.get(0).get("text")))
            );
        } else {
            CommonTaskAdmin.changeTextboxNumberIncreaseDecreaseValue(VendorCreateProductPage.D_TEXTBOX(list.get(0).get("field")), type, time);
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorCreateProductPage.D_TEXTBOX(list.get(0).get("field"))), equalToIgnoringCase(list.get(0).get("text")))
            );
        }
    }

    @And("Vendor Clear field {string} when create product")
    public void adminClearField(String field) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCreateProductPage.D_TEXTBOX(field)),
                Scroll.to(VendorCreateProductPage.D_TEXTBOX(field)),
                CommonTask.clearFieldByEnterKey(VendorCreateProductPage.D_TEXTBOX(field)),
//                Enter.theValue(" ").into(VendorCreateProductPage.D_TEXTBOX(field)),
//                Click.on(VendorCreateProductPage.D_TEXTBOX(field)),
                Hit.the(Keys.TAB).keyIn(VendorCreateProductPage.D_TEXTBOX(field))
        );
    }

    @And("Vendor edit MOQs")
    public void editMOQ(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorProduct.editMOQ(map)
            );
    }

    @And("Vendor go to Create new Product")
    public void go_to_create_an_new_product() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDashboardPage.NEW_PRODUCT),
                Click.on(VendorDashboardPage.NEW_PRODUCT)
        );
    }

    @And("Vendor go to product detail just created")
    public void go_to_product_detail() {
        theActorInTheSpotlight().attemptsTo(
                Open.url(GVs.URL_BETA + "vendors/products/" + Serenity.sessionVariableCalled("product_id"))
        );
    }

    @And("Vendor go to product detail by {string}")
    public void go_to_product_detail_by_id(String id) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(id.isEmpty())
                        .andIfSo(Open.url(GVs.URL_BETA + "vendors/products/" + Serenity.sessionVariableCalled("product_id"))
                        )
                        .otherwise(Open.url(GVs.URL_BETA + "vendors/products/" + id)),
                WindowTask.threadSleep(2000),
                Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.I_ACCEPT),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                Click.on(HomePageForm.CLOSE_POPUP),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        )
        );
    }

    @And("Vendor go to product detail by name {string}")
    public void go_to_product_detail_by_name(String product) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.goToProductDetail(product)
        );
    }

    @And("Vendor go to dashboard brand detail by id: {string}")
    public void go_to_brand_detail_by_id(String id) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(id.isEmpty())
                        .andIfSo(Open.url(GVs.URL_BETA + "/vendors/brands/" + Serenity.sessionVariableCalled("brand_id")))
                        .otherwise(Open.url(GVs.URL_BETA + "/vendors/brands/" + id))
        );
    }

    @And("Vendor check Brand {string} is {string} on dashboard")
    public void checkBrandShowingDashboard(String name, String status) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(status.toUpperCase(Locale.ROOT).equals("SHOWING")).andIfSo(
                                CommonQuestions.AskForElementIsDisplay(VendorDashboardPage.BRAND_NAME(name), true))
                        .otherwise(
                                CommonQuestions.AskForElementIsDisplay(VendorDashboardPage.BRAND_NAME(name), false))

        );
    }

    @And("Vendor go back product detail")
    public void vendorBackToProductDetailFromSKUPage() {
        theActorInTheSpotlight().attemptsTo(
                Scroll.to(VendorCreateNewSKUPage.BACK),
                Click.on(VendorCreateNewSKUPage.BACK).afterWaitingUntilEnabled(),
                WindowTask.threadSleep(500)

        );
    }

    @And("Vendor check default SKUs tap with {string}")
    public void checkSKUsTap(String sku) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isClickAble(VendorCreateNewSKUPage.NEW_SKU_BUTTON)),
                seeThat(CommonQuestions.isClickAble(CommonVendorPage.DYNAMIC_BUTTON("Remove"))),
                seeThat(CommonQuestions.isClickAble(CommonVendorPage.DYNAMIC_BUTTON("Duplicate"))),
                seeThat(CommonQuestions.isClickAble(CommonVendorPage.DYNAMIC_ANY_TEXT("Request Product Change"))),
                seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT(SKU_DESCRIPTION)))
        );
        if (sku.contains("no published")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT(NO_SKU_PUBLISHED)))
            );
        }
        if (sku.contains("no draft")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT(NO_SKU_DRAFT)))
            );
        }
    }

    @And("Vendor check price Stock Availability of SKU {string}")
    public void check_price_Stock_AvailabilitySKUs(String sku, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.goToPriceAvailability(sku)
        );
        for (Map<String, String> map : list)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorProductDetailPage.DYNAMIC_REGION_SKU(map.get("region"), 1)), equalToIgnoringCase(map.get("availability"))),
                    seeThat(CommonQuestions.targetText(VendorProductDetailPage.DYNAMIC_REGION_SKU(map.get("region"), 2)), equalToIgnoringCase(map.get("wholesale"))),
                    seeThat(CommonQuestions.targetText(VendorProductDetailPage.DYNAMIC_REGION_SKU(map.get("region"), 3)), equalToIgnoringCase(map.get("unit")))
            );
    }

    @And("Vendor close popup")
    public void check_price_Stock_AvailabilitySKUs() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.D_DIALOG_CLOSE_BUTTON),
                Scroll.to(CommonVendorPage.D_DIALOG_CLOSE_BUTTON),
                Click.on(CommonVendorPage.D_DIALOG_CLOSE_BUTTON)
        );
    }

    @And("Vendor check Inventory of SKU")
    public void checkInventorySKUs(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            if (map.get("lotCode").isEmpty())
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT("No inventories found..."))),
                        seeThat(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_ANY_TEXT("We couldn't find any matches.")))
                );
            else
                theActorInTheSpotlight().should(
//                    seeThat(CommonQuestions.targetText(VendorProductDetailPage.DYNAMIC_REGION_SKU(map.get("lotCode"), 1)), containsString(map.get("lotCode"))),
                        seeThat(CommonQuestions.targetText(VendorProductDetailPage.DYNAMIC_REGION_SKU(map.get("lotCode"), 1)), containsString(map.get("comment"))),
                        seeThat(CommonQuestions.targetText(VendorProductDetailPage.DYNAMIC_REGION_SKU(map.get("lotCode"), 2)), containsString(map.get("quantity")))
                );
    }

    @And("Vendor go to Inventory of SKU {string}")
    public void checkInventorySKUs(String sku) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.gotoInventory(sku)
        );
    }

    @And("Vendor {string} duplicate with images of SKU {string}")
    public void duplicate_sku(String action, String sku) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.duplicateSKU(action, sku)
        );
        if (!action.equalsIgnoreCase("Cancel"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT(DUPLICATE_SKU_SUCCESS), 90)
            );
    }

    @And("Vendor {string} delete SKU {string}")
    public void delete_sku(String action, String sku) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorSKU.deleteSKU(action, sku)
        );
        if (action.equalsIgnoreCase("OK"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT(DELETE_SKU_SUCCESS))
            );
    }

    @And("Vendor {string} go to change request of field {string}")
    public void go_to_change_request(String action, String field) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorProduct.goToChangeRequest(action, field)
        );
    }

    @And("Vendor check request change product page")
    public void go_to_change_request_product() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("- Please make sure you submit all necessary changes across the SKUs at once.")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("- Please leave the fields blank if you don't need to change them.")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("- If you'd like to change price, UPC / EAN and case pack, please click a SKU displayed above.")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("- We reserve 90 days to make changes for Pod Express Vendors to allow ample time for inventory adjustments, warehousing, and retailer notice. This does not mean that it will take 90 days for the request to be approved. Pod Direct change requests can be expedited.")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT("- If you have any questions, please reach out to your category manager or to"))
        );
    }
    @And("Vendor check request change sku page")
    public void go_to_change_request_sku() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("- Please make sure you submit all necessary changes across the SKUs at once.")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("- Please leave the fields blank if you don't need to change them.")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("- We reserve 90 days to make changes for Pod Express Vendors to allow ample time for inventory adjustments, warehousing, and retailer notice. This does not mean that it will take 90 days for the request to be approved. Pod Direct change requests can be expedited.")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("- You can update your MSRP/unit at any time by adjusting the specific field and republishing the SKUs.")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT("- If you have any questions, please reach out to your category manager or to"))
        );
    }

    @And("Vendor check {word} Request information change of product")
    public void check_product_change_request_after(String time, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (time.equalsIgnoreCase("current"))
            for (Map<String, String> map : list)
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(VendorChangeRequestPage.SKU_CURRENT_VALUE(map.get("field"))),
                        Ensure.that(VendorChangeRequestPage.SKU_CURRENT_VALUE(map.get("field"))).text().containsIgnoringCase(map.get("value"))
                );
        if (time.equalsIgnoreCase("after"))
            for (Map<String, String> map : list)
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(VendorChangeRequestPage.AFTER_VALUE(map.get("field"))),
                        Ensure.that(VendorChangeRequestPage.AFTER_VALUE(map.get("field"))).text().containsIgnoringCase(map.get("value")),
                        Ensure.that(VendorChangeRequestPage.EFFECTIVE_VALUE(map.get("field"))).text().containsIgnoringCase(CommonHandle.setDate2(map.get("effective"), "MM/dd/yy"))
                );
    }

    @And("Vendor check {word} Request information change region of SKU")
    public void check_sku_region_change_request(String time, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (time.equalsIgnoreCase("current"))
            for (Map<String, String> map : list)
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorChangeRequestPage.SKU_CURRENT_VALUE(map.get("region"))).text().containsIgnoringCase(map.get("price"))
                );
        else for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorChangeRequestPage.REGION_AFTER_VALUE(map.get("region"))).text().containsIgnoringCase(map.get("price")),
                    Ensure.that(VendorChangeRequestPage.REGION_EFFECTIVE_VALUE(map.get("region"))).text().containsIgnoringCase(CommonHandle.setDate2(map.get("effective"), "MM/dd/yy"))
            );
    }

    @And("Vendor Request information change of product")
    public void product_change_request(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT("Unit length (inches)")),
                Enter.theValue(list.get(0).get("unitLength")).into(CommonVendorPage.DYNAMIC_INPUT("Unit length (inches)")),
                Enter.theValue(list.get(0).get("unitWidth")).into(CommonVendorPage.DYNAMIC_INPUT("Unit width (inches)")),
                Enter.theValue(list.get(0).get("unitHeight")).into(CommonVendorPage.DYNAMIC_INPUT("Unit height (inches)")),
                Enter.theValue(list.get(0).get("note")).into(CommonVendorPage.DYNAMIC_INPUT("Note"))
        );
    }

    @And("Vendor submit Request information change")
    public void submit_change_request() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Submit Request")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Submit Request"))
        );
    }

    @And("Vendor Request information change general info of SKU {string}")
    public void sku_change_request(String sku, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorProduct.fillInfoRequestChange(sku, infos.get(0))
        );
    }

    @And("Vendor Request information change region info of SKU")
    public void sku_region_change_request(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT_AFTER_DIV(map.get("region"))),
                    Enter.theValue(map.get("price")).into(CommonVendorPage.DYNAMIC_INPUT_AFTER_DIV(map.get("region"))));
    }

    @And("Vendor edit Request information change")
    public void edit_change_request() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Edit Request")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Edit Request"))
        );
    }
}
