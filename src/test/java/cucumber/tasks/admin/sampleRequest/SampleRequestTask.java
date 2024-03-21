package cucumber.tasks.admin.sampleRequest;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.sampleRequest.SampleRequestPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.containsText;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class SampleRequestTask {
    public static Task search(Map<String, String> info) {
        return Task.where("Search Sample",
                Check.whether(valueOf(CommonAdminForm.SEARCH_BUTTON), isCurrentlyVisible())
                        .otherwise(
                                Click.on(AllBrandsPage.SHOW_FILTER)),
                Check.whether(!info.get("number").isEmpty())
                        .andIfSo(Enter.theValue(info.get("number")).into(SampleRequestPage.DYNAMIC_SEARCH("Order number"))),
                Check.whether(!info.get("store").isEmpty())
                        .andIfSo(
                                Enter.theValue(info.get("store")).into(SampleRequestPage.DYNAMIC_SEARCH("Store")),
                                CommonTask.ChooseValueFromSuggestions(info.get("store"))
                        ),
                Check.whether(!info.get("buyer").isEmpty())
                        .andIfSo(Enter.theValue(info.get("buyer")).into(SampleRequestPage.DYNAMIC_SEARCH("Buyer")),
                                CommonTask.ChooseValueFromSuggestions(info.get("buyer"))
                        ),
                Check.whether(!info.get("vendor").isEmpty())
                        .andIfSo(Enter.theValue(info.get("vendor")).into(SampleRequestPage.DYNAMIC_SEARCH("Vendor company")),
                                CommonTask.ChooseValueFromSuggestions(info.get("vendor"))
                        ),
                Check.whether(!info.get("fulfillment").isEmpty())
                        .andIfSo(Click.on(SampleRequestPage.DYNAMIC_SEARCH("Fulfillment")),
                                CommonTask.ChooseValueFromSuggestions(info.get("fulfillment"))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task search2(Map<String, String> info) {
        return Task.where("Search Sample",
                Check.whether(valueOf(CommonAdminForm.SEARCH_BUTTON), isCurrentlyVisible())
                        .otherwise(
                                Click.on(AllBrandsPage.SHOW_FILTER)),
                Check.whether(!info.get("number").isEmpty())
                        .andIfSo(Enter.theValue(info.get("number")).into(SampleRequestPage.DYNAMIC_SEARCH("Order number"))),
                Check.whether(!info.get("store").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(SampleRequestPage.DYNAMIC_SEARCH("Store"),
                                        info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("store")))
                        ),
                Check.whether(!info.get("buyer").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(SampleRequestPage.DYNAMIC_SEARCH("Buyer"),
                                        info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("buyer")))
                        ),
                Check.whether(!info.get("vendorCompany").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(SampleRequestPage.DYNAMIC_SEARCH("Vendor company"),
                                        info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("vendorCompany")))
                        ),
                Check.whether(!info.get("fulfillment").isEmpty())
                        .andIfSo(Click.on(SampleRequestPage.DYNAMIC_SEARCH("Fulfillment")),
                                CommonTask.ChooseValueFromSuggestions(info.get("fulfillment"))
                        ),
                Check.whether(!info.get("buyerCompany").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(SampleRequestPage.DYNAMIC_SEARCH("Buyer company"),
                                        info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("buyerCompany")))
                        ),
                Check.whether(!info.get("brand").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(SampleRequestPage.DYNAMIC_SEARCH("Brand"),
                                        info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("brand")))
                        ),
                Check.whether(!info.get("region").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(SampleRequestPage.DYNAMIC_SEARCH("Region"),
                                        info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("region")))
                        ),
                Check.whether(!info.get("managedBy").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(SampleRequestPage.DYNAMIC_SEARCH("Managed by"),
                                        info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("managedBy")))
                        ),
                Check.whether(!info.get("startDate").isEmpty())
                        .andIfSo(
                                Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(SampleRequestPage.DYNAMIC_SEARCH("Start date")).thenHit(Keys.TAB)
                        ),
                Check.whether(!info.get("endDate").isEmpty())
                        .andIfSo(
                                Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(SampleRequestPage.DYNAMIC_SEARCH("End date")).thenHit(Keys.TAB)
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task createSampleHeadBuyer(Map<String, String> info) {
        Task task = Task.where("Create sample for Head Buyer",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT("Fulfillment date")),
                Check.whether(info.get("fulfillment").isEmpty()).otherwise(
                        Check.whether(info.get("fulfillment").contains("Fulfilled")).andIfSo(
                                Check.whether(CommonQuestions.AskForAttributeContainText(SampleRequestPage.FULFILLMENT, "class", "is-checked")).otherwise(
                                        Click.on(SampleRequestPage.FULFILLMENT)
                                )
                        )
                ),
                Check.whether(info.get("fulfillmentDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("fulfillmentDate"), "MM/dd/yy"))
                                .into(CommonAdminForm.DYNAMIC_INPUT("Fulfillment date")).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("comment").isEmpty()).otherwise(
                        Enter.theValue(info.get("comment")).into(CommonAdminForm.DYNAMIC_INPUT("Comment"))
                ),
                Click.on(SampleRequestPage.ROLE("Head Buyer")).then(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT("Head buyer"))
                ),
                Check.whether(info.get("headBuyer").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_INPUT("Head buyer"),
                                info.get("headBuyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("headBuyer")))
                ),
                Check.whether(info.get("brand").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_INPUT("Brand"),
                                info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand")))
                )
        );
        return task;
    }

    public static Task createSampleNormalBuyer(Map<String, String> info) {
        Task task = Task.where("Create sample for Normal Buyer",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT("Fulfillment date")),
                Check.whether(info.get("fulfillment").isEmpty()).otherwise(
                        Check.whether(info.get("fulfillment").contains("Fulfilled")).andIfSo(
                                Check.whether(CommonQuestions.AskForAttributeContainText(SampleRequestPage.FULFILLMENT, "class", "is-checked")).otherwise(
                                        Click.on(SampleRequestPage.FULFILLMENT)
                                )
                        )
                ),
                Check.whether(info.get("fulfillmentDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("fulfillmentDate"), "MM/dd/yy"))
                                .into(CommonAdminForm.DYNAMIC_INPUT("Fulfillment date")).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("comment").isEmpty()).otherwise(
                        Enter.theValue(info.get("comment")).into(CommonAdminForm.DYNAMIC_INPUT("Comment"))
                ),
                Click.on(SampleRequestPage.ROLE("Buyer")).then(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT("Region"))
                ),
                Check.whether(info.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_INPUT("Region"),
                                info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))
                )
        );
        return task;
    }

    public static Task addBuyers(Map<String, String> info) {
        Task task = Task.where("Create sample for Normal Buyer add buyers",
                Check.whether(info.get("buyer").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT("Buyers")),
                        Enter.theValue(info.get("buyer")).into(CommonAdminForm.DYNAMIC_INPUT("Buyers")),
                        CommonWaitUntil.isVisible(SampleRequestPage.BUYER_INFO(info.get("buyer"), info.get("region"), info.get("store"))),
                        Click.on(SampleRequestPage.BUYER_INFO(info.get("buyer"), info.get("region"), info.get("store"))),
                        WindowTask.threadSleep(500),
                        Check.whether(info.get("brand").isEmpty()).otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_INPUT("Brand"),
                                        info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand")))
                        )
                )
        );
        return task;
    }

    public static Task addSku(Map<String, String> info) {
        Task task = Task.where("Create sample for Head Buyer add Sku",
                Check.whether(info.get("sku").isEmpty()).otherwise(
                        Click.on(SampleRequestPage.SKU(info.get("sku")))
                ),
                Check.whether(info.get("comment").isEmpty()).otherwise(
                        CommonWaitUntil.isEnabled(SampleRequestPage.SKU_COMMENT(info.get("sku"))),
                        Enter.theValue(info.get("comment")).into(SampleRequestPage.SKU_COMMENT(info.get("sku")))
                )
        );
        return task;
    }

    public static Task useDefaultReceiving(Map<String, String> info) {
        Task task = Task.where("use Default Receiving of store address",
                CommonWaitUntil.isVisible(CommonAdminForm.ANY_TEXT("Use default head buyer's stores address"))
                        .then(
                                Click.on(CommonAdminForm.ANY_TEXT("Use default head buyer's stores address"))
                        ),
                Check.whether(info.get("store").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.ANY_TEXT("Use default head buyer's stores address")),
                        Click.on(SampleRequestPage.STORE_NAME(info.get("store"))),
                        WindowTask.threadSleep(500),
                        Ensure.that(SampleRequestPage.STORE_ADDRESS(info.get("store"))).text().contains(info.get("address"))
                )
        );
        return task;
    }

    public static Task chooseStore(Map<String, String> info) {
        Task task = Task.where("use Default Receiving of store address",
                Check.whether(info.get("store").isEmpty()).otherwise(
                        Click.on(SampleRequestPage.STORE_NAME(info.get("store"))),
                        WindowTask.threadSleep(500),
                        Ensure.that(SampleRequestPage.STORE_ADDRESS(info.get("store"))).text().contains(info.get("address"))
                )
        );
        return task;
    }

    public static Task addAnotherAddress(Map<String, String> info) {
        return Task.where("add Another Address",
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name"))).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add another address"))
                                .then(
                                        Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add another address"))
                                )
                ),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name")),
                Check.whether(info.get("name").isEmpty()).otherwise(
                        Enter.theValue(info.get("name")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name"))
                ),
                Check.whether(info.get("attn").isEmpty()).otherwise(
                        Enter.theValue(info.get("attn")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Attn"))
                ),
                Check.whether(info.get("street1").isEmpty()).otherwise(
                        Enter.theValue(info.get("street1")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Street")).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("street2").isEmpty()).otherwise(
                        Enter.theValue(info.get("street2")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT2("Street", 2)).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("city").isEmpty()).otherwise(
                        Enter.theValue(info.get("city")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("City")).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("state").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_DIALOG_INPUT("State (Province/Territory)")
                                , info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("state")))
                ),
                Check.whether(info.get("zip").isEmpty()).otherwise(
                        Enter.theValue(info.get("zip")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Zip")).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("phoneNumber").isEmpty()).otherwise(
                        Enter.theValue(info.get("phoneNumber")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Phone number"))
                ),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create"))
        );
    }

    public static Task exportSample(String type) {
        return Task.where("export Sample",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Export")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Export")),
                CommonWaitUntil.isVisible(CommonAdminForm.ANY_TEXT(type)),
                Click.on(CommonAdminForm.ANY_TEXT(type)),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Exporting will cost a lot of system resources. If you need large-sized data, please contact Jungmin first. If you still want to proceed, type ")),
                Enter.theValue("I UNDERSTAND").into(CommonAdminForm.DYNAMIC_DIALOG_INPUT()),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")),
                WindowTask.threadSleep(1000)
        );
    }
}
