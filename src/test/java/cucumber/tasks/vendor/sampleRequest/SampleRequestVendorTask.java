package cucumber.tasks.vendor.sampleRequest;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;

import static cucumber.user_interface.beta.Vendor.sampleRequest.VendorSampleRequestPage.*;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderDetailPage;
import cucumber.user_interface.beta.Vendor.sampleRequest.VendorSampleRequestPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.checkerframework.checker.units.qual.C;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

public class SampleRequestVendorTask {

    public static Performable search(String tab, Map<String, String> map) {
        Performable task = Task.where("Search on tab: " + tab + " and with info",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(TAB(tab)),
                            Click.on(TAB(tab)),
                            CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your")),
                            Check.whether(map.get("region").isEmpty()).otherwise(
                                    Enter.theValue(map.get("region")).into(SEARCH("Region")),
                                    CommonTask.ChooseValueFromSuggestions(map.get("region"))
                            ),
                            Check.whether(map.get("store").isEmpty()).otherwise(
                                    Enter.theValue(map.get("store")).into(SEARCH("Store")),
                                    CommonTask.ChooseValueFromSuggestions(map.get("store"))
                            ),
                            Check.whether(map.get("requestFrom").isEmpty()).otherwise(
                                    Enter.theValue(CommonHandle.setDate2(map.get("requestFrom"), "MM/dd/yy")).into(SEARCH("Requested (from)")).thenHit(Keys.ENTER)

                            ),
                            Check.whether(map.get("requestTo").isEmpty()).otherwise(
                                    Enter.theValue(CommonHandle.setDate2(map.get("requestTo"), "MM/dd/yy")).into(SEARCH("Requested (to)")).thenHit(Keys.ENTER)
                            ),
                            CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your")),
                            WindowTask.threadSleep(1000)
                    );
                    if (map.containsKey("showCanceled")) {
                        actor.attemptsTo(
                                Check.whether(map.get("showCanceled").isEmpty()).otherwise(
                                        CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_INPUT("Show canceled items"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("showCanceled")))
                                )
                        );
                    }
                }
        );
        return task;
    }

    public static Task switchPages(WebElementFacade num) {
        return Task.where("go to page " + num,
                Click.on(num),
                CommonWaitUntil.isNotVisible(VendorSampleRequestPage.LOADING_SPIN)
        );
    }

    public static void check_no_order() {
        List<WebElementFacade> page = VendorSampleRequestPage.NUMBER_PAGE.resolveAllFor(theActorInTheSpotlight());
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(VendorSampleRequestPage.NO_RESULTS_FOUND)).andIfSo(
                        Ensure.that(CommonQuestions.isControlDisplay(VendorSampleRequestPage.NO_RESULTS_FOUND)).isTrue()
                )
        );
        if (page.size() > 1) {
            String num = Serenity.sessionVariableCalled("Number sample request") == null ? Serenity.sessionVariableCalled("Number sample request").toString() : "";
            for (int i = 0; i < page.size(); i++) {
                switchPages(page.get(i));
                if (CommonQuestions.isControlDisplay(VendorSampleRequestPage.NUMBER(num)).answeredBy(theActorInTheSpotlight())) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(CommonQuestions.isControlUnDisplay(VendorSampleRequestPage.NUMBER(num))).isTrue()
                    );
                    break;
                }
            }
        }
    }

    public static Task shippingInfo(Map<String, String> map) {
        if (map.get("shippingMethod").contains("Use my own shipping label")) {
            return Task.where("Use my own shipping label ",
                    Click.on(DYNAMIC_TEXT_SPAN(map.get("shippingMethod"))),
                    CommonWaitUntil.isVisible(DELIVERY_DATE),
                    Check.whether(map.get("fulfillmentDate").isEmpty()).otherwise(
                            Enter.theValue(CommonHandle.setDate2(map.get("fulfillmentDate"), "MM/dd/yy")).into(DELIVERY_DATE).thenHit(Keys.ENTER)
                    ),
                    Check.whether(map.get("carrier").isEmpty()).otherwise(
                            Click.on(CARRIER),
                            CommonTask.ChooseValueFromSuggestions(map.get("carrier"))
                    ),

                    Check.whether(map.get("carrier").isEmpty()).otherwise(
                            Enter.theValue(map.get("trackingNumber")).into(TRACKING_NUMBER)
                    )
//                    Click.on(CONFIRM_FULFILLMENT),
//                    CommonWaitUntil.isVisible(CONFIRM_ALERT)

            );
        } else
            return Task.where("Buy and Print shipping label",
                    Click.on(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(map.get("shippingMethod"))),
                    CommonWaitUntil.isVisible(VendorOrderDetailPage.PARCEL_INFORMATION("Width")),
                    Check.whether(map.get("width").isEmpty()).otherwise(
                            Enter.theValue(map.get("width")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Width"))
                    ),
                    Check.whether(map.get("height").isEmpty()).otherwise(
                            Enter.theValue(map.get("height")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Height"))
                    ),
                    Check.whether(map.get("length").isEmpty()).otherwise(
                            Enter.theValue(map.get("length")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Length"))
                    ),
                    Check.whether(map.get("weight").isEmpty()).otherwise(
                            Enter.theValue(map.get("weight")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Weight"))
                    ),
                    Check.whether(map.get("distance").isEmpty()).otherwise(
                            Click.on(VendorOrderDetailPage.PARCEL_INFORMATION("Distance Unit")),
                            CommonTask.ChooseValueFromSuggestions(map.get("distance"))
                    ),
                    Check.whether(map.get("mass").isEmpty()).otherwise(
                            Click.on(VendorOrderDetailPage.PARCEL_INFORMATION("Mass Unit")),
                            CommonTask.ChooseValueFromSuggestions(map.get("mass"))
                    ),
                    Check.whether(map.get("name").isEmpty()).otherwise(
                            Enter.theValue(map.get("name")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Name"))
                    ),
                    Check.whether(map.get("company").isEmpty()).otherwise(
                            Enter.theValue(map.get("company")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Company"))
                    ),
                    Check.whether(map.get("address1").isEmpty()).otherwise(
                            Enter.theValue(map.get("address1")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Address street 1"))
                    ),
                    Check.whether(map.get("city").isEmpty()).otherwise(
                            Enter.theValue(map.get("city")).into(VendorOrderDetailPage.PARCEL_INFORMATION("City"))
                    ),
                    Check.whether(map.get("zipcode").isEmpty()).otherwise(
                            Enter.theValue(map.get("zipcode")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Zipcode"))
                    ),
                    Check.whether(map.get("state").isEmpty()).otherwise(
                            Enter.theValue(map.get("state")).into(VendorOrderDetailPage.PARCEL_INFORMATION("State"))
                    ),
                    Check.whether(map.get("country").isEmpty()).otherwise(
                            Click.on(VendorOrderDetailPage.PARCEL_INFORMATION("Country")),
                            CommonTask.ChooseValueFromSuggestions(map.get("country"))
                    )

            );
    }

    public static Task selectRate() {
        return Task.where(" ",
                Click.on(CHECK_SHIPPO.resolveAllFor(theActorInTheSpotlight()).get(0)),
                CommonWaitUntil.isEnabled(BUY),
                Click.on(BUY),
                CommonWaitUntil.isNotVisible(BUY)

        );
    }

    public static Task cancelSample(Map<String, String> cancel) {
        return Task.where("cancel Sample ",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Cancel")).then(
                        Click.on(CommonVendorPage.DYNAMIC_BUTTON("Cancel"))
                ),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_INPUT2("Reason")),
                CommonTask.chooseItemInDropdown1(CommonVendorPage.DYNAMIC_INPUT2("Reason"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(cancel.get("reason"))),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_TEXT_AREA("Note for buyer")),
                Enter.theValue(cancel.get("note")).into(CommonVendorPage.DYNAMIC_TEXT_AREA("Note for buyer")),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Submit")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Cancel Request")),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Cancel Request"))
        );
    }
}
