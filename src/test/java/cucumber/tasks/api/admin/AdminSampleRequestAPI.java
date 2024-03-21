package cucumber.tasks.api.admin;

import cucumber.models.web.Admin.sample.AddressAttributes;
import cucumber.models.web.Admin.sample.ItemAttributesSample;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminSampleRequestAPI {

    CommonRequest commonRequest = new CommonRequest();

    public static AddressAttributes setAddress(Map<String, String> map) {
        AddressAttributes addressAttributes = new AddressAttributes(map.get("address_state_code"), map.get("address_state_name"), map.get("address_state_id"), map.get("street1"), map.get("city"), map.get("zip"));
        return addressAttributes;
    }

    public static ItemAttributesSample seItems(Map<String, String> map) {
        ItemAttributesSample itemAttributesSample = new ItemAttributesSample(map.get("product_variant_id"), map.get("variants_region_id"));
        return itemAttributesSample;
    }

    public Response callCreateSample(Object map, String basePath) {
        Response response = commonRequest.commonRequestWithBody2(basePath, map, "POST");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE SAMPLE: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditSampleRequestByID(String sampleID, Map<String, Object> sample_request) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.SAMPLE_REQUESTS(sampleID), sample_request, "PUT");
        System.out.println("RESPONSE EDIT SAMPLE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT SAMPLE : ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCancelSampleRequestByID(String sampleID) {
        Map<String, Object> map = new HashMap<>();
        map.put("fulfillment_state", "canceled");
        map.put("cancelled_reason", "auto");
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.SAMPLE_REQUESTS(sampleID), map, "PUT");
        System.out.println("RESPONSE EDIT SAMPLE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT SAMPLE : ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchSampleRequest(Map<String, Object> sample_request) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_SAMPLE_REQUEST, sample_request, "GET");
        System.out.println("RESPONSE SEARCH SAMPLE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH SAMPLE : ").andContents(response.prettyPrint());
        return response;
    }

    public String getIdSample(Response response) {
        JsonPath jsonPath = response.jsonPath();
        Map<String, Object> map = jsonPath.get();
        String id = "";
        String number = "";
        List<String> ids = new ArrayList<>();
        List<String> numbers = new ArrayList<>();
        if (map.containsKey("results")) {
            List<Map<String, Object>> results = (List<Map<String, Object>>) map.get("results");
            for (Map<String, Object> result : results) {
                ids.add(result.get("id").toString());
                numbers.add(result.get("number").toString());
                Serenity.setSessionVariable("Number of Sample api of buyer " + result.get("buyer_id")).to(result.get("number").toString());

            }
            Serenity.setSessionVariable("List ID of Sample api").to(ids);
            Serenity.setSessionVariable("List Number of Sample api").to(numbers);
        } else {
            id = jsonPath.get("id").toString();
            number = jsonPath.get("number").toString();
            Serenity.setSessionVariable("ID of Sample api").to(id);
            Serenity.setSessionVariable("Number of Sample api").to(number);
        }
        System.out.println("ID of sample = " + id);
        System.out.println("Number of sample = " + number);
        return id;
    }
}
