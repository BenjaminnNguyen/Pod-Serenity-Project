package cucumber.tasks.vendor.promotion;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderListPage;
import cucumber.user_interface.beta.Vendor.promotion.VendorPromotionPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.af.En;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import javax.xml.crypto.Data;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static cucumber.user_interface.beta.Vendor.promotion.VendorPromotionPage.*;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class PromotionVendorTask {

    public static Task search(String tab, Map<String, String> map) {
        return Task.where("Search on tab: " + tab + " and with info",
                CommonWaitUntil.isVisible(TAB("All")),
                Click.on(TAB(tab)),
                CommonWaitUntil.isNotVisible(LOADING_SPIN),
                Check.whether(map.get("regions").isEmpty()).otherwise(
                        Enter.theValue(map.get("regions")).into(SEARCH("Region")),
                        CommonTask.ChooseValueFromSuggestions(map.get("regions"))
                ),
                Check.whether(map.get("brand").isEmpty()).otherwise(
                        Enter.theValue(map.get("brand")).into(SEARCH("Brand")),
                        CommonTask.ChooseValueFromSuggestions(map.get("brand"))
                ),
                Check.whether(map.get("stores").isEmpty()).otherwise(
                        Enter.theValue(map.get("stores")).into(SEARCH("Store")),
                        CommonTask.ChooseValueFromSuggestions(map.get("stores"))
                ),
                Check.whether(map.get("type").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(SEARCH("Type"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("type")))
                ),
                Check.whether(map.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy")).into(SEARCH("Start date")).thenHit(Keys.ENTER)

                ),
                CommonWaitUntil.isNotVisible(LOADING_SPIN),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task searchAll() {
        return Task.where("Open search all order",
                CommonWaitUntil.isVisible(VendorOrderListPage.SEARCH_ALL),
                Click.on(VendorOrderListPage.SEARCH_ALL),
                CommonWaitUntil.isVisible(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Fulfillment state"))
        );
    }

    public static Task searchAll(String tab, Map<String, String> map) {
        return Task.where("Search on tab: " + tab + " and with info",
                CommonWaitUntil.isVisible(TAB("All")),
                Click.on(TAB(tab)),
                CommonWaitUntil.isNotVisible(LOADING_SPIN),
                CommonWaitUntil.isVisible(SEARCH_ALL),
                Click.on(SEARCH_ALL),
                CommonWaitUntil.isVisible(SEARCH_ALL_FIELD("Region")),
                Check.whether(map.get("regions").isEmpty()).otherwise(
                        Enter.theValue(map.get("regions")).into(SEARCH_ALL_FIELD("Region")),
                        CommonTask.ChooseValueFromSuggestions(map.get("regions"))
                ),
                Check.whether(map.get("brand").isEmpty()).otherwise(
                        Enter.theValue(map.get("brand")).into(SEARCH_ALL_FIELD("Brand")),
                        CommonTask.ChooseValueFromSuggestions(map.get("brand"))
                ),
                Check.whether(map.get("stores").isEmpty()).otherwise(
                        Enter.theValue(map.get("stores")).into(SEARCH_ALL_FIELD("Store")),
                        CommonTask.ChooseValueFromSuggestions(map.get("stores"))
                ),
                Check.whether(map.get("type").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(SEARCH_ALL_FIELD("Type"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("type")))
                ),
                Check.whether(map.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy")).into(SEARCH_ALL_FIELD("Start date")).thenHit(Keys.ENTER)
                ),
                Check.whether(map.get("product").isEmpty()).otherwise(
                        Enter.theValue(map.get("product")).into(SEARCH_ALL_FIELD("Product name")).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("sku").isEmpty()).otherwise(
                        Enter.theValue(map.get("sku")).into(SEARCH_ALL_FIELD("SKU name")).thenHit(Keys.TAB)
                ),
                Check.whether(map.get("number").isEmpty()).otherwise(
                        Enter.theValue(map.get("number")).into(SEARCH_ALL_FIELD("Number")).thenHit(Keys.TAB)
                ),
                Click.on(CLOSE_SEARCH_ALL),
                CommonWaitUntil.isNotVisible(LOADING_SPIN),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task switchPages(WebElementFacade num) {
        return Task.where("go to page " + num,
                Click.on(num),
                CommonWaitUntil.isNotVisible(VendorPromotionPage.LOADING_SPIN)
        );
    }

    public static void check_no_order(List<String> s) {
        List<WebElementFacade> nums = NUMBER.resolveAllFor(theActorInTheSpotlight());
        List<String> num = new ArrayList<>();
        for (WebElementFacade e : nums) {
            num.add(e.getText().trim());
        }

        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(VendorPromotionPage.NO_RESULTS_FOUND)).andIfSo(
                        Ensure.that(CommonQuestions.isControlDisplay(VendorPromotionPage.NO_RESULTS_FOUND)).isTrue()
                ).otherwise(
                        Ensure.that(num.contains(s)).isFalse()
                )
        );
    }

    public static Task check_no_Promo(String name) {
        return Task.where("", Check.whether(CommonQuestions.isControlDisplay(VendorPromotionPage.NO_RESULTS_FOUND))
                .andIfSo(
                        Ensure.that(CommonQuestions.isControlDisplay(VendorPromotionPage.NO_RESULTS_FOUND)).isTrue())
                .otherwise(
                        Ensure.that(VendorPromotionPage.NAME(name)).isNotDisplayed())
        );

    }

    public static Performable chooseRegion(List<String> regions) {
        return Task.where("Create promotion select region",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(REGION_SWITCH),
                            Check.whether(CommonQuestions.AskForAttributeContainText(REGION_SWITCH, "class", "checked")).otherwise(
                                    Click.on(REGION_SWITCH)
                            )
                    );
                    for (String region : regions) {
                        actor.attemptsTo(
                                Check.whether(region.isEmpty()).otherwise(
                                        CommonWaitUntil.isVisible(REGION_OPTION(region)),
                                        Click.on(REGION_OPTION(region))
                                )
                        );
                    }
                }
        );
    }

    public static Task selectInventoryPromotion(Map<String, String> map) {
        return Task.where("Create promotion",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT("Find lots by brand, product, SKU, or lot code...")),
                CommonTask.chooseItemInDropdownWithValueInput(CommonVendorPage.DYNAMIC_INPUT("Find lots by brand, product, SKU, or lot code..."),
                        map.get("search"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("lotCode"))),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("SKU Expiry Date")).value().contains(CommonHandle.setDate2(map.get("expiryDate"), "MM/dd/yy")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("SKU Expiry Date")).isDisabled()
        );
    }

    public static Task searchBuyerCompanyPromotion(String searchValue) {
        return Task.where("Create promotion search Buyer Company",
                Check.whether(searchValue.trim().equalsIgnoreCase("")).otherwise(
                        Check.whether(CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_BUTTON("Add Specific Buyer Companies"))).otherwise(
                                CommonWaitUntil.isVisible(SPECIFIC_SWITCH),
                                Click.on(SPECIFIC_SWITCH),
                                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Add Specific Buyer Companies"))
                        ),
                        Click.on(CommonVendorPage.DYNAMIC_BUTTON("Add Specific Buyer Companies")),
                        CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Search")),
                        Enter.theValue(searchValue).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Search")).thenHit(Keys.TAB))
        );
    }

    public static Task removeAllBuyerCompanyPromotion() {
        return Task.where("Create promotion search Buyer Company",
                Check.whether(CommonQuestions.AskForAttributeContainText(SPECIFIC_SWITCH, "class", "checked")).andIfSo(
                        Click.on(SPECIFIC_SWITCH)
                )
        );
    }

    public static Task searchSKUPromotion(String searchValue) {
        return Task.where("Create promotion search SKU",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Add Specific SKUs")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Add Specific SKUs")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Search")),
                Enter.theValue(searchValue).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Search")).thenHit(Keys.TAB),
                WindowTask.threadSleep(1000)
        );
    }

    public static Performable addBuyerCompanyPromotion(String searchValue, List<String> buyerCompanies) {
        return Task.where("Create promotion select Buyer Company",
                actor -> {
                    Boolean check = false;
                    for (String buyer : buyerCompanies) {
                        if (buyer.isEmpty()) {
                            actor.attemptsTo(
                                    Ensure.that(BUYER_COMPANY_OPTION(searchValue)).isNotDisplayed(),
                                    Ensure.that(CommonVendorPage.D_DIALOG_BUTTON).isDisabled()
                            );
                            check = true;
                        } else
                            actor.attemptsTo(
                                    CommonWaitUntil.isVisible(BUYER_COMPANY_OPTION(buyer)),
                                    Click.on(BUYER_COMPANY_OPTION(buyer)),
                                    WindowTask.threadSleep(500)
                            );
                    }
                    if (check == false) {
                        String text = buyerCompanies.size() > 1 ? " selected Buyer Companies" : " selected Buyer Company";
                        actor.attemptsTo(
                                Ensure.that(CommonVendorPage.D_DIALOG_BUTTON).text().contains("Add " + buyerCompanies.size() + text),
                                Click.on(CommonVendorPage.D_DIALOG_BUTTON)
                        );
                    }
                }
        );
    }

    public static Performable addSKUPromotion(String searchValue, List<String> skus) {
        return Task.where("Create promotion select SKU",
                actor -> {
                    Boolean check = false;
                    for (String sku : skus) {
                        if (sku.isEmpty()) {
                            actor.attemptsTo(
                                    Ensure.that(SKU_OPTION(searchValue)).isNotDisplayed(),
                                    Ensure.that(CommonVendorPage.D_DIALOG_BUTTON).isDisabled()
                            );
                            check = true;
                        } else
                            actor.attemptsTo(
                                    CommonWaitUntil.isVisible(SKU_OPTION(sku)),
                                    Click.on(SKU_OPTION(sku)),
                                    WindowTask.threadSleep(500)
                            );
                    }
                    if (check == false) {
                        String text = skus.size() > 1 ? " selected SKUs" : " selected SKU";
                        actor.attemptsTo(
                                Ensure.that(CommonVendorPage.D_DIALOG_BUTTON).text().contains("Add " + skus.size() + text),
                                Click.on(CommonVendorPage.D_DIALOG_BUTTON)
                        );
                    }
                }
        );
    }

    public static Performable checkSelectedSKUPromotion(List<String> skus) {
        return Task.where("Create promotion select SKU",
                actor -> {
                    for (String sku : skus) {
                        if (sku.isEmpty()) {
                            actor.attemptsTo(
                                    Ensure.that(SKU_OPTION_SELECTED(sku)).isDisplayed());
                        }
                    }
                }
        );
    }

    public static Performable checkNotShowSKUPromotion(List<String> skus) {
        return Task.where("Create promotion select SKU",
                actor -> {
                    for (String sku : skus) {
                        if (sku.isEmpty()) {
                            actor.attemptsTo(
                                    Ensure.that(SKU_OPTION(sku)).isNotDisplayed());
                        }
                    }
                }
        );
    }

    public static Task chooseRetailSpecificPromotion() {
        return Task.where("chooseRetailSpecificPromotion",
                CommonWaitUntil.isVisible(SPECIFIC_SWITCH),
                Check.whether(CommonQuestions.AskForAttributeContainText(SPECIFIC_SWITCH, "class", "checked")).otherwise(
                        Click.on(SPECIFIC_SWITCH)
                )
        );
    }

    public static Task createPromotion(Map<String, String> map) {
        return Task.where("Create promotion",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT("Name")),
                Check.whether(map.get("name").isEmpty()).otherwise(
                        Enter.theValue(map.get("name")).into(CommonVendorPage.DYNAMIC_INPUT("Name"))
                ),
                Check.whether(map.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("startDate"), "MM/dd/yy")).into(CommonVendorPage.DYNAMIC_INPUT("Start Date")).thenHit(Keys.ENTER)
                ),
                Check.whether(map.get("endDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("endDate"), "MM/dd/yy")).into(CommonVendorPage.DYNAMIC_INPUT("End Date")).thenHit(Keys.ENTER)
                ),
                Check.whether(map.get("note").isEmpty()).otherwise(
                        Enter.theValue(map.get("note")).into(CommonVendorPage.DYNAMIC_INPUT("Note"))
                ),
                Check.whether(map.get("promotionType").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(CommonVendorPage.DYNAMIC_INPUT("Promotion type"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("promotionType")))
                ),
                Check.whether(map.get("caseLimit").isEmpty()).otherwise(
                        Enter.theValue(map.get("caseLimit")).into(CommonVendorPage.DYNAMIC_INPUT("Case limit"))
                ),
                Check.whether(map.get("caseMinimum").isEmpty()).otherwise(
                        Enter.theValue(map.get("caseMinimum")).into(CommonVendorPage.DYNAMIC_INPUT("Case minimum"))
                ),
                Check.whether(map.get("usageLimit").isEmpty()).otherwise(
                        Enter.theValue(map.get("usageLimit")).into(CommonVendorPage.DYNAMIC_INPUT("Usage limit"))
                ),
                Check.whether(map.get("discountType").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(CommonVendorPage.DYNAMIC_INPUT("Discount Type"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("discountType")))
                ),
                Check.whether(map.get("amount").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT("Amount")),
                        Enter.theValue(map.get("amount")).into(CommonVendorPage.DYNAMIC_INPUT("Amount"))
                )
        );
    }


    public static Performable addStackDealPromotion(List<Map<String, String>> map) {
        return Task.where("Create promotion select SKU",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(STACK_DEAL_SWITCH),
                            Check.whether(CommonQuestions.AskForAttributeContainText(STACK_DEAL_SWITCH, "class", "checked")).otherwise(
                                    Click.on(STACK_DEAL_SWITCH)
                            )
                    );
                    if (map.size() == 1) {
                        actor.attemptsTo(
                                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Case minimum")).value().isEqualToIgnoringCase(CommonQuestions.targetValue(actor, STACK_DEAL("Min quantity", 1)))
                        );
                    }
                    if (map.size() > 1) {
                        for (int i = 0; i < map.size() - 1; i++)
                            actor.attemptsTo(
                                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Add Case Stack")),
                                    Click.on(CommonVendorPage.DYNAMIC_BUTTON("Add Case Stack")),
                                    WindowTask.threadSleep(500)
                            );
                    }
                    for (int i = 0; i < map.size(); i++) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(STACK_DEAL("Min quantity", i + 1)),
                                Enter.theValue(map.get(i).get("minQuantity")).into(STACK_DEAL("Min quantity", i + 1)).thenHit(Keys.TAB),
                                Enter.theValue(map.get(i).get("amount")).into(STACK_DEAL("Amount", i + 1)),
                                WindowTask.threadSleep(500)
                        );
                    }
                }
        );
    }

}
