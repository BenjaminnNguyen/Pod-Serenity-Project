package steps.buyer;

import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Buyer.brands.BrandsPage;
import io.cucumber.java.en.*;
import cucumber.tasks.buyer.addtocart.AddToCart;
import cucumber.tasks.buyer.HandleBrands;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Buyer.BuyerCatalogPage;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.MoveMouse;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class BrandStepDefinitions {

    @And("Search {word} by name {string}")
    public void search_brand_by_name(String typeSearch, String valueSearch) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue(typeSearch, valueSearch),
                HandleBrands.seeDetail(valueSearch)
        );
    }

    @And("Add to cart product {string} sku {string} and quantity {string} from product list")
    public void search_brand_by_name(String product, String sku, String quantity) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.chooseProductToAdd(product, sku),
                AddToCart.addFromPopupCart(sku, quantity)
        );
    }

    @And("Click add to cart product {string} sku {string} and quantity {string} from product list")
    public void click_add_cart(String product, String sku, String quantity) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.justAddFromPopupCart(product, sku, quantity)
        );
    }

    @And("Click add to cart product {string} sku {string} and quantity {string} from favorite page")
    public void click_add_cart_favorite(String product, String sku, String quantity) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.justAddFromPopupCartFavoritePage(product, sku, quantity)
        );
    }

    @And("Go to product detail {string} from product list of Brand")
    public void search_brand_by_name(String product) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCatalogPage.PRODUCT_NAME(product)),
                MoveMouse.to(BuyerCatalogPage.PRODUCT_NAME(product)),
                WindowTask.threadSleep(500),
                Click.on(BuyerCatalogPage.PRODUCT_NAME(product)),
                CommonWaitUntil.isNotVisible(BuyerCatalogPage.LOADING_PRODUCT)
        );
    }

    @And("Search {word} by name {string} then no found")
    public void search_brand_by_name_then_no_found(String typeSearch, String brandName) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue(typeSearch, brandName),
                CommonWaitUntil.isNotVisible(BrandsPage.BRAND_IN_GRID(brandName))
        );
    }
}
