package cucumber.tasks.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import net.serenitybdd.core.Serenity;
import okhttp3.*;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;


public class OkHTTP {

    /**
     * Tạo SKU
     */
    public static String createSKUAdmin(String url, String name, String fileName1) throws IOException, URISyntaxException {
        ClassLoader classLoader = CommonRequest.class.getClassLoader();
        File file1 = new File(classLoader.getResource(fileName1).toURI().getPath());
        String file = "/" + file1.getAbsolutePath().replaceAll("\\\\", "/");
        System.out.println("Path " + file);


        OkHttpClient client = new OkHttpClient().newBuilder()
                .connectTimeout(60, TimeUnit.SECONDS)
                .writeTimeout(60, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .build();
        MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");

        List<Map<String, String>> list = Serenity.sessionVariableCalled("List Region");
        MultipartBody.Builder builder = new MultipartBody.Builder();
        builder
                .addFormDataPart("product_variant[name]", name)
                .addFormDataPart("product_variant[state]", "active")
                .addFormDataPart("product_variant[availability]", "coming_soon")
                .addFormDataPart("product_variant[case_units]", "1")
                .addFormDataPart("product_variant[msrp_cents]", "0")
                .addFormDataPart("product_variant[master_image_attributes][alt]", "")
                .addFormDataPart("product_variant[master_image_attributes][attachment]", file,
                        RequestBody.create(new File(file), MediaType.parse("application/octet-stream")
                        ))
                .addFormDataPart("product_variant[barcode_attributes][code]", "123123123123")
                .addFormDataPart("product_variant[barcode_attributes][case_code]", "1")
                .addFormDataPart("product_variant[barcode_attributes][type]", "Barcodes::Upc")
                .addFormDataPart("product_variant[barcode_attributes][image_attributes][alt]", "")
                .addFormDataPart("product_variant[barcode_attributes][image_attributes][attachment]", file,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file)))
                .addFormDataPart("product_variant[barcode_attributes][case_image_attributes][alt]", "")
                .addFormDataPart("product_variant[barcode_attributes][case_image_attributes][attachment]", file,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file)))
                .addFormDataPart("product_variant[storage_shelf_life_attributes][days]", "1")
                .addFormDataPart("product_variant[storage_shelf_life_attributes][shelf_life_condition_id]", "1")
                .addFormDataPart("product_variant[storage_shelf_life_attributes][pull_threshold_use_default_value]", "true")
                .addFormDataPart("product_variant[storage_shelf_life_attributes][pull_threshold]", "")
                .addFormDataPart("product_variant[retail_shelf_life_attributes][days]", "1")
                .addFormDataPart("product_variant[retail_shelf_life_attributes][shelf_life_condition_id]", "1")
                .addFormDataPart("product_variant[manufacturer_address_attributes][city]", "Chicago")
                .addFormDataPart("product_variant[manufacturer_address_attributes][address_state_id]", "14");
        // thêm region theo list
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                builder
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][region_id]", list.get(i).get("id"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][case_price_cents]", list.get(i).get("casePrice"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][msrp_cents]", list.get(i).get("msrp"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][availability]", list.get(i).get("availability"));
            }
        }
        builder
                .addFormDataPart("product_variant[stores_variants_regions_attributes][]", "")
                .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][]", "")
                .addFormDataPart("product_variant[nutrition_labels_attributes][0][attachment]", file,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file)));
        builder
                .addFormDataPart("product_variant[nutrition_labels_attributes][0][description]", "")
                .addFormDataPart("product_variant[variant_inventory_config_attributes][expiry_day_threshold]", "100")
                .addFormDataPart("product_variant[variant_inventory_config_attributes][low_quantity_threshold]", "10")
                .addFormDataPart("product_variant[lead_time]", "")
                .addFormDataPart("product_variant[quality_ids]", "15")
                .addFormDataPart("product_variant[product_variants_tags_attributes][0][tag_id]", "56")
                .addFormDataPart("product_variant[product_variants_tags_attributes][0][tag_name]", "Private SKU tag_1")
                .addFormDataPart("product_variant[position]", "2")
                .addFormDataPart("product_variant[ingredients]", "Ingredients")
                .addFormDataPart("product_variant[description]", "Description");

        RequestBody body = builder.build();

        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String client1 = Serenity.sessionVariableCalled("client");
        String uid = Serenity.sessionVariableCalled("uid");

        Request request = new Request.Builder()
                .url(url)
                .method("POST", body)
                .addHeader("uid", uid)
                .addHeader("access-token", accessToken)
                .addHeader("client", client1)
                .addHeader("token-type", "Bearer")
                .build();
        Response response = null;
        try {
            response = client.newCall(request).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }

        String responseString = response.body().string();
        // in ra report response
