package steps.vendor.promotion;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import io.cucumber.java.af.En;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.vendor.promotion.PromotionVendorTask;
import cucumber.tasks.vendor.sampleRequest.SampleRequestVendorTask;
import cucumber.user_interface.beta.Vendor.promotion.VendorPromotionPage;
import cucumber.user_interface.beta.Vendor.sampleRequest.VendorSampleRequestPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cucumber.user_interface.beta.Vendor.promotion.VendorPromotionPage.STACK_DEAL;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.GivenWhenThen.when;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class PromotionsStepVendorDefinitions {

    @And("Vendor search promotion on tab {string}")
    public void search(String tap, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.search(tap, list.get(0))
        );
    }

    @And("Vendor search all filter promotion on tab {string}")
    public void searchAll(String tap, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> map = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled(""), "create by api");
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.searchAll(tap, list.get(0))
        );
    }

    @And("Vendor check records promotions")
    public void checkSample(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        List<String> promoIds = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            String number = list.get(i).get("number");
            if (list.get(i).get("number").contains("random")) {
                number = Serenity.sessionVariableCalled("ID Create Promo API" + list.get(i).get("name"));
            }
            if (list.get(i).get("number").contains("create by vendor")) {
                number = Serenity.sessionVariableCalled("Promotion id create by vendor");
            }
            if (number.isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(VendorPromotionPage.RECORD(i + 1, "name")),
                        Ensure.that(VendorPromotionPage.RECORD(i + 1, "name")).text().contains(list.get(i).get("name")),
                        Ensure.that(VendorPromotionPage.RECORD(i + 1, "type")).text().contains(list.get(i).get("type")),
                        Ensure.that(VendorPromotionPage.RECORD(i + 1, "store")).text().contains(list.get(i).get("stores")),
                        Ensure.that(VendorPromotionPage.RECORD(i + 1, "regions")).text().contains(list.get(i).get("regions")),
                        Ensure.that(VendorPromotionPage.RECORD(i + 1, "start")).text().contains(CommonHandle.setDate2(list.get(i).get("start"), "MM/dd/yy")),
                        Ensure.that(VendorPromotionPage.RECORD(i + 1, "end")).text().contains(CommonHandle.setDate2(list.get(i).get("end"), "MM/dd/yy")),
                        Ensure.that(VendorPromotionPage.RECORD(i + 1, "discount")).text().contains(list.get(i).get("discount"))
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(VendorPromotionPage.RECORD(number, "number")),
                        Ensure.that(VendorPromotionPage.RECORD(number, "number")).text().contains(number),
                        Ensure.that(VendorPromotionPage.RECORD(number, "name")).text().contains(list.get(i).get("name")),
                        Ensure.that(VendorPromotionPage.RECORD(number, "type")).text().contains(list.get(i).get("type")),
                        Ensure.that(VendorPromotionPage.RECORD(number, "store")).text().contains(list.get(i).get("stores")),
                        Ensure.that(VendorPromotionPage.RECORD(number, "regions")).text().contains(list.get(i).get("regions")),
                        Ensure.that(VendorPromotionPage.RECORD(number, "start")).text().contains(CommonHandle.setDate2(list.get(i).get("start"), "MM/dd/yy")),
                        Ensure.that(VendorPromotionPage.RECORD(number, "end")).text().contains(CommonHandle.setDate2(list.get(i).get("end"), "MM/dd/yy")),
                        Ensure.that(VendorPromotionPage.RECORD(number, "discount")).text().contains(list.get(i).get("discount"))
                );
        }
    }

    @And("Vendor check not found promotion number {string}")
    public void checkNoFound(String s) {
        List<String> nums = Serenity.sessionVariableCalled("ID Create Promo API");
        if (s.isEmpty()) {
            PromotionVendorTask.check_no_order(nums);
        } else {
            nums.add(s);
            PromotionVendorTask.check_no_order(nums);
        }
    }

    @And("Vendor check not found promotion name {string}")
    public void checkNoFoundPromoName(String s) {
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.check_no_Promo(s)
        );
    }

    @And("Vendor go to promotion detail with number or name: {string}")
    public void goToDetail(String number) {
        if (number.isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorPromotionPage.NUMBER),
                    Click.on(VendorPromotionPage.NUMBER)
            );
        } else
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorPromotionPage.NAME(number)),
                    Click.on(VendorPromotionPage.NAME(number)),
                    CommonWaitUntil.isNotVisible(VendorPromotionPage.LOADING_SPIN)
            );
    }

    @And("Vendor check promotion detail")
    public void check_info_promo_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorPromotionPage.DYNAMIC_INFO_SPAN("promotion-title"))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_INFO_SPAN("promotion-title")), containsString(list.get(0).get("title"))),
                seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_INFO_SPAN("type")), containsString(list.get(0).get("type"))),
                seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_INFO_SPAN("stores")), containsString(list.get(0).get("stores"))),
                seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_INFO_SPAN("start-date")), containsString(CommonHandle.setDate2(list.get(0).get("start-date"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_INFO_SPAN("end-date")), containsString(CommonHandle.setDate2(list.get(0).get("end-date"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_INFO_SPAN2("regions")), containsString(list.get(0).get("regions"))),
                seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_INFO_SPAN2("discount")), containsString(list.get(0).get("discount")))

        );
        if (list.get(0).containsKey("status")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.STATUS), containsString(list.get(0).get("status")))
            );
        }
        if (list.get(0).containsKey("caseLimit")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_ADDITIONAL("Case limit")), containsString(list.get(0).get("caseLimit")))
            );
        }
        if (list.get(0).containsKey("useLimit")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_ADDITIONAL("Usage limit")), containsString(list.get(0).get("useLimit")))
            );
        }
        if (list.get(0).containsKey("expiryDate")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.EXPIRY_DATE), containsString(CommonHandle.setDate2(list.get(0).get("expiryDate"), "MM/dd/yy")))
            );
        }
        if (list.get(0).containsKey("caseMinimum")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.DYNAMIC_ADDITIONAL("Case minimum")), containsString(list.get(0).get("caseMinimum")))
            );
        }
        if (list.get(0).containsKey("includeStore")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.DIV_1("included-stores")), containsString(list.get(0).get("includeStore")))
            );
        }
        if (list.get(0).containsKey("excludeStore")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.DIV_1("excluded_stores")), containsString(list.get(0).get("excludeStore")))
            );
        }
        if (list.get(0).containsKey("appliedBuyerCompany")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.DIV_1("included-buyer-companies")), containsString(list.get(0).get("appliedBuyerCompany")))
            );
        }
    }

    @And("Vendor check promotion duplicate")
    public void check_info_promo_duplicate(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT("Name")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Name")).value().contains(list.get(0).get("name")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Start Date")).value().contains(CommonHandle.setDate2(list.get(0).get("startDate"), "MM/dd/yy")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("End Date")).value().contains(CommonHandle.setDate2(list.get(0).get("endDate"), "MM/dd/yy")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Note")).value().contains(list.get(0).get("note")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Promotion type")).value().contains(list.get(0).get("promotionType")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Case limit")).value().contains(list.get(0).get("caseLimit")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Case minimum")).value().contains(list.get(0).get("caseMinimum")),
                Check.whether(list.get(0).get("usageLimit").isEmpty()).otherwise(
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Usage limit")).value().contains(list.get(0).get("usageLimit"))
                ).andIfSo(
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Usage limit")).isNotDisplayed()
                ),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Discount Type")).value().contains(list.get(0).get("discountType")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Amount")).value().contains(list.get(0).get("amount"))
        );
    }

    @And("Vendor check promotion draft")
    public void check_info_promo_draft(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT("Name")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Name")).value().isEqualTo(list.get(0).get("name")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Start Date")).value().isEqualTo(CommonHandle.setDate2(list.get(0).get("startDate"), "MM/dd/yy")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("End Date")).value().isEqualTo(CommonHandle.setDate2(list.get(0).get("endDate"), "MM/dd/yy")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Note")).value().isEqualTo(list.get(0).get("note")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Promotion type")).value().isEqualTo(list.get(0).get("promotionType")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Case limit")).value().isEqualTo(list.get(0).get("caseLimit")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Case minimum")).value().isEqualTo(list.get(0).get("caseMinimum")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Usage limit")).value().isEqualTo(list.get(0).get("usageLimit")),
                Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Discount Type")).value().isEqualTo(list.get(0).get("discountType")),
                Check.whether(list.get(0).get("discountType").isEmpty()).otherwise(
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Amount")).value().isEqualTo(list.get(0).get("amount"))
                ).andIfSo(
                        Ensure.that(CommonVendorPage.DYNAMIC_INPUT("Amount")).isNotDisplayed()
                )
        );
    }

    @And("Vendor check stack deal draft promotion")
    public void check_info_stack_deal_promo_draft(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(STACK_DEAL("Min quantity", i + 1)).value().isEqualTo(list.get(i).get("minQuantity")),
                    Ensure.that(STACK_DEAL("Amount", i + 1)).value().isEqualTo(list.get(i).get("amount"))
            );
        }
    }

    @And("Vendor Check applied SKUs on promotion detail")
    public void check_item_in_promo_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.BRAND_NAME(i + 1)), containsString(list.get(i).get("brand"))),
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.SKU_NAME(i + 1)), containsString(list.get(i).get("sku"))),
                    seeThat(CommonQuestions.targetText(VendorPromotionPage.PRODUCT_NAME(i + 1)), containsString(list.get(i).get("product")))
            );
            if (list.get(i).get("region").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorPromotionPage.REGION(i + 1)).isNotDisplayed());
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorPromotionPage.REGION(i + 1)).text().contains(list.get(i).get("region")));
            }
            if (list.get(i).get("originalPrice").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorPromotionPage.ORIGINAL_PRICE(i + 1)).isNotDisplayed());
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorPromotionPage.ORIGINAL_PRICE(i + 1)).text().contains(list.get(i).get("originalPrice")));
            }
            if (list.get(i).get("discountPrice").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorPromotionPage.DISCOUNT_PRICE(i + 1)).isNotDisplayed());
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorPromotionPage.DISCOUNT_PRICE(i + 1)).text().contains(list.get(i).get("discountPrice")));
            }
        }
    }

    @And("Vendor go to create Promotion")
    public void goToPromotion() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.PAGE_ACTION("Create Promotion")),
                Click.on(CommonVendorPage.PAGE_ACTION("Create Promotion"))
        );
    }

    @And("Vendor create Promotion with info")
    public void createPromotion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.createPromotion(list.get(0))
        );
    }

    @And("Vendor choose region for create new Promotion")
    public void chooseRegionCreatePromotion(List<String> regions) {
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.chooseRegion(regions)
        );
    }

    @And("Vendor select an Inventory Lot for create new Promotion")
    public void selectInventoryCreatePromotion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.selectInventoryPromotion(list.get(0))
        );
    }

    @And("Vendor search specific buyer companies {string} and add to Promotion")
    public void addBuyerCompanyCreatePromotion(String buyer, List<String> table) {
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.searchBuyerCompanyPromotion(buyer),
                PromotionVendorTask.addBuyerCompanyPromotion(buyer, table)
        );
    }

    @And("Vendor remove all specific buyer companies of Promotion")
    public void removeBuyerCompanyCreatePromotion() {
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.removeAllBuyerCompanyPromotion()
        );
    }

    @And("Vendor search specific SKU {string} and add to Promotion")
    public void addSKUCreatePromotion(String sku, List<String> table) {
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.searchSKUPromotion(sku),
                PromotionVendorTask.addSKUPromotion(sku, table)
        );
    }

    @And("Vendor search specific SKU {string} and check SKU is selected")
    public void checkSelectedSKUCreatePromotion(String sku, List<String> table) {
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.searchSKUPromotion(sku),
                PromotionVendorTask.checkSelectedSKUPromotion(table)
        );
    }

    @And("Vendor search specific SKU {string} and check SKU is not show")
    public void checkNotShowSKUCreatePromotion(String sku, List<String> table) {
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.searchSKUPromotion(sku),
                PromotionVendorTask.checkNotShowSKUPromotion(table)
        );
    }

    @And("Vendor check specific SKU create Promotion")
    public void checkSKUCreatePromotion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorPromotionPage.CREATE_SKU_LIST_IMAGE(i + 1)).attribute("style").contains(list.get(i).get("image")),
                    Ensure.that(VendorPromotionPage.CREATE_SKU_LIST("brand", i + 1)).text().contains(list.get(i).get("brand")),
                    Ensure.that(VendorPromotionPage.CREATE_SKU_LIST("product", i + 1)).text().contains(list.get(i).get("product")),
                    Ensure.that(VendorPromotionPage.CREATE_SKU_LIST("name", i + 1)).text().contains(list.get(i).get("skuName"))
            );
    }

    @And("Vendor remove specific SKU create Promotion")
    public void removeSKUCreatePromotion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorPromotionPage.CREATE_SKU_LIST_REMOVE(list.get(i).get("sku"))),
                    Click.on(VendorPromotionPage.CREATE_SKU_LIST_REMOVE(list.get(i).get("sku"))),
                    WindowTask.threadSleep(500)
            );
    }

    @And("Vendor add cases stack deal create Promotion")
    public void addStackDealCreatePromotion(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                PromotionVendorTask.addStackDealPromotion(list)
        );
    }

    @And("Vendor remove cases stack deal number {int} create Promotion")
    public void removeStackDealCreatePromotion(int stack) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorPromotionPage.STACK_DEAL_REMOVE(stack)),
                Click.on(VendorPromotionPage.STACK_DEAL_REMOVE(stack))
        );
    }

    @And("Vendor check store of Applied Buyer Companies {string} Promotion")
    public void checkStoreAppliedBuyerPromotion(String buyer, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (buyer.isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorPromotionPage.APPLIED_BUYER_COMPANY(buyer)).isNotDisplayed()
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorPromotionPage.APPLIED_BUYER_COMPANY(buyer)),
                    MoveMouse.to(VendorPromotionPage.APPLIED_BUYER_COMPANY(buyer)),
                    WindowTask.threadSleep(500)
            );
            for (int i = 0; i < list.size(); i++) {
                String storeId = list.get(i).get("storeId").contains("create by api") ? Serenity.sessionVariableCalled("ID Store API") : list.get(i).get("storeId");
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(storeId.isEmpty()).andIfSo(
                                Ensure.that(VendorPromotionPage.STORE_ID(i + 1)).isNotDisplayed(),
                                Ensure.that(VendorPromotionPage.STORE_REGION_ID(i + 1)).isNotDisplayed()
                        ).otherwise(
                                Ensure.that(VendorPromotionPage.STORE_ID(i + 1)).text().contains(storeId),
                                Ensure.that(VendorPromotionPage.STORE_REGION_ID(i + 1)).text().contains(list.get(i).get("region"))
                        )
                );
            }
        }
    }

    @And("Vendor duplicate promotion {string}")
    public void checkSelectedSKUCreatePromotion(String promoName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorPromotionPage.DUPLICATE(promoName)),
                Click.on(VendorPromotionPage.DUPLICATE(promoName)),
                WindowTask.threadSleep(1000)
        );
    }

    @And("Vendor save draft promotion success")
    public void saveDraftPromotion() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Save Draft")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Save Draft")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT("Promotion saved successfully.")),
                CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_P_ALERT("Promotion saved successfully."))
        );
        String id = VendorPromotionPage.PROMO_ID.resolveFor(theActorInTheSpotlight()).getText().split("#")[1];
        Serenity.setSessionVariable("Promotion id create by vendor").to(id);
    }

    @And("Vendor check buyer company {string} duplicate promotion")
    public void checkBuyerDuplicatePromotion(String status, List<String> buyer) {
        for (int i = 0; i < buyer.size(); i++) {
            if (status.contains("not")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorPromotionPage.APPLIED_BUYER_COMPANY_DUPLICATE(buyer.get(i))).isNotDisplayed()
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(VendorPromotionPage.APPLIED_BUYER_COMPANY_DUPLICATE(buyer.get(i)))
                );
        }
    }

}
