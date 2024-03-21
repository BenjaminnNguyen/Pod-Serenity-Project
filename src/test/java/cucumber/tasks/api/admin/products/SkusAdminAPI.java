package cucumber.tasks.api.admin.products;

import cucumber.models.web.Admin.Products.sku.*;
import cucumber.singleton.UrlAPI;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import net.serenitybdd.core.Serenity;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.core.MediaType;
import java.io.File;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static io.restassured.config.EncoderConfig.encoderConfig;


public class SkusAdminAPI {

    public Response activeCompanySpecific() {
        CommonRequest commonRequest = new CommonRequest();
        String variant_id = Serenity.sessionVariableCalled("Variant ID").toString();
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.PRODUCT_VARIANT(variant_id), getCompanySpecific(), "PUT");
        System.out.println("RESPONSE ACTIVE COMPANY SPECIFIC " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE ACTIVE COMPANY SPECIFIC ").andContents(response.prettyPrint());
        return response;
    }

    public Response stateStoresSpecific() {
        CommonRequest commonRequest = new CommonRequest();
        String variant_id = Serenity.sessionVariableCalled("Variant ID").toString();
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.PRODUCT_VARIANT(variant_id), getStoresSpecific(), "PUT");
        System.out.println("RESPONSE ACTIVE STORES SPECIFIC " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE ACTIVE STORES SPECIFIC ").andContents(response.prettyPrint());
        return response;
    }

    public StateStoresSku getStoresSpecific() {
        VariantStoreAttribute variantStoreAttribute = Serenity.sessionVariableCalled("Stores attributes");
        List<VariantStoreAttribute> variantStoreAttributes = new ArrayList<>();
        variantStoreAttributes.add(variantStoreAttribute);
        ProductVariantStores productVariantStores = new ProductVariantStores("active", variantStoreAttributes);
        StateStoresSku stateStoresSku = new StateStoresSku(productVariantStores);
        return stateStoresSku;
    }

    public StateCompanySku getCompanySpecific() {
        CompanyAttribuites companyAttribuite = Serenity.sessionVariableCalled("Company attributes");
        List<CompanyAttribuites> companyAttribuites = new ArrayList<>();
        companyAttribuites.add(companyAttribuite);
        ProductVariantCompanies productVariantCompany = new ProductVariantCompanies("active", companyAttribuites);
        StateCompanySku stateCompanySku = new StateCompanySku(productVariantCompany);
        return stateCompanySku;
    }


