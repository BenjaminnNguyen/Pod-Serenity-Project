package cucumber.tasks.admin.promotions;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.promotion.AllPromotionsPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;


public class HandlePromotions {
    public static Task create(Map<String, String> info) {
        return Task.where("Tạo promotion",
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.ALERT_CLOSE_BUTTON)).andIfSo(
                        Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)
                ),
                Check.whether(CommonQuestions.isControlDisplay(AllPromotionsPage.PROMO_NAME)).otherwise(
                        CommonWaitUntil.isVisible(AllPromotionsPage.CREATE_BUTTON),
                        Click.on(AllPromotionsPage.CREATE_BUTTON)
                ),
                CommonWaitUntil.isVisible(AllPromotionsPage.PROMO_NAME),
                Check.whether(info.get("name").isEmpty()).otherwise(
                        Enter.theValue(info.get("name")).into(AllPromotionsPage.PROMO_NAME)
                ),
                Check.whether(info.containsKey("note")).andIfSo(
                        Enter.theValue(info.get("note")).into(AllPromotionsPage.DYNAMIC_TEXTAREA("Note"))
                ),
                Check.whether(info.get("description").isEmpty()).otherwise(
                        Enter.theValue(info.get("description")).into(AllPromotionsPage.DYNAMIC_TEXTAREA("Description"))
                ),
                Click.on(AllPromotionsPage.DYNAMIC_TYPE_PROMO(info.get("type"))),
                Check.whether(info.get("type").equals("Short-dated"))
                        .andIfSo(
                                Check.whether(info.get("expirySKU").isEmpty()).otherwise(
                                        Enter.theValue(CommonHandle.setDate2(info.get("expirySKU"), "MM/dd/yy"))
                                                .into(AllPromotionsPage.DYNAMIC_TEXTBOX("SKU expiry date")).thenHit(Keys.ENTER))
                        ),
                Check.whether(info.get("usageLimit").isEmpty()).otherwise(
                        Enter.theValue(info.get("usageLimit")).into(AllPromotionsPage.USAGE_LIMIT)
                ),
                Check.whether(info.get("caseLimit").isEmpty()).otherwise(
                        Enter.theValue(info.get("caseLimit")).into(AllPromotionsPage.CASE_LIMIT)
                ),
                Check.whether(info.get("caseMinimum").isEmpty()).otherwise(
                        Enter.theValue(info.get("caseMinimum")).into(AllPromotionsPage.DYNAMIC_TEXTBOX("Case minimum"))
                ),
                Check.whether(info.get("fromDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("fromDate"), "MM/dd/yy")).into(AllPromotionsPage.DYNAMIC_TEXTBOX("From")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("toDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("toDate"), "MM/dd/yy")).into(AllPromotionsPage.DYNAMIC_TEXTBOX("To")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("showVendor").isEmpty()).otherwise(
                        Click.on(AllPromotionsPage.SHOW_VENDOR_SWITCH)
                ),
                Check.whether(info.get("store").isEmpty()).otherwise(CommonTask.chooseItemInDropdownWithValueInput3(
                                AllPromotionsPage.DYNAMIC_TEXTBOX("Included stores"), info.get("store"), AllPromotionsPage.DYNAMIC_ITEM_DROPDOW_STORE(info.get("store"))),
                        Click.on(AllPromotionsPage.INCLUDED_STORES)
                ),
                Check.whether(info.containsKey("excludeStore")).andIfSo(
                        Check.whether(info.get("excludeStore").isEmpty()).otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput3(AllPromotionsPage.DYNAMIC_TEXTBOX("Excluded stores"), info.get("excludeStore"), AllPromotionsPage.DYNAMIC_ITEM_DROPDOW_STORE(info.get("excludeStore"))),
                                Click.on(AllPromotionsPage.INCLUDED_STORES)
                        )
                ),
                Check.whether(info.containsKey("includedBuyerCompany")).andIfSo(
                        Check.whether(info.get("includedBuyerCompany").isEmpty()).otherwise(
                                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Included buyer companies")),
                                CommonTask.chooseItemInDropdownWithValueInput3(AllPromotionsPage.DYNAMIC_TEXTBOX("Included buyer companies"), info.get("includedBuyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("includedBuyerCompany")))
                        )),
                Check.whether(info.containsKey("excludedBuyerCompany")).andIfSo(
                        Check.whether(info.get("excludedBuyerCompany").isEmpty()).otherwise(
                                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Excluded buyer companies")),
                                CommonTask.chooseItemInDropdownWithValueInput3(AllPromotionsPage.DYNAMIC_TEXTBOX("Excluded buyer companies"), info.get("excludedBuyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("excludedBuyerCompany")))
                        )),

                Check.whether(info.get("typePromo").isEmpty()).otherwise(
                        Scroll.to(AllPromotionsPage.RULE_TYPE_PROMO(info.get("typePromo"))),
                        Click.on(AllPromotionsPage.RULE_TYPE_PROMO(info.get("typePromo")))
                ),
                Check.whether(info.get("amount").isEmpty()).otherwise(
                        Enter.theValue(info.get("amount")).into(AllPromotionsPage.DYNAMIC_TEXTBOX("Amount"))
                )

        );
    }

    public static Task addSKUs(String sku) {
        return Task.where("Choose sku " + sku,
                Check.whether(sku.isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SPAN_TEXT("Add Specific SKUs")),
                        Click.on(CommonAdminForm.DYNAMIC_SPAN_TEXT("Add Specific SKUs")),
                        WindowTask.threadSleep(500),
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("any_text")),
                        Enter.theValue(sku).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("any_text")),
                        CommonWaitUntil.isClickable(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Search")),
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Search")),
                        WindowTask.threadSleep(2000),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                        CommonWaitUntil.isVisible(AllPromotionsPage.SKU_CHECKBOX(sku)),
                        Click.on(AllPromotionsPage.SKU_CHECKBOX(sku)),
                        WindowTask.threadSleep(500),
                        CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_BUTTON("Add")),
                        Scroll.to(AllPromotionsPage.DYNAMIC_BUTTON("Add")),
                        Click.on(AllPromotionsPage.DYNAMIC_BUTTON("Add"))
                )
        );
    }

    public static Task addSKUs2(String sku) {
        return Task.where("Choose sku " + sku,
                Check.whether(sku.isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(AllPromotionsPage.SKU_CHECKBOX(sku)),
                        Click.on(AllPromotionsPage.SKU_CHECKBOX(sku)),
                        WindowTask.threadSleep(500),
                        CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_BUTTON("Add")),
                        Scroll.to(AllPromotionsPage.DYNAMIC_BUTTON("Add")),
                        Click.on(AllPromotionsPage.DYNAMIC_BUTTON("Add"))
                )
        );
    }

    public static Task addInventoryLot(String lot) {
        return Task.where("Choose lot " + lot,
                Check.whether(lot.isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_INPUT("Inventory lot"), lot, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(lot))
                )
        );
    }


    public static Task searchSKUCreatePromotion(Map<String, String> map) {
        return Task.where("Search sku ",
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[upc]"))).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SPAN_TEXT("Add Specific SKUs")),
                        Click.on(CommonAdminForm.DYNAMIC_SPAN_TEXT("Add Specific SKUs"))
                ),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("any_text")),
                Check.whether(map.get("sku").isEmpty()).otherwise(
                        Enter.theValue(map.get("sku")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("any_text"))
                ),
                Check.whether(map.get("brand").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[brand_id]"),
                                map.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("brand")))
                ),
                Check.whether(map.get("upc").isEmpty()).otherwise(
                        Enter.theValue(map.get("upc")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[upc]"))
                ),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Search")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Search")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task applyStore(Map<String, String> info) {
        return Task.where("",
                Check.whether(info.containsKey("includeStore")).andIfSo(
                        Check.whether(info.get("includeStore").isEmpty()).otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput3(AllPromotionsPage.DYNAMIC_TEXTBOX("Included stores"), info.get("includeStore"), AllPromotionsPage.DYNAMIC_ITEM_DROPDOW_STORE(info.get("includeStore"))),
                                Click.on(AllPromotionsPage.INCLUDED_STORES)
                        )
                ),
                Check.whether(info.containsKey("excludeStore")).andIfSo(
                        Check.whether(info.get("excludeStore").isEmpty()).otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput3(AllPromotionsPage.DYNAMIC_TEXTBOX("Excluded stores"), info.get("excludeStore"), AllPromotionsPage.DYNAMIC_ITEM_DROPDOW_STORE(info.get("excludeStore"))),
                                Click.on(AllPromotionsPage.INCLUDED_STORES)
                        )
                ),
                Check.whether(info.containsKey("includedBuyerCompany")).andIfSo(
                        Check.whether(info.get("includedBuyerCompany").isEmpty()).otherwise(
                                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Included buyer companies")),
                                CommonTask.chooseItemInDropdownWithValueInput3(AllPromotionsPage.DYNAMIC_TEXTBOX("Included buyer companies"), info.get("includedBuyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("includedBuyerCompany")))
                        )),
                Check.whether(info.containsKey("excludedBuyerCompany")).andIfSo(
                        Check.whether(info.get("excludedBuyerCompany").isEmpty()).otherwise(
                                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX("Excluded buyer companies")),
                                CommonTask.chooseItemInDropdownWithValueInput3(AllPromotionsPage.DYNAMIC_TEXTBOX("Excluded buyer companies"), info.get("excludedBuyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("excludedBuyerCompany")))
                        ))
        );
    }


    public static Task chooseRegion(String region) {
        return Task.where("Choose regions ",
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_REGION(region)),
                Click.on(AllPromotionsPage.DYNAMIC_REGION(region))
        );
    }

    public static Task createOrUpdate(String buttonName) {
        return Task.where("Create or update promo",
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_BUTTON(buttonName)),
                Scroll.to(AllPromotionsPage.DYNAMIC_BUTTON(buttonName)),
                Click.on(AllPromotionsPage.DYNAMIC_BUTTON(buttonName)),
                WindowTask.threadSleep(200),
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Proceed")))
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Proceed")),
                                WindowTask.threadSleep(200),
                                Check.whether(valueOf(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")), isCurrentlyVisible())
                                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process"))))
        );
    }

    public static Task processNonSku() {
        return Task.where("process Non Sku promo",
                WindowTask.threadSleep(100),
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Proceed")))
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Proceed")))
        );
    }

    public static Task processOverlapSku() {
        return Task.where("process Overlap Sku promo",
                WindowTask.threadSleep(100),
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")))
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")))
        );
    }

    public static Task search(Map<String, String> info) {
        Task task = Task.where("Search promotion by info",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(info.get("name").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("name")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("name"))
                        ),
                Check.whether(info.get("type").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("type"), info.get("type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("type")))
                        ),
                Check.whether(info.get("store").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("store")))
                        ),
                Check.whether(info.get("brand").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("brand")))
                        ),
                Check.whether(info.get("productName").isEmpty()).otherwise(
                        Enter.theValue(info.get("productName")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_name"))
                ),
                Check.whether(info.get("skuName").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_id"),
                                info.get("skuName"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("skuName")))
                ),
                Check.whether(info.get("startAt").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("startAt"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("starts_at")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("expireAt").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("expireAt"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("expires_at")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                        ),
                Check.whether(info.get("isStackDeal").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("promo_action_type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("isStackDeal")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
        if (info.containsKey("excludedStore")) {
            task.then(
                    Check.whether(info.get("excludedStore").isEmpty())
                            .otherwise(
                                    CommonTask.chooseItemInDropdownWithValueInput(
                                            CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("excluded_store_id"), info.get("excludedStore"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("excludedStore")))
                            )
            );
        }
        if (info.containsKey("includedBuyerCompany")) {
            task.then(
                    Check.whether(info.get("includedBuyerCompany").isEmpty())
                            .otherwise(
                                    CommonTask.chooseItemInDropdownWithValueInput(
                                            CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id"), info.get("includedBuyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("includedBuyerCompany")))
                            )
            );
        }
        if (info.containsKey("excludedBuyerCompany")) {
            task.then(
                    Check.whether(info.get("excludedBuyerCompany").isEmpty())
                            .otherwise(
                                    CommonTask.chooseItemInDropdownWithValueInput(
                                            CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("excluded_buyer_company_id"), info.get("excludedBuyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("excludedBuyerCompany")))
                            )
            );
        }
        if (info.containsKey("status")) {
            task.then(
                    Check.whether(info.get("status").isEmpty())
                            .otherwise(
                                    CommonTask.chooseItemInDropdown(
                                            CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("status")))
                            )
            );
        }
        return task;
    }

    public static Task editField(String field, String value) {
        if (field.contains("SKU expiry date") || field.contains("From") || field.contains("To")) {
            value = CommonHandle.setDate2(value, "MM/dd/yy");
        }
        return Task.where("Edit info of promotion",
                CommonWaitUntil.isVisible(AllPromotionsPage.DYNAMIC_TEXTBOX(field)),
                Clear.field(AllPromotionsPage.DYNAMIC_TEXTBOX(field)),
                Check.whether(field.contains("Included stores") || field.contains("Excluded stores") || field.contains("Included buyer companies") || field.contains("Excluded buyer companies")).andIfSo(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                AllPromotionsPage.DYNAMIC_TEXTBOX(field), value, AllPromotionsPage.DYNAMIC_ITEM_DROPDOW_STORE(value)),
                        CommonTask.pressESC()
                ).otherwise(
                        Enter.keyValues("0").into(AllPromotionsPage.DYNAMIC_TEXTBOX(field)).thenHit(Keys.BACK_SPACE),
                        Enter.theValue(value).into(AllPromotionsPage.DYNAMIC_TEXTBOX(field)).thenHit(Keys.ENTER))
        );
    }

    public static Task closeCreateForm() {
        return Task.where("Close create form",
                CommonWaitUntil.isVisible(CommonAdminForm.CLOSE_POPUP),
                Click.on(CommonAdminForm.CLOSE_POPUP),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task deleteStore(String st) {
        return Task.where("Close create form",
                CommonWaitUntil.isVisible(AllPromotionsPage.DELETE_STORE(st)),
                Scroll.to(AllPromotionsPage.DELETE_STORE(st)),
                Click.on(AllPromotionsPage.DELETE_STORE(st)),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(AllPromotionsPage.DELETE_STORE(st))
        );
    }

    public static Task deleteExcludedStore(String field, String st) {
        return Task.where("delete Excluded Store",
                CommonWaitUntil.isVisible(AllPromotionsPage.DELETE_EXCLUDED(field, st)),
                Scroll.to(AllPromotionsPage.DELETE_EXCLUDED(field, st)),
                Click.on(AllPromotionsPage.DELETE_EXCLUDED(field, st)),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(AllPromotionsPage.DELETE_EXCLUDED(field, st))
        );
    }

    public static Task duplicatePromo(String st) {
        return Task.where("",
                CommonWaitUntil.isVisible(CommonAdminForm.DUPLICATE(st)),
                Click.on(CommonAdminForm.DUPLICATE(st)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllPromotionsPage.DUPLICATE_BUTTON)
        );
    }

    public static Task confirmDuplicatePromo() {
        return Task.where("",
                CommonWaitUntil.isVisible(AllPromotionsPage.DUPLICATE_BUTTON),
                Click.on(AllPromotionsPage.DUPLICATE_BUTTON),
                Check.whether(valueOf(AllPromotionsPage.PROCESS_BUTTON), isCurrentlyVisible())
                        .andIfSo(Click.on(AllPromotionsPage.PROCESS_BUTTON))
        );
    }

    public static Task deletePromo(String name) {
        return Task.where("",
                CommonWaitUntil.isVisible(CommonAdminForm.DELETE(name)),
                Click.on(CommonAdminForm.DELETE(name)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SPAN_TEXT("Understand & Continue")),
                Click.on(CommonAdminForm.DYNAMIC_SPAN_TEXT("Understand & Continue"))
        );
    }

    public static Task selectInventoryPromotion(Map<String, String> map) {
        return Task.where("Create promotion",
                CommonWaitUntil.isVisible(AllPromotionsPage.INVENTORY_INPUT),
                CommonTask.chooseItemInDropdownWithValueInput(AllPromotionsPage.INVENTORY_INPUT,
                        map.get("search"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(map.get("lotCode"))),
                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("SKU expiry date")).value().contains(CommonHandle.setDate2(map.get("expiryDate"), "MM/dd/yy")),
                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("SKU expiry date")).isDisabled()
        );
    }

}