//        ObjectMapper mapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
//        System.out.println("response " + mapper.writeValueAsString(mapper.readTree(responseString)));
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE SKU").andContents(mapper.writeValueAsString(mapper.readTree(responseString)));

        return responseString;
    }

    /**
     * Create SKU có apply Prop65
     *
     * @param url
     * @param name:     name of sku
     * @param state:    active, inactive, draft
     * @param fileName1
     * @throws IOException
     * @throws URISyntaxException
     */

    public static String createSKUAdmin2(String url, String name, String state, String fileName1) throws IOException, URISyntaxException {
        ClassLoader classLoader = CommonRequest.class.getClassLoader();
        File file1 = new File(classLoader.getResource(fileName1).toURI().getPath());
        String file = "/" + file1.getAbsolutePath().replaceAll("\\\\", "/");
        System.out.println("Path " + file);
        OkHttpClient client = new OkHttpClient().newBuilder()
                .connectTimeout(90, TimeUnit.SECONDS)
                .writeTimeout(90, TimeUnit.SECONDS)
                .readTimeout(90, TimeUnit.SECONDS)
                .build();
        MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");

        List<Map<String, String>> list_region = Serenity.sessionVariableCalled("List Region");
        List<Map<String, String>> listBuyerCompany = Serenity.sessionVariableCalled("List Buyer company");
        List<Map<String, String>> listStores = Serenity.sessionVariableCalled("List Store specific");
        List<Map<String, String>> prop65 = Serenity.hasASessionVariableCalled("Prop65 Info") ? Serenity.sessionVariableCalled("Prop65 Info") : null;
        MultipartBody.Builder builder = new MultipartBody.Builder();
        builder
                .addFormDataPart("product_variant[name]", name)
                .addFormDataPart("product_variant[state]", state)
                .addFormDataPart("product_variant[availability]", "coming_soon")
                .addFormDataPart("product_variant[case_units]", "1")
                .addFormDataPart("product_variant[msrp_cents]", "0")
                .addFormDataPart("product_variant[master_image_attributes][alt]", "")
                .addFormDataPart("product_variant[master_image_attributes][attachment]", file,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file)))
                .addFormDataPart("product_variant[barcode_attributes][code]", "123123123123")
                .addFormDataPart("product_variant[barcode_attributes][case_code]", "123123123123")
                .addFormDataPart("product_variant[barcode_attributes][type]", "Barcodes::Upc")
                .addFormDataPart("product_variant[barcode_attributes][image_attributes][alt]", "")
                .addFormDataPart("product_variant[barcode_attributes][image_attributes][attachment]", file,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file)))
                .addFormDataPart("product_variant[barcode_attributes][case_image_attributes][alt]", "")
                .addFormDataPart("product_variant[barcode_attributes][case_image_attributes][attachment]", file,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file)))
                .addFormDataPart("product_variant[storage_shelf_life_attributes][days]", "1")
                .addFormDataPart("product_variant[storage_shelf_life_attributes][shelf_life_condition_id]", "1")
                .addFormDataPart("product_variant[storage_shelf_life_attributes][pull_threshold_use_default_value]", "true")
                .addFormDataPart("product_variant[storage_shelf_life_attributes][pull_threshold]", "")
                .addFormDataPart("product_variant[retail_shelf_life_attributes][days]", "1")
                .addFormDataPart("product_variant[retail_shelf_life_attributes][shelf_life_condition_id]", "1")
                .addFormDataPart("product_variant[max_temperature]", "1")
                .addFormDataPart("product_variant[min_temperature]", "1")
                .addFormDataPart("product_variant[manufacturer_address_attributes][city]", "Chicago")
                .addFormDataPart("product_variant[manufacturer_address_attributes][address_state_id]", "14");
        // thêm region theo list
        if (list_region != null)
            for (int i = 0; i < list_region.size(); i++) {
                builder
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][region_id]", list_region.get(i).get("id"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][case_price_cents]", list_region.get(i).get("casePrice"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][msrp_cents]", list_region.get(i).get("msrp"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][availability]", list_region.get(i).get("availability"));
                if (list_region.get(i).containsKey("arrivingDate")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][inventory_receiving_date]", CommonHandle.setDate2(list_region.get(i).get("arrivingDate"), "yyyy-MM-dd"));
                }
                if (list_region.get(i).containsKey("out_of_stock_reason")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][out_of_stock_reason]", list_region.get(i).get("out_of_stock_reason"));
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][auto_out_of_stock_reason]", list_region.get(i).get("auto_out_of_stock_reason"));
                }
                if (list_region.get(i).containsKey("startDate")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(list_region.get(i).get("startDate"), "yyyy-MM-dd"));
                }
                if (list_region.get(i).containsKey("endDate")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(list_region.get(i).get("endDate"), "yyyy-MM-dd"));
                }
                if (list_region.get(i).containsKey("state")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][state]", list_region.get(i).get("state"));
                }
            }
        // thêm Buyer company theo list
        if (listBuyerCompany != null)
            for (int i = 0; i < listBuyerCompany.size(); i++) {
                builder
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_id]", listBuyerCompany.get(i).get("buyer_company_id"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_name]", listBuyerCompany.get(i).get("buyer_company_name"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][region_id]", listBuyerCompany.get(i).get("region_id"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(listBuyerCompany.get(i).get("start_date"), "yyyy-MM-dd"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(listBuyerCompany.get(i).get("end_date"), "yyyy-MM-dd"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][case_price_cents]", listBuyerCompany.get(i).get("case_price_cents"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][msrp_cents]", listBuyerCompany.get(i).get("msrp_cents"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][availability]", listBuyerCompany.get(i).get("availability"));
                if (listBuyerCompany.get(i).containsKey("out_of_stock_reason")) {
                    builder
                            .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][out_of_stock_reason]", listBuyerCompany.get(i).get("out_of_stock_reason"))
                            .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][auto_out_of_stock_reason]", listBuyerCompany.get(i).get("auto_out_of_stock_reason"));

                }
            }
        else
            builder.addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][]", "");
        // thêm Store specific theo list
        if (listStores != null)
            for (int i = 0; i < listStores.size(); i++) {
                builder
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][region_id]", listStores.get(i).get("region_id"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][store_id]", listStores.get(i).get("store_id"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][store_name]", listStores.get(i).get("store_name"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_id]", listStores.get(i).get("buyer_company_id"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_name]", listStores.get(i).get("buyer_company_name"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(listStores.get(i).get("start_date"), "yyyy-MM-dd"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(listStores.get(i).get("end_date"), "yyyy-MM-dd"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][case_price_cents]", listStores.get(i).get("case_price_cents"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][msrp_cents]", listStores.get(i).get("msrp_cents"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][availability]", listStores.get(i).get("availability"));
            }
        else
            builder.addFormDataPart("product_variant[stores_variants_regions_attributes][]", "");
        builder
                .addFormDataPart("product_variant[nutrition_labels_attributes][0][attachment]", file,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file)));
        builder
                .addFormDataPart("product_variant[nutrition_labels_attributes][0][description]", "")
                .addFormDataPart("product_variant[variant_inventory_config_attributes][expiry_day_threshold]", "100")
                .addFormDataPart("product_variant[variant_inventory_config_attributes][low_quantity_threshold]", "10")
                .addFormDataPart("product_variant[lead_time]", "")
                .addFormDataPart("product_variant[quality_ids]", "15")
                .addFormDataPart("product_variant[product_variants_tags_attributes][0][tag_id]", "56")
                .addFormDataPart("product_variant[product_variants_tags_attributes][0][tag_name]", "Private SKU tag_1")
                .addFormDataPart("product_variant[position]", "2")
                .addFormDataPart("product_variant[ingredients]", "Ingredients")
                .addFormDataPart("product_variant[description]", "Description");

        if (prop65 != null) {
            builder.addFormDataPart("product_variant[chemical_prop_form][contain_chemical]", prop65.get(0).get("containChemical"))
                    .addFormDataPart("product_variant[chemical_prop_form][first_name]", prop65.get(0).get("firstName"))
                    .addFormDataPart("product_variant[chemical_prop_form][last_name]", prop65.get(0).get("lastName"))
                    .addFormDataPart("product_variant[chemical_prop_form][email]", prop65.get(0).get("email"));
        }
        RequestBody body = builder.build();


        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String client1 = Serenity.sessionVariableCalled("client");
        String uid = Serenity.sessionVariableCalled("uid");

        Request request = new Request.Builder()
                .url(url)
                .method("POST", body)
                .addHeader("uid", uid)
                .addHeader("access-token", accessToken)
                .addHeader("client", client1)
                .addHeader("token-type", "Bearer")
                .build();
        Response response = null;