    /**
     * @param url      - endpoint
     * @param name     - tên sku
     * @param state    - active hay inactive
     * @param fileName - tên file upload
     * @return
     */
    public RequestSpecification setSKU(String url, String name, String state, String fileName) {
        RestAssured.baseURI = url;
        RequestSpecification requestSpecification = new RequestSpecBuilder().build();

        List<Map<String, String>> listRegion = Serenity.sessionVariableCalled("List Region");
        List<Map<String, String>> listBuyerCompany = Serenity.sessionVariableCalled("List Buyer company");
        List<Map<String, String>> listStores = Serenity.sessionVariableCalled("List Store specific");
        List<Map<String, String>> prop65 = Serenity.hasASessionVariableCalled("Prop65 Info") ? Serenity.sessionVariableCalled("Prop65 Info") : null;

        requestSpecification
                .formParam("product_variant[name]", name)
                .formParam("product_variant[state]", state)
                .formParam("product_variant[availability]", "coming_soon")
                .formParam("product_variant[case_units]", "1")
                .formParam("product_variant[msrp_cents]", "0")
                .formParam("product_variant[master_image_attributes][alt]", "")
                .multiPart("product_variant[master_image_attributes][attachment]", new File(System.getProperty("user.dir") + "/src/test/resources/Images/" + fileName))
                .formParam("product_variant[barcode_attributes][code]", "123123123123")
                .formParam("product_variant[barcode_attributes][case_code]", "123123123123")
                .formParam("product_variant[barcode_attributes][type]", "Barcodes::Upc")
                .formParam("product_variant[barcode_attributes][image_attributes][alt]", "")
                .multiPart("product_variant[barcode_attributes][image_attributes][attachment]", new File(System.getProperty("user.dir") + "/src/test/resources/Images/" + fileName))
                .formParam("product_variant[barcode_attributes][case_image_attributes][alt]", "")
                .multiPart("product_variant[barcode_attributes][case_image_attributes][attachment]", new File(System.getProperty("user.dir") + "/src/test/resources/Images/" + fileName))
                .formParam("product_variant[storage_shelf_life_attributes][days]", "1")
                .formParam("product_variant[storage_shelf_life_attributes][shelf_life_condition_id]", "1")
                .formParam("product_variant[storage_shelf_life_attributes][pull_threshold_use_default_value]", "true")
                .formParam("product_variant[storage_shelf_life_attributes][pull_threshold]", "")
                .formParam("product_variant[retail_shelf_life_attributes][days]", "1")
                .formParam("product_variant[retail_shelf_life_attributes][shelf_life_condition_id]", "1")
                .formParam("product_variant[max_temperature]", "1")
                .formParam("product_variant[min_temperature]", "1")
                .formParam("product_variant[manufacturer_address_attributes][city]", "Chicago")
                .formParam("product_variant[manufacturer_address_attributes][address_state_id]", "14");
        ;
        // thêm region theo list
        if (listRegion != null) {
            int size = listRegion.size();
            for (int i = 0; i < size; i++) {
                requestSpecification
                        .formParam("product_variant[variants_regions_attributes][" + i + "][region_id]", listRegion.get(i).get("id"))
                        .formParam("product_variant[variants_regions_attributes][" + i + "][case_price_cents]", listRegion.get(i).get("casePrice"))
                        .formParam("product_variant[variants_regions_attributes][" + i + "][msrp_cents]", listRegion.get(i).get("msrp"))
                        .formParam("product_variant[variants_regions_attributes][" + i + "][availability]", listRegion.get(i).get("availability"))
                ;
            }
        }
        // thêm Buyer company theo list
        if (listBuyerCompany != null) {
            int size = listBuyerCompany.size();
            for (int i = 0; i < listBuyerCompany.size(); i++) {
                requestSpecification
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_id]", listBuyerCompany.get(i).get("buyer_company_id"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_name]", listBuyerCompany.get(i).get("buyer_company_name"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][region_id]", listBuyerCompany.get(i).get("region_id"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(listBuyerCompany.get(i).get("start_date"), "yyyy-MM-dd"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(listBuyerCompany.get(i).get("end_date"), "yyyy-MM-dd"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][case_price_cents]", listBuyerCompany.get(i).get("case_price_cents"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][msrp_cents]", listBuyerCompany.get(i).get("msrp_cents"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][availability]", listBuyerCompany.get(i).get("availability"));
                if (listBuyerCompany.get(i).containsKey("out_of_stock_reason")) {
                    requestSpecification
                            .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][out_of_stock_reason]", listBuyerCompany.get(i).get("out_of_stock_reason"))
                            .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][auto_out_of_stock_reason]", listBuyerCompany.get(i).get("auto_out_of_stock_reason"));
                }
            }
        } else {
            requestSpecification.formParam("product_variant[buyer_companies_variants_regions_attributes][]", "");
        }
        // thêm Store specific theo list
        if (listStores != null) {
            for (int i = 0; i < listStores.size(); i++) {
                requestSpecification
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][region_id]", listStores.get(i).get("region_id"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][store_id]", listStores.get(i).get("store_id"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][store_name]", listStores.get(i).get("store_name"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_id]", listStores.get(i).get("buyer_company_id"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_name]", listStores.get(i).get("buyer_company_name"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(listStores.get(i).get("start_date"), "yyyy-MM-dd"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(listStores.get(i).get("end_date"), "yyyy-MM-dd"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][case_price_cents]", listStores.get(i).get("case_price_cents"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][msrp_cents]", listStores.get(i).get("msrp_cents"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][availability]", listStores.get(i).get("availability"));
            }
        } else {
            requestSpecification.formParam("product_variant[stores_variants_regions_attributes][]", "");
        }

        requestSpecification
                .multiPart("product_variant[nutrition_labels_attributes][0][attachment]", new File(System.getProperty("user.dir") + "/src/test/resources/Images/" + fileName))
                .formParam("product_variant[nutrition_labels_attributes][0][description]", "")
                .formParam("product_variant[variant_inventory_config_attributes][expiry_day_threshold]", "100")
                .formParam("product_variant[variant_inventory_config_attributes][low_quantity_threshold]", "10")
                .formParam("product_variant[lead_time]", "")
                .formParam("product_variant[quality_ids]", "15")
