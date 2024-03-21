package cucumber.user_interface.admin.fee;

import net.serenitybdd.screenplay.targets.Target;

public class AdminMiscellaneousFeePage {

    public static final Target YEAR_PICKER(String year) {
        return Target.the("YEAR_PICKER")
                .locatedBy("//div[@class='el-picker-panel__body']//div[@class='el-picker-panel__content']//table[@class='el-year-table']//a[text()='" + year + "']");
    }

    public static final Target MONTH_PICKER(String month) {
        return Target.the("MONTH_PICKER")
                .locatedBy("//div[@class='el-picker-panel__body']//div[@class='el-picker-panel__content']//table[@class='el-month-table']//a[text()='" + month + "']");
    }

    public static final Target YEAR_PICKER = Target.the("YEAR_PICKER")
            .locatedBy(".el-picker-panel__body span[class='el-date-picker__header-label']");

    public static final Target DELETE = Target.the("DELETE")
            .locatedBy("//td[contains(@class,'actions el-table__cell')]//button[2]");

}
