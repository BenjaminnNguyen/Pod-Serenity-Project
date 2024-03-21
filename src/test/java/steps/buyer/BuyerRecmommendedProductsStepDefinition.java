package steps.buyer;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.user_interface.beta.Buyer.BuyerOrderGuidePage;
import cucumber.user_interface.beta.Buyer.BuyerRecommendedProductPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.checkerframework.checker.units.qual.C;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class BuyerRecmommendedProductsStepDefinition {


    @And("Buyer check Recommended products")
    public void Recommended_list_item(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(list.get(i).get("product"), "flex aic brand-section")),
                    Ensure.that(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(list.get(i).get("product"), "contain")).attribute("style").contains(list.get(i).get("image")),
                    Ensure.that(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(list.get(i).get("product"), "flex aic brand-section")).text().contains(list.get(i).get("brand")),
                    Ensure.that(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(list.get(i).get("product"), "metas__recommended")).text().contains(list.get(i).get("comment"))
            );
            if (list.get(i).containsKey("expressTag")) {
                if (list.get(i).get("expressTag").equals("show"))
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(list.get(i).get("product"), "express-tag express has-tooltip")).isDisplayed()
                    );
                else theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(list.get(i).get("product"), "express-tag express has-tooltip")).isNotDisplayed()
                );
            }
        }
    }

    @And("Buyer check not show Recommended product {string}")
    public void Recommended_list_item(String productName) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(productName, "contain")).isNotDisplayed()
        );
    }

    @And("Buyer search Recommended product with {string}")
    public void Recommended_search(String filter) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerRecommendedProductPage.FILTER),
                CommonTask.chooseItemInDropdown1(BuyerRecommendedProductPage.FILTER, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(filter))
        );
    }

    @And("Buyer export Recommended product")
    public void ExportOrderGuide() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                WindowTask.threadSleep(200),
                JavaScriptClick.on(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.waitToDownloadSuccessfully("Pod_Foods_recommended-product_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".csv")
        );
    }

    @And("Buyer delete file export Recommended product")
    public void deleteExportOrderGuide() {
        theActorInTheSpotlight().attemptsTo(
                CommonFile.deleteFileToDownload2("Pod_Foods_recommended-product_")
        );
    }

    @And("Buyer check file export Recommended product")
    public void checkExportOrderGuide(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        List<String[]> file = CommonFile.readDataLineByLine(System.getProperty("user.dir") + "/target/Pod_Foods_recommended-product_" + Utility.getTimeNow("MMddyyyy") + ".csv");
        List<Map<String, String>> actual = CommonHandle.convertListArrayStringToMapString(file);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(actual.get(0).get("Brand name")).containsIgnoringCase(map.get("brand")),
                    Ensure.that(actual.get(0).get("Product name")).containsIgnoringCase(map.get("productName")),
                    Ensure.that(actual.get(0).get("Product type")).containsIgnoringCase(map.get("productType")),
                    Ensure.that(actual.get(0).get("Product categories")).containsIgnoringCase(map.get("categories")),
                    Ensure.that(actual.get(0).get("Product package size")).containsIgnoringCase(map.get("packageSize")),
                    Ensure.that(actual.get(0).get("Product unit size")).containsIgnoringCase(map.get("unitSize")),
                    Ensure.that(actual.get(0).get("Case dimensions")).containsIgnoringCase(map.get("dimensions")),
                    Ensure.that(actual.get(0).get("Product MOQ")).containsIgnoringCase(map.get("moq")),
                    Ensure.that(actual.get(0).get("SKU name")).containsIgnoringCase(map.get("sku")),
                    Ensure.that(actual.get(0).get("Unit UPC / EAN")).containsIgnoringCase(map.get("unitUPC")),
                    Ensure.that(actual.get(0).get("Location")).containsIgnoringCase(map.get("location")),
                    Ensure.that(actual.get(0).get("Lead time")).containsIgnoringCase(map.get("leadTime")),
                    Ensure.that(actual.get(0).get("Units/case")).containsIgnoringCase(map.get("unitCase")),
                    Ensure.that(actual.get(0).get("Margin")).containsIgnoringCase(map.get("margin")),
                    Ensure.that(actual.get(0).get("MSRP")).containsIgnoringCase(map.get("msrp")),
                    Ensure.that(actual.get(0).get("Storage shelf life")).containsIgnoringCase(map.get("storeShelfLife")),
                    Ensure.that(actual.get(0).get("Retail shelf life")).containsIgnoringCase(map.get("retailShelfLife")),
                    Ensure.that(actual.get(0).get("Temperature requirement")).containsIgnoringCase(map.get("temperature")),
                    Ensure.that(actual.get(0).get("Qualities")).containsIgnoringCase(map.get("qualities"))
                    );
        }
    }
}
