package steps.vendor.brands;

import cucumber.questions.Admin.Brands.BrandCatalogInfo;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.*;
import cucumber.tasks.vendor.HandleBrand;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.VendorCatalogPage;
import cucumber.user_interface.beta.Vendor.brands.VendorDetailBrandCatalogPage;
import cucumber.user_interface.beta.Vendor.brands.VendorDetailBrandDashboardPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.*;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class VendorBrandStepDefinition {

    @And("Vendor create brand with info")
    public void vendor_create_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.enterInfo(list),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON2("Create"))
        );
    }


    @And("Vendor check list brand on dashboard")
    public void vendor_check_list_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("New Brand")),
                    Ensure.that(VendorDetailBrandDashboardPage.BRAND_LIST(i + 1, "contain")).attribute("style").contains(list.get(i).get("image")),
                    Ensure.that(VendorDetailBrandDashboardPage.BRAND_LIST(i + 1, "name ")).text().contains(list.get(i).get("brandName")),
                    Ensure.that(VendorDetailBrandDashboardPage.BRAND_LIST(i + 1, "description ")).text().contains(list.get(i).get("description")),
                    Ensure.that(VendorDetailBrandDashboardPage.BRAND_LIST(i + 1, "edt-piece address ")).text().contains(list.get(i).get("address"))
            );
        }
    }

    @And("Vendor go to detail of brand {string} on dashboard")
    public void vendor_go_detail_brand(String brandName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.BRAND_NAME(brandName)),
                Click.on(VendorDetailBrandDashboardPage.BRAND_NAME(brandName))
        );
    }


    @And("Vendor click {string} delete brand {string}")
    public void vendor_check_list_brand(String action, String name) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.BRAND_DELETE(name)),
                Click.on(VendorDetailBrandDashboardPage.BRAND_DELETE(name)),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_TEXT("Are you sure you want to remove this brand?")),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON(action))
        );
    }

    @And("Vendor verify not any product was showing")
    public void vendor_Verify_Not_Any_Brand_Will_Show() {
        BrandCatalogInfo.noShowAnyBrand();
    }

    @And("Vendor upload logo image, Cover image, Photos2")
    public void vendor_upload_logo_cover_photos2(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isPresent(VendorDetailBrandDashboardPage.UPLOAD_LOGO),
                    Check.whether(item.get("logo").isEmpty()).otherwise(
                            CommonFile.upload(item.get("logo"), VendorDetailBrandDashboardPage.UPLOAD_LOGO)
                    ),
                    Check.whether(item.get("cover").isEmpty()).otherwise(
                            CommonFile.upload(item.get("cover"), VendorDetailBrandDashboardPage.UPLOAD_COVER)
                    ),
                    Check.whether(item.get("photos").isEmpty()).otherwise(
                            CommonFile.upload(item.get("photos"), VendorDetailBrandDashboardPage.UPLOAD_PHOTOS)
                    ),
                    CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.LIST_PHOTOS)
            );
        }
    }

    @And("Vendor check brand detail on dashboard")
    public void check_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.BRAND_STATE),
                Ensure.that(VendorDetailBrandDashboardPage.BRAND_NAME).text().isEqualToIgnoringCase(list.get(0).get("brandName")),
                Ensure.that(VendorDetailBrandDashboardPage.BRAND_CITY).text().isEqualToIgnoringCase(list.get(0).get("city")),
                Ensure.that(VendorDetailBrandDashboardPage.BRAND_STATE).text().isEqualToIgnoringCase(list.get(0).get("state")),
                Ensure.that(VendorDetailBrandDashboardPage.BRAND_COUNTRY).text().isEqualToIgnoringCase(list.get(0).get("country")),