//                .formParam("product_variant[product_variants_tags_attributes][0][tag_id]", "56")
//                .formParam("product_variant[product_variants_tags_attributes][0][tag_name]", "Private SKU tag_1")
                .formParam("product_variant[position]", "2")
                .formParam("product_variant[ingredients]", "Ingredients")
                .formParam("product_variant[description]", "Description");
        ;
        // them prop65
        if (prop65 != null) {
            requestSpecification
                    .formParam("product_variant[chemical_prop_form][contain_chemical]", prop65.get(0).get("containChemical"))
                    .formParam("product_variant[chemical_prop_form][first_name]", prop65.get(0).get("firstName"))
                    .formParam("product_variant[chemical_prop_form][last_name]", prop65.get(0).get("lastName"))
                    .formParam("product_variant[chemical_prop_form][email]", prop65.get(0).get("email"));
        }

        return requestSpecification;
    }

    /**
     * @param url  - endpoint
     * @param info - Map data
     * @return
     */
    public RequestSpecification setSKU2(String url, Map<String, String> info) throws URISyntaxException {
        RestAssured.baseURI = url;
        RequestSpecification requestSpecification = new RequestSpecBuilder().build();

        ClassLoader classLoader = CommonRequest.class.getClassLoader();
        File masterImageFile = new File(classLoader.getResource("Images/" + info.get("masterImage")).toURI().getPath());

        String masterImage = "/" + masterImageFile.getAbsolutePath().replaceAll("\\\\", "/");
        String barcodeImage = "/" + new File(classLoader.getResource("Images/" + info.get("barcodeImage")).toURI().getPath())
                .getAbsolutePath().replaceAll("\\\\", "/");
        String caseImage = "/" + new File(classLoader.getResource("Images/" + info.get("caseImage")).toURI().getPath())
                .getAbsolutePath().replaceAll("\\\\", "/");
        String masterCartonImage = "/" + new File(classLoader.getResource("Images/" + info.get("masterCartonImage")).toURI().getPath())
                .getAbsolutePath().replaceAll("\\\\", "/");
        String nutritionLabel = "/" + new File(classLoader.getResource("Images/" + info.get("nutritionLabelImage")).toURI().getPath())
                .getAbsolutePath().replaceAll("\\\\", "/");

        List<Map<String, String>> listRegion = Serenity.sessionVariableCalled("List Region");
        List<Map<String, String>> listBuyerCompany = Serenity.sessionVariableCalled("List Buyer company");
        List<Map<String, String>> listStores = Serenity.sessionVariableCalled("List Store specific");
        List<Map<String, String>> prop65 = Serenity.hasASessionVariableCalled("Prop65 Info") ? Serenity.sessionVariableCalled("Prop65 Info") : null;

        requestSpecification
                .formParam("product_variant[name]", info.get("name"))
                .formParam("product_variant[state]", info.get("state"))
                .formParam("product_variant[availability]", "out_of_stock")
                .formParam("product_variant[case_units]", info.get("case_units"))
                .formParam("product_variant[msrp_cents]", info.get("msrp_cents"))
                .formParam("product_variant[master_image_attributes][alt]", "")
                .multiPart("product_variant[master_image_attributes][attachment]", new File(masterImage))
                .formParam("product_variant[barcode_attributes][code]", info.get("code"))
                .formParam("product_variant[barcode_attributes][case_code]", info.get("case_code"))
                .formParam("product_variant[barcode_attributes][type]", info.get("barcode_type"))
                .formParam("product_variant[barcode_attributes][image_attributes][alt]", "")
                .multiPart("product_variant[barcode_attributes][image_attributes][attachment]", new File(barcodeImage))
                .formParam("product_variant[barcode_attributes][case_image_attributes][alt]", "")
                .multiPart("product_variant[barcode_attributes][case_image_attributes][attachment]", new File(caseImage))
                .formParam("product_variant[master_carton_code]", info.get("master_carton_code"))
                .multiPart("product_variant[master_carton_image_attributes][attachment]", new File(masterCartonImage))
                .formParam("product_variant[storage_shelf_life_attributes][days]", info.get("storage_shelf_life"))
                .formParam("product_variant[storage_shelf_life_attributes][shelf_life_condition_id]", info.get("shelf_life_condition_id"))
                .formParam("product_variant[storage_shelf_life_attributes][pull_threshold_use_default_value]", info.get("pull_threshold_use_default_value"))
                .formParam("product_variant[storage_shelf_life_attributes][pull_threshold]", info.get("pull_threshold"))
                .formParam("product_variant[retail_shelf_life_attributes][days]", info.get("retail_shelf_life"))
                .formParam("product_variant[retail_shelf_life_attributes][shelf_life_condition_id]", info.get("retail_shelf_life_id"))
                .formParam("product_variant[max_temperature]", info.get("max_temperature"))
                .formParam("product_variant[min_temperature]", info.get("min_temperature"))
                .formParam("product_variant[manufacturer_address_attributes][city]", info.get("city"))
                .formParam("product_variant[manufacturer_address_attributes][address_state_id]", info.get("address_state_id"))
        ;
        // thêm region theo list
        if (listRegion != null) {
            int size = listRegion.size();
            for (int i = 0; i < size; i++) {
                requestSpecification
                        .formParam("product_variant[variants_regions_attributes][" + i + "][region_id]", listRegion.get(i).get("id"))
                        .formParam("product_variant[variants_regions_attributes][" + i + "][case_price_cents]", listRegion.get(i).get("casePrice"))
                        .formParam("product_variant[variants_regions_attributes][" + i + "][msrp_cents]", listRegion.get(i).get("msrp"))
                        .formParam("product_variant[variants_regions_attributes][" + i + "][availability]", listRegion.get(i).get("availability"))
                ;
            }
        }
        // thêm Buyer company theo list
        if (listBuyerCompany != null) {
            int size = listBuyerCompany.size();
            for (int i = 0; i < listBuyerCompany.size(); i++) {
                requestSpecification
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_id]", listBuyerCompany.get(i).get("buyer_company_id"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_name]", listBuyerCompany.get(i).get("buyer_company_name"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][region_id]", listBuyerCompany.get(i).get("region_id"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(listBuyerCompany.get(i).get("start_date"), "yyyy-MM-dd"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(listBuyerCompany.get(i).get("end_date"), "yyyy-MM-dd"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][case_price_cents]", listBuyerCompany.get(i).get("case_price_cents"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][msrp_cents]", listBuyerCompany.get(i).get("msrp_cents"))
                        .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][availability]", listBuyerCompany.get(i).get("availability"));
                if (listBuyerCompany.get(i).containsKey("out_of_stock_reason")) {
                    requestSpecification
                            .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][out_of_stock_reason]", listBuyerCompany.get(i).get("out_of_stock_reason"))
                            .formParam("product_variant[buyer_companies_variants_regions_attributes][" + i + "][auto_out_of_stock_reason]", listBuyerCompany.get(i).get("auto_out_of_stock_reason"));
                }
            }
        } else {
            requestSpecification.formParam("product_variant[buyer_companies_variants_regions_attributes][]", "");
        }
        // thêm Store specific theo list
        if (listStores != null) {
            for (int i = 0; i < listStores.size(); i++) {
                requestSpecification
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][region_id]", listStores.get(i).get("region_id"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][store_id]", listStores.get(i).get("store_id"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][store_name]", listStores.get(i).get("store_name"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_id]", listStores.get(i).get("buyer_company_id"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_name]", listStores.get(i).get("buyer_company_name"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(listStores.get(i).get("start_date"), "yyyy-MM-dd"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(listStores.get(i).get("end_date"), "yyyy-MM-dd"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][case_price_cents]", listStores.get(i).get("case_price_cents"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][msrp_cents]", listStores.get(i).get("msrp_cents"))
                        .formParam("product_variant[stores_variants_regions_attributes][" + i + "][availability]", listStores.get(i).get("availability"));
            }
        } else {
            requestSpecification.formParam("product_variant[stores_variants_regions_attributes][]", "");
        }

        requestSpecification
                .multiPart("product_variant[nutrition_labels_attributes][0][attachment]", new File(nutritionLabel))
                .formParam("product_variant[nutrition_labels_attributes][0][description]", info.get("nutrition_description"))
                .formParam("product_variant[variant_inventory_config_attributes][expiry_day_threshold]", info.get("expiry_day_threshold"))
                .formParam("product_variant[variant_inventory_config_attributes][low_quantity_threshold]", info.get("low_quantity_threshold"))
                .formParam("product_variant[lead_time]", info.get("lead_time"))
                .formParam("product_variant[quality_ids]", "15")
