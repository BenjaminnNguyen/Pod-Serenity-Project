package cucumber.tasks.buyer;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Buyer.brands.BrandsPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;

public class HandleBrands {

    public static Task seeDetail(String brandName) {
        return Task.where("Xem chi tiết brand ",
                CommonWaitUntil.isVisible(BrandsPage.BRAND_IN_GRID(brandName)),
                Click.on(BrandsPage.BRAND_IN_GRID(brandName)),
                CommonWaitUntil.isVisible(BrandsPage.PRODUCT_TAB)
        );
    }
}
