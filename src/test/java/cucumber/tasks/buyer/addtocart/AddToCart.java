package cucumber.tasks.buyer.addtocart;

import cucumber.questions.CommonQuestions;
import cucumber.singleton.GVs;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.products.BuyerProductDetailPage;
import cucumber.user_interface.beta.Buyer.BuyerCatalogPage;
import cucumber.user_interface.beta.Buyer.cart.CartPage;
import cucumber.user_interface.beta.HomePageForm;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.waits.Wait;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static org.hamcrest.CoreMatchers.equalTo;

public class AddToCart {
    public static Task searchByValue(String typeSearch, String value) {
        return Task.where("Tìm kiếm theo " + typeSearch,
//                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_BUTTON),
                CommonWaitUntil.isVisible(HomePageForm.SEARCH_FIELD),
                Check.whether(typeSearch.equalsIgnoreCase("Brands"))
                        .andIfSo(
                                CommonWaitUntil.isVisible(BuyerCatalogPage.MENU_ITEMS("Brands")),
                                Click.on(BuyerCatalogPage.MENU_ITEMS("Brands")),
                                WindowTask.threadSleep(1000),
                                Enter.theValue(value).into(HomePageForm.SEARCH_FIELD).thenHit(Keys.ENTER),
                                WindowTask.threadSleep(1000),
                                // Chọn loại filter để web search do lỗi kailua (filter brand khác filter product)
                                CommonWaitUntil.isVisible(HomePageForm.SORT_FILTER_BRAND_BUTTON),
                                CommonTask.chooseItemInDropdown1(HomePageForm.SORT_FILTER_BRAND_BUTTON, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3("Order by name — A-Z"))
                        ).otherwise(
                                CommonWaitUntil.isVisible(BuyerCatalogPage.MENU_ITEMS("Catalog")),
                                Click.on(BuyerCatalogPage.MENU_ITEMS("Catalog")),
                                Enter.theValue(value).into(HomePageForm.SEARCH_FIELD).thenHit(Keys.ENTER),
                                WindowTask.threadSleep(1000),
                                CommonWaitUntil.isVisible(HomePageForm.SORT_FILTER_PRODUCT_BUTTON),
                                CommonTask.chooseItemInDropdown1(HomePageForm.SORT_FILTER_PRODUCT_BUTTON, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3("Order by Popularity"))
                        )
        );
    }

    public static Task searchByValue1(String typeSearch, String typeSort, String value) {
        return Task.where("Tìm kiếm theo " + typeSearch,
//                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_BUTTON),
//                Check.whether(typeSearch.equalsIgnoreCase("Brands"))
//                        .andIfSo(
//                                // chọn brand
//                                CommonTask.chooseItemInDropdown(HomePageForm.PRODUCT_BUTTON, HomePageForm.TYPE_SEARCH(typeSearch))
//                        ),
                CommonWaitUntil.isPresent(HomePageForm.SEARCH_FIELD),
                CommonWaitUntil.isPresent(HomePageForm.SEARCH_BUTTON),
                Enter.theValue(value).into(HomePageForm.SEARCH_FIELD).thenHit(Keys.ENTER),
                // Chọn loại filter để web search do lỗi kailua (filter brand khác filter product)
                Check.whether(typeSearch.equalsIgnoreCase("Brands"))
                        .andIfSo(
                                CommonWaitUntil.isVisible(HomePageForm.SORT_FILTER_BRAND_BUTTON),
                                CommonTask.chooseItemInDropdown1(HomePageForm.SORT_FILTER_BRAND_BUTTON, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3("Order by name — A-Z")))
                        .otherwise(
                                CommonWaitUntil.isVisible(HomePageForm.SORT_FILTER_PRODUCT_BUTTON),
                                CommonTask.chooseItemInDropdown1(HomePageForm.SORT_FILTER_PRODUCT_BUTTON, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(typeSort))),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task searchByValue2(String typeSearch, String value) {
        return Task.where("Tìm kiếm theo " + typeSearch,
                Enter.theValue(value).into(HomePageForm.SEARCH_FIELD).thenHit(Keys.ENTER),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task add(String amount) {
        return Task.where("Thêm vào giỏ hàng với số lượng " + amount,
                CommonWaitUntil.isVisible(HomePageForm.ADDTOCART_BUTTON),
                Click.on(HomePageForm.ADDTOCART_BUTTON),
                Enter.theValue(amount).into(HomePageForm.AMOUNT_FIELD),
                Click.on(HomePageForm.ADDTOCART_IN_POPUP_BUTTON)
        );
    }

    public static Task chooseProductToAdd(String productName, String name) {
        return Task.where("Choose product to add to cart",
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                Scroll.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                CommonWaitUntil.isVisible(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName)),
                Click.on(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName)),
                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART(name))
        );
    }

    public static Task chooseProductToAdd(String productName) {
        return Task.where("Choose product to add to cart",
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                Scroll.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                CommonWaitUntil.isVisible(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT2(productName)),
                Click.on(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT2(productName))
        );
    }

    public static Task chooseProductToAdd(String productName, String brand, String name) {
        return Task.where("Choose product to add to cart",
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName, brand)),
                Scroll.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName, brand)),
