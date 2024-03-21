package cucumber.tasks.api;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import net.serenitybdd.core.Serenity;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OkHTTPHandleResponse {

    public static String getIDSKU(String response) {
        JSONObject jsonObject = new JSONObject(response);
        JSONObject product_variant = jsonObject.getJSONObject("product_variant");
        String id = product_variant.get("id").toString();
        System.out.println("id " + id);
        Serenity.setSessionVariable("ID SKU").to(id);
//        Serenity.recordReportData().asEvidence().withTitle("ID SKU")
//                .andContents(id);
        return id;
    }

    public static String getIDSKUAdmin(String response) {
        JSONObject jsonObject = new JSONObject(response);
        String id = jsonObject.get("id").toString();
        JSONArray arr = jsonObject.getJSONArray("variants_regions_attributes");
        JSONArray arr2 = jsonObject.getJSONArray("stores_variants_regions_attributes");
        List<String> region_ids = new ArrayList<>();
        List<String> store_ids = new ArrayList<>();
        for (int i = 0; i < arr.length(); i++) {
            String variant_region= arr.getJSONObject(i).get("id").toString();
            region_ids.add(variant_region);
            Serenity.setSessionVariable("ID Region SKU Admin" + arr.getJSONObject(i).get("region_id")).to(variant_region);
        }
        for (int i = 0; i < arr2.length(); i++) {
            store_ids.add(arr2.getJSONObject(i).get("id").toString());
        }
        System.out.println("id " + id);
        Serenity.setSessionVariable("ID SKU Admin").to(id);
        Serenity.setSessionVariable("ID Region SKU Admin").to(region_ids);
        Serenity.setSessionVariable("ID Store variant region SKU Admin").to(store_ids);
        Serenity.setSessionVariable("Store variant region SKU Admin").to(arr2);
        return id;
    }

    public static String getIDRegionSKUAdmin(String skuName, String regionId) {
        Response response = Serenity.sessionVariableCalled("Create SKU response api" + skuName);
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> variants_regions_attributes = new ArrayList<>();
        variants_regions_attributes = jsonPath.get("variants_regions_attributes");
        String id ="";
        for (Map<String, Object> map : variants_regions_attributes){
            if(map.get("region_id").toString().equals(regionId)){
                id = map.get("id").toString();
            }
        }
        System.out.println("region_id" + id);
        Serenity.setSessionVariable("Variant region ID api").to(id);
        return id;
    }
}