//                Ensure.that(VendorDetailBrandDashboardPage.BRAND_PRICING).text().isEqualToIgnoringCase(list.get(0).get("pricing")),
                Ensure.that(VendorDetailBrandDashboardPage.BRAND_DESCRIPTION).text().isEqualToIgnoringCase(list.get(0).get("description"))
        );
    }

    @And("Vendor check disable upload photos brand")
    public void check_disable_photo_brand() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorDetailBrandDashboardPage.UPLOAD_PHOTO).attribute("class").contains("is-disabled")
        );
    }

    @And("Vendor check image of brand detail on dashboard")
    public void check_brand_image(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (!list.get(i).get("photo").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.PHOTO_OF_BRAND(list.get(i).get("photo")), 60)
                );
            }
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.LOGO_BRAND),
                Ensure.that(VendorDetailBrandDashboardPage.LOGO_BRAND).attribute("style").contains(list.get(0).get("logo"))
        );
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.COVER_IMAGE_BRAND),
                Ensure.that(VendorDetailBrandDashboardPage.COVER_IMAGE_BRAND).attribute("style").contains(list.get(0).get("coverImage"))
        );
    }

    @And("Vendor delete image of brand")
    public void delete_brand_image(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorDetailBrandDashboardPage.DELETE_PHOTO_OF_BRAND(list.get(i).get("photo"))),
                    Click.on(VendorDetailBrandDashboardPage.DELETE_PHOTO_OF_BRAND(list.get(i).get("photo"))),
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_TEXT("Are you sure you want to remove this photo?")),
                    Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Remove it")),
                    CommonWaitUntil.isNotVisible(VendorDetailBrandDashboardPage.DELETE_PHOTO_OF_BRAND(list.get(i).get("photo")))
            );
        }
    }

    @And("Vendor check info edit brand")
    public void check_edit_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Brand name")),
                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_TEXT("Edit brand " + list.get(0).get("brandName"))).isDisplayed(),
                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Brand name")).value().isEqualTo(list.get(0).get("brandName")),
                Ensure.that(CommonVendorPage.DYNAMIC_TEXT_AREA2("Brand description (maximum 1000 characters)")).value().isEqualTo(list.get(0).get("description")),
                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_INPUT("Country")).value().isEqualTo(list.get(0).get("country")),
                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_INPUT("State (Province/Territory)")).value().isEqualTo(list.get(0).get("state")),
                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_INPUT("City")).value().isEqualTo(list.get(0).get("city"))
        );
    }

    @And("Vendor edit brand with info")
    public void vendor_edit_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBrand.enterInfo(list),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON2("Update"))
        );
    }

    @And("{word} go to brand {string} detail on catalog")
    public void vendor_go_to_brand_detail(String word, String brandName) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorCatalogPage.BRANDS_NAME(brandName))
        );
    }

    @And("{word} check brand detail on catalog")
    public void vendor_check_brand_detail_on_catalog(String word, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDetailBrandCatalogPage.BRAND_NAME),
                Ensure.that(VendorDetailBrandCatalogPage.BRAND_NAME).text().contains(list.get(0).get("brandName")),
                Ensure.that(VendorDetailBrandCatalogPage.BRAND_ADDRESS).text().isEqualTo(list.get(0).get("city") + ", " + list.get(0).get("state")),
                Click.on(VendorDetailBrandCatalogPage.ABOUT_TAP),
                CommonWaitUntil.isVisible(VendorDetailBrandCatalogPage.DESCRIPTION),
                Ensure.that(VendorDetailBrandCatalogPage.DESCRIPTION).text().contains(list.get(0).get("description"))
        );
        if (list.get(0).containsKey("logo")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorDetailBrandCatalogPage.LOGO_BRAND),
                    Ensure.that(VendorDetailBrandCatalogPage.LOGO_BRAND).attribute("style").contains(list.get(0).get("logo"))
            );
        }
        if (list.get(0).containsKey("coverImage")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorDetailBrandCatalogPage.COVER_IMAGE_BRAND),
                    Ensure.that(VendorDetailBrandCatalogPage.COVER_IMAGE_BRAND).attribute("style").contains(list.get(0).get("coverImage"))
            );
        }
    }

    @And("{word} check photo of brand on catalog")
    public void vendor_check_photo_brand_detail_on_catalog(String word, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorDetailBrandCatalogPage.PHOTO_OF_BRAND_CATALOG(i + 1)).attribute("style").contains(list.get(i).get("photo"))
            );
        }
    }

    @And("Vendor check a product on brand detail")
    public void vendor_check_a_product_brand_detail(String product) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorDetailBrandCatalogPage.BRAND_NAME),
                Click.on(VendorDetailBrandCatalogPage.PRODUCT_TAP),
                CommonWaitUntil.isVisible(VendorDetailBrandCatalogPage.PRODUCT_NAME(product))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(VendorDetailBrandCatalogPage.PRODUCT_NAME(product)))
        );
    }

}
