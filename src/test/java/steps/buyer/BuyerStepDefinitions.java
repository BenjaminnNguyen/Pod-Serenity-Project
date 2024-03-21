package steps.buyer;

import cucumber.constants.buyer.WebsiteBuyerConstants;
import cucumber.tasks.admin.inventory.HandleInventory;
import cucumber.user_interface.beta.Buyer.BuyerFavoritesPage;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.Vendor.products.VendorProductDetailPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.buyer.addtocart.AddToCart;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.buyer.BuyerCatalogTask;
import cucumber.tasks.buyer.orders.HandleOrders;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerOrderDetailPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerOrderGuildPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerOrderPage;
import cucumber.user_interface.beta.Vendor.VendorDashboardPage;
import cucumber.user_interface.beta.Buyer.BuyerCatalogPage;
import cucumber.user_interface.beta.Buyer.products.BuyerProductDetailPage;
import cucumber.user_interface.beta.Buyer.products.BuyerProductOfBrandPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.ui.Link;
import org.openqa.selenium.Keys;

import java.util.*;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class BuyerStepDefinitions {

    @And("Search item {string}")
    public void search_item(String item) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(HomePageForm.SEARCH_FIELD),
                Enter.theValue(item).into(HomePageForm.SEARCH_FIELD).thenHit(Keys.ENTER),
                WindowTask.threadSleep(3000),
                CommonWaitUntil.isVisible(BuyerCatalogPage.SEARCH_OPTION),
                CommonTask.chooseItemInDropdown1(BuyerCatalogPage.SEARCH_OPTION, BuyerCatalogPage.SEARCH_OPTION("Order by Product name — A > Z")),
                //Wait chờ lỗi 500 trên auto biến mất
                WindowTask.threadSleep(3000)

        );
    }

    @And("Search Brand item {string}")
    public void search_brand_item(String item) {
        theActorInTheSpotlight().attemptsTo(
                BuyerCatalogTask.search_with_brand(item),
                CommonWaitUntil.isNotVisible(BuyerCatalogPage.BRAND_GRID)
        );
    }

    @And("Check button add to cart is disable")
    public void verify_AddToCard_Disable() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.FIRST_PRODUCT));
        CommonTask.HoverToElementUsingSelenium("//div[@class='caption']/a[1]");
        theActorInTheSpotlight().attemptsTo(
//                HoverOverElement.over(Buyer_Catalog_Page.PRODUCT_NAME),
//                HoverOverBy.over(Buyer_Catalog_Page.FIRST_PRODUCT),
                CommonQuestions.AskForElementIsDisplay(BuyerCatalogPage.ADD_TO_CARD_ICON, false)
        );
    }

    @And("Check have no product showing")
    public void check_no_product_showing() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.NO_RESULTS_FOUND)
        );
    }

    @And("Check have no brands showing")
    public void check_no_brands_showing() {
        theActorInTheSpotlight().should(
//                seeThat(CommonQuestions.isControlUnDisplay(Buyer_Catalog_Page.PRODUCT_NAME)),
                seeThat(CommonQuestions.isControlUnDisplay(BuyerCatalogPage.BRAND_CARD))
        );
    }

    @And("Check brands {string} {string} showing")
    public void check_show_brand(String brandName, String status) {
        if (status.equals("not")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isNotVisible(
                            BuyerCatalogPage.BRAND_CARD(brandName, "name pf-ellipsis"))
            );
        } else
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(
                            BuyerCatalogPage.BRAND_CARD(brandName, "name pf-ellipsis"))
            );
    }

    @And("Go to Recommended products")
    public void go_to_recommended() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.RECOMMENDED_PRODUCTS),
                Click.on(BuyerCatalogPage.RECOMMENDED_PRODUCTS),
                CommonWaitUntil.isNotVisible(BuyerCatalogPage.PRODUCT_GRID)
        );
    }

    @And("Go to Promotions")
    public void go_to_promotions() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.PROMOTIONS),
                Click.on(BuyerCatalogPage.PROMOTIONS),
                CommonWaitUntil.isVisible(BuyerCatalogPage.PROMOTIONS_PAGE_BRAND)
        );
    }

    @And("Go to Order guide")
    public void go_to_order_guild() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.PROMOTIONS),
                Click.on(BuyerCatalogPage.ORDER_GUILD),
                CommonWaitUntil.isNotVisible(BuyerCatalogPage.LOADING)
        );
    }

    @And("{word} Go to Dashboard")
    public void go_to_dashboard(String actor) {
        theActorCalled(actor).attemptsTo(
                CommonWaitUntil.isVisible(Link.withText("Dashboard")),
                Click.on(Link.withText("Dashboard")),
                CommonWaitUntil.isNotVisible(BuyerOrderPage.LOADING_ICON("Fetching your orders...")),
                CommonWaitUntil.isVisible(VendorDashboardPage.ORDERS)
        );
    }

    @And("Check orders in order guild")
    public void check_order_in_order_guild(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerOrderGuildPage.BRAND_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("brandName"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderGuildPage.PRODUCT_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderGuildPage.SKU_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("skuName"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderGuildPage.UNIT_PER_CASE(i + 1)), equalToIgnoringCase(list.get(i).get("unitPerCase"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderGuildPage.ORDER_DATE(i + 1)), equalToIgnoringCase(list.get(i).get("orderDate"))),
                    seeThat(CommonQuestions.targetText(BuyerOrderGuildPage.QUANTITY(i + 1)), equalToIgnoringCase(list.get(i).get("quantity"))),
                    seeThat(CommonQuestions.attributeText(BuyerOrderGuildPage.ADD_TO_CART_BUTTON(i + 1), "class"), containsString(list.get(i).get("addCart")))
            );
        }
    }

    @And("Go to order detail with order number {string}")
    public void goToOrderNumber(String number) {
        String value = null;
        switch (number) {
            case "":
                value = Serenity.hasASessionVariableCalled("ID Invoice") ? Serenity.sessionVariableCalled("ID Invoice").toString() : "2";
                value = value.substring(value.lastIndexOf("#") + 1).trim();
                break;
            case "create by api":
                value = Serenity.sessionVariableCalled("ID Invoice").toString();
                break;
            case "create by buyer":
                value = Serenity.sessionVariableCalled("ID Invoice").toString();
                value = value.substring(7);
                break;
            case "create by admin":
                value = Serenity.sessionVariableCalled("ID Order").toString();
                break;
            default:
                value = number;
        }

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOrderPage.NUMBER(value)),
                Click.on(BuyerOrderPage.NUMBER(value)),
                CommonWaitUntil.isVisible(BuyerOrderDetailPage.BACK_TO_ORDER));
    }

    @And("Search Promotions with brand {string}")
    public void searchPromotionBrand(String brand) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.PROMOTIONS_PAGE_BRAND),
                Enter.theValue(brand).into(BuyerCatalogPage.PROMOTIONS_PAGE_BRAND),
                CommonTask.ChooseValueFromSuggestions(brand)
        );
    }

    @And("Check button add to cart on product detail is disable")
    public void verify_AddToCard_product_Detail_Disable() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isDisabled(BuyerProductDetailPage.ADD_TO_CART_BUTTON))
        );
    }

    @And("Show detail of all promotions")
    public void expand_detail_promotion() {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000)
        );
        int i = 0;
        while (i < BuyerCatalogPage.PROMOTIONS_PAGE_SHOW_DETAIL.resolveAllFor(theActorInTheSpotlight()).size()) {
            WebElementFacade e = BuyerCatalogPage.PROMOTIONS_PAGE_SHOW_DETAIL.resolveAllFor(theActorInTheSpotlight()).get(0);
            e.click();
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(500)
            );
            i++;
        }
    }

    @And("Check SKU {string} not in of all promotions")
    public void checkSKUNotInAllPromotion(String sku) {
        List<String> skus = new ArrayList<>();
        for (WebElementFacade i : BuyerCatalogPage.SKU_NAME_IN_PROMOTION_DETAIL.resolveAllFor(theActorInTheSpotlight())) {
            skus.add(i.getText());
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.AskForContainValue(Arrays.asList(skus.toArray()), sku), equalTo(false))
        );
    }

    @And("Search Brand and go to detail")
    public void search_with_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                BuyerCatalogTask.search_with_brand(list.get(0).get("brand")),
                CommonWaitUntil.isVisible(BuyerCatalogPage.BRANDNAME(list.get(0).get("brand"))),
                Click.on(BuyerCatalogPage.BRANDNAME(list.get(0).get("brand"))),
                CommonWaitUntil.isVisible(BuyerCatalogPage.LIST_PRODUCT),
