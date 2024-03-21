package cucumber.user_interface.admin.fee;

import net.serenitybdd.screenplay.targets.Target;

public class AdminFeePage {

    public static final Target FEE_DETAIL(String name) {
        return Target.the("Fee detail")
                .locatedBy("//div[contains(text(),'" + name + "')]//ancestor::td//following-sibling::td[contains(@class,'actions') and not(contains(@class,'hidden'))]//button");
    }
    public static final Target FREE_FILL = Target.the("Fee detail")
            .locatedBy("//label[normalize-space()='No fee if free-fill']/following-sibling::div//label");

}
