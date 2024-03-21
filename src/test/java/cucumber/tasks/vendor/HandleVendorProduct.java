package cucumber.tasks.vendor;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.products.VendorChangeRequestPage;
import cucumber.user_interface.beta.Vendor.products.VendorCreateProductPage;
import cucumber.user_interface.beta.Vendor.products.VendorCreateNewSKUPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class HandleVendorProduct {

    public static Task changeInfoSKU(Map<String, String> info) {
        return Task.where("Change info SKU",
                Enter.theValue(info.get("priceNY")).into(VendorCreateNewSKUPage.PRICE_OF_REGION_SPECIFIC_TEXTBOX("New York Express")),
                Enter.theValue(info.get("priceChicago")).into(VendorCreateNewSKUPage.PRICE_OF_REGION_SPECIFIC_TEXTBOX("Chicagoland Express")),
                Enter.theValue(info.get("requestNote")).into(VendorCreateNewSKUPage.REQUEST_NOTE_TEXTAREA),
                Click.on(VendorCreateNewSKUPage.SUBMIT_REQUEST_BUTTON)
        );
    }

    public static Task inputName(Map<String, String> map) {
        return Task.where("Edit name",
                CommonWaitUntil.isVisible(VendorCreateProductPage.PRODUCT_TITLE),
                Check.whether(map.get("productName").isEmpty()).otherwise(
                        Enter.theValue(map.get("productName")).into(VendorCreateProductPage.PRODUCT_TITLE)
                )
        );
    }

    public static Task editField(Map<String, String> map) {
        return Task.where("Edit ",
                CommonWaitUntil.isVisible(VendorCreateProductPage.PRODUCT_TITLE),
                Clear.field(VendorCreateProductPage.DYNAMIC_FIELD(map.get("field"))),
                Click.on(VendorCreateProductPage.DYNAMIC_FIELD(map.get("field"))),
                Enter.theValue(map.get("value")).into(VendorCreateProductPage.DYNAMIC_FIELD(map.get("field"))).thenHit(Keys.TAB),
                Enter.keyValues("a").into(VendorCreateProductPage.DYNAMIC_FIELD(map.get("field"))).thenHit(Keys.BACK_SPACE).thenHit(Keys.TAB)
        );
    }

    public static Task inputPackagingSize(Map<String, String> map) {
        return Task.where("Edit Packaging Size",
                Check.whether(map.get("unitLength").isEmpty()).otherwise(
                        Enter.theValue(map.get("unitLength")).into(VendorCreateProductPage.D_TEXTBOX("Unit length"))
                ),
                Check.whether(map.get("unitWidth").isEmpty()).otherwise(
                        Enter.theValue(map.get("unitWidth")).into(VendorCreateProductPage.D_TEXTBOX("Unit width"))
                ),
                Check.whether(map.get("unitHeight").isEmpty()).otherwise(
                        Enter.theValue(map.get("unitHeight")).into(VendorCreateProductPage.D_TEXTBOX("Unit height"))
                ),
                Check.whether(map.get("unitLength").isEmpty()).otherwise(
                        Enter.theValue(map.get("unitLength")).into(VendorCreateProductPage.D_2_TEXTBOX("Case length"))
                ),
                Check.whether(map.get("caseWidth").isEmpty()).otherwise(
                        Enter.theValue(map.get("caseWidth")).into(VendorCreateProductPage.D_2_TEXTBOX("Case width"))
                ),
                Check.whether(map.get("caseHeight").isEmpty()).otherwise(
                        Enter.theValue(map.get("caseHeight")).into(VendorCreateProductPage.D_2_TEXTBOX("Case height"))
                ),
                Check.whether(map.get("caseWeight").isEmpty()).otherwise(
                        Enter.theValue(map.get("caseWeight")).into(VendorCreateProductPage.D_2_TEXTBOX("Case Weight"))
                ),
                Check.whether(map.get("packageSize").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                VendorCreateProductPage.D_TEXTBOX2("Package size"), VendorCreateProductPage.PACKAGE_SIZE_LIST(map.get("packageSize")))
                ),
                Check.whether(map.get("unitSize").isEmpty()).otherwise(
                        Enter.theValue(map.get("unitSize")).into(VendorCreateProductPage.D_TEXTBOX("Unit Size")),
                        CommonTask.chooseItemInDropdown(
                                VendorCreateProductPage.D_2_TEXTBOX("Unit"), VendorCreateProductPage.UNIT_LIST(map.get("unit")))
                )
        );
    }

    public static Task inputOrganization(Map<String, String> map) {
        return Task.where("Edit Organization",
                Check.whether(map.get("brandName").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                VendorCreateProductPage.DYNAMIC_FIELD("Brand"), map.get("brandName"), VendorCreateProductPage.BRANDS_LIST(map.get("brandName")))
                ),
                Check.whether(map.get("category").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                VendorCreateProductPage.DYNAMIC_FIELD("Category"), map.get("category"), VendorCreateProductPage.CATEGORY_LIST(map.get("category")))
                ),
                Check.whether(map.get("productType").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                VendorCreateProductPage.DYNAMIC_FIELD("Product type"), VendorCreateProductPage.PRODUCT_TYPE_LIST(map.get("productType")))
                ),
