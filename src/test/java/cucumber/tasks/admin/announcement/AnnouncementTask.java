package cucumber.tasks.admin.announcement;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.checkerframework.checker.units.qual.K;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

public class AnnouncementTask {

    public static Task goToCreate() {
        return Task.where("Go to create announcement",
                CommonWaitUntil.isVisible(CommonAdminForm.CREATE_BUTTON_ON_HEADER),
                Click.on(CommonAdminForm.CREATE_BUTTON_ON_HEADER)
        );
    }

    public static Task announceToRegion(Map<String, String> info) {
        return Task.where("Go to create announcement",
                Check.whether(info.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Regions"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))
                )
        );
    }

    public static Task confirmCreate() {
        return Task.where("Go to create announcement",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task createInfo(List<Map<String, String>> info) {
        return Task.where("Go to create announcement",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Title")),
                Check.whether(info.get(0).get("title").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("title")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Title"))
                ),
                Check.whether(info.get(0).get("body").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("body")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Body"))
                ),
                Check.whether(info.get(0).get("link").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("link")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Link"))
                ),
                Check.whether(info.get(0).get("linkTitle").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("linkTitle")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Link title"))
                ),
                Check.whether(info.get(0).get("announceTo").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Announce to"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get(0).get("announceTo")))
                ),
                Check.whether(info.get(0).get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get(0).get("startDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Start delivering date")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get(0).get("stopDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get(0).get("stopDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Stop delivering date")).thenHit(Keys.TAB)
                )
        );
    }

    public static Task search(Map<String, String> info) {
        return Task.where("Search announcement",
                Check.whether(info.get("title").isEmpty()).otherwise(
                        Enter.theValue(info.get("title")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[title]"))
                ),
                Check.whether(info.get("body").isEmpty()).otherwise(
                        Enter.theValue(info.get("body")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[body]"))
                ),
                Check.whether(info.get("announcementTo").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[recipient_type]"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("announcementTo")))
                ),
                Check.whether(info.get("from").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("from"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[start_delivering_date]")).thenHit(Keys.TAB)
                ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String vendorCompany) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(VendorCompaniesPage.NAME_RESULT(vendorCompany)),
                Click.on(VendorCompaniesPage.NAME_RESULT(vendorCompany)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }
}
