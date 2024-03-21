package steps.api.admin.sampleRequest;

import cucumber.models.web.Admin.sample.AddressAttributes;
import cucumber.models.web.Admin.sample.CreateSampleModel;
import cucumber.models.web.Admin.sample.ItemAttributesSample;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.AdminSampleRequestAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SampleRequestAPIStepDefinitions {
    AdminSampleRequestAPI sampleAPI = new AdminSampleRequestAPI();

    @And("Admin create sample request by API")
    public void create_sample_by_API(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        AddressAttributes addressAttributes = AdminSampleRequestAPI.setAddress(list.get(0));
        List<ItemAttributesSample> itemsAttributes = Serenity.sessionVariableCalled("List items sample API");
        List<String> buyers = new ArrayList<>();
        buyers.add(list.get(0).get("buyer_ids"));
        List<String> products = new ArrayList<>();
        products.add(list.get(0).get("product_ids").isEmpty() ? Serenity.sessionVariableCalled("ID Product Admin").toString() : list.get(0).get("product_ids"));
        CreateSampleModel createSampleModel = new CreateSampleModel(addressAttributes, list.get(0).get("buyer_id"), buyers, list.get(0).get("comment"), CommonHandle.setDate2(list.get(0).get("fulfillment_date"), "yyyy-MM-dd"), list.get(0).get("fulfillment_state"), list.get(0).get("head_buyer_id"), products, itemsAttributes, list.get(0).get("store_id"), list.get(0).get("vendor_company_id"));
        Map<String, Object> map = new HashMap<>();
        map.put("sample_request", createSampleModel);
        Response response = sampleAPI.callCreateSample(map, UrlAdminAPI.ADMIN_SAMPLE_REQUEST);
//        System.out.println(response.asString());
        sampleAPI.getIdSample(response);
    }

    @And("Admin create sample request for Head Buyer by API")
    public void create_sample_head_buyer_by_API(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        AddressAttributes addressAttributes = AdminSampleRequestAPI.setAddress(list.get(0));
        List<ItemAttributesSample> itemsAttributes = Serenity.sessionVariableCalled("List items sample API");
        List<String> products = new ArrayList<>();
        products.add(list.get(0).get("product_ids").isEmpty() ? Serenity.sessionVariableCalled("ID Product Admin").toString() : list.get(0).get("product_ids"));
        CreateSampleModel createSampleModel = new CreateSampleModel(addressAttributes, null, null, list.get(0).get("comment"), list.get(0).get("fulfillment_date"), list.get(0).get("fulfillment_state"), list.get(0).get("head_buyer_id"), products, itemsAttributes, null, list.get(0).get("vendor_company_id"));
        Map<String, Object> map = new HashMap<>();
        map.put("sample_request", createSampleModel);
        Response response = sampleAPI.callCreateSample(map, UrlAdminAPI.ADMIN_SAMPLE_REQUEST);
        System.out.println(response.asString());
        sampleAPI.getIdSample(response);
    }

    @And("Admin create sample request by API2")
    public void create_sample_by_API2(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        AddressAttributes addressAttributes = AdminSampleRequestAPI.setAddress(list.get(0));
        List<ItemAttributesSample> itemsAttributes = Serenity.sessionVariableCalled("List items sample API");
        List<String> buyers = Serenity.sessionVariableCalled("List Buyer of sample request api");
        List<String> products = new ArrayList<>();
        products.add(list.get(0).get("product_ids").isEmpty() ? Serenity.sessionVariableCalled("ID Product Admin").toString() : list.get(0).get("product_ids"));
        Map<String, Object> map = new HashMap<>();
        Response response = null;
        if (buyers.size() > 1) {
//            #    Neu multiple buyer thi k can store id, address cung dc
            if (list.get(0).get("vendor_company_id").contains("create by api")) {
            }
            CreateSampleModel createSampleModel = new CreateSampleModel(addressAttributes, null, buyers, list.get(0).get("comment"), list.get(0).get("fulfillment_date"), list.get(0).get("fulfillment_state"), list.get(0).get("head_buyer_id"), products, itemsAttributes, list.get(0).get("store_id"), list.get(0).get("vendor_company_id").contains("create by api") ? Serenity.sessionVariableCalled("ID of Vendor company") : list.get(0).get("vendor_company_id"));
            map.put("sample_request", createSampleModel);
            map.put("buyer_ids", buyers);
            response = sampleAPI.callCreateSample(map, UrlAdminAPI.ADMIN_MULTIPLE_SAMPLE_REQUEST);
        } else {
            CreateSampleModel createSampleModel = new CreateSampleModel(addressAttributes, buyers.get(0), buyers, list.get(0).get("comment"), list.get(0).get("fulfillment_date"), list.get(0).get("fulfillment_state"), list.get(0).get("head_buyer_id"), products, itemsAttributes, list.get(0).get("store_id"), list.get(0).get("vendor_company_id").contains("create by api") ? Serenity.sessionVariableCalled("ID of Vendor company") : list.get(0).get("vendor_company_id"));
            map.put("sample_request", createSampleModel);
            response = sampleAPI.callCreateSample(map, UrlAdminAPI.ADMIN_SAMPLE_REQUEST);
        }
        System.out.println(response.asString());
        sampleAPI.getIdSample(response);
    }

    @And("Admin create sample request by with multiple products API")
    public void create_sample_by_API3(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        AddressAttributes addressAttributes = AdminSampleRequestAPI.setAddress(list.get(0));
        List<ItemAttributesSample> itemsAttributes = Serenity.sessionVariableCalled("List items sample API");
        List<String> buyers = Serenity.sessionVariableCalled("List Buyer of sample request api");
        List<String> products = Serenity.sessionVariableCalled("List id products sample request api");
        Map<String, Object> map = new HashMap<>();
        Response response = null;
        if (buyers.size() > 1) {
//            #    Neu multiple buyer thi k can store id, address cung dc
            if (list.get(0).get("vendor_company_id").contains("create by api")) {
            }
            CreateSampleModel createSampleModel = new CreateSampleModel(addressAttributes, null, buyers, list.get(0).get("comment"), CommonHandle.setDate2(list.get(0).get("fulfillment_date"), "yyyy-MM-dd"), list.get(0).get("fulfillment_state"), list.get(0).get("head_buyer_id"), products, itemsAttributes, list.get(0).get("store_id"), list.get(0).get("vendor_company_id").contains("create by api") ? Serenity.sessionVariableCalled("ID of Vendor company") : list.get(0).get("vendor_company_id"));
            map.put("sample_request", createSampleModel);
            map.put("buyer_ids", buyers);
            response = sampleAPI.callCreateSample(map, UrlAdminAPI.ADMIN_MULTIPLE_SAMPLE_REQUEST);
        } else {
            CreateSampleModel createSampleModel = new CreateSampleModel(addressAttributes, buyers.get(0), buyers, list.get(0).get("comment"), CommonHandle.setDate2(list.get(0).get("fulfillment_date"), "yyyy-MM-dd"), list.get(0).get("fulfillment_state"), list.get(0).get("head_buyer_id"), products, itemsAttributes, list.get(0).get("store_id"), list.get(0).get("vendor_company_id").contains("create by api") ? Serenity.sessionVariableCalled("ID of Vendor company") : list.get(0).get("vendor_company_id"));
            map.put("sample_request", createSampleModel);
            response = sampleAPI.callCreateSample(map, UrlAdminAPI.ADMIN_SAMPLE_REQUEST);
        }
        System.out.println(response.asString());
        sampleAPI.getIdSample(response);
    }

    @And("Admin add buyer for sample request by API")
    public void addBuyerSample(DataTable dt) {
        List<Map<String, String>> buyers = dt.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        List<String> buyer = new ArrayList<>();
        if (buyers.size() > 1) {
            for (Map<String, String> m : buyers) {
                buyer.add(m.get("buyer_id"));
            }
            map.put("buyer_ids", buyer);
        }
        if (buyers.size() == 1) {
            buyer.add(buyers.get(0).get("buyer_id"));
        }
        Serenity.setSessionVariable("List Buyer of sample request api").to(buyer);
    }

    @And("Admin add SKUs sample request by API")
    public void admin_create_line_item_attributes_by_api(DataTable dt) {
        List<Map<String, String>> listItems = dt.asMaps(String.class, String.class);
        List<ItemAttributesSample> itemsAttributes = new ArrayList<>();
        List<String> variants_region_ids = new ArrayList<>();
        List<String> store_variants_region_ids = new ArrayList<>();
//        if (Serenity.hasASessionVariableCalled("List items sample API")) {
//            itemsAttributes = Serenity.sessionVariableCalled("List items sample API");
//        }
//        if (Serenity.hasASessionVariableCalled("ID Region SKU Admin")) {
//            variants_region_ids = Serenity.sessionVariableCalled("ID Region SKU Admin");
//        }
//        if (Serenity.hasASessionVariableCalled("ID Store variant region SKU Admin")) {
//            store_variants_region_ids = Serenity.sessionVariableCalled("ID Store variant region SKU Admin");
//        }
        if (listItems.get(0).containsKey("skuName")) {
            for (Map<String, String> item : listItems) {
                String skuId = item.get("product_variant_id").isEmpty() ? Serenity.sessionVariableCalled("itemCode" + item.get("skuName")) : item.get("product_variant_id");
                String skuRegion = item.get("variants_region_id").isEmpty() ? Serenity.sessionVariableCalled("ID Region SKU Admin" + item.get("skuName") + item.get("region_id")) : item.get("variants_region_id");
                ItemAttributesSample itemAttributes = new ItemAttributesSample(skuId, skuRegion);
                itemsAttributes.add(itemAttributes);
            }

        }
//        if (variants_region_ids.size() > 0) {
//            for (Map<String, String> item : listItems) {
//                String skuId = item.get("product_variant_id").isEmpty() ? Serenity.sessionVariableCalled("ID SKU Admin").toString() : item.get("product_variant_id");
//                String skuRegion = item.get("variants_region_id").isEmpty() ? variants_region_ids.get(0) : item.get("variants_region_id");
//                ItemAttributesSample itemAttributes = new ItemAttributesSample(skuId, skuRegion);
//                itemsAttributes.add(itemAttributes);
//            }
//        }
//        if (store_variants_region_ids.size() > 0) {
//            for (Map<String, String> item : listItems) {
//                String skuId = item.get("product_variant_id").isEmpty() ? Serenity.sessionVariableCalled("ID SKU Admin").toString() : item.get("product_variant_id");
//                String skuRegion = item.get("variants_region_id").isEmpty() ? store_variants_region_ids.get(0) : item.get("variants_region_id");
//                ItemAttributesSample itemAttributes = new ItemAttributesSample(skuId, skuRegion);
//                itemsAttributes.add(itemAttributes);
//            }
//        }
        else {
            for (Map<String, String> item : listItems) {
                String skuId = item.get("product_variant_id").isEmpty() ? Serenity.sessionVariableCalled("ID SKU Admin").toString() : item.get("product_variant_id");
                String skuRegion = item.get("variants_region_id").isEmpty() ? new ArrayList<>(Serenity.sessionVariableCalled("ID Region SKU Admin")).get(0).toString() : item.get("variants_region_id");
                ItemAttributesSample itemAttributes = new ItemAttributesSample(skuId, skuRegion);
                itemsAttributes.add(itemAttributes);
//
//                String skuId = item.get("product_variant_id");
//                String skuRegion = item.get("variants_region_id");
//                ItemAttributesSample itemAttributes = new ItemAttributesSample(skuId, skuRegion);
//                itemsAttributes.add(itemAttributes);
            }
        }
        Serenity.setSessionVariable("List items sample API").to(itemsAttributes);
    }

    @And("Admin add products sample request by API")
    public void admin_add_product_by_api(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        List<String> products = new ArrayList<>();
//        if (Serenity.hasASessionVariableCalled("List id products sample request api")) {
//            products = Serenity.sessionVariableCalled("List id products sample request api");
//        }
        for (Map<String, String> item : list) {
            if (item.containsKey("product_name")) {
                products.add(list.get(0).get("product_ids").isEmpty() ? Serenity.sessionVariableCalled("ID Product Admin" + item.get("product_name")).toString() : list.get(0).get("product_ids"));
            } else
                products.add(list.get(0).get("product_ids").isEmpty() ? Serenity.sessionVariableCalled("ID Product Admin").toString() : item.get("product_ids"));

        }
        Serenity.setSessionVariable("List id products sample request api").to(products);
    }


    @And("Admin add all SKUs just created to sample request by API")
    public void add_all_sku_to_sample() {
        List<ItemAttributesSample> itemsAttributes = new ArrayList<>();
        if (Serenity.hasASessionVariableCalled("List items sample API")) {
            itemsAttributes = Serenity.sessionVariableCalled("List items sample API");
        }
        List<String> variants_region_ids = new ArrayList<>();
        List<String> store_variants_region_ids = new ArrayList<>();
        if (Serenity.hasASessionVariableCalled("ID Region SKU Admin")) {
            variants_region_ids = Serenity.sessionVariableCalled("ID Region SKU Admin");
        }
        if (Serenity.hasASessionVariableCalled("ID Store variant region SKU Admin")) {
            store_variants_region_ids = Serenity.sessionVariableCalled("ID Store variant region SKU Admin");
        }
        String skuId = Serenity.sessionVariableCalled("ID SKU Admin").toString();
        for (int i = 0; i < variants_region_ids.size(); i++) {
            String skuRegion = variants_region_ids.get(i);
            ItemAttributesSample itemAttributes = new ItemAttributesSample(skuId, skuRegion);
            itemsAttributes.add(itemAttributes);
        }
        for (int i = 0; i < store_variants_region_ids.size(); i++) {
            String skuRegion = store_variants_region_ids.get(i);
            ItemAttributesSample itemAttributes = new ItemAttributesSample(skuId, skuRegion);
            itemsAttributes.add(itemAttributes);
        }
        Serenity.setSessionVariable("List items sample API").to(itemsAttributes);
    }

    @And("Admin edit sample request id {string} by API")
    public void changeSampleRequest(String requestId, DataTable dt) {
        List<Map<String, Object>> listItems = CommonHandle.convertDataTable(dt);
        HashMap<String, Object> hashMap = new HashMap<>();
        if (requestId.isEmpty())
            requestId = Serenity.sessionVariableCalled("ID of Sample api").toString();

        if (listItems.get(0).containsKey("fulfillment_date")) {
//            String a = listItems.get(0).get("fulfillment_date").toString();
            hashMap = CommonTask.setValue1(listItems.get(0), "fulfillment_date", listItems.get(0).get("fulfillment_date"), CommonHandle.setDate2(listItems.get(0).get("fulfillment_date").toString(), "yyyy-MM-dd"), "currentDate");
//            listItems.get(0).replace("fulfillment_date", CommonHandle.setDate2(listItems.get(0).get("fulfillment_date").toString(),"yyyy-MM-dd"));
            sampleAPI.callEditSampleRequestByID(requestId, hashMap);
        } else
            sampleAPI.callEditSampleRequestByID(requestId, listItems.get(0));
    }

    @And("Admin search sample request by API")
    public void searchSampleRequest(DataTable dt) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(dt);
        List<String> sampleIds = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        for (Map<String, Object> ob : list) {
            map.putIfAbsent(ob.get("field").toString(), ob.get("value"));
        }
        JsonPath jsonPath = sampleAPI.callSearchSampleRequest(map).jsonPath();
        List<HashMap> list2 = jsonPath.get("results");
        for (HashMap x : list2) {
            sampleIds.add(x.get("id").toString());
        }
        Serenity.setSessionVariable("List ID of Sample api").to(sampleIds);
    }

    @And("Admin cancel all sample request by API")
    public void changeAllSampleRequest() {
        List<String> sampleIds = Serenity.sessionVariableCalled("List ID of Sample api");
        for (String id : sampleIds)
            sampleAPI.callCancelSampleRequestByID(id);
    }
}