//                Check.whether(map.get("category").equalsIgnoreCase("Beverage")).andIfSo(
//                        CommonTask.chooseItemInDropdown(
//                                VendorCreateProductPage.DYNAMIC_FIELD("Container Type"), VendorCreateProductPage.PRODUCT_TYPE_LIST("Plastic PETE #1"))
//                ),
                Check.whether(map.get("allowSample").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(VendorCreateProductPage.REQUEST_SAMPLE_BOX),
                        Click.on(VendorCreateProductPage.REQUEST_SAMPLE_BOX)
                )
        );
    }

    public static Task isBeverage(Map<String, String> map) {
        return Task.where("Edit isBeverage",
                Check.whether(map.get("isBeverage").isEmpty()).otherwise(
                        Scroll.to(VendorCreateProductPage.IS_BEVERAGE(map.get("isBeverage"))),
                        Click.on(VendorCreateProductPage.IS_BEVERAGE(map.get("isBeverage")))
                ),
                Check.whether(map.get("containerType").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                VendorCreateProductPage.DYNAMIC_FIELD("Container Type"), VendorCreateProductPage.PRODUCT_TYPE_LIST(map.get("containerType")))
                ));
    }

    public static Task allowSample(String allow) {
        return Task.where("Edit isBeverage",
                Check.whether(allow.equalsIgnoreCase("yes")).andIfSo(
                        Click.on(CommonVendorPage.DYNAMIC_ANY_TEXT("Allow stores to request samples")))
        );
    }

    public static Task inputPalletConfiguration(Map<String, String> map) {
        return Task.where("Edit Pallet Configuration",
                Check.whether(map.get("casesPerPallet").isEmpty()).otherwise(
                        Enter.theValue(map.get("casesPerPallet")).into(VendorCreateProductPage.D_TEXTBOX("Cases per pallet"))
                ),
                Check.whether(map.get("casesPerLayer").isEmpty()).otherwise(
                        Enter.theValue(map.get("casesPerLayer")).into(VendorCreateProductPage.D_TEXTBOX("Cases per layer"))
                ),
                Check.whether(map.get("layersPerFullPallet").isEmpty()).otherwise(
                        Enter.theValue(map.get("layersPerFullPallet")).into(VendorCreateProductPage.D_TEXTBOX("Layers per full pallet"))
                )
        );
    }

    public static Task clickCreate(String action) {
        return Task.where("Click create",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON(action)),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON(action))
        );
    }

    public static Task editMOQ(Map<String, String> map) {
        String val = map.get("value");
        if (map.get("value").isEmpty()) {
            val = "e";
        }
        return Task.where("edit MOQs",
                CommonWaitUntil.isVisible(VendorCreateProductPage.MOQ_FIELD(map.get("region"))),
                Clear.field(VendorCreateProductPage.MOQ_FIELD(map.get("region"))),
                Enter.theValue(val).into(VendorCreateProductPage.MOQ_FIELD(map.get("region")))
        );
    }

    public static Task inputMasterCaseConfiguration(Map<String, String> map) {
        return Task.where("Master Case Configuration",

                Check.whether(map.get("masterCartonsPerPallet").isEmpty()).otherwise(
                        Enter.theValue(map.get("masterCartonsPerPallet")).into(VendorCreateProductPage.D_2_TEXTBOX("Master Cartons per Pallet"))
                ),
                Check.whether(map.get("casesPerMasterCarton").isEmpty()).otherwise(
                        Enter.theValue(map.get("casesPerMasterCarton")).into(VendorCreateProductPage.D_2_TEXTBOX("Cases per Master Carton"))
                ),
                Check.whether(map.get("masterCaseDimensionsLength").isEmpty()).otherwise(
                        Enter.theValue(map.get("masterCaseDimensionsLength")).into(VendorCreateProductPage.D_2_TEXTBOX("Master carton length"))
                ),
                Check.whether(map.get("masterCaseDimensionsWidth").isEmpty()).otherwise(
                        Enter.theValue(map.get("masterCaseDimensionsWidth")).into(VendorCreateProductPage.D_2_TEXTBOX("Master carton width"))
                ),
                Check.whether(map.get("masterCaseDimensionsHeight").isEmpty()).otherwise(
                        Enter.theValue(map.get("masterCaseDimensionsHeight")).into(VendorCreateProductPage.D_2_TEXTBOX("Master carton height"))
                ),
                Check.whether(map.get("masterCaseWeight").isEmpty()).otherwise(
                        Enter.theValue(map.get("masterCaseWeight")).into(VendorCreateProductPage.D_2_TEXTBOX("Master carton Weight")))

        );
    }

    public static Task addBottleDeposits(Map<String, String> map) {
        return Task.where("add Bottle Deposits",
                Scroll.to(CommonVendorPage.DYNAMIC_BUTTON("Add new bottle deposit...")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Add new bottle deposit...")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_FIELD("Bottle Deposit")),
                CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_FIELD("Bottle Deposit"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("bottle"))),
                Enter.theValue(map.get("perUnit")).into(CommonVendorPage.DYNAMIC_FIELD("Bottle Deposit per unit (cents)"))
        );
    }

    public static Task deleteBottleDeposits(int i) {
        return Task.where("add Bottle Deposits",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_FIELD("Bottle Deposit")),
                Scroll.to(CommonVendorPage.DELETE_BOTTLE_DEPOSIT(i)),
                Click.on(CommonVendorPage.DELETE_BOTTLE_DEPOSIT(i))
        );
    }

    public static Task uploadCasePhoto(Map<String, String> map) {
        return Task.where("add Bottle Deposits",
                Check.whether(map.get("casePack").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(VendorCreateProductPage.CASE_PHOTO_UPLOAD_BUTTON("Case Pack Photo")),
                        Scroll.to(VendorCreateProductPage.CASE_PHOTO_UPLOAD_BUTTON("Case Pack Photo")),
                        Click.on(VendorCreateProductPage.CASE_PHOTO_UPLOAD_BUTTON("Case Pack Photo")),
                        CommonFile.upload(map.get("casePack"), VendorCreateProductPage.CASE_PHOTO_UPLOAD("Case Pack Photo"))
                ),
                Check.whether(map.get("masterCarton").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(VendorCreateProductPage.CASE_PHOTO_UPLOAD_BUTTON("Master Carton Photo")),
                        Click.on(VendorCreateProductPage.CASE_PHOTO_UPLOAD_BUTTON("Master Carton Photo")),
                        CommonFile.upload(map.get("masterCarton"), VendorCreateProductPage.CASE_PHOTO_UPLOAD("Master Carton Photo"))
                )

        );
    }

    public static Performable goToChangeRequest(String action, String field) {
        return Task.where("go to Change request",
                actor -> {
                    if (field.isEmpty()) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("Request Product Change")),
                                Click.on(CommonVendorPage.DYNAMIC_ANY_TEXT("Request Product Change"))
                        );
                    } else {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorChangeRequestPage.CHANGE_REQUEST_FIELD(field)),
                                Scroll.to(VendorChangeRequestPage.CHANGE_REQUEST_FIELD(field)),
                                Click.on(VendorChangeRequestPage.CHANGE_REQUEST_FIELD(field)),
                                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_TEXT("You can change this information by go to ")),
                                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action)),
                                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action))
                        );
                    }
                }
        );
    }

    public static Performable fillInfoRequestChange(String sku, Map<String, String> info) {
        return Task.where("add Bottle Deposits",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(sku)),
                            Click.on(CommonVendorPage.DYNAMIC_CONTAIN_ANY_TEXT(sku)),
                            WindowTask.threadSleep(500),
                            Check.whether(info.get("barcodes").isEmpty()).otherwise(
                                    Click.on(CommonVendorPage.DYNAMIC_INPUT("Barcodes Type")),
                                    CommonTask.ChooseValueFromSuggestions(info.get("barcodes"))
                            ),
                            Enter.theValue(info.get("unitCase")).into(CommonVendorPage.DYNAMIC_INPUT("Units/case")),
                            Enter.theValue(info.get("note")).into(CommonVendorPage.DYNAMIC_INPUT("Note"))
                    );
                    if (info.get("barcodes").equalsIgnoreCase("EAN"))
                        theActorInTheSpotlight().attemptsTo(
                                Enter.theValue(info.get("unit")).into(CommonVendorPage.DYNAMIC_INPUT("Unit EAN")),
                                Enter.theValue(info.get("case")).into(CommonVendorPage.DYNAMIC_INPUT("Case EAN"))
                        );
                    else {
                        theActorInTheSpotlight().attemptsTo(
                                Enter.theValue(info.get("unit")).into(CommonVendorPage.DYNAMIC_INPUT("Unit UPC")),
                                Enter.theValue(info.get("case")).into(CommonVendorPage.DYNAMIC_INPUT("Case UPC"))
                        );
                    }
                }
        );
    }


}
