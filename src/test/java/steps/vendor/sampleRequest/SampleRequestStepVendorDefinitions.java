package steps.vendor.sampleRequest;

import cucumber.tasks.vendor.orders.HandleOrdersVendor;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.vendor.sampleRequest.SampleRequestVendorTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.sampleRequest.VendorSampleRequestPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class SampleRequestStepVendorDefinitions {

    @And("Vendor search sample request on tab {string}")
    public void search(String tap, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    SampleRequestVendorTask.search(tap, map)
            );
    }

    @And("{word} clear filter on field {string}")
    public void clear_field(String actor, String field) {
        theActorCalled(actor).attemptsTo(
                CommonWaitUntil.isVisible(VendorSampleRequestPage.SEARCH(field)),
                MoveMouse.to(VendorSampleRequestPage.SEARCH(field)),
                CommonWaitUntil.isVisible(VendorSampleRequestPage.CLEAR_ICON),
                Click.on(VendorSampleRequestPage.CLEAR_ICON),
                WindowTask.threadSleep(1000)
        );
    }
    @And("Vendor check records sample request")
    public void checkSample(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String number = list.get(0).get("number");
        if (list.get(0).get("number").isEmpty()) {
            number = Serenity.sessionVariableCalled("Number sample request").toString();
        }
        if (list.get(0).get("number").contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number of Sample api").toString();
        }

        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.RECORD(number, "requested")), containsString(CommonHandle.setDate(list.get(0).get("requested"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.RECORD(number, "number")), containsString(number)),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.RECORD(number, "store")), containsString(list.get(0).get("store"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.RECORD(number, "brand")), containsString(list.get(0).get("brand"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.RECORD(number, "products")), containsString(list.get(0).get("products"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.RECORD(number, "fulfillment")), containsString(list.get(0).get("fulfillment")))
        );
    }

    @And("Vendor check have no sample found")
    public void checkNoFound() {
        SampleRequestVendorTask.check_no_order();
    }

    @And("{word} check sample number {string} not found")
    public void checkNotFound(String actor, String number) {
        if (number.contains("by api"))
            number = Serenity.sessionVariableCalled("Number of Sample api").toString();
        theActorCalled(actor).attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(VendorSampleRequestPage.NO_RESULTS_FOUND)).andIfSo(
                        Ensure.that(CommonQuestions.isControlDisplay(VendorSampleRequestPage.NO_RESULTS_FOUND)).isTrue()
                ).otherwise(
                        Ensure.that(CommonQuestions.isControlUnDisplay(VendorSampleRequestPage.NUMBER(number))).isTrue()
                )
        );
    }

    @And("Vendor go to sample detail of number: {string}")
    public void goToDetail(String number) {
        if (number.isEmpty()) {
            number = Serenity.sessionVariableCalled("Number sample request");
        }
        if (number.contains("by api")) {
            number = Serenity.sessionVariableCalled("Number of Sample api");
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorSampleRequestPage.NUMBER(number)),
                CommonWaitUntil.isNotVisible(VendorSampleRequestPage.LOADING_SPIN)
        );
    }

    @And("{word} Check items in sample request detail of product {string}")
    public void check_item_in_sample_detail(String actor, String product, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorSampleRequestPage.BRAND_NAME(product, i + 1)),
                    Ensure.that(VendorSampleRequestPage.BRAND_NAME(product, i + 1)).text().contains(list.get(i).get("brandName")),
                    Ensure.that(VendorSampleRequestPage.SKU_NAME(product, i + 1)).text().contains(list.get(i).get("skuName")),
                    Ensure.that(VendorSampleRequestPage.STATUS(i + 1)).text().contains(list.get(i).get("status"))
            );
            if (list.get(i).containsKey("unitUPC")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorSampleRequestPage.UNIT(product, i + 1)).text().contains(list.get(i).get("unitUPC"))
                );
            }
            if (list.get(i).containsKey("casePrice")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorSampleRequestPage.CASE_PRICE(product, i + 1)).text().contains(list.get(i).get("casePrice"))
                );
            }
        }

    }

    @And("Vendor Check info sample request detail")
    public void check_info_sample_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.DIV_2("requested-date")), containsString(CommonHandle.setDate(list.get(0).get("requestDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.DIV_2("region")), containsString(list.get(0).get("region"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.DIV_2("fulfillment")), containsString(list.get(0).get("fulfillment"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.DIV_1("buyer-name")), containsString(list.get(0).get("buyerName"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.DIV_1("store-name")), containsString(list.get(0).get("storeName"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.DIV_1("address-stamp")), containsString(list.get(0).get("address"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.EMAIL_BUYER), containsString(list.get(0).get("emailBuyer"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.COMMENT), containsString(list.get(0).get("comment")))
        );
    }

    @And("Vendor select shipping method of sample")
    public void selectShipping(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                SampleRequestVendorTask.shippingInfo(list.get(0))
        );

    }

    @And("Vendor select a Rate and then confirm")
    public void selectShippo() {
        theActorInTheSpotlight().attemptsTo(
                SampleRequestVendorTask.selectRate()
        );
    }

    @And("Vendor check fulfillment detail")
    public void checkFulfillmentDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.FULFILLMENT_DATE), containsString(CommonHandle.setDate2(list.get(0).get("fulfilledOn"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.CARRIER2), containsString(list.get(0).get("carrier"))),
                seeThat(CommonQuestions.targetText(VendorSampleRequestPage.TRACKING_NUM), containsString(list.get(0).get("trackingNumber")))

        );
    }

    @And("Vendor check address to fulfillment detail")
    public void checkAddressFulfillmentDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_INPUT("Name")), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_INPUT("Company")), containsString(list.get(0).get("company"))),
                seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_INPUT("Address street 1")), containsString(list.get(0).get("address1"))),
                seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_INPUT("Address street 2")), containsString(list.get(0).get("address2"))),
                seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_INPUT("City")), containsString(list.get(0).get("city"))),
                seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_INPUT("Zipcode")), containsString(list.get(0).get("zipcode"))),
                seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_INPUT("State")), containsString(list.get(0).get("state"))),
                seeThat(CommonQuestions.targetValue(CommonVendorPage.DYNAMIC_INPUT("Country")), containsString(list.get(0).get("country")))

        );
    }


    @And("Vendor Cancel sample request")
    public void cancelSample(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                SampleRequestVendorTask.cancelSample(list.get(0))
        );
    }

}
