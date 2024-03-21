package cucumber.tasks.buyer.orders;

import cucumber.singleton.GVs;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.claims.AdminClaimsPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerClaimPage;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleClaim {

    public static Task goToClaimPage() {
        return Task.where("Go to claim page",
                CommonWaitUntil.isVisible(BuyerClaimPage.ISSUES_BUTTON),
                Click.on(BuyerClaimPage.ISSUES_BUTTON),
                WindowTask.switchToChildWindowsByTitle("Claims & Inquiry Form - Pod Foods | Online Distribution Platform for Emerging Brands"),
                CommonTask.bypassPolicyPopup()
        );
    }

    public static Task goToClaimPageByUrl() {
        return Task.where("Go to claim page by url",
                Open.url(GVs.URL_BETA + "claim"),
                WindowTask.switchToChildWindowsByTitle("Claims & Inquiry Form - Pod Foods | Online Distribution Platform for Emerging Brands"),
                CommonTask.bypassPolicyPopup()
        );
    }

    public static Task fillInfoToClaimBuyer(String invoice, Map<String, String> map) {
        return Task.where("Fill info to claim of buyer",
                CommonTask.chooseItemInDropdownWithValueInput1(BuyerClaimPage.INVOICE_TEXTBOX, invoice, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(invoice)),
                Scroll.to(BuyerClaimPage.INVOICE_TEXTBOX),
                Click.on(BuyerClaimPage.D_ISSUES(map.get("issues"))),
                Enter.theValue(map.get("description")).into(BuyerClaimPage.ISSUES_TEXTAREA)
        );
    }

    public static Task fillInfoToClaimHeadBuyer(String invoice, Map<String, String> map) {
        return Task.where("Fill info to claim of head buyer",
                Scroll.to(BuyerClaimPage.CLAIMS_POLICY_LINK),
                CommonTask.chooseItemInDropdownWithValueInput1(BuyerClaimPage.STORE_TEXTBOX, map.get("store"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(map.get("store"))),
                Enter.theValue(map.get("email")).into(BuyerClaimPage.EMAIL_TEXTBOX),
                CommonTask.chooseItemInDropdownWithValueInput1(BuyerClaimPage.INVOICE_TEXTBOX, invoice, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(invoice)),
                Click.on(BuyerClaimPage.D_ISSUES(map.get("issues"))),
                Enter.theValue(map.get("description")).into(BuyerClaimPage.ISSUES_TEXTAREA)
        );
    }

    public static Task guestFillInfoToClaim(Map<String, String> map) {
        return Task.where("Guest fill info to claim",
                Enter.theValue(map.get("company")).into(BuyerClaimPage.COMPANY_TEXTBOX),
                Enter.theValue(map.get("email")).into(BuyerClaimPage.EMAIL_TEXTBOX),
                Enter.theValue(map.get("invoice")).into(BuyerClaimPage.INVOICE_TEXTBOX),
                Click.on(BuyerClaimPage.D_ISSUES(map.get("issues"))),
                Enter.theValue(map.get("affectedProduct")).into(BuyerClaimPage.AFFECTED_PRODUCT_TEXTAREA),
                Enter.theValue(map.get("description")).into(BuyerClaimPage.ISSUES_TEXTAREA)
        );
    }

    public static Performable uploadFile(List<Map<String, String>> infos) {
        return Task.where("Guest fill info to claim",
                actor -> {
                    for (int i = 0; i < infos.size(); i++) {
                        actor.attemptsTo(
                                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Add a file")),
                                CommonFile.upload1(infos.get(i).get("picture"), BuyerClaimPage.PICTURE_BUTTON(i + 1))
                        );
                    }
                }
        );
    }

    public static Task finishFormClaimSuccess(String message) {
        return Task.where("Finish form claim",
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                CommonWaitUntil.isVisible(BuyerClaimPage.MESSAGE_SUCCESS(message))
        );
    }

    public static Task finishFormClaimError(String message) {
        return Task.where("Finish form claim with mesage error",
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                CommonWaitUntil.isVisible(BuyerClaimPage.MESSAGE_ERROR),
                Ensure.that(BuyerClaimPage.MESSAGE_ERROR).text().contains(message)
        );
    }

    public static Task reSubmitClaimByHere() {
        return Task.where("Finish form claim",
                Click.on(BuyerClaimPage.HERE_BUTTON),
                CommonWaitUntil.isVisible(BuyerClaimPage.INVOICE_TEXTBOX)
        );
    }

    public static Task chooseSkuAffected(Map<String, String> info) {
        return Task.where("Choose sku affected product",
                CommonWaitUntil.isVisible(BuyerClaimPage.SKU_AFFECTED_CHECKBOX(info.get("sku"))),
                Click.on(BuyerClaimPage.SKU_AFFECTED_CHECKBOX(info.get("sku"))).afterWaitingUntilEnabled(),
                WindowTask.threadSleep(500),
                Enter.theValue(info.get("quantity")).into(BuyerClaimPage.QUANTITY_AFFECTED_CHECKBOX(info.get("sku"))).thenHit(Keys.TAB)
        );
    }

    public static Task headbuyerChooseSkuAffected(Map<String, String> info) {
        return Task.where("Choose sku affected product",
                CommonWaitUntil.isVisible(BuyerClaimPage.SKU_AFFECTED_CHECKBOX(info.get("sku"))),
                Click.on(BuyerClaimPage.SKU_AFFECTED_CHECKBOX(info.get("sku"))).afterWaitingUntilEnabled(),
                WindowTask.threadSleep(500),
                Enter.theValue(info.get("quantity")).into(BuyerClaimPage.QUANTITY_AFFECTED_CHECKBOX(info.get("sku"))).thenHit(Keys.TAB)
        );
    }

    public static Task adminChooseSkuAffected(Map<String, String> info) {
        return Task.where("Choose sku affected product",
                CommonWaitUntil.isVisible(AdminClaimsPage.AFFECTED_PRODUCT_CHECKBOX(info.get("skuID"))),
                Click.on(AdminClaimsPage.AFFECTED_PRODUCT_CHECKBOX(info.get("skuID"))).afterWaitingUntilEnabled(),
                WindowTask.threadSleep(500),
                Enter.theValue(info.get("quantity")).into(AdminClaimsPage.AFFECTED_PRODUCT_QUANTITY_TEXTBOX(info.get("skuID"))).thenHit(Keys.TAB)
        );
    }
}
