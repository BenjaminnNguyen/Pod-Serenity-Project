package cucumber.tasks.vendor.storeList;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.storeList.VendorStoreListPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleVendorStoreList {

    public static Task search(Map<String, String> info) {
        return Task.where("search store list",
                Check.whether(info.get("buyerCompany").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(VendorStoreListPage.D_SEARCH_TEXTBOX("Buyer company"), info.get("buyerCompany"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("buyerCompany")))),
                Check.whether(info.get("region").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput(VendorStoreListPage.D_SEARCH_TEXTBOX("Region"), info.get("region"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("region")))),
                Check.whether(info.get("storeType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput(VendorStoreListPage.D_SEARCH_TEXTBOX("Store Type"), info.get("storeType"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("storeType")))),
                Check.whether(info.get("keyAccount").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(VendorStoreListPage.D_SEARCH_TEXTBOX("Key Account"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("keyAccount")))),
                Check.whether(info.get("distributionType").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(VendorStoreListPage.D_SEARCH_TEXTBOX("Distribution Type"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("distributionType")))),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING)
        );
    }

    public static Task create(Map<String, String> info) {
        return Task.where("create account store list",
                Check.whether(info.get("storeName").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("storeName")).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Store name"))
                        ),
                Check.whether(info.get("storeAddress").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("storeAddress")).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Store address"))
                        ),
                Check.whether(info.get("skuList").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("skuList")).into(CommonVendorPage.DYNAMIC_TEXT_AREA2("SKU list"))
                        ),
                Check.whether(info.get("buyerName").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("buyerName")).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Buyer name"))
                        ),
                Check.whether(info.get("email").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("email")).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Email"))
                        ),
                Check.whether(info.get("phone").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("phone")).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Phone number"))
                        ),
                Check.whether(info.get("confirmation").isEmpty())
                        .otherwise(
                                Check.whether(info.get("confirmation").equalsIgnoreCase("Yes")).andIfSo(
                                        Click.on(CommonVendorPage.DYNAMIC_DIALOG_TEXT("Yes"))
                                ).otherwise(
                                        Click.on(CommonVendorPage.DYNAMIC_DIALOG_TEXT("No"))
                                )
                        ),
                Check.whether(info.get("distribution").isEmpty())
                        .otherwise(
                                Enter.theValue(info.get("distribution")).into(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Distribution transferring from"))
                        ),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON2("Add")),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING)
        );
    }


    public static Task edit(Map<String, String> info) {
        return Task.where("search store list",
                CommonWaitUntil.isVisible(VendorStoreListPage.RESULT_BUYER_COMPANY(info.get("buyerCompany"))),
                Check.whether(info.get("currentStore").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(VendorStoreListPage.RESULT_CURRENT_STORE(info.get("buyerCompany")), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("currentStore")))
                ), WindowTask.threadSleep(500),
                Check.whether(info.get("distributionType").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(VendorStoreListPage.RESULT_DISTRIBUTION_TYPE(info.get("buyerCompany")), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("distributionType")))
                ), WindowTask.threadSleep(500),
                Check.whether(info.get("contacted").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(VendorStoreListPage.RESULT_CONTACTED(info.get("buyerCompany")), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("contacted")))
                ), WindowTask.threadSleep(500),
                Check.whether(info.get("sampleSent").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(VendorStoreListPage.RESULT_SAMPLE_SENT(info.get("buyerCompany")), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("sampleSent")))
                ), WindowTask.threadSleep(500),
                Check.whether(info.get("note").isEmpty()).otherwise(
                        Enter.theValue(info.get("note")).into(VendorStoreListPage.RESULT_NOTE(info.get("buyerCompany"))).thenHit(Keys.TAB))
        );
    }

    public static Task chooseAllMassEditing() {
        return Task.where("choose All Mass Editing",
                CommonWaitUntil.isVisible(VendorStoreListPage.MASS_EDIT_ALL),
                Click.on(VendorStoreListPage.MASS_EDIT_ALL),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Mass Editing"))
        );
    }

    public static Task chooseStoreMassEditing(String store) {
        return Task.where("choose Store Mass Editing ",
                CommonWaitUntil.isVisible(VendorStoreListPage.CHECKBOX_STORE(store)),
                Click.on(VendorStoreListPage.CHECKBOX_STORE(store))
        );
    }

    public static Task massEditing(Map<String, String> map) {
        return Task.where("Mass Editing ",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Mass Editing")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Mass Editing")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Current Store")),
                Check.whether(map.get("currentStore").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Current Store"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("currentStore")))
                        , WindowTask.threadSleep(500)
                ),
                Check.whether(map.get("distributionType").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Distribution Type"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("distributionType")))
                        , WindowTask.threadSleep(500)
                ),
                Check.whether(map.get("contacted").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Contacted"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("contacted")))
                        , WindowTask.threadSleep(500)
                ),
                Check.whether(map.get("sampleSent").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Samples Sent"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("sampleSent")))
                        , WindowTask.threadSleep(500)
                ),
                Check.whether(map.get("note").isEmpty()).otherwise(
                        Enter.theValue(map.get("note")).into(CommonVendorPage.DYNAMIC_DIALOG_TEXT_AREA("Notes"))
                ),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON2("Update all selected"))
        );
    }

}
