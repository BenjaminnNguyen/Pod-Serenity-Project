package cucumber.tasks.buyer;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.inventory.AllInventoryPage;
import cucumber.user_interface.beta.Buyer.BuyerCatalogPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.products.BuyerProductDetailPage;
import cucumber.user_interface.beta.HomePageForm;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class BuyerCatalogTask {

    public static Task go_to_product(String item) {
        return Task.where("Product " + item,
                Enter.theValue(item).into(HomePageForm.SEARCH_FIELD).thenHit(Keys.ENTER),
                CommonWaitUntil.isVisible(HomePageForm.SEARCH_FIELD),
                CommonTask.chooseItemInDropdown1(BuyerCatalogPage.SEARCH_OPTION, BuyerCatalogPage.SEARCH_OPTION("Order by Product name — A > Z")),
                CommonWaitUntil.isVisible(BuyerCatalogPage.PRODUCT_NAME(item)),
                MoveMouse.to(BuyerCatalogPage.PRODUCT_NAME(item)),
                WindowTask.threadSleep(500),
                Click.on(BuyerCatalogPage.PRODUCT_NAME(item)),
                CommonWaitUntil.isNotVisible(BuyerCatalogPage.LOADING_PRODUCT)
        );
    }

    public static Task go_to_product_detail(String item) {
        return Task.where("Product " + item,
                CommonWaitUntil.isVisible(BuyerCatalogPage.PRODUCT_NAME(item)),
                MoveMouse.to(BuyerCatalogPage.PRODUCT_NAME(item)),
                Click.on(BuyerCatalogPage.PRODUCT_NAME(item)),
                CommonWaitUntil.isNotVisible(BuyerCatalogPage.LOADING_PRODUCT)
//                CommonWaitUntil.isVisible(BuyerProductDetailPage.PRODUCT_NAME)
        );
    }

    public static Task chooseExpressOnly(Map<String, String> map) {
        return Task.where("choose Express Only",
                CommonWaitUntil.isVisible(BuyerCatalogPage.EXPRESS_FILTER),
                Check.whether(map.get("express_only").equalsIgnoreCase("no")).otherwise(
                        Click.on(BuyerCatalogPage.EXPRESS_FILTER)
                ),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_BAR)
        );
    }

    public static Task chooseState(Map<String, String> map) {
        return Task.where("choose State",
                Check.whether(map.get("state").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(BuyerCatalogPage.STATE_FILTER, map.get("state"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(map.get("state")))
                ),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_BAR)
        );
    }

    public static Task and_product_qualities(String prd) {
        return Task.where("and_product_qualities",
                CommonWaitUntil.isVisible(BuyerCatalogPage.PRODUCT_QUALITIES_FILTER(prd)),
                Scroll.to(BuyerCatalogPage.PRODUCT_QUALITIES_FILTER(prd)),
                Click.on(BuyerCatalogPage.PRODUCT_QUALITIES_FILTER(prd)),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_BAR)
        );
    }

    public static Task and_tag(String tag) {
        return Task.where("and_tag",
                CommonWaitUntil.isVisible(BuyerCatalogPage.TAGS_FILTER(tag)),
                Scroll.to(BuyerCatalogPage.TAGS_FILTER(tag)),
                Click.on(BuyerCatalogPage.TAGS_FILTER(tag)),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_BAR)
        );
    }

    public static Task and_packet_size(String pkz) {
        return Task.where("and_packet_size",
                CommonWaitUntil.isVisible(BuyerCatalogPage.PACKAGE_SIZES_FILTER(pkz)),
                Scroll.to(BuyerCatalogPage.PACKAGE_SIZES_FILTER(pkz)),
                Click.on(BuyerCatalogPage.PACKAGE_SIZES_FILTER(pkz)),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_BAR)
        );
    }

    public static Task search_with_brand(String brand) {
        return Task.where("Search Brand " + brand,
                CommonWaitUntil.isVisible(BuyerCatalogPage.MENU_ITEMS("Brands")),
                Click.on(BuyerCatalogPage.MENU_ITEMS("Brands")),
                Enter.theValue(brand).into(HomePageForm.SEARCH_FIELD).thenHit(Keys.ENTER),
                WindowTask.threadSleep(1000),
                // Chọn loại filter để web search do lỗi kailua (filter brand khác filter product)
                CommonWaitUntil.isVisible(HomePageForm.SORT_FILTER_BRAND_BUTTON),
                CommonTask.chooseItemInDropdown1(HomePageForm.SORT_FILTER_BRAND_BUTTON, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3("Order by name — A-Z"))

        );
    }

    public static Task goToWholesalePricing() {
        return Task.where("Go to wholesale pricing",
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_BUTTON("Wholesale Pricing")),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Wholesale Pricing")),
                CommonWaitUntil.isVisible(BuyerProductDetailPage.WHOLESALE_PRICING_DIALOG)
        );
    }

    public static Task fillInfoWholesalePricing(Map<String, String> info) {
        return Task.where("Fill info to wholesale pricing",
                CommonWaitUntil.isVisible(BuyerProductDetailPage.WHOLESALE_PRICING_TEXTBOX("First name")),
                Enter.theValue(info.get("firstName")).into(BuyerProductDetailPage.WHOLESALE_PRICING_TEXTBOX("First name")),
                Enter.theValue(info.get("lastName")).into(BuyerProductDetailPage.WHOLESALE_PRICING_TEXTBOX("Last name")),
                Enter.theValue(info.get("email")).into(BuyerProductDetailPage.WHOLESALE_PRICING_TEXTBOX("Email")),
                Enter.theValue(info.get("storeName")).into(BuyerProductDetailPage.WHOLESALE_PRICING_TEXTBOX("Store name")),
                Check.whether(info.get("comment").isEmpty())
                        .otherwise(Enter.theValue(info.get("comment")).into(BuyerProductDetailPage.WHOLESALE_PRICING_COMMENT)),
                Check.whether(info.get("partner").isEmpty())
                        .otherwise(Click.on(BuyerProductDetailPage.WHOLESALE_PRICING_RETAIL))
        );
    }

    public static Performable chooseSKUForWholesalePricing(List<Map<String, String>> infos) {
        return Task.where("Choose sku for wholesale pricing",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerProductDetailPage.WHOLESALE_PRICING_SKU(info.get("sku"))),
                                Click.on(BuyerProductDetailPage.WHOLESALE_PRICING_SKU(info.get("sku")))
                        );
                    }
                }
        );
    }

    public static Task createWholesalePricingSuccess() {
        return Task.where("Create wholesale priing success",
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_DIALOG_BUTTON("Wholesale Pricing")),
                Click.on(CommonBuyerPage.DYNAMIC_DIALOG_BUTTON("Wholesale Pricing"))
        );
    }

    public static Task checkQuantity(Map<String, String> map) {
        return Task.where("check Quantity",
                CommonWaitUntil.isVisible(BuyerProductDetailPage.QUANTITY_CHANGE_SKU(map.get("sku"), map.get("action"))),
                Check.whether(CommonQuestions.targetValue(theActorInTheSpotlight(), BuyerProductDetailPage.QUANTITY_SKU_IN_DETAIL(map.get("sku"))).equals("0")).andIfSo(
                        Ensure.that(BuyerProductDetailPage.QUANTITY_CHANGE_SKU(map.get("sku"), "decrease")).attribute("class").contains("is-disabled")
                ),
                Check.whether(map.get("action").equals("decrease")).andIfSo(
                        Click.on(BuyerProductDetailPage.QUANTITY_CHANGE_SKU(map.get("sku"), "decrease"))
                ),
                Check.whether(map.get("action").equals("increase")).andIfSo(
                        Click.on(BuyerProductDetailPage.QUANTITY_CHANGE_SKU(map.get("sku"), "increase"))
                ),
                WindowTask.threadSleep(500)
        );
    }
}
