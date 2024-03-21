package steps.api.admin.products.sku;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.OkHTTP;
import cucumber.tasks.api.admin.products.SkusAdminAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.java.en.*;
import cucumber.models.web.Admin.Products.sku.VariantRegionAttributes;
import cucumber.tasks.api.OkHTTPHandleResponse;
import cucumber.tasks.api.admin.AuthorizedSKUsAPI;
import cucumber.tasks.api.admin.HandleSkuAPI;
import cucumber.tasks.api.admin.products.ProductAdminAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.it.Ma;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import net.serenitybdd.core.Serenity;

import javax.ws.rs.core.MediaType;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static io.restassured.config.EncoderConfig.encoderConfig;

public class SkuAPIStepDefinitions {

    HandleSkuAPI skusAPI = new HandleSkuAPI();

    ProductAdminAPI productAdminAPI = new ProductAdminAPI();
    AuthorizedSKUsAPI authorizedSKUsAPI = new AuthorizedSKUsAPI();


    @And("Admin change info of regions attributes with sku {string}")
    public void regions_attributes(String statusSKU, List<VariantRegionAttributes> variantRegionAttributesList) {
        Serenity.setSessionVariable("Variant ID").to(variantRegionAttributesList.get(0).getProduct_variant_id());
        Serenity.setSessionVariable("List regions attributes").to(variantRegionAttributesList);
        for (VariantRegionAttributes item : variantRegionAttributesList) {
            skusAPI.changeRegionsSpecific(String.valueOf(item.getProduct_variant_id()), statusSKU);
        }
    }

    @And("Admin change info of regions attributes of sku {string} state {string}")
    public void regions_attributes2(String skuName, String statusSKU, List<VariantRegionAttributes> variantRegionAttributesList) {
        Serenity.setSessionVariable("Variant ID").to(variantRegionAttributesList.get(0).getProduct_variant_id());
        Serenity.setSessionVariable("List regions attributes").to(variantRegionAttributesList);
        if (skuName.contains("random")) {
            String skuId = Serenity.sessionVariableCalled("itemCode" + skuName);
            for (VariantRegionAttributes item : variantRegionAttributesList) {
                item.setProduct_variant_id(Integer.parseInt(skuId));
                if (Integer.valueOf(item.getId()) == 0) {
                    String id = OkHTTPHandleResponse.getIDRegionSKUAdmin(skuName, String.valueOf(item.getRegion_id()));
                    item.setId(Integer.parseInt(id));
                }
                skusAPI.changeRegionsSpecific(String.valueOf(item.getProduct_variant_id()), statusSKU);
            }
        } else
            for (VariantRegionAttributes item : variantRegionAttributesList) {
                skusAPI.changeRegionsSpecific(String.valueOf(item.getProduct_variant_id()), statusSKU);
            }
    }


