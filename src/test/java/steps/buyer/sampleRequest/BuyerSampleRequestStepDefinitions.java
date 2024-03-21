package steps.buyer.sampleRequest;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.buyer.sampleRequest.HandleSampleRequestBuyer;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.Utility;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.vendor.sampleRequest.SampleRequestVendorTask;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerOrderPage;
import cucumber.user_interface.beta.Buyer.sampleRequest.BuyerSampleRequestDetailPage;
import cucumber.user_interface.beta.Buyer.sampleRequest.BuyerSampleRequestPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class BuyerSampleRequestStepDefinitions {
    @And("Buyer create sample request with info")
    public void createSampleRequest(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleSampleRequestBuyer.createSample(list.get(0))
        );
    }

    @And("Select Skus to sample")
    public void selectSkuSampleRequest(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>();
        for (Map<String, String> map : list) {
            info = CommonTask.setValue(map, "sku", map.get("sku"), Serenity.sessionVariableCalled("SKU inventory"), "");
            theActorInTheSpotlight().attemptsTo(
                    HandleSampleRequestBuyer.selectSkuCreateSample(info)
            );
        }
    }

    @And("Buyer open submit sample request")
    public void goSubmitSampleRequest() {
        theActorInTheSpotlight().attemptsTo(
                HandleSampleRequestBuyer.goToCreateSample()
        );
    }

    @And("Buyer check form submit sample request")
    public void checksSubmitSampleRequest(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerSampleRequestPage.PRODUCT).text().contains(list.get(0).get("product")),
                Ensure.that(BuyerSampleRequestPage.COMMENT).value().contains(list.get(0).get("comment"))
        );
        if (list.get(0).get("defaultShippingAddress").equals("yes")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerSampleRequestPage.HELP).text().contains("We will deliver to your store address below:"),
                    Ensure.that(BuyerSampleRequestPage.D_DEFAULT_ADDRESS("store-name")).text().containsIgnoringCase(list.get(0).get("store")),
                    Ensure.that(BuyerSampleRequestPage.D_DEFAULT_ADDRESS("address-stamp")).text().containsIgnoringCase(list.get(0).get("address")),
                    Ensure.that(BuyerSampleRequestPage.D_DEFAULT_ADDRESS("store-phone")).text().containsIgnoringCase(list.get(0).get("phone"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonBuyerPage.DYNAMIC_INPUT("Name")).value().isEqualTo(list.get(0).get("name")),
                    Ensure.that(CommonBuyerPage.DYNAMIC_INPUT("Street")).value().isEqualTo(list.get(0).get("street")),
                    Ensure.that(CommonBuyerPage.DYNAMIC_INPUT("Apt, Suite, etc.")).value().isEqualTo(list.get(0).get("etc")),
                    Ensure.that(CommonBuyerPage.DYNAMIC_INPUT("City")).value().isEqualTo(list.get(0).get("city")),
                    Ensure.that(CommonBuyerPage.DYNAMIC_INPUT("State")).value().isEqualTo(list.get(0).get("state")),
                    Ensure.that(CommonBuyerPage.DYNAMIC_INPUT("Postal/Zip")).value().isEqualTo(list.get(0).get("postalZip")),
                    Ensure.that(CommonBuyerPage.DYNAMIC_INPUT("Phone number")).value().isEqualTo(list.get(0).get("phoneNumber"))
            );
        }
    }

    @And("Buyer submit sample request")
    public void selectSkuSampleRequest() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerSampleRequestPage.SUBMIT),
                Click.on(BuyerSampleRequestPage.SUBMIT)
        );
        Serenity.setSessionVariable("Sample Request Time").to(Utility.getTimeNow("E, dd MMM yyyy, hh:mma"));
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerSampleRequestPage.ALERT),
                CommonWaitUntil.isNotVisible(BuyerSampleRequestPage.ALERT),
                WindowTask.threadSleep(500)
        );
    }

    @And("Buyer {string} Use default name and store address")
    public void useDefaultAddress(String action, DataTable table) {
//        action = "not" | "use"
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (action.equalsIgnoreCase("not")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_SPAN_TEXT("Use default name and store address")),
                    Click.on(CommonBuyerPage.DYNAMIC_SPAN_TEXT("Use default name and store address")),
                    CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_INPUT("Name")),
                    Check.whether(list.get(0).get("name").isEmpty()).otherwise(
                            Enter.theValue(list.get(0).get("name")).into(CommonBuyerPage.DYNAMIC_INPUT("Name"))
                    ),
                    Check.whether(list.get(0).get("attn").isEmpty()).otherwise(
                            Enter.theValue(list.get(0).get("attn")).into(CommonBuyerPage.DYNAMIC_INPUT("Attn"))
                    ),
                    Check.whether(list.get(0).get("street").isEmpty()).otherwise(
                            Enter.theValue(list.get(0).get("street")).into(CommonBuyerPage.DYNAMIC_INPUT("Street"))
                    ),
                    Check.whether(list.get(0).get("etc").isEmpty()).otherwise(
                            Enter.theValue(list.get(0).get("etc")).into(CommonBuyerPage.DYNAMIC_INPUT("Apt, Suite, etc."))
                    ),
                    Check.whether(list.get(0).get("city").isEmpty()).otherwise(
                            Enter.theValue(list.get(0).get("city")).into(CommonBuyerPage.DYNAMIC_INPUT("City"))
                    ),
                    Check.whether(list.get(0).get("state").isEmpty()).otherwise(
                            Enter.theValue(list.get(0).get("state")).into(CommonBuyerPage.DYNAMIC_INPUT("State")),
                            CommonTask.ChooseValueFromSuggestions(list.get(0).get("state"))
                    ),
                    Check.whether(list.get(0).get("postalZip").isEmpty()).otherwise(
                            Enter.theValue(list.get(0).get("postalZip")).into(CommonBuyerPage.DYNAMIC_INPUT("Postal/Zip"))
                    ),
                    Check.whether(list.get(0).get("phoneNumber").isEmpty()).otherwise(
                            Enter.theValue(list.get(0).get("phoneNumber")).into(CommonBuyerPage.DYNAMIC_INPUT("Phone number"))
                    )
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerSampleRequestPage.D_DEFAULT_ADDRESS("store-name")).text().containsIgnoringCase(list.get(0).get("store")),
                    Ensure.that(BuyerSampleRequestPage.D_DEFAULT_ADDRESS("address-stamp")).text().containsIgnoringCase(list.get(0).get("addressStamp")),
                    Ensure.that(BuyerSampleRequestPage.D_DEFAULT_ADDRESS("store-phone")).text().containsIgnoringCase(list.get(0).get("storePhone"))
            );
        }

    }

    @And("Buyer search sample request on tab {string}")
    public void search(String tap, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleSampleRequestBuyer.search(tap, list.get(0))
        );
    }

    @And("Buyer go to page {string} sample request")
    public void goToPage(String tab) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerSampleRequestPage.PAGE(tab)),
                Click.on(BuyerSampleRequestPage.PAGE(tab))
        );
    }

    @And("Check items in sample request detail")
    public void check_item_in_sample_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.BRAND_NAME(i + 1)), containsString(list.get(i).get("brandName"))),
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.SKU_NAME(i + 1)), containsString(list.get(i).get("skuName"))),
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.STATUS(i + 1)), equalToIgnoringCase(list.get(i).get("status"))),
                    seeThat(CommonQuestions.attributeText(BuyerSampleRequestDetailPage.ADD_TO_CART_BUTTON(list.get(i).get("skuName")), "class"), containsString(list.get(i).get("addCart")))
            );
            if (list.get(i).containsKey("casePrice")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.CASE_PRICE(i + 1)), equalToIgnoringCase(list.get(i).get("casePrice")))
                );
            }
            if (list.get(i).containsKey("unitUPC")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.UNIT(i + 1)), equalToIgnoringCase(list.get(i).get("unitUPC")))
                );
            }
        }
    }

    @And("Buyer check records sample request")
    public void checkSample(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String number = list.get(0).get("number");
        if (list.get(0).get("number").isEmpty()) {
            number = Serenity.sessionVariableCalled("Number sample request").toString();
        }
        if (list.get(0).get("number").equalsIgnoreCase("create by api")) {
            number = Serenity.sessionVariableCalled("Number of Sample api").toString();
        }
        if (list.get(0).get("number").contains("create by api of buyer")) {
            String buyerId = list.get(0).get("number").split("buyer ")[1];
            number = Serenity.sessionVariableCalled("Number of Sample api of buyer " + buyerId).toString();
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.RECORD(number, "requested")), containsString(CommonHandle.setDate(list.get(0).get("requested"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.RECORD(number, "number")), containsString(number)),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.RECORD(number, "brand")), containsString(list.get(0).get("brand"))),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.RECORD(number, "product")), containsString(list.get(0).get("product"))),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.RECORD(number, "fulfillment")), containsString(list.get(0).get("fulfillment")))
        );
        if (list.get(0).containsKey("store"))
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.RECORD(number, "store")), containsString(list.get(0).get("store")))
            );
    }

    @And("Buyer check have no sample found")
    public void checkNoFound() {
        SampleRequestVendorTask.check_no_order();
    }

    @And("Check info sample request detail")
    public void check_info_sample_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.REQUEST_DATE), equalToIgnoringCase(CommonHandle.setDate(list.get(0).get("requestDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.FULFILLMENT), equalToIgnoringCase(list.get(0).get("fulfillment"))),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.DYNAMIC_DIV("order-buyer-name")), equalToIgnoringCase(list.get(0).get("buyerName"))),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.DYNAMIC_DIV("order-store-name")), equalToIgnoringCase(list.get(0).get("storeName"))),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.DYNAMIC_DIV("address-stamp")), containsString(list.get(0).get("address"))),
                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.EMAIL_BUYER), equalToIgnoringCase(list.get(0).get("emailBuyer")))
        );
        if (list.get(0).containsKey("canceledNote")) {
            if (list.get(0).get("canceledNote").isEmpty())
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlUnDisplay(BuyerSampleRequestDetailPage.CANCELATION_NOTE))
                );
            else theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.CANCELATION_NOTE), equalToIgnoringCase(list.get(0).get("canceledNote")))
            );
        }
    }

    @And("Check Delivery detail of sample request")
    public void check_info_Delivery_sample_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