//        System.out.println(body.toString());
        try {
            response = client.newCall(request).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }
        String responseString = response.body().string();
        // in ra report response
        ObjectMapper mapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
        System.out.println("response " + mapper.writeValueAsString(mapper.readTree(responseString)));
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE SKU")
//                .andContents(mapper.writeValueAsString(mapper.readTree(responseString)));

        return responseString;
    }


    public static String createSKUAdmin3(String url, Map<String, String> info) throws IOException, URISyntaxException {
        ClassLoader classLoader = CommonRequest.class.getClassLoader();
        File masterImageFile = new File(classLoader.getResource("Images/" + info.get("masterImage")).toURI().getPath());
        String masterImage = "/" + masterImageFile.getAbsolutePath().replaceAll("\\\\", "/");
        String barcodeImage = "/" + new File(classLoader.getResource("Images/" + info.get("barcodeImage")).toURI().getPath())
                .getAbsolutePath().replaceAll("\\\\", "/");
        String caseImage = "/" + new File(classLoader.getResource("Images/" + info.get("caseImage")).toURI().getPath())
                .getAbsolutePath().replaceAll("\\\\", "/");
        String masterCartonImage = "/" + new File(classLoader.getResource("Images/" + info.get("masterCartonImage")).toURI().getPath())
                .getAbsolutePath().replaceAll("\\\\", "/");

        OkHttpClient client = new OkHttpClient().newBuilder()
                .connectTimeout(90, TimeUnit.SECONDS)
                .writeTimeout(90, TimeUnit.SECONDS)
                .readTimeout(90, TimeUnit.SECONDS)
                .build();
        MediaType mediaType = MediaType.parse("application/json;charset=UTF-8");

        List<Map<String, String>> list_region = Serenity.sessionVariableCalled("List Region");
        List<Map<String, String>> listBuyerCompany = Serenity.sessionVariableCalled("List Buyer company");
        List<Map<String, String>> listStores = Serenity.sessionVariableCalled("List Store specific");
        List<Map<String, String>> prop65 = Serenity.hasASessionVariableCalled("Prop65 Info") ? Serenity.sessionVariableCalled("Prop65 Info") : null;
        List<Map<String, String>> listNutritionLabel = Serenity.sessionVariableCalled("List nutrition label SKU");
        MultipartBody.Builder builder = new MultipartBody.Builder();
        builder
                .addFormDataPart("product_variant[name]", info.get("name"))
                .addFormDataPart("product_variant[state]", info.get("state"))
                .addFormDataPart("product_variant[availability]", "out_of_stock")
                .addFormDataPart("product_variant[case_units]", info.get("case_units"))
                .addFormDataPart("product_variant[msrp_cents]", info.get("msrp_cents"))
                .addFormDataPart("product_variant[master_image_attributes][alt]", "")
                .addFormDataPart("product_variant[master_image_attributes][attachment]", masterImage,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(masterImage)))
                .addFormDataPart("product_variant[barcode_attributes][code]", info.get("code"))
                .addFormDataPart("product_variant[barcode_attributes][case_code]", info.get("case_code"))
                .addFormDataPart("product_variant[barcode_attributes][type]", info.get("barcode_type"))
                .addFormDataPart("product_variant[barcode_attributes][image_attributes][alt]", "")
                .addFormDataPart("product_variant[barcode_attributes][image_attributes][attachment]", barcodeImage,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(barcodeImage)))
                .addFormDataPart("product_variant[barcode_attributes][case_image_attributes][alt]", "")
                .addFormDataPart("product_variant[barcode_attributes][case_image_attributes][attachment]", caseImage,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(caseImage)))
                .addFormDataPart("product_variant[master_carton_code]", info.get("master_carton_code"))
                .addFormDataPart("product_variant[master_carton_image_attributes][attachment]", masterCartonImage,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(masterCartonImage)))
                .addFormDataPart("product_variant[storage_shelf_life_attributes][days]", info.get("storage_shelf_life"))
                .addFormDataPart("product_variant[storage_shelf_life_attributes][shelf_life_condition_id]", info.get("shelf_life_condition_id"))
                .addFormDataPart("product_variant[storage_shelf_life_attributes][pull_threshold_use_default_value]", info.get("pull_threshold_use_default_value"))
                .addFormDataPart("product_variant[storage_shelf_life_attributes][pull_threshold]", info.get("pull_threshold"))
                .addFormDataPart("product_variant[retail_shelf_life_attributes][days]", info.get("retail_shelf_life"))
                .addFormDataPart("product_variant[retail_shelf_life_attributes][shelf_life_condition_id]", info.get("retail_shelf_life_id"))
                .addFormDataPart("product_variant[max_temperature]", info.get("max_temperature"))
                .addFormDataPart("product_variant[min_temperature]", info.get("min_temperature"))
                .addFormDataPart("product_variant[manufacturer_address_attributes][city]", info.get("city"))
                .addFormDataPart("product_variant[manufacturer_address_attributes][address_state_id]", info.get("address_state_id"));
        // thêm region theo list
        if (list_region != null)
            for (int i = 0; i < list_region.size(); i++) {
                builder
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][region_id]", list_region.get(i).get("id"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][case_price_cents]", list_region.get(i).get("casePrice"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][msrp_cents]", list_region.get(i).get("msrp"))
                        .addFormDataPart("product_variant[variants_regions_attributes][" + i + "][availability]", list_region.get(i).get("availability"));
                if (list_region.get(i).containsKey("arrivingDate")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][inventory_receiving_date]", CommonHandle.setDate2(list_region.get(i).get("arrivingDate"), "yyyy-MM-dd"));
                }
                if (list_region.get(i).containsKey("out_of_stock_reason")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][out_of_stock_reason]", list_region.get(i).get("out_of_stock_reason"));
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][auto_out_of_stock_reason]", list_region.get(i).get("auto_out_of_stock_reason"));
                }
                if (list_region.get(i).containsKey("startDate")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(list_region.get(i).get("startDate"), "yyyy-MM-dd"));
                }
                if (list_region.get(i).containsKey("endDate")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(list_region.get(i).get("endDate"), "yyyy-MM-dd"));
                }
                if (list_region.get(i).containsKey("state")) {
                    builder.addFormDataPart("product_variant[variants_regions_attributes][" + i + "][state]", list_region.get(i).get("state"));
                }
            }
        // thêm Buyer company theo list
        if (listBuyerCompany != null)
            for (int i = 0; i < listBuyerCompany.size(); i++) {
                builder
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_id]", listBuyerCompany.get(i).get("buyer_company_id"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][buyer_company_name]", listBuyerCompany.get(i).get("buyer_company_name"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][region_id]", listBuyerCompany.get(i).get("region_id"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(listBuyerCompany.get(i).get("start_date"), "yyyy-MM-dd"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(listBuyerCompany.get(i).get("end_date"), "yyyy-MM-dd"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][case_price_cents]", listBuyerCompany.get(i).get("case_price_cents"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][msrp_cents]", listBuyerCompany.get(i).get("msrp_cents"))
                        .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][availability]", listBuyerCompany.get(i).get("availability"));
                if (listBuyerCompany.get(i).containsKey("out_of_stock_reason")) {
                    builder
                            .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][out_of_stock_reason]", listBuyerCompany.get(i).get("out_of_stock_reason"))
                            .addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][" + i + "][auto_out_of_stock_reason]", listBuyerCompany.get(i).get("auto_out_of_stock_reason"));

                }
            }
        else
            builder.addFormDataPart("product_variant[buyer_companies_variants_regions_attributes][]", "");
        // thêm Store specific theo list
        if (listStores != null)
            for (int i = 0; i < listStores.size(); i++) {
                builder
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][region_id]", listStores.get(i).get("region_id"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][store_id]", listStores.get(i).get("store_id"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][store_name]", listStores.get(i).get("store_name"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_id]", listStores.get(i).get("buyer_company_id"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][buyer_company_name]", listStores.get(i).get("buyer_company_name"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][start_date]", CommonHandle.setDate2(listStores.get(i).get("start_date"), "yyyy-MM-dd"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][variants_regions_config_attributes][end_date]", CommonHandle.setDate2(listStores.get(i).get("end_date"), "yyyy-MM-dd"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][case_price_cents]", listStores.get(i).get("case_price_cents"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][msrp_cents]", listStores.get(i).get("msrp_cents"))
                        .addFormDataPart("product_variant[stores_variants_regions_attributes][" + i + "][availability]", listStores.get(i).get("availability"));
            }
        else
            builder.addFormDataPart("product_variant[stores_variants_regions_attributes][]", "");
        if (listNutritionLabel.size() > 0) {
            for (int i = 0; i < listNutritionLabel.size(); i++) {
                String nutritionLabel = "/" + new File(classLoader.getResource("Images/" + listNutritionLabel.get(i).get("nutritionLabelImage")).toURI().getPath())
                        .getAbsolutePath().replaceAll("\\\\", "/");
                builder
                        .addFormDataPart("product_variant[nutrition_labels_attributes][" + i + "][attachment]", nutritionLabel,
                                RequestBody.create(MediaType.parse("application/octet-stream"),
                                        new File(nutritionLabel)))
                        .addFormDataPart("product_variant[nutrition_labels_attributes][" + i + "][description]", listNutritionLabel.get(i).get("nutritionDescription"));
            }
        }
        builder
                .addFormDataPart("product_variant[variant_inventory_config_attributes][expiry_day_threshold]", info.get("expiry_day_threshold"))
                .addFormDataPart("product_variant[variant_inventory_config_attributes][low_quantity_threshold]", info.get("low_quantity_threshold"))
                .addFormDataPart("product_variant[lead_time]", info.get("lead_time"))
                .addFormDataPart("product_variant[quality_ids]", "15")
                .addFormDataPart("product_variant[position]", info.get("position"))
                .addFormDataPart("product_variant[ingredients]", info.get("ingredients"))
                .addFormDataPart("product_variant[description]", info.get("description"));

        if (prop65 != null) {
            builder.addFormDataPart("product_variant[chemical_prop_form][contain_chemical]", prop65.get(0).get("containChemical"))
                    .addFormDataPart("product_variant[chemical_prop_form][first_name]", prop65.get(0).get("firstName"))
                    .addFormDataPart("product_variant[chemical_prop_form][last_name]", prop65.get(0).get("lastName"))
                    .addFormDataPart("product_variant[chemical_prop_form][email]", prop65.get(0).get("email"));
        }
        RequestBody body = builder.build();


        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String client1 = Serenity.sessionVariableCalled("client");
        String uid = Serenity.sessionVariableCalled("uid");

        Request request = new Request.Builder()
                .url(url)
                .method("POST", body)
                .addHeader("uid", uid)
                .addHeader("access-token", accessToken)
                .addHeader("client", client1)
                .addHeader("token-type", "Bearer")
                .build();
        Response response = null;
