package cucumber.tasks.admin.fees;

import cucumber.models.web.Admin.brand.SearchBrand;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.VendorPageForm;
import cucumber.user_interface.admin.fee.AdminFeePage;
import cucumber.user_interface.admin.fee.AdminMiscellaneousFeePage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public class HandleAdminFees {

    public static Task goToCreate() {
        return Task.where("Go to create fees",
                CommonWaitUntil.isVisible(CommonAdminForm.CREATE_BUTTON_ON_HEADER),
                Click.on(CommonAdminForm.CREATE_BUTTON_ON_HEADER)
        );
    }


    public static Task confirmCreate() {
        return Task.where("Go to create fees",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task supportTarget(String target) {
        return Task.where("Go to create tags with target  " + target,
                Check.whether(target.isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_SPAN_TEXT(target)),
                        Click.on(CommonAdminForm.DYNAMIC_DIALOG_SPAN_TEXT(target))
                )
        );
    }

    public static Task createInfo(List<Map<String, String>> info) {
        return Task.where("Go to create tag",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name")),
                Check.whether(info.get(0).get("name").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("name")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name"))
                ),
                Check.whether(info.get(0).get("description").isEmpty()).otherwise(
                        Enter.theValue(info.get(0).get("description")).into(CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Description"))
                ),
                Check.whether(info.get(0).get("state").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.DYNAMIC_DIALOG_INPUT("State (Province/Territory)"), info.get(0).get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get(0).get("state")))
                ),
                Check.whether(info.get(0).get("freeFill").contains("yes")).otherwise(
                        Click.on(AdminFeePage.FREE_FILL)
                )
        );
    }

    public static Task search(Map<String, String> info) {
        String[] target = info.get("target").split(",");
        return Task.where("Search tags",
                Check.whether(info.get("term").isEmpty()).otherwise(
                        Enter.theValue(info.get("term")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[any_text]"))
                ),
                Check.whether(info.get("target").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown4(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[tag_target_ids]"), target)
                ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task edit(String name) {
        return Task.where("Edit " + name,
                CommonWaitUntil.isVisible(AdminFeePage.FEE_DETAIL(name)),
                Click.on(AdminFeePage.FEE_DETAIL(name))
        );
    }

    public static Task checkDetail(Map<String, String> info) {
        return Task.where("check Detail ",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name")),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name")).value().contains(info.get("name")),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Description")).value().contains(info.get("description")),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_INPUT("State (Province/Territory)")).value().contains(info.get("state")),
                Check.whether(info.get("freeFill").contains("yes")).andIfSo(
                        Ensure.that(AdminFeePage.FREE_FILL).attribute("class").contains("checked")
                ).otherwise(
                        Ensure.that(AdminFeePage.FREE_FILL).attribute("class").doesNotContain("checked")
                )

        );
    }


    public static Performable createMiscellaneousFeesInfo(List<Map<String, String>> info) {
        return Task.where("create Miscellaneous Fees",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Fee type")),
                            Check.whether(info.get(0).get("feeType").isEmpty()).otherwise(
                                    CommonTask.chooseItemInDropdown(
                                            CommonAdminForm.DYNAMIC_DIALOG_INPUT("Fee type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get(0).get("feeType")))
                            ));
                    if (info.get(0).containsKey("feeTypeText")) {
                        actor.attemptsTo(
                                Check.whether(info.get(0).get("feeTypeText").isEmpty()).otherwise(
                                        Enter.theValue(info.get(0).get("feeTypeText")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Fee type text"))
                                )
                        );
                    }
                    actor.attemptsTo(
                            Check.whether(info.get(0).get("serviceYear").isEmpty()).otherwise(
                                    Click.on(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Service Year & Month")),
                                    CommonWaitUntil.isVisible(AdminMiscellaneousFeePage.YEAR_PICKER),
                                    Click.on(AdminMiscellaneousFeePage.YEAR_PICKER),
                                    CommonWaitUntil.isVisible(AdminMiscellaneousFeePage.YEAR_PICKER(info.get(0).get("serviceYear"))),
                                    Click.on(AdminMiscellaneousFeePage.YEAR_PICKER(info.get(0).get("serviceYear"))),
                                    CommonWaitUntil.isVisible(AdminMiscellaneousFeePage.MONTH_PICKER(info.get(0).get("serviceMonth"))),
                                    Click.on(AdminMiscellaneousFeePage.MONTH_PICKER(info.get(0).get("serviceMonth"))),
                                    CommonWaitUntil.isNotVisible(AdminMiscellaneousFeePage.MONTH_PICKER(info.get(0).get("serviceMonth")))
                            ));
                    actor.attemptsTo(
                            Check.whether(info.get(0).get("type").isEmpty()).otherwise(
                                    CommonTask.chooseItemInDropdown(
                                            CommonAdminForm.DYNAMIC_DIALOG_INPUT("Type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get(0).get("type")))
                            )
                    );
                    if (info.get(0).containsKey("coveredBy")) {
                        actor.attemptsTo(
                                Check.whether(info.get(0).get("coveredBy").isEmpty()).otherwise(
                                        CommonTask.chooseItemInDropdown(
                                                CommonAdminForm.DYNAMIC_DIALOG_INPUT("Covered by"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get(0).get("coveredBy")))
                                )
                        );
                    }
                    if (info.get(0).containsKey("lpCompany")) {
                        actor.attemptsTo(
                                Check.whether(info.get(0).get("lpCompany").isEmpty()).otherwise(
                                        CommonTask.chooseItemInDropdownWithValueInput(
                                                CommonAdminForm.DYNAMIC_DIALOG_INPUT("LP company"), info.get(0).get("lpCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get(0).get("lpCompany")))
                                )
                        );
                    }
                    actor.attemptsTo(
                            Check.whether(info.get(0).get("vendorCompany").isEmpty()).otherwise(
                                    CommonTask.chooseItemInDropdownWithValueInput(
                                            CommonAdminForm.DYNAMIC_DIALOG_INPUT("Vendor company"), info.get(0).get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get(0).get("vendorCompany")))
                            ),
                            Check.whether(info.get(0).get("amount").isEmpty()).otherwise(
                                    Enter.theValue(info.get(0).get("amount")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Amount to charge or payout"))
                            ),
                            Check.whether(info.get(0).get("region").isEmpty()).otherwise(
                                    CommonTask.chooseItemInDropdown(
                                            CommonAdminForm.DYNAMIC_DIALOG_INPUT("Express region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get(0).get("region")))
                            ),
                            Check.whether(info.get(0).get("note").isEmpty()).otherwise(
                                    Enter.theValue(info.get(0).get("note")).into(CommonAdminForm.DYNAMIC_DIALOG_TEXTAREA("Notes"))
                            ),
                            Check.whether(info.get(0).get("file").isEmpty()).otherwise(
                                    CommonFile.upload(info.get(0).get("file"), CommonAdminForm.DYNAMIC_DIALOG_INPUT("Upload file"))
                            ),
                            Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create"))
                    );
                }
        );
    }

    public static Task searchMiscellaneous(Map<String, String> map) {
        return Task.where("Search Miscellaneous",
                Check.whether(map.get("year").isEmpty()).otherwise(
                        Click.on(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[service_time]")),
                        CommonWaitUntil.isVisible(AdminMiscellaneousFeePage.YEAR_PICKER),
                        Click.on(AdminMiscellaneousFeePage.YEAR_PICKER),
                        CommonWaitUntil.isVisible(AdminMiscellaneousFeePage.YEAR_PICKER(CommonHandle.setDate2(map.get("year"), "yyyy"))),
                        Click.on(AdminMiscellaneousFeePage.YEAR_PICKER(CommonHandle.setDate2(map.get("year"), "yyyy"))),
                        CommonWaitUntil.isVisible(AdminMiscellaneousFeePage.MONTH_PICKER(CommonHandle.setDate2(map.get("month"), "MMM"))),
                        Click.on(AdminMiscellaneousFeePage.MONTH_PICKER(CommonHandle.setDate2(map.get("month"), "MMM"))),
                        CommonWaitUntil.isNotVisible(AdminMiscellaneousFeePage.MONTH_PICKER(CommonHandle.setDate2(map.get("month"), "MMM")))
                ),
                Check.whether(map.get("vendorCompany").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[vendor_company_id]"), map.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("vendorCompany")))
                ),
                Check.whether(map.get("type").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[type]"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("type")))
                ),
                Check.whether(map.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[region_id]"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("region")))
                ),
                Check.whether(map.get("coveredBy").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[covered_by]"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("coveredBy")))
                ),
                Check.whether(map.get("lpCompany").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[logistics_company_id]"), map.get("lpCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(map.get("lpCompany")))
                ),
                Click.on(VendorPageForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

}