//                .formParam("product_variant[product_variants_tags_attributes][0][tag_id]", "56")
//                .formParam("product_variant[product_variants_tags_attributes][0][tag_name]", "Private SKU tag_1")
                .formParam("product_variant[position]", info.get("position"))
                .formParam("product_variant[ingredients]", info.get("ingredients"))
                .formParam("product_variant[description]", info.get("description"));
        ;

        if (prop65 != null) {
            requestSpecification
                    .formParam("product_variant[chemical_prop_form][contain_chemical]", prop65.get(0).get("containChemical"))
                    .formParam("product_variant[chemical_prop_form][first_name]", prop65.get(0).get("firstName"))
                    .formParam("product_variant[chemical_prop_form][last_name]", prop65.get(0).get("lastName"))
                    .formParam("product_variant[chemical_prop_form][email]", prop65.get(0).get("email"));
        }

        return requestSpecification;
    }

    public Response createSKU(String orderId, RequestSpecification requestSpec) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestMultiPart(UrlAdminAPI.UPDATE_LINE_ITEM_ORDER(orderId), requestSpec, "POST");
        System.out.println("RESPONSE CREATE SKU " + response.prettyPrint());
        return response;
    }


    public static String getIDSKUAdmin(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        List<HashMap> arr = jsonPath.get("variants_regions_attributes");
        List<HashMap> arr2 = jsonPath.get("stores_variants_regions_attributes");
        List<String> region_ids = new ArrayList<>();
        List<String> store_ids = new ArrayList<>();
        for (int i = 0; i < arr.size(); i++) {
            String variant_region = arr.get(i).get("id").toString();
            region_ids.add(variant_region);
            Serenity.setSessionVariable("ID Region SKU Admin" + arr.get(i).get("region_id")).to(variant_region);
        }
        for (int i = 0; i < arr2.size(); i++) {
            store_ids.add(arr2.get(i).get("id").toString());
        }
        System.out.println("id " + id);
        System.out.println("variants_regions_attributes " + region_ids);

        Serenity.setSessionVariable("ID SKU Admin").to(id);
        Serenity.setSessionVariable("ID Region SKU Admin").to(region_ids);
        Serenity.setSessionVariable("ID Store variant region SKU Admin").to(store_ids);
        Serenity.setSessionVariable("Store variant region SKU Admin").to(arr2);
        return id;
    }

    public static String getIDSKUAdmin2(String skuName, Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        List<HashMap> arr = jsonPath.get("variants_regions_attributes");
        List<HashMap> arr2 = jsonPath.get("stores_variants_regions_attributes");
        List<String> region_ids = new ArrayList<>();
        List<String> store_ids = new ArrayList<>();
        for (int i = 0; i < arr.size(); i++) {
            String variant_region = arr.get(i).get("id").toString();
            region_ids.add(variant_region);
            Serenity.setSessionVariable("ID Region SKU Admin" + arr.get(i).get("region_id")).to(variant_region);
            Serenity.setSessionVariable("ID Region SKU Admin" + skuName + arr.get(i).get("region_id")).to(variant_region);
        }
        for (int i = 0; i < arr2.size(); i++) {
            store_ids.add(arr2.get(i).get("id").toString());
        }
        System.out.println("id " + id);
        System.out.println("variants_regions_attributes " + region_ids);
        Serenity.setSessionVariable("ID SKU Admin").to(id);
        Serenity.setSessionVariable("ID Region SKU Admin").to(region_ids);
        Serenity.setSessionVariable("ID Store variant region SKU Admin").to(store_ids);
        Serenity.setSessionVariable("Store variant region SKU Admin").to(arr2);
        return id;
    }


}