//        theActorInTheSpotlight().should(
//                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.FULFILLMENT_DATE), containsString(CommonHandle.setDate2(list.get(0).get("fulfillmentDate"), "E, dd MMM yyyy"))),
//                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.FULFILLMENT_CARRIER), containsString(list.get(0).get("carrier"))),
//                seeThat(CommonQuestions.targetText(BuyerSampleRequestDetailPage.FULFILLMENT_TRACKING_NUMBER), containsString(list.get(0).get("trackingNumber")))
//        );
        theActorInTheSpotlight().attemptsTo(
                Check.whether(list.get(0).get("fulfillmentDate").isEmpty()).otherwise(
                        Ensure.that(BuyerSampleRequestDetailPage.FULFILLMENT_DATE).text().containsIgnoringCase(CommonHandle.setDate2(list.get(0).get("fulfillmentDate"), "E, dd MMM yyyy"))
                ).andIfSo(
                        Ensure.that(BuyerSampleRequestDetailPage.FULFILLMENT_DATE).isNotDisplayed()
                ),
                Check.whether(list.get(0).get("carrier").isEmpty()).otherwise(
                        Ensure.that(BuyerSampleRequestDetailPage.FULFILLMENT_CARRIER).text().containsIgnoringCase(list.get(0).get("carrier"))
                ).andIfSo(
                        Ensure.that(BuyerSampleRequestDetailPage.FULFILLMENT_CARRIER).isNotDisplayed()
                ),
                Check.whether(list.get(0).get("trackingNumber").isEmpty()).otherwise(
                        Ensure.that(BuyerSampleRequestDetailPage.FULFILLMENT_TRACKING_NUMBER).text().containsIgnoringCase(list.get(0).get("trackingNumber"))
                ).andIfSo(
                        Ensure.that(BuyerSampleRequestDetailPage.FULFILLMENT_TRACKING_NUMBER).isNotDisplayed()
                )
        );
    }

    @And("Check first Sample request in dashboard")
    public void check_sample_in_dashboard_sample(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("number").isEmpty()) {
                Serenity.setSessionVariable("Number sample request").to(BuyerSampleRequestPage.NUMBER(1).resolveFor(theActorInTheSpotlight()).getText());
            }
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.REQUESTED(i + 1)), equalToIgnoringCase(CommonHandle.setDate(list.get(i).get("requested"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.NUMBER(i + 1)), equalToIgnoringCase(list.get(i).get("number").isEmpty() ? Serenity.sessionVariableCalled("Number sample request") : list.get(i).get("number"))),
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.STORE(i + 1)), containsString(list.get(i).get("store"))),
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.BRAND(i + 1)), containsString(list.get(i).get("brand"))),
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.PRODUCT(i + 1)), containsString(list.get(i).get("product"))),
                    seeThat(CommonQuestions.targetText(BuyerSampleRequestPage.FULFILLMENT(i + 1)), equalToIgnoringCase(list.get(i).get("fulfillment")))
            );
        }
    }

    @And("Go to sample request detail with number {string}")
    public void goToSampleRequest(String number) {
        if (number.isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(BuyerSampleRequestPage.NUMBER(1)),
                    Click.on(BuyerSampleRequestPage.NUMBER(1)),
                    CommonWaitUntil.isVisible(BuyerSampleRequestPage.BACK)
            );
        } else {
            if (number.equalsIgnoreCase("create by api")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(BuyerSampleRequestPage.NUMBER(Serenity.sessionVariableCalled("Number of Sample api"))),
                        Click.on(BuyerSampleRequestPage.NUMBER(Serenity.sessionVariableCalled("Number of Sample api"))),
                        CommonWaitUntil.isVisible(BuyerSampleRequestPage.BACK)
                );
            } else if (number.contains("create by api of buyer")) {
                String buyerId = number.split("buyer ")[1];
                number = Serenity.sessionVariableCalled("Number of Sample api of buyer " + buyerId).toString();
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(BuyerSampleRequestPage.NUMBER(Serenity.sessionVariableCalled("Number of Sample api of buyer " + buyerId).toString())),
                        Click.on(BuyerSampleRequestPage.NUMBER(Serenity.sessionVariableCalled("Number of Sample api of buyer " + buyerId).toString())),
                        CommonWaitUntil.isVisible(BuyerSampleRequestPage.BACK)
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(BuyerOrderPage.NUMBER(number)),
                        Click.on(BuyerOrderPage.NUMBER(number)),
                        CommonWaitUntil.isVisible(BuyerSampleRequestPage.BACK));
            }
        }
    }

    @And("Add to cart sku {string} from sample request")
    public void addCartFromSample(String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerSampleRequestPage.ADD_CART(sku)),
                Click.on(BuyerSampleRequestPage.ADD_CART(sku)),
                WindowTask.threadSleep(1000)
        );
    }

    @And("{word} click Back to Sample requests")
    public void backToSample(String actor) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerSampleRequestPage.BACK),
                Click.on(BuyerSampleRequestPage.BACK),
                WindowTask.threadSleep(1000)
        );
    }

}