    @And("Admin change info of store specific of sku {string}")
    public void store_attributes2(String skuId, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (skuId.contains("create by api")) {
            skuId = Serenity.sessionVariableCalled("ID SKU Admin");
        }
        if (skuId.contains("random")) {
            skuId = Serenity.sessionVariableCalled("itemCode" + skuId);
        }
        Map<String, Object> storeAttribute = new HashMap<>();
        for (int i = 0; i < list.size(); i++) {
            String store_variants_regions_attributes_config_id = skusAPI.getIdStoreAttribute(skuId, list.get(i).get("store_id"));
            String variants_region_id = list.get(i).get("id").isEmpty() ? Serenity.sessionVariableCalled("stores_variants_regions_attributes_id" + skuId) : list.get(i).get("id");

            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][id]", variants_region_id);
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][region_id]", list.get(i).get("region_id"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][store_id]", list.get(i).get("store_id"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][store_name]", list.get(i).get("store_name"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_id]", list.get(i).get("buyer_company_id"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_name]", list.get(i).get("buyer_company_name"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][product_variant_id]", skuId);
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][case_price_cents]", list.get(i).get("case_price_cents"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][state]", list.get(i).get("state"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][msrp_cents]", list.get(i).get("msrp_cents"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][availability]", list.get(i).get("availability"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][id]", store_variants_regions_attributes_config_id);
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][variants_region_id]", variants_region_id);
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(list.get(i).get("start_date"), "yyyy-MM-dd"));
            storeAttribute.put("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(list.get(i).get("end_date"), "yyyy-MM-dd"));
        }
        skusAPI.callEditSKU(skuId, storeAttribute);
    }

    @And("Admin change info of buyer company specific of sku {string}")
    public void buyer_attributes2(String skuId, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
//        String id = skuId;
        if (skuId.contains("create by api")) {
            skuId = Serenity.sessionVariableCalled("ID SKU Admin");
        }
        if (skuId.contains("random")) {
            skuId = Serenity.sessionVariableCalled("itemCode" + skuId);
        }
        Map<String, Object> buyerAttribute = new HashMap<>();
        for (int i = 0; i < list.size(); i++) {
            String buyer_variants_regions_attributes_config_id = skusAPI.getIdBuyerAttribute(skuId, list.get(i).get("buyer_company_id"), list.get(i).get("region_id"));
            String variant_region_id = list.get(i).get("id").isEmpty() ? Serenity.sessionVariableCalled("buyer_variants_regions_attributes_id" + skuId) : list.get(i).get("id");
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][id]", variant_region_id);
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][region_id]", list.get(i).get("region_id"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][product_variant_id]", skuId);
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_id]", list.get(i).get("buyer_company_id"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_name]", list.get(i).get("buyer_company_name"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_state]", list.get(i).get("buyer_company_state"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][case_price_cents]", list.get(i).get("case_price_cents"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][state]", list.get(i).get("state"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][msrp_cents]", list.get(i).get("msrp_cents"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][availability]", list.get(i).get("availability"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][id]", buyer_variants_regions_attributes_config_id);
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][variants_region_id]", variant_region_id);
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(list.get(i).get("start_date"), "yyyy-MM-dd"));
            buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(list.get(i).get("end_date"), "yyyy-MM-dd"));
            if (list.get(i).containsKey("out_of_stock_reason")) {
                buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][out_of_stock_reason]", list.get(i).get("out_of_stock_reason"));
                buyerAttribute.put("product_variant[buyer_companies_variants_regions_attributes][" + i + "][auto_out_of_stock_reason]", list.get(i).get("out_of_stock_reason"));

            }
        }
        skusAPI.callEditSKU(skuId, buyerAttribute);
    }

    @And("Admin change MOQ value of product {string} by API")
    public void change_MOQ_product_by_api(String productID, DataTable dt) {
        List<Map<String, Object>> data = CommonHandle.convertDataTable(dt);
        Map<String, Object> product = productAdminAPI.setChangeMOQ(data);
        productAdminAPI.callChangeMOQvalue(productID, product);
    }

    @And("Change state of SKU id: {string} to {string}")
    public void changeStateSKUActive(String id, String state) {
        if (id.contains("random")) {
            id = Serenity.sessionVariableCalled("itemCode" + id);
        }
        productAdminAPI.callChangeStateSKU(id, state);
    }

    @And("Update all SKU of product {string} to {string}")
    public void activeAllSKUofProduct(String id, String state) {
        List<String> ids = productAdminAPI.getAllSkuId(productAdminAPI.callProductDetail(id));
        for (String sku : ids) {
            productAdminAPI.callChangeStateSKU(id, state);
        }
    }

    @And("Update regions info of SKU {string}")
    public void updateAvailabilitySKU(String sku, DataTable table) {
        List<cucumber.models.api.VariantRegionAttributes> variantRegionAttributes = table.asList(cucumber.models.api.VariantRegionAttributes.class);
        Map<String, Object> mapVariantsRegion = new HashMap<>();
        mapVariantsRegion.putIfAbsent("variants_regions_attributes", variantRegionAttributes);
        productAdminAPI.callChangeRegionInfoSKU(sku, mapVariantsRegion);
    }

    @And("Admin Authorized SKU id {string} to Store id {string}")
    public void authorizedSKUs(String id, String storeID) {
        authorizedSKUsAPI.authorizeSKU(id, storeID);
    }

    @And("Admin Authorized SKU id {string} to Buyer id {string}")
    public void authorizedSKUsBuyer(String id, String buyerId) {
        buyerId = buyerId.equals("create by api") ? Serenity.sessionVariableCalled("Buyer Account ID").toString() : buyerId;
        authorizedSKUsAPI.authorizeSKUBuyer(id, buyerId);
    }

    @And("Admin create SKU from admin with name {string} of product {string}")
    public void test(String name, String idProduct) {
        // get ID after create sku
        String id = Serenity.sessionVariableCalled("ID Product Admin");
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        if (!idProduct.isEmpty()) {
            id = idProduct;
        }
        String tmp = name;
        if (name.contains("random")) {
            // Random số để phân biệt sku
//            name = name + CommonTask.getDateTimeString();
            name = name + CommonTask.randomAlphaNumeric(10);
            Serenity.setSessionVariable("SKU inventory").to(name);
        }

        SkusAdminAPI skusAdminAPI = new SkusAdminAPI();

        RequestSpecification requestSpecification = skusAdminAPI.setSKU(UrlAdminAPI.CREATE_SKU(id), name, "active", "anhJPEG.jpg");
        Response response = skusAdminAPI.createSKU(UrlAdminAPI.CREATE_SKU(id), requestSpecification);
        String skuId = skusAdminAPI.getIDSKUAdmin(response);

        Serenity.setSessionVariable("itemCode" + tmp).to(skuId);
        Serenity.setSessionVariable("Create SKU response api" + tmp).to(response);
    }

    @And("Admin create a {string} SKU from admin with name {string} of product {string}")
    public void create_sku_in_admin_by_api2(String state, String name, String idProduct) {
        // get ID after create sku
        String id = Serenity.sessionVariableCalled("ID Product Admin");
        if (!idProduct.isEmpty()) {
            id = idProduct;
        }
        String tmp = name;
        if (name.contains("random")) {
            // Random số để phân biệt sku
            name = name + CommonTask.getDateTimeString();
            Serenity.setSessionVariable("SKU inventory").to(name);
        }

        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        SkusAdminAPI skusAdminAPI = new SkusAdminAPI();
        RequestSpecification requestSpecification = skusAdminAPI.setSKU(UrlAdminAPI.CREATE_SKU(id), name, state, "anhJPG2.jpg");

        Response response = skusAdminAPI.createSKU(UrlAdminAPI.CREATE_SKU(id), requestSpecification);
        String skuId = skusAdminAPI.getIDSKUAdmin2(tmp, response);

        Serenity.setSessionVariable("skuNameRandom" + tmp).to(name);
        Serenity.setSessionVariable("itemCode" + tmp).to(skuId);
        Serenity.setSessionVariable("Create SKU response api" + tmp).to(response);
        if (Serenity.hasASessionVariableCalled("Prop65 Info")) {
            List<Map<String, String>> list = Serenity.sessionVariableCalled("Prop65 Info");
            HandleSkuAPI.addProp65(Boolean.parseBoolean(list.get(0).get("containChemical")), list.get(0).get("firstName"), list.get(0).get("lastName"), list.get(0).get("email"), Integer.parseInt(skuId), Integer.parseInt(list.get(0).get("vendorCompanyId")));
            Serenity.setSessionVariable("Prop65 Info").to(null);
        }
    }

    @And("Admin create SKU of product {string} by api")
    public void create_sku_in_admin_by_api2(String idProduct, DataTable table) throws IOException, URISyntaxException {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String id = Serenity.sessionVariableCalled("ID Product Admin");
        if (!idProduct.equals("")) {
            id = idProduct;
        }
        String name = list.get(0).get("name");
        String tmp = name;

        if (list.get(0).get("name").contains("random")) {
            // Random số để phân biệt sku
            name = list.get(0).get("name") + CommonTask.getDateTimeString();
        }
        Serenity.setSessionVariable("SKU inventory").to(tmp);
        HashMap<String, String> info = CommonTask.setValue2(list.get(0), "name", list.get(0).get("name"), name, "random");

        SkusAdminAPI skusAdminAPI = new SkusAdminAPI();
        RequestSpecification requestSpecification = skusAdminAPI.setSKU2(UrlAdminAPI.CREATE_SKU(id), info);

        Response response = skusAdminAPI.createSKU(UrlAdminAPI.CREATE_SKU(id), requestSpecification);
        String skuId = skusAdminAPI.getIDSKUAdmin(response);

        Serenity.setSessionVariable("itemCode" + tmp).to(skuId);
        Serenity.setSessionVariable("Create SKU response api" + tmp).to(response);
        if (Serenity.hasASessionVariableCalled("Prop65 Info")) {
            List<Map<String, String>> prop65_info = Serenity.sessionVariableCalled("Prop65 Info");
            HandleSkuAPI.addProp65(Boolean.parseBoolean(prop65_info.get(0).get("containChemical")), prop65_info.get(0).get("firstName"), prop65_info.get(0).get("lastName"), prop65_info.get(0).get("email"), Integer.parseInt(skuId), Integer.parseInt(prop65_info.get(0).get("vendorCompanyId")));
            Serenity.setSessionVariable("Prop65 Info").to(null);
        }
    }

    @And("Info of Region")
    public void info_of_region(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        Serenity.setSessionVariable("List Region").to(list);
    }

    @And("Clear Info of Region api")
    public void clear_info_of_region() {
        Serenity.setSessionVariable("List Region").to(null);
    }

    @And("Clear Info of buyer company api")
    public void clear_info_of_buyer() {
        Serenity.setSessionVariable("List Buyer company").to(null);
    }

    @And("Clear Info of store api")
    public void clear_info_of_store() {
        Serenity.setSessionVariable("List Store specific").to(null);
    }

    @And("Info of Buyer company specific")
    public void info_of_buyer_company(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        Serenity.setSessionVariable("List Buyer company").to(list);
    }

    @And("Info of Store specific")
    public void info_of_store(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        Serenity.setSessionVariable("List Store specific").to(list);
    }

    @And("Info of Prop65")
    public void info_of_prop(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        Serenity.setSessionVariable("Prop65 Info").to(list);
    }

    @And("Admin save sku name by index {string}")
    public void admin_save_sku_name_by_index(String index) {
        String skuName = Serenity.sessionVariableCalled("SKU inventory");
        // lưu tên sku nếu tạo nhiều sku 1 lúc, ví dụ random1, random2
        // lấy ký tự cuối làm index
        Serenity.setSessionVariable("SKU inventory" + index).to(skuName);
    }
}
