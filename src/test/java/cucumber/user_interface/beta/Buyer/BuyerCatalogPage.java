package cucumber.user_interface.beta.Buyer;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class BuyerCatalogPage {

    public static Target SEARCH_BOX = Target.the("Search box")
            .located(By.xpath("(//div[@class='search-box']//input)[2]"));

    public static final Target SEARCH_BUTTON = Target.the("'Button Search'")
            .locatedBy("//div[@class='search-box']//i[contains(@class,'bx-search')]");


    public static final Target SEARCH_OPTION = Target.the("'SEARCH_OPTION'")
            .locatedBy("//div[@class='el-select sort vam']//input");


    public static final Target SEARCH_OPTION(String option) {
        return Target.the("'SEARCH_OPTION' " + option)
                .locatedBy("//div[contains(@x-placement,'start')]//*[text()='" + option + "']");
    }


    public static Target PRODUCT_NAME = Target.the("Product Name")
            .located(By.xpath("//div[@class='caption']/a[1]"));

    public static Target NO_RESULTS_FOUND = Target.the("No results found")
            .located(By.xpath("//span[normalize-space()='No results found']"));

    public static Target FIRST_PRODUCT = Target.the("First Product")
            .located(By.cssSelector("article:nth-child(1)"));

    public static Target BRAND_CARD = Target.the("First Product")
            .located(By.cssSelector("article.brand-card"));

    public static Target BRAND_CARD(String brand, String class_) {
        return Target.the("BRAND_CARD " + brand)
                .located(By.xpath("//a[contains(text(),'" + brand + "')]//ancestor::article//*[@class='" + class_ + "']"));
    }

    public static Target RECOMMENDED_PRODUCTS = Target.the("Recommended products")
            .located(By.xpath("//a[normalize-space()='Recommended products']"));

    public static Target MENU_ITEMS(String item) {
        return Target.the("MENU_ITEMS " + item)
                .located(By.xpath("//div[@class='menu']//a[normalize-space()='" + item + "']"));
    }

    public static Target PROMOTIONS = Target.the("Promotions page")
            .located(By.xpath("//a[normalize-space()='Promotions']"));

    public static Target ORDER_GUILD = Target.the("Order guide page")
            .located(By.xpath("//a[@title='Order guide']"));

    public static Target PROMOTIONS_PAGE_BRAND = Target.the("Brand field in Promotions page")
            .located(By.xpath("//div[@placeholder='Type to select']//input"));

    public static Target PROMOTIONS_PAGE_SHOW_DETAIL = Target.the("Show detail of promotion in Promotions page")
//            .located(By.cssSelector("div.record.line-item button.el-button.el-button--default span span"));
            .locatedBy("//span[text()='Show Details']");

    public static Target SKU_NAME_IN_PROMOTION_DETAIL = Target.the("SKU of promotion in Promotions page")
            .located(By.cssSelector("div.preview div.variant"));


    public static Target BRANDNAME(String brand) {
        return Target.the("brand name").locatedBy("div[class='caption'] a[title='" + brand + "']");
    }

    public static Target PRODUCT_NAME(String product) {
        return Target.the("Product name").locatedBy("//a[contains(@class,'product') and contains(text(),'" + product + "')]");
    }

    public static Target PRODUCT_NAME(String brand, String product) {
        return Target.the("Product name" + product)
                .locatedBy("//a[contains(text(),'" + brand + "')]/ancestor::div[@class='caption']/a[contains(text(),'" + product + "')]");
    }

    public static Target PRODUCT_SKU_NUM(String brand, String product) {
        return Target.the("Product name" + product)
                .locatedBy("//a[contains(text(),'" + brand + "')]/ancestor::div[@class='caption']/a[contains(text(),'" + product + "')]/ancestor::article//div[@class='skus']");
    }

    public static Target PRODUCT_IMAGE(String brand, String product) {
        return Target.the("Product name" + product)
                .locatedBy("//a[contains(text(),'" + brand + "')]/ancestor::div[@class='caption']/a[contains(text(),'" + product + "')]/ancestor::article//a[@class='image']/div");
    }

    public static Target SKU_SWIPE(int i) {
        return Target.the("SKU ")
                .locatedBy("//div[@class='thumbnails hidden-sm-and-down']//div[@class='swiper-wrapper']/div[" + i + "]");
    }

    public static Target SKU_SWIPE_IMAGE(int i) {
        return Target.the("SKU ")
                .locatedBy("//div[@class='thumbnails hidden-sm-and-down']//div[@class='swiper-wrapper']/div[" + i + "]/div");
    }

    public static Target MASTER_IMAGE = Target.the("MASTER_IMAGE ")
            .locatedBy("//div[@class='image']//div[@class='contain']");

    public static Target LOADING_PRODUCT = Target.the("Loading product ")
            .locatedBy("//div[text()='Loading product...']");

    public static Target LOADING = Target.the("Loading")
            .locatedBy("//div[@class='loading']");

    public static Target LIST_PRODUCT = Target.the("List Product")
            .located(By.cssSelector("div.products-grid .product-card.buyer.cartable"));

    public static Target PRODUCT_BRAND = Target.the("Product brand")
            .located(By.xpath("//div[@class='name pf-ellipsis']"));

    public static Target BRAND_GRID = Target.the(" brand")
            .located(By.cssSelector("div.brands-grid.pen"));

    public static Target PRODUCT_GRID = Target.the(" brand")
            .located(By.cssSelector("div.brands-grid.pen"));

    public static Target SEARCH_TYPE = Target.the(" Search type")
            .located(By.xpath("//div[@class='el-input-group__prepend']//input[@placeholder='Select']"));

    public static Target SEARCH_TYPE_BRAND = Target.the(" Search type brand ")
            .located(By.xpath("//span[normalize-space()='Brands']"));

    public static Target EXPRESS_TAG = Target.the("Express-tag ")
            .located(By.cssSelector("div.express-tag"));

    public static Target EXPRESS_TAG(String sku) {
        return Target.the("Express-tag ")
                .locatedBy("//div[contains(text(),'" + sku + "')]//ancestor::div[contains(@class,'variant')]//div[contains(@class,'express-tag')]");
    }

    public static Target SKU_ID_AFTER_NAME(String sku) {
        return Target.the("Express-tag ")
                .locatedBy("//div[contains(text(),'" + sku + "')]//following-sibling::div[contains(@class,'id')]");
    }

    public static Target PRICE_PER_UNIT(String product) {
        return Target.the("Price per unit")
                .locatedBy("//a[contains(text(),'" + product + "')]/parent::div//following-sibling::div/div[contains(@class,'unit-price')]");
    }

    public static Target PRICE_PER_UNIT = Target.the("Product price per unit")
            .located(By.cssSelector("div[class='unit-price'] span[class='current']"));

    public static Target PRICE_PER_CASE = Target.the("Product price per case")
            .located(By.cssSelector("div[class='case-price'] span[class='current']"));

    public static Target AVAILABILITY = Target.the("Product availability")
            .located(By.xpath("//dd[@class='pd-availability']"));

    public static Target PRODUCTS_TAP = Target.the("The product tap")
            .locatedBy("//div[@id='tab-products']");
    public static Target CART_ON_HEADER = Target.the("The card icon in header")
            .located(By.cssSelector("div.user-links a[title='Cart']"));

    public static Target ADD_TO_CARD_ICON = Target.the("The Add to card icon")
            .located(By.xpath("//div[@class='quick-actions']/div"));

    public static Target ADD_TO_CARD_MODAL = Target.the("Add to cart modal")
            .located(By.cssSelector("div.page__dialog-info"));

    public static Target ADD_TO_CARD_CARD = Target.the("The Item")
            .located(By.cssSelector(".add-to-cart-card"));

    public static Target WAREHOUSE_ITEM = Target.the("The Warehouse Item")
            .located(By.cssSelector("div.add-to-cart-card.warehouse-items"));

    public static Target PRODUCT_NAME_OF_WAREHOUSE_ITEM = Target.the("The Product Name of warehouse item")
            .located(By.cssSelector("div[class='product'] span"));

    public static Target SKU_NAME_OF_WAREHOUSE_ITEM = Target.the("The Sku name of warehouse item")
            .located(By.cssSelector(".info-variant__name"));

    public static Target UNIT_PRICE_OF_WAREHOUSE_ITEM = Target.the("The Unit price of warehouse item")
            .located(By.xpath("//div[@class='price']"));

    public static Target BUY_IN_TAG_OF_WAREHOUSE_ITEM = Target.the("Buy-In tag of Warehouse Item")
            .located(By.cssSelector(".add-to-cart-card.warehouse-items .promotion.buy-in"));

    public static Target ON_GOING_TAG_OF_WAREHOUSE_ITEM = Target.the("On-Going tag of Warehouse Item")
            .located(By.cssSelector("div.promotions-tag div[type=ongoing]"));

    public static Target CLOSE_POPUP_BUTTON = Target.the("Close popup button")
            .located(By.cssSelector("button[aria-label='Close']"));

    public static Target BUY_IN_TAG_OF_DIRECT_ITEM = Target.the("Buy-In tag of Direct Item")
            .located(By.cssSelector(".add-to-cart-card.pfd-items .promotion.buy-in"));

    public static Target LOADING_BAR = Target.the("The loading bar")
            .located(By.cssSelector(".loading-bar"));

    public static Target EXPRESS_ONLY_BOX = Target.the("The Express Only box")
            .located(By.cssSelector("#filter-pfd"));

    public static Target THE_CURRENT_TAG = Target.the("The Current Tag")
            .located(By.cssSelector("div.filtered-item-bar .filtered-item .fa-times-circle"));

    public static Target THE_RESET_BUTTON = Target.the("The Reset button")
            .located(By.cssSelector("div.filtered-item-bar .filtered-item.remove-all"));

    public static Target STATES_LIST = Target.the("The list of state")
            .located(By.cssSelector("#filter-by-states .css-kj6f9i-menu .css-11unzgr"));

    // List Tags
    public static Target CATALOG_TAG_2 = Target.the("Catalog Tag 2")
            .located(By.cssSelector("#tag_ids-2"));

    public static Target CATALOG_TAG_4 = Target.the("Catalog Tag 4")
            .located(By.cssSelector("#tag_ids-10"));

    public static Target CATALOG_TAG_8 = Target.the("Catalog Tag 8")
            .located(By.cssSelector("#tag_ids-14"));

    public static Target LAST_CREATE_TIME_TAG = Target.the("Last Create Time Tag")
            .located(By.cssSelector("#tag_ids-17"));

    public static Target TRA_DO_NOT_CHANGE_TAG = Target.the("Tra Do Not Change")
            .located(By.cssSelector("#tag_ids-53"));

    // List Product Qualities

    public static Target NATURAL_100_filter = Target.the("100 % Natural")
            .located(By.cssSelector("#product_quality-15"));

    public static Target ORGANIC_filter = Target.the("Organic")
            .located(By.cssSelector("#product_quality-8"));

    public static Target VEGAN_filter = Target.the("Vegan")
            .located(By.cssSelector("#product_quality-4"));


    // List Package Size
    public static Target BULK_filter = Target.the("Bulk")
            .located(By.cssSelector("#package_size-7"));

    public static Target INDIVIDUAL_SERVINGS_filter = Target.the("Individual Servings")
            .located(By.cssSelector("#package_size-1"));

    public static Target MULTIPLE_SERVINGS_filter = Target.the("Multiple Servings")
            .located(By.cssSelector("li.filter-package_size-3 input"));

    public static Target UNKNOWN_filter = Target.the("Unknown filter").located(By.cssSelector("#package_size-8"));


    // Sort
    public static Target SORT_BY_PAGE = Target.the("Sort by Page")
            .located(By.cssSelector(".catalog-actions.product-page >form:nth-child(1) >select"));

    // PAGING
    public static Target NEXT_PAGE = Target.the("Next page button")
            .located(By.cssSelector(".rb-pagination .page-item:nth-child(4) .page-link"));

    public static Target PREVIOUS_PAGE = Target.the("Previous Page button")
            .located(By.cssSelector(".rb-pagination .page-item:nth-child(2) .page-link"));

    public static Target START_PAGE = Target.the("Start Page button")
            .located(By.cssSelector(".rb-pagination .page-item:nth-child(1) .page-link"));

    public static Target END_PAGE = Target.the("End Page button")
            .located(By.cssSelector(".rb-pagination .page-item:nth-child(5) .page-link"));

    // Categories
    public static Target ALL_category = Target.the("All")
            .located(By.cssSelector("div.categories >div:nth-child(1)"));

    public static Target NEW_category = Target.the("New")
            .located(By.cssSelector("div.categories >div:nth-child(2)"));

    public static Target DAIRY_category = Target.the("Dairy")
            .located(By.cssSelector("div.categories >div:nth-child(3)"));

    public static Target FROZEN_category = Target.the("Frozen")
            .located(By.cssSelector("div.categories >div:nth-child(4)"));

    public static Target GROCERY_category = Target.the("Grocery")
            .located(By.cssSelector("div.categories >div:nth-child(5)"));

    public static Target GRAB_AND_GO_category = Target.the("Grab and Go")
            .located(By.cssSelector("div.categories >div:nth-child(6)"));

    public static Target CONFECTIONS_category = Target.the("Confections")
            .located(By.cssSelector("div.categories >div:nth-child(7)"));

    //Catalog page
    public static Target LOGO = Target.the("LOGO")
            .located(By.xpath("//img[@src='/img/logo.svg']"));
    public static final Target DASHBOARD_BUTTON = Target.the("Dashboard button")
            .locatedBy("//span[text()='Dashboard']");

    public static final Target ANNOUNCEMENT_TITLE = Target.the("ANNOUNCEMENT_TITLE")
            .locatedBy("//span[@class='announcement__title']");

    public static final Target ANNOUNCEMENT_DESCRIPTION = Target.the("ANNOUNCEMENT_DESCRIPTION")
            .locatedBy("//span[@class='announcement__description']");

    public static final Target ANNOUNCEMENT_LINK = Target.the("ANNOUNCEMENT_LINK")
            .locatedBy("//span[@class='announcement__external']");

    public static final Target EXPRESS_FILTER = Target.the("EXPRESS_FILTER")
            .locatedBy("//section[@class='express']//span");

    public static final Target STATE_FILTER = Target.the("The state filter")
            .locatedBy("//div[@placeholder='Select brand location']//input");

    public static Target TAGS_FILTER(String title) {
        return Target.the(title)
                .locatedBy("//section[@class='product-tags']//span[contains(text() , '" + title + "')]");
    }

    public static Target PRODUCT_QUALITIES_FILTER(String title) {
        return Target.the(title)
                .locatedBy("//section[@class='product-qualities']//span[contains(text() , '" + title + "')]");
    }

    public static Target PACKAGE_SIZES_FILTER(String title) {
        return Target.the(title)
                .locatedBy("//section[@class='package-sizes']//span[contains(text() , '" + title + "')]");
    }

    public static Target CATEGORY_BAR(String title) {
        return Target.the(title)
                .locatedBy("//div[@class='categories']/a[@title = '" + title + "']");
    }

    public static Target CATEGORY_PAGE_TITLE() {
        return Target.the("")
                .locatedBy("//h1[@class='page__title']");
    }

    public static Target PAGE_SHOWING_DESCRIPTION(String count) {
        return Target.the("")
                .locatedBy("//div[@class='page__description paginator']//span[@class='" + count + "']");
    }

    public static Target FILTER_CRITERIA(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='chips']/a)[" + i + "]");
    }

    public static Target TAGS_ON_PRODUCT(String product, String tag) {
        return Target.the("")
                .locatedBy("//a[contains(text(),'" + product + "')]//ancestor::article//div[@class='product-tag-stamps']/span[text()='" + tag + "']");
    }

    public static Target TAG_EXPRESS(String product) {
        return Target.the("")
                .locatedBy("//a[contains(text(),'" + product + "')]//ancestor::article//div[@class='express-tag express has-tooltip']");
    }

    /**
     * Refer Brand
     */

    public static Target BRAND_NAME(String name, int i) {
        return Target.the("Message")
                .locatedBy("(//label[normalize-space()='" + name + "']/following-sibling::div//input)[" + i + "]");
    }

    public static Target WORKING_THIS_BRAND(int i) {
        return Target.the("Message")
                .locatedBy("(//span[text()=\"I'm currently working with this brand\"])[" + i + "]");
    }

    public static Target DELETE_THIS_BRAND(int i) {
        return Target.the("Message")
                .locatedBy("(//div[@class='invitation__actions']/button)[" + i + "]");
    }

}