//        System.out.println(body.toString());
        try {
            response = client.newCall(request).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }
        String responseString = response.body().string();
        // in ra report response
        ObjectMapper mapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
        System.out.println("response " + mapper.writeValueAsString(mapper.readTree(responseString)));
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE SKU")
//                .andContents(mapper.writeValueAsString(mapper.readTree(responseString)));

        return responseString;
    }

    public static String createInventory(String url, Map<String, String> map) throws IOException, URISyntaxException {
        ClassLoader classLoader = CommonRequest.class.getClassLoader();
        File fileName1 = new File(classLoader.getResource(map.get("fileName1")).toURI().getPath());
        File fileName2 = new File(classLoader.getResource(map.get("fileName2")).toURI().getPath());
        File fileName3 = new File(classLoader.getResource(map.get("fileName3")).toURI().getPath());
        String file1 = "/" + fileName1.getAbsolutePath().replaceAll("\\\\", "/");
        String file2 = "/" + fileName2.getAbsolutePath().replaceAll("\\\\", "/");
        String file3 = "/" + fileName3.getAbsolutePath().replaceAll("\\\\", "/");

        OkHttpClient client = new OkHttpClient().newBuilder()
                .connectTimeout(60, TimeUnit.SECONDS)
                .writeTimeout(60, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .build();
        MediaType mediaType = MediaType.parse("text/plain");


        MultipartBody.Builder builder = new MultipartBody.Builder();
        builder
                .addFormDataPart("inventory[product_variant_id]", map.get("skuID"))
                .addFormDataPart("inventory[quantity]", map.get("quantity"))
                .addFormDataPart("inventory[lot_code]", map.get("lotCode"))
                .addFormDataPart("inventory[warehouse_id]", map.get("warehouseID"))
                .addFormDataPart("inventory[receive_date]", map.get("receiveDate"))
                .addFormDataPart("inventory[expiry_date]", map.get("expiryDate"))
                .addFormDataPart("inventory[comment]", map.get("comment"))
                .addFormDataPart("inventory[inventory_images_attributes][0][attachment]", file1,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file1)))
                .addFormDataPart("inventory[inventory_images_attributes][0][description]", "Auto Upload 1")
                .addFormDataPart("inventory[inventory_images_attributes][1][attachment]", file2,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file2)))
                .addFormDataPart("inventory[inventory_images_attributes][1][description]", "Auto Upload 2")
                .addFormDataPart("inventory[inventory_images_attributes][2][attachment]", file3,
                        RequestBody.create(MediaType.parse("application/octet-stream"),
                                new File(file3)))
                .addFormDataPart("inventory[inventory_images_attributes][2][description]", "Auto Upload 3");

        String accessToken = Serenity.sessionVariableCalled("accessToken");
        String client1 = Serenity.sessionVariableCalled("client");
        String uid = Serenity.sessionVariableCalled("uid");

        RequestBody body = builder.build();

        Request request = new Request.Builder()
                .url(url)
                .method("POST", body)
                .addHeader("uid", uid)
                .addHeader("access-token", accessToken)
                .addHeader("client", client1)
                .addHeader("token-type", "Bearer")
                .build();
        Response response = null;
        try {
            response = client.newCall(request).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }

        String responseString = response.body().string();
        // in ra report response
//        ObjectMapper mapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
//        System.out.println("response " + mapper.writeValueAsString(mapper.readTree(responseString)));
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE INVENTORY")
//                .andContents(mapper.writeValueAsString(mapper.readTree(responseString)));
        return responseString;
    }
}
