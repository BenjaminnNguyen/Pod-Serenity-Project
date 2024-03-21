package cucumber.tasks.admin.products;

import cucumber.models.web.Admin.Products.SearchProduct;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.products.AdminAllProductsPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleFilterProduct {

    public static Task filter(SearchProduct info) {
        return Task.where("Search brands",
                Check.whether(CommonQuestions.isControlUnDisplay(AdminAllProductsPage.ft_SEARCH_TERM)).andIfSo(
                        Click.on(AdminAllProductsPage.SHOW_FILTERS)
                ),

                Check.whether(!info.getTerm().isEmpty()).andIfSo(
                        Enter.theValue(info.getTerm()).into(AdminAllProductsPage.ft_SEARCH_TERM)
                ),

                Check.whether(!info.getProductState().isEmpty()).andIfSo(
                        Check.whether(info.getProductState().equalsIgnoreCase("-")).andIfSo(
                                Click.on(AdminAllProductsPage.ft_PRODUCT_STATE),
                                Click.on(AdminAllProductsPage.ALL_PRODUCT_STATE)
                        ).otherwise(
                                Check.whether(info.getProductState().equalsIgnoreCase("Inactive")).andIfSo(
                                        Click.on(AdminAllProductsPage.ft_PRODUCT_STATE),
                                        Click.on(AdminAllProductsPage.INACTIVE_PRODUCT_STATE)
                                ).otherwise(
                                        Check.whether(info.getProductState().equalsIgnoreCase("Active")).andIfSo(
                                                Click.on(AdminAllProductsPage.ft_PRODUCT_STATE),
                                                Click.on(AdminAllProductsPage.ACTIVE_PRODUCT_STATE)
                                        )
                                )
                        )
                ),
                Check.whether(!info.getBrandName().isEmpty()).andIfSo(
                        Enter.theValue(info.getBrandName()).into(AdminAllProductsPage.ft_BRAND),
                        CommonTask.ChooseValueFromSuggestions(info.getBrandName())
                ),

                Check.whether(!info.getVendorCompany().isEmpty()).andIfSo(
                        Enter.theValue(info.getVendorCompany()).into(AdminAllProductsPage.ft_VENDOR_COMPANY),
                        CommonTask.ChooseValueFromSuggestions(info.getVendorCompany())
                ),

                Check.whether(!info.getProductType().isEmpty()).andIfSo(
                        Click.on(AdminAllProductsPage.ft_PRODUCT_TYPE),
                        Enter.theValue(info.getProductType()).into(AdminAllProductsPage.ft_PRODUCT_TYPE),
                        CommonTask.ChooseValueFromSuggestions(info.getProductType())
                ),

                Check.whether(!info.getPackageSize().isEmpty()).andIfSo(
                        Click.on(AdminAllProductsPage.ft_PACKING_SIZE),
                        Enter.theValue(info.getPackageSize()).into(AdminAllProductsPage.ft_PACKING_SIZE),
                        CommonTask.ChooseValueFromSuggestions(info.getPackageSize())
                ),

                Check.whether(!info.getSampleable().isEmpty()).andIfSo(
                        Check.whether(info.getSampleable().equalsIgnoreCase("Sampleable")).andIfSo(
                                Click.on(AdminAllProductsPage.ft_SAMPLEABLE),
                                Click.on(AdminAllProductsPage.YES_SAMPLEABLE)
                        ).otherwise(
                                Check.whether(info.getSampleable().equalsIgnoreCase("Not sampleable")).andIfSo(
                                        Click.on(AdminAllProductsPage.ft_SAMPLEABLE),
                                        Click.on(AdminAllProductsPage.NOT_SAMPLEABLE)
                                )
                        )
                ),

                Check.whether(!info.getAvailableIn().isEmpty()).andIfSo(
                        Click.on(AdminAllProductsPage.ft_AVAILABLE_IN),
                        Enter.theValue(info.getAvailableIn()).into(AdminAllProductsPage.ft_AVAILABLE_IN),
                        CommonTask.ChooseValueFromSuggestions(info.getAvailableIn())
                ),

                Check.whether(!info.getTags().isEmpty()).andIfSo(
                        Click.on(AdminAllProductsPage.ft_TAGS),
                        Enter.theValue(info.getTags()).into(AdminAllProductsPage.ft_TAGS),
                        CommonTask.ChooseValueFromSuggestions(info.getTags())
                ),

                Click.on(AdminAllProductsPage.SEARCH_BUTTON),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(AdminAllProductsPage.LOADING_ICON)
        );
    }

    public static Task filter(Map<String, String> info) {
        return Task.where("Search brands",
                Check.whether(CommonQuestions.isControlUnDisplay(AdminAllProductsPage.ft_SEARCH_TERM)).andIfSo(
                        Click.on(AdminAllProductsPage.SHOW_FILTERS)
                ),
                Check.whether(info.get("term").isEmpty()).otherwise(
                        Enter.theValue(info.get("term")).into(AdminAllProductsPage.ft_SEARCH_TERM)
                ),
                Check.whether(info.get("productState").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(AdminAllProductsPage.ft_PRODUCT_STATE, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("productState")))
                ),
                Check.whether(info.get("brand").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminAllProductsPage.ft_BRAND, info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("brand")))
                ),
                Check.whether(info.get("vendorCompany").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminAllProductsPage.ft_VENDOR_COMPANY, info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorCompany")))
                ),
                Check.whether(info.get("productType").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminAllProductsPage.ft_PRODUCT_TYPE, info.get("productType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("productType")))
                ),
                Check.whether(info.get("packageSize").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminAllProductsPage.ft_PACKING_SIZE, info.get("packageSize"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("packageSize")))
                ),
                Check.whether(info.get("sampleable").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(AdminAllProductsPage.ft_SAMPLEABLE, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("sampleable")))
                ),
                Check.whether(info.get("availableIn").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminAllProductsPage.ft_AVAILABLE_IN, info.get("availableIn"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("availableIn")))
                ),
                Check.whether(info.get("tags").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminAllProductsPage.ft_TAGS, info.get("tags"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("tags")))
                ),
                Check.whether(info.get("sku").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(AdminAllProductsPage.ft_SKU, info.get("sku"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("sku")))
                ),
                Click.on(AdminAllProductsPage.SEARCH_BUTTON),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(AdminAllProductsPage.LOADING_ICON)
        );
    }

    public static Task resetFilter() {
        return Task.where("Reset filter",
                Check.whether(valueOf(AdminAllProductsPage.ft_SEARCH_TERM), isCurrentlyVisible())
                        .andIfSo(Click.on(AdminAllProductsPage.RESET_BUTTON),
                                CommonWaitUntil.isNotVisible(AllBrandsPage.LOADING_ICON)
                        )
        );
    }

    public static Performable editVisibility(Map<String, String> info) {
        return Task.where("Edit visibility in search",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(CommonQuestions.isControlUnDisplay(CommonAdminForm.DYNAMIC_BUTTON("Search"))).andIfSo(
                                    Click.on(AdminAllProductsPage.SHOW_FILTERS)
                            )
                    );
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.EDIT_VISIBILITY_BUTTON),
                            Click.on(CommonAdminForm.EDIT_VISIBILITY_BUTTON),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Save")),
                            WindowTask.threadSleep(1000)
                    );
                    if (info.containsKey("searchTerm")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Search term")));
                    }
                    if (info.containsKey("brand")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Brand")));
                    }
                    if (info.containsKey("productType")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Product type")));
                    }
                    if (info.containsKey("sampleable")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Sampleable")));
                    }
                    if (info.containsKey("tags")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Tags")));
                    }
                    if (info.containsKey("productState")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Product state")));
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Vendor company")));
                    }
                    if (info.containsKey("packageSize")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Package size")));
                    }
                    if (info.containsKey("available")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Available in")));
                    }
                    if (info.containsKey("sku")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("SKU name / Item code")));
                    }
                    if (info.containsKey("buyer")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Buyer")));
                    }
                    actor.attemptsTo(
                            // save
                            WindowTask.threadSleep(500),
                            Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Save")),
                            WindowTask.threadSleep(1000)
                    );
                });
    }

    public static Performable searchFieldUnVisible(Map<String, String> info) {
        return Task.where("Uncheck all edit visibility in search",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(CommonQuestions.isControlUnDisplay(CommonAdminForm.DYNAMIC_BUTTON("Search"))).andIfSo(
                                    Click.on(AdminAllProductsPage.SHOW_FILTERS)
                            ),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Search"))
                    );
                    if (info.containsKey("searchTerm")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Search term")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("brand")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Brand")).isNotDisplayed());
                    }
                    if (info.containsKey("productType")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Product type")).isNotDisplayed());
                    }
                    if (info.containsKey("sampleable")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Sampleable")).isNotDisplayed());
                    }
                    if (info.containsKey("tags")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Tags")).isNotDisplayed());
                    }
                    if (info.containsKey("productState")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Product state")).isNotDisplayed());
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Vendor company")).isNotDisplayed());
                    }
                    if (info.containsKey("packageSize")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Package size")).isNotDisplayed());
                    }
                    if (info.containsKey("available")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Available in")).isNotDisplayed());
                    }
                    if (info.containsKey("sku")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("SKU name / Item code")).isNotDisplayed());
                    }
                    if (info.containsKey("buyer")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Buyer")).isNotDisplayed());
                    }
                });
    }

    public static Performable searchFieldVisible(Map<String, String> info) {
        return Task.where("Uncheck all edit visibility in search",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(CommonQuestions.isControlUnDisplay(CommonAdminForm.DYNAMIC_BUTTON("Search"))).andIfSo(
                                    Click.on(AdminAllProductsPage.SHOW_FILTERS)
                            ),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Search"))
                    );
                    if (info.containsKey("searchTerm")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Search term")).isDisplayed()
                        );
                    }
                    if (info.containsKey("brand")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Brand")).isDisplayed());
                    }
                    if (info.containsKey("productType")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Product type")).isDisplayed());
                    }
                    if (info.containsKey("sampleable")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Sampleable")).isDisplayed());
                    }
                    if (info.containsKey("tags")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Tags")).isDisplayed());
                    }
                    if (info.containsKey("productState")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Product state")).isDisplayed());
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Vendor company")).isDisplayed());
                    }
                    if (info.containsKey("packageSize")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Package size")).isDisplayed());
                    }
                    if (info.containsKey("available")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Available in")).isDisplayed());
                    }
                    if (info.containsKey("sku")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("SKU name / Item code")).isDisplayed());
                    }
                    if (info.containsKey("buyer")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Buyer")).isDisplayed());
                    }
                });
    }
}