//                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName, brand)),
//                CommonWaitUntil.isVisible(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName, brand)),
//                CommonWaitUntil.isPresent(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName, brand)),
                JavaScriptClick.on(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName, brand)),
                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART(name))
        );
    }

    // search sku vs xpath text constant
    public static Task addFromPopupCart(String name, String amount) {
        return Task.where("Add to cart from cart tool tip" + amount,
                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)),
                Enter.theValue(amount).into(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)).thenHit(Keys.ENTER),
                CommonWaitUntil.isClickable(HomePageForm.ADDTOCART_BUTTON_IN_POPUP),
                Click.on(HomePageForm.ADDTOCART_BUTTON_IN_POPUP),
                // Check popup confirm short date item
                Check.whether(valueOf(HomePageForm.CONFIRM_POPUP), isCurrentlyVisible())
                        .andIfSo(Click.on(HomePageForm.UNDERSTAND_BUTTON)),
                // nếu hiện popup minimize order
                Check.whether(valueOf(HomePageForm.UPDATECART_BUTTON_IN_POPUP), isCurrentlyVisible())
                        .andIfSo(
                                Enter.theValue(amount).into(HomePageForm.QUANTITY_POPUP_UPDATECART(name)).thenHit(Keys.ENTER),
                                CommonWaitUntil.isClickable(HomePageForm.UPDATECART_BUTTON_IN_POPUP),
                                Click.on(HomePageForm.UPDATECART_BUTTON_IN_POPUP)
                        )
        );
    }

    // search sku vs xpath text =
    public static Task addFromPopupCart1(String name, String amount) {
        return Task.where("Add to cart from cart tool tip" + amount,
                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART1(name)),
                Enter.theValue(amount).into(HomePageForm.QUANTITY_POPUP_ADDTOCART1(name)).thenHit(Keys.ENTER),
                CommonWaitUntil.isClickable(HomePageForm.ADDTOCART_BUTTON_IN_POPUP),
                Click.on(HomePageForm.ADDTOCART_BUTTON_IN_POPUP),
                // Check popup confirm short date item
                Check.whether(valueOf(HomePageForm.CONFIRM_POPUP), isCurrentlyVisible())
                        .andIfSo(Click.on(HomePageForm.UNDERSTAND_BUTTON)),
                // nếu hiện popup minimize order
                Check.whether(valueOf(HomePageForm.UPDATECART_BUTTON_IN_POPUP), isCurrentlyVisible())
                        .andIfSo(
                                Enter.theValue(amount).into(HomePageForm.QUANTITY_POPUP_UPDATECART(name)).thenHit(Keys.ENTER),
                                CommonWaitUntil.isClickable(HomePageForm.UPDATECART_BUTTON_IN_POPUP),
                                Click.on(HomePageForm.UPDATECART_BUTTON_IN_POPUP)
                        )
        );
    }

    public static Task chooseItemAddCartPopup(String name, String amount) {
        return Task.where("Add to cart from cart tool tip" + amount,
                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)),
                Enter.theValue(amount).into(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)).thenHit(Keys.TAB)
        );
    }

    public static Task checkAddToCartSuccess(String sku) {
        return Task.where("Check add to cart success",
                // chờ mất popup message item add to cart
                CommonWaitUntil.isNotVisible(CartPage.MESSAGE_ADD_TO_CART),
                CommonWaitUntil.isVisible(CartPage.SKU_SIDE_BAR(sku))
        );
    }

    public static Task justAddFromPopupCart(String productName, String name, String amount) {
        return Task.where("Add to cart from cart tool tip" + amount,
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.ADD_TO_CART_BY_SKU(name)),
                CommonWaitUntil.isVisible(HomePageForm.ADD_TO_CART_TOOLTIP_BY_SKU(name)),
                Click.on(HomePageForm.ADD_TO_CART_TOOLTIP_BY_SKU(name)),
                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)),
                Enter.theValue(amount).into(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)).thenHit(Keys.ENTER),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task justUpdateQuantityFromPopupCart(String productName, String name, String amount) {
        return Task.where("Add to cart from cart tool tip" + amount,
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                CommonWaitUntil.isVisible(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName)),
                Click.on(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName)),
                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)),
                Enter.theValue(amount).into(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)).thenHit(Keys.ENTER)
        );
    }

    public static Task openPopupCart(String productName) {
        return Task.where("Add to cart from cart tool tip",
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                CommonWaitUntil.isVisible(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName)),
                Click.on(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName))
        );
    }

    public static Task justAddFromPopupCartFavoritePage(String productName, String name, String amount) {
        return Task.where("Add to cart from cart tool tip" + amount,
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.ADD_TO_CART_BY_SKU(name)),
                CommonWaitUntil.isVisible(HomePageForm.ADD_TO_CART_TOOLTIP_BY_SKU(name)),
                Click.on(HomePageForm.ADD_TO_CART_TOOLTIP_BY_SKU(name)),
                WindowTask.threadSleep(2000)
        );
    }

    public static Task chooseSKUFromProductDetail(String skuName) {
        return Task.where("Chọn SKU " + skuName,
                CommonWaitUntil.isVisible(BuyerProductDetailPage.SKU_IN_DETAIL(skuName)),
                Scroll.to(BuyerProductDetailPage.SKU_IN_DETAIL(skuName)),
                Click.on(BuyerProductDetailPage.SKU_IN_DETAIL(skuName)),
//                CommonWaitUntil.isVisible(BuyerProductDetailPage.SKU_NAME(skuName)),
//                Click.on(BuyerProductDetailPage.SKU_NAME(skuName)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task addFromProductDetail(String skuName, String amount) {
        return Task.where("Add to cart from product detail" + amount,
                chooseSKUFromProductDetail(skuName),
                CommonWaitUntil.isVisible(BuyerProductDetailPage.QUANTITY_SKU_IN_DETAIL(skuName)),
                Check.whether(amount.isEmpty()).otherwise(
                        Clear.field(BuyerProductDetailPage.QUANTITY_SKU_IN_DETAIL(skuName)),
                        Enter.theValue(amount).into(BuyerProductDetailPage.QUANTITY_SKU_IN_DETAIL(skuName))),
                Scroll.to(BuyerProductDetailPage.ADD_TO_CART_BUTTON),
                Click.on(BuyerProductDetailPage.ADD_TO_CART_BUTTON),
//                CommonWaitUntil.isVisible(BuyerProductDetailPage.ALERT_ADD_CART),
                CommonWaitUntil.isNotVisible(BuyerProductDetailPage.ALERT_ADD_CART)
        );
    }

    public static Performable removeItemInCartBefore() {
        Boolean check = true;
        while (check) {
            if (CommonQuestions.isControlUnDisplay(HomePageForm.CART_REMOVE_BEFORE).answeredBy(theActorInTheSpotlight()))
                check = false;
            else {
                theActorInTheSpotlight().attemptsTo(
                        removeItemInCartBefore2()
                );
            }
        }
        return Wait.until(CommonQuestions.targetText(HomePageForm.CART_EMPTY_LABEL), equalTo("Your cart is currently empty."))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    public static Task removeItemInCartBefore2() {
        return Task.where("remove cart to empty",
                CommonWaitUntil.isVisible(HomePageForm.CART_REMOVE_BEFORE),
                Click.on(HomePageForm.CART_REMOVE_BEFORE),
                CommonWaitUntil.isVisible(HomePageForm.REMOVE_BUTTON_IN_POUP),
                Click.on(HomePageForm.REMOVE_BUTTON_IN_POUP),
                CommonWaitUntil.isVisible(HomePageForm.ITEM_REMOVED_FROM_CARD),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(HomePageForm.ITEM_REMOVED_FROM_CARD)
        );
    }

    public static Task goToCartDetailPage() {
        return Task.where("Go to cart detail",
                WindowTask.threadSleep(2000),
                CommonWaitUntil.isClickable(BuyerCatalogPage.CART_ON_HEADER),
                Click.on(BuyerCatalogPage.CART_ON_HEADER),
//                // Wait recommment sos popup
//                WindowTask.threadSleep(2000),
//                Check.whether(valueOf(HomePageForm.CLOSE_POPUP_ADD_TO_CART), isCurrentlyVisible())
//                        .andIfSo(
//                                Click.on(HomePageForm.CLOSE_POPUP_ADD_TO_CART).afterWaitingUntilEnabled()),
                CommonWaitUntil.isClickable(BuyerCatalogPage.CART_ON_HEADER),
                CommonWaitUntil.isVisible(CartPage.CHECKOUT_BUTTON)
        );
    }

    public static Task closeRecommendedItemsModal() {
        return Task.where("Close popup recommended item modal",
                Check.whether(valueOf(CartPage.RECOMMEND_ITEM_POPUP), isCurrentlyVisible())
                        .andIfSo(
                                CommonWaitUntil.isVisible(CartPage.RECOMMEND_ITEM_POPUP),
                                Click.on(CartPage.RECOMMEND_ITEM_POPUP_CLOSE_BUTTON).afterWaitingUntilEnabled(),
                                CommonWaitUntil.isNotVisible(CartPage.RECOMMEND_ITEM_POPUP))
        );
    }

    public static Task closeSOS() {
        return Task.where("close SOS",
                // Wait recommment sos popup
                WindowTask.threadSleep(1000),
                Check.whether(valueOf(HomePageForm.CLOSE_POPUP_ADD_TO_CART), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.CLOSE_POPUP_ADD_TO_CART).afterWaitingUntilEnabled())
        );
    }

    public static Task chooseProductToPreOrder(String productName, String name) {
        return Task.where("Choose product to pre order",
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                CommonWaitUntil.isVisible(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName)),
                Click.on(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName)),
                CommonWaitUntil.isVisible(HomePageForm.PRE_ORDER_LINK),
                Click.on(HomePageForm.PRE_ORDER_LINK),
                CommonWaitUntil.isVisible(HomePageForm.QUANTITY_POPUP_ADDTOCART(name))

        );
    }

    public static Task enterAmountOfSku(String name, String amount) {
        return Task.where("Enter amount of sku want pre order",
                Enter.theValue(amount).into(HomePageForm.QUANTITY_POPUP_ADDTOCART(name)).thenHit(Keys.ENTER)
        );
    }

    public static Task createPreOrderSuccess() {
        return Task.where("Create pre order success",
                CommonWaitUntil.isClickable(HomePageForm.PRE_ORDER_BUTTON),
                Click.on(HomePageForm.PRE_ORDER_BUTTON),
                CommonWaitUntil.isNotVisible(HomePageForm.PRE_ORDER_SENT_MESSAGE),
                Click.on(HomePageForm.CLOSE_POPUP_ADD_TO_CART)
        );
    }

    public static Task closeAddCart() {
        return Task.where("closeAddCart",
                Check.whether(CommonQuestions.isControlDisplay(CartPage.CLOSE_MOV_ALERT_ADD_CART)).andIfSo(
                        Click.on(CartPage.CLOSE_MOV_ALERT_ADD_CART),
                        CommonWaitUntil.isNotVisible(CartPage.CLOSE_MOV_ALERT_ADD_CART)
                ),
                Check.whether(CommonQuestions.isControlDisplay(CartPage.CLOSE_ALERT_ADD_CART)).andIfSo(
                        Click.on(CartPage.CLOSE_ALERT_ADD_CART),
                        CommonWaitUntil.isNotVisible(CartPage.CLOSE_MOV_ALERT_ADD_CART)
                )
        );
    }

    public static Task openPopupAddToCart(String product) {
        return Task.where("Open popup add to cart of product " + product,
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(product)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(product)),
                Click.on(HomePageForm.ADD_TO_CART_BY_SKU(product)),
                CommonWaitUntil.isVisible(HomePageForm.PRE_ORDER_LINK)
        );
    }

    public static Task changeQuantityInBeforeCheckout(Map<String, String> info) {
        return Task.where("Change quantity in before checkout",
                Clear.field(CartPage.ITEM_CART_QUANTITY_BY_SKUID(info.get("skuID"))),
                Enter.theValue(info.get("quantity")).into(CartPage.ITEM_CART_QUANTITY_BY_SKUID(info.get("skuID"))).thenHit(Keys.ENTER)
        );
    }

    public static Task changeQuantityInBeforeCheckoutByButton(Map<String, String> info) {
        return Task.where("Change quantity in before checkout by button",
                Check.whether(!info.get("increase").equals(""))
                        .andIfSo(Click.on(CartPage.INCREASE_BUTTON)),
                Check.whether(!info.get("decrease").equals(""))
                        .andIfSo(Click.on(CartPage.DECREASE_BUTTON))
        );
    }

    public static Task changeQuanityOfSkuInMovAlert(Map<String, String> info) {
        return Task.where("Change quantity of sku in mov alert",
                CommonWaitUntil.isVisible(CartPage.MOV_ALERT_QUANTITY_TEXTBOX(info.get("sku"))),
                Clear.field(CartPage.MOV_ALERT_QUANTITY_TEXTBOX(info.get("sku"))),
                Enter.theValue(info.get("quantity")).into(CartPage.MOV_ALERT_QUANTITY_TEXTBOX(info.get("sku"))).thenHit(Keys.ENTER)
        );
    }

    public static Task updateCartFromPopupMovAlertSuccess() {
        return Task.where("Update cart from popup mov alert success",
                CommonWaitUntil.isClickable(CommonBuyerPage.DYNAMIC_BUTTON("Update cart")),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Update cart"))
        );
    }

    public static Task updateCartFromPopupPopupCartSuccess() {
        return Task.where("Update cart from popup cart success",
                CommonWaitUntil.isClickable(CommonBuyerPage.DYNAMIC_BUTTON("Add to cart")),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Add to cart"))
        );
    }

    public static Task changeQuanityOfSkuInPopupCart(Map<String, String> info) {
        return Task.where("Change quantity of sku in mov alert",
                Clear.field(HomePageForm.QUANTITY_POPUP_ADDTOCART(info.get("sku"))),
                Enter.theValue(info.get("quantity")).into(HomePageForm.QUANTITY_POPUP_ADDTOCART(info.get("sku"))).thenHit(Keys.ENTER)
        );
    }

    public static Performable removeItemSpecInCartBefore(String skuID) {
        return Task.where("Remove item specific in cart before",
                CommonWaitUntil.isVisible(HomePageForm.CART_REMOVE_BEFORE(skuID)),
                Click.on(HomePageForm.CART_REMOVE_BEFORE(skuID)),
                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP("Are you sure you want to remove this item from your shopping cart?")),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Remove")),
                CommonWaitUntil.isNotVisible(HomePageForm.ITEM_REMOVED_FROM_CARD)
        );
    }

    public static Performable removeItemSpecThenCancelInCartBefore(String skuID) {
        return Task.where("Remove item specific then cancel in cart before",
                CommonWaitUntil.isVisible(HomePageForm.CART_REMOVE_BEFORE(skuID)),
                Click.on(HomePageForm.CART_REMOVE_BEFORE(skuID)),
                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP("Are you sure you want to remove this item from your shopping cart?")),
                Ensure.that(CommonBuyerPage.D_MESSAGE_POPUP("Are you sure you want to remove this item from your shopping cart?")).isDisplayed(),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Cancel"))
        );
    }

    public static Performable removeItemSpecInCartDetail(String skuName) {
        return Task.where("Remove item specific in cart before",
                CommonWaitUntil.isVisible(CartPage.ITEM_CART_REMOVE_BUTTON(skuName)),
                Click.on(CartPage.ITEM_CART_REMOVE_BUTTON(skuName)),
                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP("Are you sure you want to remove this item from your shopping cart?")),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Remove")),
                CommonWaitUntil.isNotVisible(HomePageForm.ITEM_REMOVED_FROM_CARD)
        );
    }

    public static Performable AddSkuInRecommendedItemModal(List<Map<String, String>> infos) {
        return Task.where("Add sku in recommended item modal",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CartPage.RECOMMEND_ITEM_POPUP),
                                Clear.field(CartPage.RECOMMEND_ITEM_POPUP_ITEM_QUANTITY(info.get("sku"))),
                                Enter.theValue(info.get("quantity")).into(CartPage.RECOMMEND_ITEM_POPUP_ITEM_QUANTITY(info.get("sku"))).thenHit(Keys.TAB),
                                CommonWaitUntil.isNotVisible(CommonBuyerPage.D_MESSAGE_POPUP("Cart updated!"))
                        );
                    }
                }
        );
    }

    public static Performable saveForLater(String skuName) {
        return Task.where("Save fo later item in cart detail",
                CommonWaitUntil.isVisible(CartPage.SAVE_FOR_LATER_BTN(skuName)),
                Click.on(CartPage.SAVE_FOR_LATER_BTN(skuName)),
                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP("Item moved to Saved for later section!")),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.D_MESSAGE_POPUP("Item moved to Saved for later section!"))
        );
    }
    public static Performable moveCartSaveForLater(String skuName) {
        return Task.where("Move to cart in save fo later item",
                CommonWaitUntil.isVisible(CartPage.SAVE_FOR_LATER_MOVE_CART(skuName)),
                Click.on(CartPage.SAVE_FOR_LATER_MOVE_CART(skuName)),
                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP("Item moved to cart!")),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.D_MESSAGE_POPUP("Item moved to cart!"))
        );
    }
}
