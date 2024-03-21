package cucumber.tasks.admin.changeRequests;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.changeRequest.AdminChangeRequestPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleChangeRequests {

    public static Task search(Map<String, String> info) {
        return Task.where("Search Change request",
                Check.whether(info.get("value").isEmpty()).otherwise(
                        Check.whether(info.get("type").contains("drop")).otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("value"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_INPUT(info.get("field"))).thenHit(Keys.TAB)

                        ).andIfSo(
                                Click.on(CommonAdminForm.DYNAMIC_INPUT(info.get("field"))),
                                CommonTask.ChooseValueFromSuggestions(info.get("value"))

                        ), Click.on(CommonAdminForm.SEARCH_BUTTON),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                )
        );
    }

    public static Task search1(Map<String, String> info) {
        return Task.where("Search Change request",
                Check.whether(info.get("productName").equals(""))
                        .otherwise(Enter.theValue(info.get("productName")).into(CommonAdminForm.DYNAMIC_INPUT("Product name"))),
                Check.whether(info.get("skuName").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_INPUT("SKU name / Item code"), info.get("skuName"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("skuName")))),
                Check.whether(info.get("region").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_INPUT("Region"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Check.whether(info.get("vendorCompany").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_INPUT("Vendor company"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))),
                Check.whether(info.get("vendorBrand").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_INPUT("Vendor brand"), info.get("vendorBrand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorBrand")))),
                Check.whether(info.get("requestFrom").equals(""))
                        .otherwise(Enter.theValue(info.get("requestFrom")).into(CommonAdminForm.DYNAMIC_INPUT("Request (from)")).thenHit(Keys.ENTER)),
                Check.whether(info.get("requestTo").equals(""))
                        .otherwise(Enter.theValue(info.get("requestTo")).into(CommonAdminForm.DYNAMIC_INPUT("Request (to)")).thenHit(Keys.ENTER)),
                Check.whether(info.get("applyFrom").equals(""))
                        .otherwise(Enter.theValue(info.get("applyFrom")).into(CommonAdminForm.DYNAMIC_INPUT("Apply (from)")).thenHit(Keys.ENTER)),
                Check.whether(info.get("applyTo").equals(""))
                        .otherwise(Enter.theValue(info.get("applyTo")).into(CommonAdminForm.DYNAMIC_INPUT("Apply (to)")).thenHit(Keys.ENTER)),
                Check.whether(info.get("type").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_INPUT("Type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("type")))),
                Check.whether(info.get("status").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_INPUT("Status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("status")))),
                Check.whether(info.get("store").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_INPUT("Store"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))),
                Check.whether(info.get("managedBy").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_INPUT("Vendor company Managed by"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managedBy")))),


                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable goToDetail(String value) {
        return Task.where("Add tags in create brand",
                actor -> {
                    String id = null;
                    if (value.equals("")) {
                        id = Serenity.sessionVariableCalled("ID Change request");
                    }

                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(AdminChangeRequestPage.D_EDIT_BUTTON(id)),
                            Click.on(AdminChangeRequestPage.D_EDIT_BUTTON(id))
                    );
                }
        );
    }

    public static Task edit(Map<String, String> info) {
        return Task.where("Edit change request",
                CommonWaitUntil.isVisible(AdminChangeRequestPage.EFFECT_DATE_TEXTBOX_DETAIL),
                Enter.theValue(CommonHandle.setDate2(info.get("effectiveDate"), "MM/dd/yy")).into(AdminChangeRequestPage.EFFECT_DATE_TEXTBOX_DETAIL).thenHit(Keys.ENTER),
                Enter.theValue(info.get("sizeL")).into(AdminChangeRequestPage.SIZE_L_TEXTBOX_DETAIL),
                Enter.theValue(info.get("sizeW")).into(AdminChangeRequestPage.SIZE_W_TEXTBOX_DETAIL),
                Enter.theValue(info.get("sizeH")).into(AdminChangeRequestPage.SIZE_H_TEXTBOX_DETAIL)
        );
    }

    public static Task editSuccess() {
        return Task.where("Edit change request success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update"))
        );
    }

    public static Task delete(String id) {
        return Task.where("Delete change request success",
                CommonWaitUntil.isVisible(AdminChangeRequestPage.D_DELETE_BUTTON(id)),
                Click.on(AdminChangeRequestPage.D_DELETE_BUTTON(id)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(AdminChangeRequestPage.D_DELETE_BUTTON(id))
        );
    }
}
