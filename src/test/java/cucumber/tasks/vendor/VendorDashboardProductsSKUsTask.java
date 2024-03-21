package cucumber.tasks.vendor;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Vendor.products.VendorCreateNewSKUPage;
import cucumber.user_interface.beta.Vendor.products.VendorProductDetailPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.targets.Target;

import java.util.Map;

public class VendorDashboardProductsSKUsTask {

    public static Task goToSKUsTab() {
        return Task.where("Go to SKUs tab from dashboard product detail",
                CommonWaitUntil.isVisible(VendorProductDetailPage.SKUS_TAB),
                Click.on(VendorProductDetailPage.SKUS_TAB),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isVisible(VendorProductDetailPage.ADD_NEW_SKU_BUTTON)
        );
    }

    public static Task goToSKUDetail(String sku) {
        return Task.where("Go to SKU detail from dashboard product detail",
                CommonWaitUntil.isVisible(VendorProductDetailPage.ADD_NEW_SKU_BUTTON),
                Click.on(VendorProductDetailPage.SKU_NAME(sku)),
                CommonWaitUntil.isNotVisible(VendorProductDetailPage.LOADING_ICON)
        );
    }

    public static Task checkTapGeneralSKU(Map<String, String> list) {
        return Task.where("Check tap General of SKU detail",
                CommonWaitUntil.isVisible(VendorCreateNewSKUPage.PAGE_INFO, 60),
                Ensure.that(VendorCreateNewSKUPage.PAGE_TITLE).text().contains("Edit " + list.get("skuName")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Name")).value().contains(list.get("skuName")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD_AREA("Ingredients")).value().contains(list.get("ingredients")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD_AREA("Description")).value().contains(list.get("description")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Lead time")).value().contains(list.get("leadTime")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Units/case")).value().contains(list.get("unitCase")),
                Check.whether(CommonQuestions.isControlDisplay(VendorCreateNewSKUPage.BARCODE_TYPE_DISABLE)).andIfSo(
                        Check.whether(CommonQuestions.textContains(VendorCreateNewSKUPage.BARCODE_TYPE,"UPC")).andIfSo(
                                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Unit UPC")).value().contains(list.get("unitUPC")),
                                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Case UPC")).value().contains(list.get("caseUPC"))
                        ).otherwise(
                                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Unit EAN")).value().contains(list.get("unitUPC")),
                                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Case EAN")).value().contains(list.get("caseUPC"))
                        )
                ).otherwise(
                        Check.whether(CommonQuestions.AskForAttributeValue(VendorCreateNewSKUPage.BARCODE_TYPE2,"UPC")).andIfSo(
                                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Unit UPC")).value().contains(list.get("unitUPC")),
                                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Case UPC")).value().contains(list.get("caseUPC"))
                        ).otherwise(
                                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Unit EAN")).value().contains(list.get("unitUPC")),
                                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Case EAN")).value().contains(list.get("caseUPC"))
                        )
                ),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Country")).value().contains(list.get("country")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("City")).value().contains(list.get("city")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("State (Province/Territory)")).value().contains( list.get("state")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Storage shelf life (days)")).value().contains( list.get("storage")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Retail shelf life (days)")).value().contains( list.get("retail")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Min temperature (F)")).value().contains( list.get("minTemperature")),
                Ensure.that(VendorCreateNewSKUPage.DYNAMIC_FIELD("Max temperature (F)")).value().contains(list.get("maxTemperature"))

        );
    }

    public static Task checkTapRegionSpecificSKU(Map<String, String> list) {
        return Task.where("Check tap Region-specific of SKU detail",
                CommonQuestions.AskForAttributeText(Target.the("").locatedBy(String.format(VendorCreateNewSKUPage.WHOLESALE_PRICE, list.get("regionName"))), "value", list.get("casePrice")),
                CommonQuestions.AskForAttributeText(Target.the("").locatedBy(String.format(VendorCreateNewSKUPage.MSRP_UNIT, list.get("regionName"))), "value", list.get("msrpUnit")),
                CommonQuestions.AskForElementIsDisplay(Target.the("").locatedBy(String.format(VendorCreateNewSKUPage.AVAILABILITY_CHECKED, list.get("regionName"), list.get("availability"))), true)

        );
    }

}
