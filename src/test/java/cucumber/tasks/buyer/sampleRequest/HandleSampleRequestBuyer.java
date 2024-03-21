package cucumber.tasks.buyer.sampleRequest;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Buyer.products.BuyerProductDetailPage;
import cucumber.user_interface.beta.Buyer.sampleRequest.BuyerSampleRequestPage;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

import static cucumber.user_interface.beta.Vendor.sampleRequest.VendorSampleRequestPage.*;

public class HandleSampleRequestBuyer {
    public static Task createSample(Map<String, String> map) {
        if (map.containsKey("shippingAddress")) {
            return Task.where("In put the information of sample request",
                    CommonWaitUntil.isVisible(BuyerProductDetailPage.SAMPLE_REQUEST),
                    Click.on(BuyerProductDetailPage.SAMPLE_REQUEST),
                    CommonWaitUntil.isVisible(BuyerSampleRequestPage.COMMENT),
                    Enter.theValue(map.get("comment")).into(BuyerSampleRequestPage.COMMENT),
                    Click.on(BuyerSampleRequestPage.SWITCH),
                    CommonWaitUntil.isVisible(BuyerSampleRequestPage.DYNAMIC_SHIPPING("Name")),
                    Enter.theValue(map.get("name")).into(BuyerSampleRequestPage.DYNAMIC_SHIPPING("Name")),
                    Enter.theValue(map.get("attn")).into(BuyerSampleRequestPage.DYNAMIC_SHIPPING("Attn")),
                    Enter.theValue(map.get("street")).into(BuyerSampleRequestPage.DYNAMIC_SHIPPING("Street")),
                    Enter.theValue(map.get("apt")).into(BuyerSampleRequestPage.DYNAMIC_SHIPPING("Apt, Suite, etc.")),
                    Enter.theValue(map.get("city")).into(BuyerSampleRequestPage.DYNAMIC_SHIPPING("City")),
                    Enter.theValue(map.get("state")).into(BuyerSampleRequestPage.DYNAMIC_SHIPPING("State")),
                    CommonTask.ChooseValueFromSuggestions(map.get("state")),
                    Enter.theValue(map.get("zip")).into(BuyerSampleRequestPage.DYNAMIC_SHIPPING("Postal/Zip")),
                    Enter.theValue(map.get("phone")).into(BuyerSampleRequestPage.DYNAMIC_SHIPPING("Phone number"))

            );
        } else
            return Task.where("In put the information of sample request",
                    CommonWaitUntil.isVisible(BuyerProductDetailPage.SAMPLE_REQUEST),
                    Click.on(BuyerProductDetailPage.SAMPLE_REQUEST),
                    CommonWaitUntil.isVisible(BuyerSampleRequestPage.COMMENT),
                    Enter.theValue(map.get("comment")).into(BuyerSampleRequestPage.COMMENT)
            );
    }

    public static Task goToCreateSample() {
        return Task.where("Go to submit sample request",
                CommonWaitUntil.isVisible(BuyerProductDetailPage.SAMPLE_REQUEST),
                Click.on(BuyerProductDetailPage.SAMPLE_REQUEST),
                CommonWaitUntil.isVisible(BuyerSampleRequestPage.COMMENT)
        );
    }

    public static Task selectSkuCreateSample(Map<String, String> list) {
        return Task.where("",
                CommonWaitUntil.isVisible(BuyerSampleRequestPage.DYNAMIC_SKU(list.get("sku"))),
                Click.on(BuyerSampleRequestPage.DYNAMIC_SKU(list.get("sku")))
        );
    }

    public static Task search(String tab, Map<String, String> map) {
        return Task.where("Search on tab: " + tab + " and with info",
                CommonWaitUntil.isVisible(TAB("All")),
                Click.on(TAB(tab)),
                CommonWaitUntil.isNotVisible(LOADING_SPIN),
                Check.whether(map.get("brand").isEmpty()).otherwise(
                        Enter.theValue(map.get("brand")).into(SEARCH("Brand")),
                        CommonTask.ChooseValueFromSuggestions(map.get("brand"))
                ),
                Check.whether(map.get("requestFrom").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("requestFrom"), "MM/dd/yy")).into(SEARCH("Request date (from)")).thenHit(Keys.ENTER)

                ),
                Check.whether(map.get("requestTo").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("requestTo"), "MM/dd/yy")).into(SEARCH("Request date (to)")).thenHit(Keys.ENTER)

                ),
//                Check.whether(map.containsKey("store")).andIfSo(
//                        Check.whether(map.get("store").isEmpty()).otherwise(
//                                Enter.theValue(map.get("store")).into(SEARCH("Store")),
//                                CommonTask.ChooseValueFromSuggestions(map.get("store"))
//                        )
//                ),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your")),
                WindowTask.threadSleep(1000)
        );
    }
}
