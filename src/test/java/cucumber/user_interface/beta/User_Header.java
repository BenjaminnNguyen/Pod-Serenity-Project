package cucumber.user_interface.beta;


import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class User_Header {

    public static Target SEARCH_BOX = Target.the("Search box")
            .located(By.xpath("//div[@class='search-box']//div[@class='el-select']/following::input[1]"));

    public static Target CATALOG = Target.the("Catalog")
            .located(By.xpath("//a[@href='/products']"));

    public static Target BRANDS = Target.the("Brands")
            .located(By.xpath("//a[@href='/brands']"));

    public static Target PROMOTIONS = Target.the("Promotions")
            .located(By.xpath("//a[@href='/promotions']"));

    public static Target ORDER_GUIDE = Target.the("Order Guide")
            .located(By.xpath("//a[text()='Order Guide']"));

    public static Target RECOMMENDED_PRODUCTS = Target.the("Recommended Products")
            .located(By.xpath("//a[@href='/recommended_products']"));

    public static Target AUTHORIZED_PRODUCTS = Target.the("Authorized Products")
            .located(By.xpath("//a[@href=\"/authorized_products\"]"));

    public static Target FAVORITES_PRODUCTS = Target.the("The Favorites Page")
            .located(By.xpath("//a[@href=\"/favorites\"]"));

    public static Target CART_ICON = Target.the("Icon Cart")
            .located(By.xpath("//div[@class='for-desktop']//a[@title='Cart']"));

    public static Target START_SHOPPING = Target.the("Start Shopping")
            .located(By.xpath("//a[normalize-space()='Start Shopping']"));

//    public static Target DASHBOARD = Target.the("Dashboard icon")
//                .located(By.xpath("//span[normalize-space()='Dashboard']"));

    public static Target COUNTER_OF_CART = Target.the("Counter of Cart")
            .located(By.cssSelector(".top-bar .actions div.cart .counter"));

    public static Target TOTAL_VALUE_OF_CART = Target.the("Total value on the cart icon")
            .located(By.cssSelector(".top-bar .actions div.cart .caption"));

    public static Target LOADING_BAR = Target.the("The loading bar")
            .located(net.serenitybdd.core.annotations.findby.By.cssSelector(".loading-bar"));

    public static Target MENU_BAR = Target.the("menu bar")
            .located(By.xpath("//aside[@class='dashboard-side-bar']//div[@class='menu']"));

    public static Target BRAND_REFERRAL = Target.the("Brand referral")
            .located(By.xpath("//a[@href='/brands/invite']"));
    /**
     * Log out
     */
    public static Target LOG_OUT_BUTTON = Target.the("Log out button")
            .located(By.xpath("//div[text()='Log out']"));

    public static Target LOG_OUT_POPUP = Target.the("Log out popup")
            .located(By.xpath("//p[text()='Are you sure you want to log out?']"));

    public static Target LOG_OUT_POPUP_BUTTON = Target.the("Log out button")
            .located(By.xpath("//button//span[contains(text(),'Log out')]"));
}
