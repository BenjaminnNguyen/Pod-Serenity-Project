package steps.buyer;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.buyer.HandleOrderGuide;
import cucumber.tasks.common.*;
import cucumber.user_interface.beta.Buyer.BuyerOrderGuidePage;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.*;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class BuyerOrderGuideStepDefinitions {

    @And("Buyer search Order guide on tab {string}")
    public void search_item(String item, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleOrderGuide.goToTab(item),
                    HandleOrderGuide.search(map)
            );
    }

    @And("Buyer export Order guide")
    public void export_item() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                WindowTask.threadSleep(500)
        );
    }

    @And("Buyer check previous order items on Order guide")
    public void list_item(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            String id = map.get("skuId");
            if (id.contains("create by api"))
                id = Serenity.sessionVariableCalled("ID SKU Admin");
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(1000),
                    CommonWaitUntil.isVisible(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "brand")),
                    Scroll.to(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "brand")),
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "brand")).text().contains(map.get("brand")),
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "product")).text().contains(map.get("product")),
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "contain")).attribute("style").contains(map.get("image")),
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "info-variant__id has-tooltip")).text().contains(id),
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "upc")).text().contains(map.get("upc")),
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "pack")).text().contains(map.get("pack")),
                    Check.whether(map.get("expressTag").equals("show")).andIfSo(
                            Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "express-tag")).isDisplayed()
                    ).otherwise(
                            Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "express-tag")).isNotDisplayed()
                    ),
                    Check.whether(map.get("price").isEmpty()).otherwise(
                            Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "price-unit")).text().contains(map.get("price"))
                    ).andIfSo(
                            Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "price-unit")).isNotDisplayed()
                    ),
                    Check.whether(map.get("nextReorderDate").isEmpty()).otherwise(
                            Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "next-reorder-date")).text().contains(CommonHandle.setDate2(map.get("nextReorderDate"), "MM/dd/yy"))
                    ).andIfSo(
                            Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "nextReorderDate")).isNotDisplayed()
                    ),
                    Check.whether(map.get("avgOrderDay").isEmpty()).otherwise(
                            Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "avg-order-day")).text().contains(map.get("avgOrderDay"))
                    ).andIfSo(
                            Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "avgOrderDay")).isNotDisplayed()
                    )

            );
            if (map.containsKey("store")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "edt-piece store")).text().contains(map.get("store"))
                );
            }
            if (map.containsKey("addCart")) {
                if (map.get("addCart").contains("disable"))
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerOrderGuidePage.ADD_CART(map.get("sku"))).attribute("class").contains("is-disabled")
                    );
                else theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderGuidePage.ADD_CART(map.get("sku"))).attribute("class").doesNotContain("is-disabled")
                );
            }
        }
    }

    @And("Buyer check Recommended products section Order guide")
    public void Recommended_list_item(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(list.get(i).get("product"), "contain")).attribute("style").contains(list.get(i).get("image")),
                    Ensure.that(BuyerOrderGuidePage.RECOMMENDED_PRODUCT(list.get(i).get("product"), "flex aic brand-section")).text().contains(list.get(i).get("brand"))

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

    @And("Buyer click sku {string} on Order guide")
    public void go_to_sku(String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_A_TEXT(sku)),
                Click.on(CommonVendorPage.DYNAMIC_A_TEXT(sku))
        );
    }

    @And("Buyer check previous order date of SKU {string} in Order guide")
    public void previous_order(String sku, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (!list.get(i).get("orderDate").isEmpty())
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderGuidePage.ORDER_DATE(sku, i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("orderDate"), "MM/dd/yy")),
                        Ensure.that(BuyerOrderGuidePage.ORDER_QTY(sku, i + 1)).text().contains(list.get(i).get("quantity"))
                );
            else theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerOrderGuidePage.ORDER_DATE(sku, i + 1)).isNotDisplayed(),
                    Ensure.that(BuyerOrderGuidePage.ORDER_QTY(sku, i + 1)).isNotDisplayed()
            );
        }
    }

    @And("Buyer check price applied promotions of SKU in Order guide")
    public void promotion_price(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO2(map.get("sku"), "old")).text().contains(map.get("oldPrice")),
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO2(map.get("sku"), "current")).text().contains(map.get("currentPrice")),
                    Ensure.that(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "promotion-tag el-popover__reference")).text().contains(map.get("typePromotion"))
            );
        }
    }

    @And("Buyer check promotions tag of SKU in Order guide")
    public void promotion_price_POPUP(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    MoveMouse.to(BuyerOrderGuidePage.SKU_INFO(map.get("sku"), "promotion-tag el-popover__reference")),
                    CommonWaitUntil.isVisible(BuyerOrderGuidePage.TOOLTIP_PROMO("sku pf-ellipsis")),
                    Ensure.that(BuyerOrderGuidePage.TOOLTIP_PROMO("sku pf-ellipsis")).text().containsIgnoringCase(map.get("sku")),
                    Ensure.that(BuyerOrderGuidePage.TOOLTIP_PROMO("promotion-type ml-2")).text().containsIgnoringCase(map.get("typePromotion")),
                    Ensure.that(BuyerOrderGuidePage.TOOLTIP_PROMO("current promoted")).text().containsIgnoringCase(map.get("currentPrice")),
                    Ensure.that(BuyerOrderGuidePage.TOOLTIP_PROMO("old")).text().containsIgnoringCase(map.get("oldPrice"))
            );
            if (map.containsKey("caseLimit")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderGuidePage.TOOLTIP_PROMO("case-limit")).text().containsIgnoringCase(map.get("caseLimit"))
                );
            }
            if (map.containsKey("expiryDate")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerOrderGuidePage.TOOLTIP_PROMO("expiry-date")).text().containsIgnoringCase(CommonHandle.setDate2(map.get("expiryDate"), "MM/dd/yy"))
                );
            }
        }
    }

    @And("Buyer check item {string} not show in Order guide")
    public void checkItem(String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(BuyerOrderGuidePage.SKU_INFO(sku, "info-variant__name"))
        );
    }

    @And("Buyer export order guide")
    public void ExportOrderGuide() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                WindowTask.threadSleep(2000)
        );
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.waitToDownloadSuccessfully("Pod_Foods_order-history_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".xlsx")

        );
    }

    @And("Buyer delete file export order guide")
    public void deleteExportOrderGuide() {
        theActorInTheSpotlight().attemptsTo(
                CommonFile.deleteFileToDownload2("Pod_Foods_order-history_")
        );
    }

    @And("Buyer check file export order guide")
    public void checkExportOrderGuide(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        List<String[]> file = CommonFile.readDataExcelLineByLine(System.getProperty("user.dir") + "/target/Pod_Foods_order-history_" + Utility.getTimeNow("MMddyyyy") + ".xlsx");
        List<Map<String, String>> acture = CommonHandle.convertListArrayStringToMapString(file, 2, 9);
        for (Map<String, String> map : list) {
            String id = map.get("itemId");
            if (map.get("itemId").equals("create by api"))
                id = Serenity.sessionVariableCalled("itemCode" + map.get("sku"));
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(acture.get(0).get("Item #")).containsIgnoringCase(id),
                    Ensure.that(acture.get(0).get("Brand")).containsIgnoringCase(map.get("brand")),
                    Ensure.that(acture.get(0).get("Product")).containsIgnoringCase(map.get("product")),
                    Ensure.that(acture.get(0).get("SKU")).containsIgnoringCase(map.get("sku")),
                    Ensure.that(acture.get(0).get("Price/case")).containsIgnoringCase(map.get("priceCase")),
                    Ensure.that(acture.get(0).get("Price/unit")).containsIgnoringCase(map.get("priceUnit")),
                    Ensure.that(acture.get(0).get("Pack")).containsIgnoringCase(map.get("pack")),
                    Ensure.that(acture.get(0).get("Unit Size")).containsIgnoringCase(map.get("unitSize")),
                    Ensure.that(acture.get(0).get("Unit UPC / EAN")).containsIgnoringCase(map.get("unitUPC"))
            );
        }
    }
}