//                CommonQuestions.AskForNumberElement(BuyerCatalogPage.LIST_PRODUCT, list.size()),
                CommonQuestions.AskForTextContains(BuyerProductOfBrandPage.PRODUCT_NAME(list.get(0).get("productName")), list.get(0).get("productName")),
                CommonQuestions.AskForTextContains(BuyerProductOfBrandPage.UNIT_PRICE(list.get(0).get("productName")), list.get(0).get("unitPrice")),
                CommonQuestions.AskForTextContains(BuyerProductOfBrandPage.NUMBER_SKUS(list.get(0).get("productName")), list.get(0).get("numberSku"))
        );
    }

    @And("Buyer check product info on catalog")
    public void productInfo(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonQuestions.AskForTextContains(BuyerProductOfBrandPage.PRODUCT_NAME(map.get("productName")), map.get("productName")),
                    CommonQuestions.AskForTextContains(BuyerProductOfBrandPage.BRAND_NAME(map.get("productName")), map.get("brand")),
                    CommonQuestions.AskForTextContains(BuyerProductOfBrandPage.UNIT_PRICE(map.get("productName")), map.get("unitPrice")),
                    CommonQuestions.AskForTextContains(BuyerProductOfBrandPage.NUMBER_SKUS(map.get("productName")), map.get("numberSku"))
            );
    }

    @And("Search item and go to detail of first result")
    public void search_item_go_to_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                BuyerCatalogTask.go_to_product(list.get(0).get("productName")),
                CommonWaitUntil.isVisible(BuyerProductDetailPage.PRODUCT_NAME)
        );
        if (list.get(0).containsKey("arrivingDate") && list.get(0).get("availability").equalsIgnoreCase("Launching soon")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRODUCT_NAME), containsString(list.get(0).get("productName"))),
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_UNIT), equalToIgnoringCase(list.get(0).get("pricePerUnit"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_CASE), equalToIgnoringCase(list.get(0).get("pricePerCase"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.AVAILABILITY), equalToIgnoringCase(list.get(0).get("availability"))),
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.NEW_INVENTORY_ARRIVING), equalToIgnoringCase(CommonHandle.setDate(list.get(0).get("arrivingDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.isControlUnDisplay(BuyerProductDetailPage.ADD_TO_CART_BUTTON)),
                    seeThat(CommonQuestions.isControlDisplay(BuyerProductDetailPage.DYNAMIC_BUTTON("Pre-order")))
            );
        } else
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRODUCT_NAME), containsString(list.get(0).get("productName"))),
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_UNIT), equalToIgnoringCase(list.get(0).get("pricePerUnit"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_CASE), equalToIgnoringCase(list.get(0).get("pricePerCase"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.AVAILABILITY), containsString(list.get(0).get("availability")))

            );
        if (list.get(0).get("availability").equalsIgnoreCase("Out of stock")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlUnDisplay(BuyerProductDetailPage.ADD_TO_CART_BUTTON))
            );
        }
    }

    @And("Buyer check detail of product")
    public void product_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (list.get(0).containsKey("arrivingDate") && list.get(0).get("availability").equalsIgnoreCase("Launching soon")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRODUCT_NAME), containsString(list.get(0).get("productName"))),
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_UNIT), equalToIgnoringCase(list.get(0).get("pricePerUnit"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_CASE), equalToIgnoringCase(list.get(0).get("pricePerCase"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.AVAILABILITY), equalToIgnoringCase(list.get(0).get("availability"))),
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.NEW_INVENTORY_ARRIVING), equalToIgnoringCase(CommonHandle.setDate(list.get(0).get("arrivingDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.isControlUnDisplay(BuyerProductDetailPage.ADD_TO_CART_BUTTON)),
                    seeThat(CommonQuestions.isControlDisplay(BuyerProductDetailPage.DYNAMIC_BUTTON("Pre-order")))
            );
        } else
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRODUCT_NAME), containsString(list.get(0).get("productName"))),
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_UNIT), equalToIgnoringCase(list.get(0).get("pricePerUnit"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_CASE), equalToIgnoringCase(list.get(0).get("pricePerCase"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.AVAILABILITY), containsString(list.get(0).get("availability")))

            );
        if (list.get(0).get("availability").equalsIgnoreCase("Out of stock")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isDisabled(BuyerProductDetailPage.ADD_TO_CART_BUTTON))
            );
        }
        if (list.get(0).containsKey("address")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerProductDetailPage.BRAND_ADDRESS).text().contains(list.get(0).get("address"))
            );
        }
    }

    @And("Head buyer check price of sku on product detail")
    public void headBuyerCheckPrice(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_CASE2), equalToIgnoringCase(list.get(0).get("pricePerCase")))
        );
        if (list.get(0).containsKey("pricePerUnit")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerProductDetailPage.PRICE_PER_UNIT).text().contains(list.get(0).get("pricePerUnit"))
            );
        }
        if (list.get(0).containsKey("availability")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.AVAILABILITY), containsString(list.get(0).get("availability")))
            );
        }
    }

    @And("Buyer check quantity of sku on product detail")
    public void checkQuantity(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerProductDetailPage.QUANTITY_SKU_IN_DETAIL(map.get("sku"))),
                    Ensure.that(BuyerProductDetailPage.QUANTITY_SKU_IN_DETAIL(map.get("sku"))).attribute("value").isEqualTo(map.get("quantity"))
            );

    }

    @And("Go to detail of product {string} from catalog")
    public void go_to_detail(String product) {
        theActorInTheSpotlight().attemptsTo(
                BuyerCatalogTask.go_to_product_detail(product)
        );
    }

    @And("Check more information of SKU")//Check with buyer
    public void buyer_check_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.UNIT_UPC_EAN), equalToIgnoringCase(list.get(0).get("unitUpcEan"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DYNAMIC_FIELD("MSRP")), equalToIgnoringCase(list.get(0).get("msrp"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DYNAMIC_FIELD("Unit Dimensions")), equalToIgnoringCase(list.get(0).get("unitDimension"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DYNAMIC_FIELD("Case Dimensions")), equalToIgnoringCase(list.get(0).get("caseDimension"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DYNAMIC_FIELD("Unit Size")), equalToIgnoringCase(list.get(0).get("unitSize"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DYNAMIC_FIELD("Case Pack")), equalToIgnoringCase(list.get(0).get("casePack")))
        );
        if (list.get(0).containsKey("minimumOrder") && !list.get(0).get("minimumOrder").isEmpty())
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DYNAMIC_FIELD(list.get(0).get("minimumOrder").contains("$") ? "Minimum Order Value" : "Minimum Order Quantity")), equalToIgnoringCase(list.get(0).get("minimumOrder")))
            );
        if (list.get(0).containsKey("grossMargin"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DYNAMIC_FIELD("Gross-margin")), equalToIgnoringCase(list.get(0).get("grossMargin")))
            );
    }

    @And("Buyer check master image info")
    public void vendorCheckMasterImage(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(1000),
                Ensure.that(VendorProductDetailPage.MASTER_IMAGE).attribute("style").contains(list.get(0).get("masterImage")),
                Ensure.that(VendorProductDetailPage.MASTER_IMAGE_SKU_NAME).text().contains(list.get(0).get("skuName")),
                Ensure.that(VendorProductDetailPage.MASTER_IMAGE_SKU_NUMBER).text().contains(list.get(0).get("numberSKU"))
        );
    }

    @And("Check information of SKU")
    public void check_Sku_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (list.get(0).containsKey("arrivingDate") && list.get(0).get("availability").equalsIgnoreCase("Launching soon")) {
            theActorInTheSpotlight().should(
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRODUCT_NAME), containsString(list.get(0).get("productName"))),
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_UNIT), equalToIgnoringCase(list.get(0).get("pricePerUnit"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_CASE), equalToIgnoringCase(list.get(0).get("pricePerCase"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.AVAILABILITY), equalToIgnoringCase(list.get(0).get("availability"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.NEW_INVENTORY_ARRIVING), equalToIgnoringCase(CommonHandle.setDate(list.get(0).get("arrivingDate"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.isControlUnDisplay(BuyerProductDetailPage.ADD_TO_CART_BUTTON)),
                    seeThat(CommonQuestions.isControlDisplay(BuyerProductDetailPage.DYNAMIC_BUTTON("Pre-order")))
            );
        } else
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRODUCT_NAME), containsString(list.get(0).get("productName"))),
//                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_UNIT), equalToIgnoringCase(list.get(0).get("pricePerUnit"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.PRICE_PER_CASE), equalToIgnoringCase(list.get(0).get("pricePerCase"))),
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.AVAILABILITY), containsString(list.get(0).get("availability")))

            );
    }

    @And("Check tag Express is {string}")
    public void check_tag(String check) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(BuyerCatalogPage.EXPRESS_TAG), equalTo(Boolean.valueOf(check)))
        );
    }

    @And("Check tag Express of sku {string} is {string}")
    public void check_tag(String sku, String check) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(BuyerCatalogPage.EXPRESS_TAG(sku)), equalTo(Boolean.valueOf(check)))
        );
    }

    @And("Hover on id of SKU {string}")
    public void hover_on_sku(String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.SKU_ID_AFTER_NAME(sku)),
                MoveMouse.to(BuyerCatalogPage.SKU_ID_AFTER_NAME(sku)),
                WindowTask.threadSleep(500),
                Ensure.that(CommonBuyerPage.DYNAMIC_ANY_TEXT("Item code is a unique identifier for SKUs that helps you search products and order with ease.")).isDisplayed()
        );
    }

    @And("{word} choose SKU {string} in product detail")
    public void chooseSKUProductDetail(String actor, String sku) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.chooseSKUFromProductDetail(sku)
        );
    }

    @And("Buyer check list SKU on product detail catalog page")
    public void buyerCheckListSKUProductDetailCatalog(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerProductDetailPage.SKU_IN_DETAIL(item.get("skuName"))).text().contains(item.get("skuName")),
                    Ensure.that(BuyerProductDetailPage.SKU_IN_DETAIL_ID(item.get("skuName"))).text().contains(item.get("id")),
                    Ensure.that(BuyerProductDetailPage.SKU_IN_DETAIL_PRICE(item.get("skuName"))).text().contains(item.get("price")),
                    Check.whether(item.get("quantity").contains("Not available")).otherwise(
                            Ensure.that(BuyerProductDetailPage.QUANTITY_SKU_IN_DETAIL(item.get("skuName"))).value().contains(item.get("quantity"))
                    ).andIfSo(
                            Ensure.that(BuyerProductDetailPage.SKU_IN_DETAIL_NOT_AVAILABLE(item.get("skuName"))).text().contains("Not available")
                    )
            );
    }

    @And("Head buyer check list SKU on product detail catalog page")
    public void headBuyerCheckListSKUProductDetailCatalog(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerProductDetailPage.SKU_IN_DETAIL(item.get("skuName"))).text().contains(item.get("skuName")),
                    Ensure.that(BuyerProductDetailPage.SKU_IN_DETAIL_ID(item.get("skuName"))).text().contains(item.get("id"))
            );
    }

    @And("Check badge Direct is {string}")
    public void check_badge_Direct(String check) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(BuyerProductDetailPage.BADGE_DIRECT), equalTo(Boolean.valueOf(check)))
        );
    }

    @And("Buyer check tag Express of product {string} is {string}")
    public void check_badge_Express(String product, String show) {
        if (show.equals("show"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerCatalogPage.TAG_EXPRESS(product))
            );
        else theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerCatalogPage.TAG_EXPRESS(product)).isNotDisplayed()
        );
    }

    @And("Buyer check tag {string} of sku {string} is {string}")
    public void check_badge_Express_sku(String tag, String sku, String show) {
        if (tag.equals("Express")) {
            if (show.equals("show"))
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(BuyerProductDetailPage.EXPRESS_ICON_ITEM(sku)),
                        CommonWaitUntil.isVisible(BuyerProductDetailPage.EXPRESS_ICON_PRODUCT),
                        Ensure.that(BuyerProductDetailPage.EXPRESS_ICON_PRODUCT_DES).text().contains("Fast delivery, fully consolidated")

                );
            else theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isNotVisible(BuyerProductDetailPage.EXPRESS_ICON_ITEM(sku)),
                    CommonWaitUntil.isNotVisible(BuyerProductDetailPage.EXPRESS_ICON_PRODUCT)
            );
        } else {
            if (show.equals("show"))
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(BuyerProductDetailPage.TRUCK_ICON),
                        Ensure.that(BuyerProductDetailPage.TRUCK_ICON_PRODUCT_DES).text().contains("This item will be shipped directly to you from the vendor.")
                );
            else theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isNotVisible(BuyerProductDetailPage.TRUCK_ICON)
            );
        }

    }

    @Given("Buyer go to {string} from dashboard")
    public void navigateTo(String title) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.goToTabFromDashboard(title)
        );
    }

    @Given("Buyer reorder sku {string} and quantity {string}")
    public void reorder(String sku, String quantity) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.reorder(sku, quantity)
        );
    }

    @Given("Buyer verify label pop direct item is {string}")
    public void buyer_verify_label_pop_direct_item_is(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrderDetailPage.POD_DIRECT_ITEM_HEADER_MESSAGE),
                Ensure.that(OrderDetailPage.POD_DIRECT_ITEM_HEADER_MESSAGE).text().contains(message)
        );
    }

    @Given("Buyer reorder by button reorder then verify popup add items")
    public void buyer_reorder_bu_button_reorder_then_verify_popup_add_items(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOrderDetailPage.REORDER),
                Click.on(BuyerOrderDetailPage.REORDER),
                CommonWaitUntil.isVisible(BuyerOrderDetailPage.REORDER_POPUP_TITLE)
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    // Verify
                    Ensure.that(BuyerOrderDetailPage.REORDER_POPUP_TITLE).text().contains("Add items to cart"),
                    Ensure.that(BuyerOrderDetailPage.REORDER_POPUP_HEADER(i + 1)).text().contains(list.get(i).get("header")),
                    Ensure.that(BuyerOrderDetailPage.REORDER_POPUP_DESCRIPTION(i + 1)).text().contains(list.get(i).get("description")),
                    Ensure.that(BuyerOrderDetailPage.REORDER_POPUP_PRODUCT(i + 1)).text().contains(list.get(i).get("product")),
                    Ensure.that(BuyerOrderDetailPage.REORDER_POPUP_SKU(i + 1)).text().contains(list.get(i).get("sku")),
                    Ensure.that(BuyerOrderDetailPage.REORDER_POPUP_UNITCASE(i + 1)).text().contains(list.get(i).get("unitcase")),
                    Ensure.that(BuyerOrderDetailPage.REORDER_POPUP_PRICE(i + 1)).text().contains(list.get(i).get("price")),
                    Ensure.that(BuyerOrderDetailPage.REORDER_ADD).isDisplayed()
            );
        }
    }

    @Given("Buyer add to card in popup reorder")
    public void buyer_add_to_cart_in_popup_reorder(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.reOrderPopup(infos)
        );
    }

    @And("Buyer search product {string} with sku {string} then open popup cart")
    public void search_item_and_open_popup_cart(String product, String sku) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("product", product),
                WindowTask.threadSleep(2000),
                AddToCart.chooseProductToAdd(product, sku)
        );

    }

    @And("Buyer click add to cart product {string} on popup cart")
    public void open_popup_cart(String product) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.chooseProductToAdd(product)
        );
    }

    @And("Buyer check not show add to cart button of product {string} on catalog")
    public void not_popup_cart(String product) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(product)),
                Scroll.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(product)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(product)),
                Ensure.that(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT2(product)).isNotDisplayed()
        );
    }

    @And("Check dialog button {string} is {string}")
    public void checkDialogBtt(String btn, String status) {
        if (status.contains("disable"))
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonBuyerPage.DYNAMIC_DIALOG_BUTTON(btn)).isDisabled()
            );
        if (status.contains("enable"))
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonBuyerPage.DYNAMIC_DIALOG_BUTTON(btn)).isEnabled()
            );
    }

    @And("Buyer check items on popup add cart")
    public void check_popup_cart(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(HomePageForm.SKU_ON_POPUP_ADD_CART(map.get("type"), map.get("sku"), "product")),
                    Ensure.that(HomePageForm.SKU_ON_POPUP_ADD_CART(map.get("type"), map.get("sku"), "product")).text().contains(map.get("product")),
                    Ensure.that(HomePageForm.SKU_ON_POPUP_ADD_CART(map.get("type"), map.get("sku"), "pack")).text().contains(map.get("caseUnit")),
                    Ensure.that(HomePageForm.SKU_ON_POPUP_ADD_CART(map.get("type"), map.get("sku"), "price")).text().contains(map.get("price")),
                    Ensure.that(HomePageForm.IMAGE_SKU_ON_POPUP_ADD_CART(map.get("type"), map.get("sku"))).attribute("style").contains(map.get("image")),
                    Ensure.that(HomePageForm.QUANTITY_SKU_ON_POPUP_ADD_CART(map.get("type"), map.get("sku"))).value().contains(map.get("quantity"))
            );
            if (map.get("type").equals("Pod Direct Items")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.DYNAMIC_CONTAIN_ANY_TEXT("These items will be delivered directly from the vendors.")).isDisplayed()
                );
            }
            if (map.get("type").equals("Pod Express Items")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.DYNAMIC_CONTAIN_ANY_TEXT("These items will be consolidated and delivered to you from our distribution centers.")).isDisplayed()
                );
            }
        }
    }

    @And("Buyer check items not available on popup add cart")
    public void check_not_available_popup_cart(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(HomePageForm.QUANTITY_POPUP_ADDTOCART(map.get("sku"))).isDisabled(),
                    Ensure.that(HomePageForm.MESSAGE_OUT_STOCK_OF_SKU(map.get("sku"))).isDisplayed()
            );
        }
    }

    @And("Buyer check items on popup add cart not met MOV")
    public void check_popup_cart_MOV(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(HomePageForm.SKU_ON_POPUP_ADD_CART_MOV(map.get("type"), map.get("sku"), "product")),
                    Ensure.that(HomePageForm.SKU_ON_POPUP_ADD_CART_MOV(map.get("type"), map.get("sku"), "product")).text().contains(map.get("product")),
                    Ensure.that(HomePageForm.SKU_ON_POPUP_ADD_CART_MOV(map.get("type"), map.get("sku"), "pack")).text().contains(map.get("caseUnit")),
                    Ensure.that(HomePageForm.SKU_ON_POPUP_ADD_CART_MOV(map.get("type"), map.get("sku"), "price")).text().contains(map.get("price")),
                    Ensure.that(HomePageForm.IMAGE_SKU_ON_POPUP_ADD_CART_MOV(map.get("type"), map.get("sku"))).attribute("style").contains(map.get("image")),
                    Ensure.that(HomePageForm.QUANTITY_SKU_ON_POPUP_ADD_CART_MOV(map.get("type"), map.get("sku"))).value().contains(map.get("quantity"))
            );
            if (map.get("type").equals("Pod Direct Items")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.DYNAMIC_CONTAIN_ANY_TEXT("These items will be delivered directly from the vendors.")).isDisplayed()
                );
            }
            if (map.get("type").equals("Pod Express Items")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.DYNAMIC_CONTAIN_ANY_TEXT("These items will be consolidated and delivered to you from our distribution centers.")).isDisplayed()
                );
            }
        }

    }

    @And("Buyer go to {string} from menu bar")
    public void go_to_from_menu(String title) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.MENU_ITEMS(title)),
                Click.on(BuyerCatalogPage.MENU_ITEMS(title)),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isNotVisible(BuyerCatalogPage.LOADING_BAR)
        );
    }

    @And("Buyer Search product by name {string}")
    public void buyer_search_(String product) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("product", product),
                WindowTask.threadSleep(2000)
        );
    }

    @And("{word} buyer check catalog page")
    public void checkCatalogPage(String role) {
        String role_ = Serenity.sessionVariableCalled("Role buyer").toString();
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.MENU_ITEMS("Catalog")),
                Ensure.that(CommonQuestions.pageTitle()).containsIgnoringCase(WebsiteBuyerConstants.CATALOG_TITLE),
                Ensure.that(BuyerCatalogPage.LOGO).isDisplayed(),
                Ensure.that(BuyerCatalogPage.SEARCH_BOX).isDisplayed(),
                Ensure.that(BuyerCatalogPage.DASHBOARD_BUTTON).isDisplayed(),
                Ensure.that(BuyerCatalogPage.MENU_ITEMS("Brands")).isDisplayed(),
                Ensure.that(BuyerCatalogPage.MENU_ITEMS("Order guide")).isDisplayed(),
                Ensure.that(BuyerCatalogPage.MENU_ITEMS("Recommended products")).isDisplayed(),
                Ensure.that(BuyerCatalogPage.MENU_ITEMS("Favorites")).isDisplayed(),
                Ensure.that(BuyerCatalogPage.MENU_ITEMS("Refer a Brand")).isDisplayed(),
                Ensure.that(BuyerCatalogPage.CATEGORY_BAR("All")).isDisplayed()
        );
        if (role_.equals("head buyer")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerCatalogPage.MENU_ITEMS("Promotions")).isNotDisplayed(),
                    Ensure.that(BuyerCatalogPage.CART_ON_HEADER).isNotDisplayed()
            );
        }
        if (role_.equals("buyer")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerCatalogPage.CART_ON_HEADER).isDisplayed(),
                    Ensure.that(BuyerCatalogPage.MENU_ITEMS("Promotions")).isDisplayed()
            );
        }
    }

    @And("Buyer check redirect link on catalog page")
    public void checkRedirectCatalogPage(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerCatalogPage.MENU_ITEMS(map.get("title"))),
                    Click.on(BuyerCatalogPage.MENU_ITEMS(map.get("title")))
            );
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(1000),
                    CommonWaitUntil.waitToLoadingNewWindow(map.get("newTitle")),
                    WindowTask.switchToChildWindowsByTitle(map.get("newTitle")),
                    Ensure.that(CommonHandle.getCurrentURL()).contains(map.get("redirectLink")));
        }
    }

    @And("Buyer filter by category {string} on catalog page")
    public void checkCategoryCatalogPage(String category) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isPresent(BuyerCatalogPage.CATEGORY_BAR(category)),
                JavaScriptClick.on(BuyerCatalogPage.CATEGORY_BAR(category)),
                CommonWaitUntil.isVisible(BuyerCatalogPage.CATEGORY_PAGE_TITLE())
                        .then(
                                Ensure.that(BuyerCatalogPage.CATEGORY_PAGE_TITLE()).text().containsIgnoringCase("Catalog>" + category)
                        )

        );
    }

    @And("Buyer check product on catalog")
    public void buyer_product_page(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (map.get("status").contains("showing")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(BuyerCatalogPage.PRODUCT_NAME(map.get("brand"), map.get("product"))),
                        Ensure.that(BuyerCatalogPage.PRODUCT_SKU_NUM(map.get("brand"), map.get("product"))).text().containsIgnoringCase(map.get("sku"))
                );
                if (map.containsKey("image")) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerCatalogPage.PRODUCT_IMAGE(map.get("brand"), map.get("product"))).attribute("style").contains(map.get("image"))
                    );
                }
                if (map.containsKey("price")) {
                    if (!map.get("price").isEmpty())
                        theActorInTheSpotlight().attemptsTo(
                                Ensure.that(BuyerCatalogPage.PRICE_PER_UNIT(map.get("product"))).text().containsIgnoringCase(map.get("price"))
                        );
                    else theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerCatalogPage.PRICE_PER_UNIT(map.get("product"))).isNotDisplayed()
                    );
                }
                if (map.containsKey("expressTag")) {
                    if (map.get("expressTag").equals("show"))
                        theActorInTheSpotlight().attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCatalogPage.TAG_EXPRESS(map.get("product")))
                        );
                    else theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerCatalogPage.TAG_EXPRESS(map.get("product"))).isNotDisplayed()
                    );
                }
            }
            if (map.get("status").contains("not show")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(BuyerCatalogPage.PRODUCT_NAME(map.get("brand"), map.get("product")))
                );
            }

        }
    }

    /**
     * /   active khi sku dc focus
     * next: khi sku khong dc focus
     */
    @And("Buyer check focus SKU on product detail")
    public void buyer_product_detail_page(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("focus").contains("active")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerCatalogPage.SKU_SWIPE(i + 1)).attribute("class").containsIgnoringCase("image swiper-slide active"),
                        Ensure.that(BuyerCatalogPage.MASTER_IMAGE).attribute("style").containsIgnoringCase(list.get(i).get("image"))
                );
            } else theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerCatalogPage.SKU_SWIPE(i + 1)).attribute("class").doesNotContain("image swiper-slide active")
            );
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerCatalogPage.SKU_SWIPE_IMAGE(i + 1)).attribute("style").containsIgnoringCase(list.get(i).get("image"))
            );
        }
    }

    @And("Buyer check price per unit of product on catalog")
    public void buyer_check_price(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (map.get("status").contains("showing")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(BuyerCatalogPage.PRICE_PER_UNIT(map.get("product"))),
                        Ensure.that(BuyerCatalogPage.PRICE_PER_UNIT(map.get("product"))).text().containsIgnoringCase(map.get("price"))
                );
            }
            if (map.get("status").contains("not show")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(BuyerCatalogPage.PRICE_PER_UNIT(map.get("product")))
                );
            }
        }
    }

    @And("Buyer check number product show on catalog")
    public void buyer_check_number_product(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.PAGE_SHOWING_DESCRIPTION("count")),
                Ensure.that(BuyerCatalogPage.PAGE_SHOWING_DESCRIPTION("count")).text().containsIgnoringCase(list.get(0).get("count")),
                Ensure.that(BuyerCatalogPage.PAGE_SHOWING_DESCRIPTION("total")).text().containsIgnoringCase(list.get(0).get("total"))
        );
    }

    @And("Buyer check announcement is {string}")
    public void buyer_check_announcement(String show, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (show.equals("showing")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerCatalogPage.ANNOUNCEMENT_TITLE),
                    Ensure.that(BuyerCatalogPage.ANNOUNCEMENT_TITLE).text().containsIgnoringCase(list.get(0).get("title")),
                    Ensure.that(BuyerCatalogPage.ANNOUNCEMENT_DESCRIPTION).text().containsIgnoringCase(list.get(0).get("description"))

            );
            if (!list.get(0).get("link").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerCatalogPage.ANNOUNCEMENT_LINK).text().containsIgnoringCase(list.get(0).get("link"))
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerCatalogPage.ANNOUNCEMENT_LINK).isNotDisplayed()
                );
        } else theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(BuyerCatalogPage.ANNOUNCEMENT_TITLE),
                Ensure.that(BuyerCatalogPage.ANNOUNCEMENT_TITLE).isNotDisplayed(),
                Ensure.that(BuyerCatalogPage.ANNOUNCEMENT_DESCRIPTION).isNotDisplayed(),
                Ensure.that(BuyerCatalogPage.ANNOUNCEMENT_LINK).isNotDisplayed()
        );
    }

    @And("Buyer filter on left side with:")
    public void buyer_check_filter_left(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (!list.get(0).get("express_only").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    BuyerCatalogTask.chooseExpressOnly(list.get(0))
            );
        }
        if (!list.get(0).get("state").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    BuyerCatalogTask.chooseState(list.get(0))
            );
        }
    }

    @And("Buyer filter with tags")
    public void with_tags(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    BuyerCatalogTask.and_tag(map.get("tag"))
            );
    }

    @And("Buyer filter with product qualities")
    public void withQualities(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    BuyerCatalogTask.and_product_qualities(map.get("qualities"))
            );
    }

    @And("Buyer filter with package size")
    public void withPackageSize(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    BuyerCatalogTask.and_packet_size(map.get("packageSize"))
            );
    }

    @And("Check display of filter criteria")
    public void checkCriteria(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerCatalogPage.FILTER_CRITERIA(i + 1)).text().contains(list.get(i).get("criteria"))
            );
    }

    @And("Check tags of product on catalog")
    public void checkTags(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerCatalogPage.TAGS_ON_PRODUCT(map.get("product"), map.get("tag")))
            );
    }

    @And("Check tags of product on detail")
    public void checkTagsDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(list.get(i).get("status").equals("show")).andIfSo(
                            CommonWaitUntil.isVisible(BuyerProductDetailPage.TAGS_ON_PRODUCT_DETAIL(list.get(i).get("tag")))
                    ).otherwise(
                            CommonWaitUntil.isNotVisible(BuyerProductDetailPage.TAGS_ON_PRODUCT_DETAIL(list.get(i).get("tag")))
                    )
            );
        }
    }

    @And("Check Refer Brand Page")
    public void checkReferBrand() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_TITLE("Brand Referral")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_ANY_TEXT("Tell us what brands you'd like to see on the Pod Foods catalog!")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_ANY_TEXT("When you click the Invite button, brands will be invited to Pod Foods by email.")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_ANY_TEXT("I'm currently working with this brand")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_INPUT("Brand name")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_INPUT("Email")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_INPUT("Contact name")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_BUTTON("Add more brands")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_BUTTON("Invite"))
        );
    }

    @And("Buyer enter Refer Brand info")
    public void enterReferBrand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (list.size() > 1) {
            for (int i = 1; i < list.size(); i++) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_BUTTON("Add more brands")),
                        Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Add more brands"))
                );
            }
        }
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerCatalogPage.BRAND_NAME("Brand name", i + 1)),
                    Enter.theValue(list.get(i).get("brandName")).into(BuyerCatalogPage.BRAND_NAME("Brand name", i + 1)),
                    Enter.theValue(list.get(i).get("email")).into(BuyerCatalogPage.BRAND_NAME("Email", i + 1)),
                    Enter.theValue(list.get(i).get("contact")).into(BuyerCatalogPage.BRAND_NAME("Contact name", i + 1)),
                    Check.whether(list.get(i).get("currentBrand").contains("true")).andIfSo(
                            Click.on(BuyerCatalogPage.WORKING_THIS_BRAND(i + 1))
                    )
            );
        }
    }

    @And("Buyer delete Refer Brand number {int}")
    public void deleteReferBrand(int i) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.DELETE_THIS_BRAND(i)),
                Click.on(BuyerCatalogPage.DELETE_THIS_BRAND(i))
        );
    }

    @And("Buyer search brand on brands page")
    public void searchBrand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(map.get("state").isEmpty()).otherwise(
                            CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_INPUT2("State (Province/Territory)")),
                            CommonTask.chooseItemInDropdownWithValueInput(CommonBuyerPage.DYNAMIC_INPUT2("State (Province/Territory)"),
                                    map.get("state"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(map.get("state"))),
                            CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_BAR)
                    ),
                    Check.whether(map.get("sortBy").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdown(CommonBuyerPage.DYNAMIC_INPUT2("Sort by"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(map.get("sortBy"))),
                            CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_BAR)
                    )
            );
        }
    }

    @And("Buyer check list brand on all brands page")
    public void checkListBrands(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerCatalogPage.BRAND_CARD(map.get("brand"), "name pf-ellipsis")),
                    Ensure.that(BuyerCatalogPage.BRAND_CARD(map.get("brand"), "address")).text().contains(map.get("address")),
                    Ensure.that(BuyerCatalogPage.BRAND_CARD(map.get("brand"), "contain")).attribute("style").contains(map.get("image"))
            );
        }
    }

    @And("Buyer check list product on brand detail page")
    public void vendor_check_product_on_list(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            if (map.get("status").contains("showing")) {
                theActorInTheSpotlight().attemptsTo(
                        Click.on(BuyerCatalogPage.PRODUCTS_TAP),
                        CommonWaitUntil.isVisible(BuyerCatalogPage.PRODUCT_NAME(map.get("brand"), map.get("product"))),
                        Ensure.that(BuyerCatalogPage.PRODUCT_SKU_NUM(map.get("brand"), map.get("product"))).text().containsIgnoringCase(map.get("sku"))
                );
                if (map.containsKey("image")) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerCatalogPage.PRODUCT_IMAGE(map.get("brand"), map.get("product"))).attribute("style").contains(map.get("image"))
                    );
                }
                if (map.containsKey("price")) {
                    if (!map.get("price").isEmpty())
                        theActorInTheSpotlight().attemptsTo(
                                Ensure.that(BuyerCatalogPage.PRICE_PER_UNIT(map.get("product"))).text().containsIgnoringCase(map.get("price"))
                        );
                    else theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerCatalogPage.PRICE_PER_UNIT(map.get("product"))).isNotDisplayed()
                    );
                }
                if (map.containsKey("expressTag")) {
                    if (map.get("expressTag").equals("show"))
                        theActorInTheSpotlight().attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCatalogPage.TAG_EXPRESS(map.get("product")))
                        );
                    else theActorInTheSpotlight().attemptsTo(
                            Ensure.that(BuyerCatalogPage.TAG_EXPRESS(map.get("product"))).isNotDisplayed()
                    );
                }
            }
            if (map.get("status").contains("not show")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(BuyerCatalogPage.PRODUCT_NAME(map.get("brand"), map.get("product")))
                );
            }
        }
    }

    @And("Buyer check list favorite variants")
    public void checkListFavorites(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            String skuId = map.get("skuId").toString();
            if (skuId.contains("api")) {
                skuId = Serenity.sessionVariableCalled("itemCode" + map.get("sku"));
            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "image")),
                    Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "contain")).attribute("style").contains(map.get("image")),
                    Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "product pf-ellipsis")).text().contains(map.get("product")),
                    Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "brand pf-ellipsis")).text().contains(map.get("brand")),
                    Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "metas__favorites-variant")).text().contains(map.get("sku")),
                    Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "metas__favorites-variant")).text().contains(map.get("upc")),
                    Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "metas__favorites-code")).text().contains(skuId),
                    Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "metas__favorites-price")).text().contains(map.get("unitCase"))
            );
            if (map.get("price").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "metas__favorites-price")).text().isEqualTo("")
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "metas__favorites-price")).text().contains(map.get("price"))
                );
            }
            if (map.get("expressTag").equals("show")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "express-tag express")).isDisplayed()
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(BuyerFavoritesPage.SKU_INFO(map.get("sku"), "express-tag express")).isNotDisplayed()
                );
            }
        }
    }

    @And("Buyer remove favorite SKU {string}")
    public void removeFavorite(String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerFavoritesPage.SKU_INFO(sku, "metas__favorites-variant")),
                MoveMouse.to(BuyerFavoritesPage.SKU_INFO(sku, "metas__favorites-variant")),
                CommonWaitUntil.isVisible(BuyerFavoritesPage.FAVORITE_ICON),
                MoveMouse.to(BuyerFavoritesPage.FAVORITE_ICON),
                Ensure.that(CommonBuyerPage.DYNAMIC_ANY_TEXT("Remove from favorites")).isDisplayed(),
                Click.on(BuyerFavoritesPage.FAVORITE_ICON)
        );
    }

    @And("Buyer check SKU {string} not available on favorite page")
    public void checkSKUAvailableFavorite(String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerFavoritesPage.SKU_INFO(sku, "metas__favorites-variant")),
                MoveMouse.to(BuyerFavoritesPage.SKU_INFO(sku, "metas__favorites-variant")),
                CommonWaitUntil.isVisible(BuyerFavoritesPage.CART_ICON),
                Ensure.that(BuyerFavoritesPage.CART_ICON).attribute("class").contains("disabled"),
                MoveMouse.to(BuyerFavoritesPage.CART_ICON),
                Ensure.that(CommonBuyerPage.DYNAMIC_ANY_TEXT("This product is removed or no longer available in your region.")).isDisplayed()
        );
    }

    @And("Guest fill info wholesale pricing of product detail")
    public void fill_info_wholesale_pricing_of_product_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        if (info.get("email").equals("random")) {
            String email = (CommonTask.randomAlphaNumeric(10) + "@gmail.com").toLowerCase();
            Serenity.setSessionVariable("Purchase Order Email").to(email);
            info = CommonTask.setValue(info, "email", info.get("email"), email, "random");

        }

        theActorInTheSpotlight().attemptsTo(
                BuyerCatalogTask.goToWholesalePricing(),
                BuyerCatalogTask.fillInfoWholesalePricing(info)
        );
    }

    @And("Guest choose sku in wholesale pricing of product detail")
    public void choose_sku_in_wholesale_pricing_of_product_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                BuyerCatalogTask.chooseSKUForWholesalePricing(infos)
        );
    }

    @And("Guest create wholesale pricing success")
    public void create_wholesale_pricing_success() {
        theActorInTheSpotlight().attemptsTo(
                BuyerCatalogTask.createWholesalePricingSuccess()
        );
    }

    @And("Buyer change the quantity with button")
    public void editQuantity(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    BuyerCatalogTask.checkQuantity(map),
                    Ensure.that(BuyerProductDetailPage.QUANTITY_SKU_IN_DETAIL(map.get("sku"))).attribute("value").isEqualToIgnoringCase(map.get("value"))
            );
    }


}
