package cucumber.tasks.admin.regions;

import cucumber.actions.GoBack;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.regions.AdminRegionsForm;
import cucumber.user_interface.admin.regions.DistributionCenterForm;
import cucumber.user_interface.beta.Buyer.BuyerCatalogPage;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleDistributionCenter {

    public static Task goToCreateForm() {
        return Task.where("go to create form",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(DistributionCenterForm.CREATE_FORM_LABEL)
        );
    }


    public static Performable search(String distributionName) {
        return Task.where("{0} search",
                actor -> {
                    //page
                    int i = 1;
                    Boolean check = true;
                    // list distribution center

                    List<WebElementFacade> listDC = DistributionCenterForm.NAME_RESULT.resolveAllFor(actor);
                    while (check) {
                        for (WebElementFacade item : listDC) {
                            // neu co distribution center thi break
                                check = false;
                                break;
                        }
                        // cong page len 1
                        i = i + 1;

                        // neu khong co thi bam nex page
                        if (check == false) {
                            break;
                        } else {
                            actor.attemptsTo(
                                    Click.on(DistributionCenterForm.PAGE_NUM(i)),
                                    WindowTask.threadSleep(1000)
                            );
                        }
                    }
                });
    }

    public static Task fillInfo(Map<String, String> info) {
        return Task.where("Fill info to create",
                CommonTask.chooseItemInDropdown1(DistributionCenterForm.D_TEXT("Region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region"))),
                CommonTask.chooseItemInDropdownWithValueInput1(DistributionCenterForm.D_TEXT("Warehousing LP"), info.get("warehouse"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("warehouse"))),
                CommonTask.chooseItemInDropdown1(DistributionCenterForm.D_TEXT("Timezone"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("timeZone"))),
                Enter.theValue(info.get("name")).into(DistributionCenterForm.D_TEXT("Name")),
                Check.whether(info.get("attn").equals(""))
                        .otherwise(Enter.theValue(info.get("attn")).into(DistributionCenterForm.D_TEXT("ATTN"))),
                Enter.theValue(info.get("street1")).into(DistributionCenterForm.D_TEXT("Street 1")),
                Check.whether(info.get("street2").equals(""))
                        .otherwise(Enter.theValue(info.get("street2")).into(DistributionCenterForm.D_TEXT("Street 2"))),
                Enter.theValue(info.get("city")).into(DistributionCenterForm.D_TEXT("City")),
                CommonTask.chooseItemInDropdownWithValueInput1(DistributionCenterForm.D_TEXT("State (Province/Territory)"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("state"))),
                Enter.theValue(info.get("zip")).into(DistributionCenterForm.D_TEXT("Zip")),
                Check.whether(info.get("phone").equals(""))
                        .otherwise(Enter.theValue(info.get("phone")).into(DistributionCenterForm.D_TEXT("Phone number")))
        );
    }

    public static Task createSuccess() {
        return Task.where("create success",
                Scroll.to(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(DistributionCenterForm.CREATE_FORM_LABEL)
        );
    }

    public static Task delete(String name) {
        return Task.where("delete success",
                Check.whether(valueOf(CommonAdminForm.CLOSE_POPUP), isCurrentlyVisible())
                                .andIfSo(Click.on(CommonAdminForm.CLOSE_POPUP)),
                Click.on(DistributionCenterForm.DELETE_RESULT(name)),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(DistributionCenterForm.DELETE_RESULT(name))
                );
    }

    public static Task goToDetail(String name) {
        return Task.where("Go to detail",
                Click.on(DistributionCenterForm.NAME_RESULT(name)),
                CommonWaitUntil.isVisible(DistributionCenterForm.EDIT_FORM_LABEL(name))
        );
    }
}
