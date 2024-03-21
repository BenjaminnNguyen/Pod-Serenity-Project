package cucumber.tasks.buyer;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.promotion.PromotionsPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;
import java.util.Objects;

public class HandlePromotion {

    public static Task search(Map<String, String> info) {
        return Task.where("Search promotion by brand",
                CommonTask.chooseItemInDropdownWithValueInput(PromotionsPage.BRAND_TEXTBOX, info.get("brandName"), PromotionsPage.DYNAMIC_ITEM_DROPDOWN(info.get("brandName"))),
                Check.whether(!Objects.equals(info.get("orderBrand"), ""))
                        .andIfSo(CommonTask.chooseItemInDropdown(PromotionsPage.ORDERED_BRAND, PromotionsPage.DYNAMIC_ITEM_DROPDOWN(info.get("orderBrand")))),
                Check.whether(info.get("time").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown(PromotionsPage.TIME_DROPDOWN, PromotionsPage.DYNAMIC_ITEM_DROPDOWN(CommonHandle.setDate2(info.get("time"),"MMM yyyy")))),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.D_LOADING_MESSAGE("Fetching your promotions...")),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.D_LOADING_MESSAGE("Fetching your promotions..."))
        );
    }

    public static Task showDetail(int i) {
        return Task.where("show detail promotion",
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(PromotionsPage.SHOW_DETAILS(i)),
                Click.on(PromotionsPage.SHOW_DETAILS(i)),
                CommonWaitUntil.isVisible(PromotionsPage.PRICE_PROMOTED),
                CommonWaitUntil.isVisible(PromotionsPage.HIDE_BUTTON),
                WindowTask.threadSleep(1000)

        );
    }
    public static Task closeDetail() {
        return Task.where("close detail promotion",
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(PromotionsPage.HIDE_DETAILS),
                Click.on(PromotionsPage.HIDE_DETAILS),
                WindowTask.threadSleep(1000)

        );
    }
}
