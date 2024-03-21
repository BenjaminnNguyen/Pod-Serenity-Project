package cucumber.tasks.admin.claims;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.claims.AdminClaimsPage;
import cucumber.user_interface.admin.store.AllStoresPage;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleAdminClaims {

    public static Task search(Map<String, String> info) {
        return Task.where("Search claim",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(info.get("orderNumber").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("orderNumber") + info.get("sub")).into(AdminClaimsPage.D_TEXTBOX("Sub-invoice #"))),
                Check.whether(info.get("store").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Store"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))),
                Check.whether(info.get("buyer").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Buyer"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer")))),
                Check.whether(info.get("buyerCompany").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Buyer company"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany")))),
                Check.whether(info.get("managedBy").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Managed by"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managedBy")))),
                Check.whether(info.get("status").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Status"), info.get("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("status")))),
                Check.whether(info.get("claimNumber").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("claimNumber")).into(AdminClaimsPage.D_TEXTBOX("Claim Number"))),
                Check.whether(info.get("startDate").equals(""))
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(AdminClaimsPage.D_TEXTBOX("Start date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("endDate").equals(""))
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(AdminClaimsPage.D_TEXTBOX("End date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("region").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Region"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String order, int index) {
        return Task.where("Go to detail of claim",
                CommonWaitUntil.isVisible(AdminClaimsPage.NUMBER_RESULT(order, index)),
                Click.on(AdminClaimsPage.NUMBER_RESULT(order, index)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetailFirstResult() {
        return Task.where("Go to detail of claim first result",
                CommonWaitUntil.isVisible(AdminClaimsPage.NUMBER_FIRST_RESULT),
                Click.on(AdminClaimsPage.NUMBER_FIRST_RESULT),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToCreateClaims() {
        return Task.where("Go to create claims",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(AdminClaimsPage.D_TEXTBOX("Buyer"))
        );
    }

    public static Task createClaims(Map<String, String> info) {
        return Task.where("Create Claims",
                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Buyer"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer"))),
                Check.whether(info.get("type").equals("buyer"))
                        .andIfSo(
                                CommonWaitUntil.isVisible(AdminClaimsPage.STORE_NAME_CREATE_CLAIM(info.get("store"))),
                                Ensure.that(AdminClaimsPage.STORE_NAME_CREATE_CLAIM).text().contains(info.get("store")),
                                Ensure.that(AdminClaimsPage.BUYER_COMPANY_CREATE_CLAIM).text().contains(info.get("buyerCompany")))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Store"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))
                        ),
                CommonTask.chooseItemInDropdownWithValueInput1(AdminClaimsPage.D_TEXTBOX("Sub invoice"), info.get("orderID") + info.get("subInvoice"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("orderID") + info.get("subInvoice"))),
                Click.on(AdminClaimsPage.D_CHECKBOX("Issue", info.get("issue"))),
                Enter.theValue(info.get("description")).into(AdminClaimsPage.D_TEXTAREA("Issue description")),
                Enter.theValue(info.get("adminNote")).into(AdminClaimsPage.D_TEXTAREA("Admin note"))
        );
    }

    public static Performable uploadPicture(List<Map<String, String>> infos) {
        return Task.where("Upload pictures",
                actor -> {
                    for (int i = 0; i < infos.size(); i++) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add picture")),
                                CommonFile.upload1(infos.get(i).get("picture"), CommonAdminForm.ATTACHMENT_BUTTON)
                        );
                    }
                }
        );
    }

    public static Task claimSuccess() {
        return Task.where("Claim success",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AdminClaimsPage.CLAIM_ID)
        );
    }

    public static Task save() {
        return Task.where("Save claim",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task removeLineItem(String sku) {
        return Task.where("remove line item ",
                Click.on(AdminClaimsPage.ACTION_AFFECTED(sku)),
                CommonWaitUntil.isNotVisible(AdminClaimsPage.ACTION_AFFECTED(sku))
        );
    }

    public static Task deleteClaim(String order) {
        return Task.where("Delete claims",
                CommonWaitUntil.isVisible(AdminClaimsPage.DELETE_RESULT(order)),
                Click.on(AdminClaimsPage.DELETE_RESULT(order)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToAddItem() {
        return Task.where("Go to select item",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add item")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add item")),
                CommonWaitUntil.isVisible(AdminClaimsPage.SELECT_ITEM_POPUP)
        );
    }

    public static Task addItemInClaimDetail(Map<String, String> info) {
        return Task.where("Choose sku affected product",
                Click.on(AdminClaimsPage.SELECT_ITEM_TEXTBOX).afterWaitingUntilEnabled(),
                Click.on(AdminClaimsPage.SKU_IN_POPUP(info.get("sku"))).afterWaitingUntilEnabled()
        );
    }

    public static Performable uploadPictureInDetail(List<Map<String, String>> infos) {
        return Task.where("Upload pictures in detail",
                actor -> {
                    for (int i = 0; i < infos.size(); i++) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                                CommonFile.upload1(infos.get(i).get("picture"), AdminClaimsPage.UPLOAD_PICTURE_INPUT)
                        );
                    }
                }
        );
    }

    public static Performable removePictureInDetail() {
        return Task.where("Remove pictures in detail",
                actor -> {
                    List<WebElementFacade> elements = AdminClaimsPage.REMOVE_PICTURE_BUTTON.resolveAllFor(theActorInTheSpotlight());
                    while (elements.size() > 0) {
                        theActorInTheSpotlight().attemptsTo(
                                Click.on(elements.get(0)),
                                WindowTask.threadSleep(1000)
                        );
                        elements = AdminClaimsPage.REMOVE_PICTURE_BUTTON.resolveAllFor(theActorInTheSpotlight());
                    }
                }
        );
    }
    public static Task saveActionPicture() {
        return Task.where("Save actions with picture",
                CommonWaitUntil.isVisible(AdminClaimsPage.PICTURE_SAVE_BUTTON),
                Click.on(AdminClaimsPage.PICTURE_SAVE_BUTTON),
                CommonWaitUntil.isNotVisible(AdminClaimsPage.PICTURE_SAVE_BUTTON)
        );
    }

}
