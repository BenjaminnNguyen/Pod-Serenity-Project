package cucumber.tasks.lp.inventory;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Vendor.products.VendorCreateNewSKUPage;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.inventory.CreateInventoryLPPage;
import cucumber.user_interface.lp.inventory.InboundInventoryDetailLPPage;
import cucumber.user_interface.lp.inventory.InboundInventoryLPPage;
import cucumber.user_interface.lp.inventory.InventoryLPPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.actions.Upload;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleAllInventoryLP {

    public static Task search(Map<String, String> list) {
        return Task.where("",
                Check.whether(!list.get("sku").isEmpty()).andIfSo(
                        Enter.theValue(list.get("sku")).into(InventoryLPPage.SKU_SEARCH).thenHit(Keys.TAB)
                ),
                Check.whether(!list.get("product").isEmpty()).andIfSo(
                        Enter.theValue(list.get("product")).into(InventoryLPPage.PRODUCT_SEARCH).thenHit(Keys.TAB)
                ),
                Check.whether(!list.get("vendorCompany").isEmpty()).andIfSo(
                        Enter.theValue(list.get("vendorCompany")).into(InventoryLPPage.VENDOR_COMPANY_SEARCH).thenHit(Keys.TAB)
                ),
                Check.whether(!list.get("vendorBrand").isEmpty()).andIfSo(
                        Enter.theValue(list.get("vendorBrand")).into(InventoryLPPage.VENDOR_BRAND_SEARCH).thenHit(Keys.TAB)
                ),
                CommonWaitUntil.isNotVisible(InventoryLPPage.LOADING)
        );

    }

    public static Task goToDetail(String lotCode) {
        return Task.where("Go to detail inventory",
                CommonWaitUntil.isVisible(InventoryLPPage.SKU_IN_TABLE_RESULT(lotCode)),
                Click.on(InventoryLPPage.SKU_IN_TABLE_RESULT(lotCode)),
                CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
        );
    }

    public static Task goToTab(String tabName) {
        return Task.where("Go to tab " + tabName,
                CommonWaitUntil.isVisible(InventoryLPPage.D_HEADER_TAB(tabName)),
                Click.on(InventoryLPPage.D_HEADER_TAB(tabName)),
                CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
        );
    }

    public static Task addImage(String image, String des) {
        return Task.where("Add image " + image,
                CommonWaitUntil.isPresent(CreateInventoryLPPage.IMAGE),
                CommonFile.upload2(image, CreateInventoryLPPage.IMAGE),
                Enter.theValue(des).into(CreateInventoryLPPage.IMAGE_DES)
        );
    }
    public static Task deleteImage(int i) {
        return Task.where("Delete Image",
                CommonWaitUntil.isVisible(InventoryLPPage.DELETE_IMAGE(i)),
                Scroll.to(InventoryLPPage.DELETE_IMAGE(i)),
                Click.on(InventoryLPPage.DELETE_IMAGE(i))
        );
    }
    public static Task createNewInventory(Map<String, String> info) {
        return Task.where("Input Create new inventory",
                Check.whether(info.get("distribution").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CreateInventoryLPPage.D_TEXTBOX_CREATENEW("Distribution center"), info.get("distribution"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN(info.get("distribution")))
                ),
                Check.whether(info.get("sku").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CreateInventoryLPPage.D_TEXTBOX_CREATENEW("SKU"), info.get("sku"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN(info.get("sku")))
                ),
                Check.whether(info.get("quantity").isEmpty()).otherwise(
                        Enter.theValue(info.get("quantity")).into(CreateInventoryLPPage.D_TEXTBOX_CREATENEW("Quantity"))

                ),
//                Check.whether(info.get("sku").equals(info.get("lotCode"))).andIfSo(
                        Enter.theValue(info.get("lotCode")).into(CreateInventoryLPPage.D_TEXTBOX_CREATENEW("Lot Code")),
//                ).otherwise(
//                        Check.whether(info.get("lotCode").isEmpty()).otherwise(
//                                Enter.theValue(info.get("lotCode")).into(CreateInventoryLPPage.D_TEXTBOX_CREATENEW("Lot Code"))
//                        )
//                ),
                Check.whether(info.get("receiveDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("receiveDate"), "MM/dd/yy")).into(CreateInventoryLPPage.D_TEXTBOX_CREATENEW("Receive date")).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("expiryDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy")).into(CreateInventoryLPPage.D_TEXTBOX_CREATENEW("Expiry date")).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("comment").isEmpty()).otherwise(
                        Enter.theValue(info.get("comment")).into(CreateInventoryLPPage.D_TEXTBOX_CREATENEW("Comment"))
                )
        );
    }

    public static Task goCreateNewInventory() {
        return Task.where("Create new inventory",
                CommonWaitUntil.isVisible(CreateInventoryLPPage.NEW_INVENTORY_BUTTON),
                Click.on(CreateInventoryLPPage.NEW_INVENTORY_BUTTON),
                CommonWaitUntil.isVisible(CreateInventoryLPPage.CREATE_NEW_INVENTORY_HEADER)
        );
    }
}
