package cucumber.tasks.admin.brands;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.BrandReferralPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.claims.AdminClaimsPage;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.questions.Text;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleBrandReferrals {

    public static Task search(Map<String, String> info) {
        return Task.where("Search brand invite",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_name")),
                Check.whether(info.get("brand").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("brand")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_name"))),
                Check.whether(info.get("store").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("store")))),
                Check.whether(info.get("email").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("email")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email"))),
                Check.whether(info.get("contact").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("contact")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("contact_name"))),
                Check.whether(info.get("onboarded").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("onboarded"), info.get("onboarded"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("onboarded")))),
                Check.whether(info.get("vendorCompany").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorCompany")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail() {
        return Task.where("Go to detail",
                Click.on(BrandReferralPage.ID_BRAND_REFERRAL),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable chooseBrandAndMark(List<Map<String, String>> infos) {
        return Task.where("Choose brand and mark as onboarded",
                actor -> {
                    for (int i = 0; i < infos.size(); i++) {
                        String brandInput = BrandReferralPage.BRAND_TEXTBOX(i + 1).resolveFor(theActorInTheSpotlight()).getAttribute("value").trim();
                        if (brandInput.equals(infos.get(i).get("brand"))) {
                            actor.attemptsTo(
                                    Click.on(BrandReferralPage.CHECKBOX(i + 1)),
                                    WindowTask.threadSleep(500)
                            );
                        }
                    }
                }
        );
    }

    public static Performable editInfo(List<Map<String, String>> infos) {
        return Task.where("Edit info",
                actor -> {
                    for (int i = 0; i < infos.size(); i++) {
                        String brandInput = BrandReferralPage.BRAND_TEXTBOX(i + 1).resolveFor(theActorInTheSpotlight()).getAttribute("value").trim();
                        if (brandInput.equals(infos.get(i).get("brand"))) {
                            actor.attemptsTo(
                                    Check.whether(infos.get(i).get("brandEdit").isEmpty())
                                            .otherwise(
                                                    Enter.theValue(infos.get(i).get("brandEdit")).into(BrandReferralPage.BRAND_TEXTBOX(i + 1))),
                                    Check.whether(infos.get(i).get("email").isEmpty())
                                            .otherwise(
                                                    Enter.theValue(infos.get(i).get("email")).into(BrandReferralPage.EMAIL_TEXTBOX(i + 1))),
                                    Check.whether(infos.get(i).get("contact").isEmpty())
                                            .otherwise(
                                                    Enter.theValue(infos.get(i).get("contact")).into(BrandReferralPage.CONTACT_TEXTBOX(i + 1))),
                                    Check.whether(infos.get(i).get("work").isEmpty())
                                            .otherwise(
                                                    CommonTask.chooseItemInDropdownWithValueInput(BrandReferralPage.WORKING_TEXTBOX(i + 1), infos.get(i).get("work"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(i).get("work")))),
                                    Check.whether(infos.get(i).get("note").isEmpty())
                                            .otherwise(
                                                    Enter.theValue(infos.get(i).get("note")).into(BrandReferralPage.NOTE_TEXTAREA(i + 1)))
                            );
                        }
                    }
                }
        );
    }

    public static Task save() {
        return Task.where("Save",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Brand referal have been saved successfully!")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)
        );
    }

    public static Task chooseMarkAsOnboardedAndConfirm(String vendorCompany) {
        return Task.where("Choose mark as onboarded and confirm",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Mark as onboarded")),
                CommonWaitUntil.isVisible(BrandReferralPage.CONFIRM_ONBOARD_POPUP),
                // Select vendor company
                CommonTask.chooseItemInDropdownWithValueInput(BrandReferralPage.VENDOR_COMPANY_SELECT, vendorCompany, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(vendorCompany)),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Submit")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Item has been updated successfully!")),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task delete(String brandReferral) {
        return Task.where("Delete brand referral",
                CommonWaitUntil.isVisible(BrandReferralPage.D_DELETE_IN_RESULT(brandReferral)),
                Click.on(BrandReferralPage.D_DELETE_IN_RESULT(brandReferral)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(BrandReferralPage.D_DELETE_IN_RESULT(brandReferral))
        );
    }

    public static Performable removeBrand(List<Map<String, String>> infos) {
        return Task.where("Remove brand in detail",
                actor -> {
                    // tìm tổng số record brand
                    List<WebElementFacade> size = BrandReferralPage.ROW_IN_BRAND_TABLE.resolveAllFor(theActorInTheSpotlight());

                    for (int i = 0; i < size.size(); i++) {
                        String brandInput = BrandReferralPage.BRAND_TEXTBOX(i + 1).resolveFor(theActorInTheSpotlight()).getAttribute("value").trim();
                        for (int j = 0; j < infos.size(); j++) {
                            if (brandInput.equals(infos.get(j).get("brand"))) {
                                actor.attemptsTo(
                                        CommonWaitUntil.isVisible(BrandReferralPage.BRAND_DELETE_BUTTON(i + 1)),
                                        Click.on(BrandReferralPage.BRAND_DELETE_BUTTON(i + 1)),
                                        CommonWaitUntil.isNotVisible(BrandReferralPage.BRAND_DELETE_BUTTON(i + 1))
                                );
                            }
                        }
                    }
                }
        );
    }

    public static Task redirect(Map<String, String> info) {
        return Task.where("Redirect to vendor company by link",
                CommonWaitUntil.isVisible(BrandReferralPage.VENDOR_COMPANY_LINK(info.get("index"))),
                Click.on(BrandReferralPage.VENDOR_COMPANY_LINK(info.get("index"))),
                WindowTask.threadSleep(2000),
                WindowTask.switchToChildWindowsByTitle1("Vendor company 2019 — " + info.get("vendorCompany")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_TITLE),
                WindowTask.switchToDefaultWindow(),
                WindowTask.threadSleep(1000)
        );
    }

}
