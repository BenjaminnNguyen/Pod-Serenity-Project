package cucumber.tasks.api.admin.vendor;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminAllVendorAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response searchAllVendor(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_ALL_VENDOR, map, "GET");
        Serenity.recordReportData().withTitle("RESPONSE SEARCH ALL VENDOR: ").andContents(response.prettyPrint());
        return response;
    }

    public void callDeleteVendorCompany(String vendor) {
            Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_ALL_VENDOR(vendor), "DELETE");
            Serenity.recordReportData().withTitle("RESPONSE DELETE VENDOR_COMPANY: ").andContents(response.prettyPrint());
    }

    public List<String> getListAllVendorId(Response response, String name) {
        List<String> vendor = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            if(item.get("name").equals(name)) {
                vendor.add(item.get("id").toString());
            }
        }
        Serenity.setSessionVariable("List Id ALl Vendor API").to(vendor);
        System.out.println(vendor);
        return vendor;
    }

    public Map<String, Object> setEditVendor(Map<String, Object> info) {
        Map<String, Object> vendor = new HashMap<>();
        Map<String, Object> vendorInfo = new HashMap<>();
        vendorInfo = info;
        vendor.putIfAbsent("vendor", vendorInfo);

        return vendor;
    }
}
