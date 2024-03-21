package cucumber.user_interface.admin.fee;

import net.serenitybdd.screenplay.targets.Target;

public class AdminSmallOrderSurchargePage {

    public static final Target FEE_DETAIL(String name) {
        return Target.the("Fee detail")
                .locatedBy("//div[contains(text(),'" + name + "')]//ancestor::td//following-sibling::td[contains(@class,'actions') and not(contains(@class,'hidden'))]//button");
    }
    public static final Target SMALL_ORDER_SURCHARGE_DETAIL = Target.the("SMALL_ORDER_SURCHARGE_DETAIL")
            .locatedBy("//td[contains(@class,'actions el-table__cell')]//button[contains(@type,'button')]");

}
