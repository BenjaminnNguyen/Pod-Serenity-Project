package steps.api.admin.products;

import com.fasterxml.jackson.databind.JsonNode;
import cucumber.models.api.Tax.AddTax;
import cucumber.models.api.Tax.DeleteTax;
import cucumber.tasks.api.admin.HandleSkuAPI;
import io.cucumber.java.en.*;
import cucumber.singleton.GVs;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.products.ProductAdminAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ProductAPIStepDefinitions {

    CommonHandle commonHandle = new CommonHandle();
    ProductAdminAPI productAdminAPI = new ProductAdminAPI();
    HandleSkuAPI skuAPI = new HandleSkuAPI();

    @And("Create product in admin by api with name {string} with file {string}")
    public void test_read_json(String nameProduct, String file) throws Exception {
        //get data Create Product
        JsonNode dataFromJson = commonHandle.readJsonNodeFile(GVs.PATH_ADMIN + file);
        JSONObject jsonObject = new JSONObject(dataFromJson.toString());
        // set data từ cucumber vào object
        CommonHandle.updateJson1(jsonObject, "name", "Auto Product Admin Api 01", nameProduct);

        // lấy endpoint và port từ file config
        Response response = productAdminAPI.callCreateProduct(jsonObject, UrlAdminAPI.CREATE_PRODUCT);
        // lấy ID của product mới tạo
        productAdminAPI.getIDProduct(response);
    }

    @And("Admin delete sku {string} in product {string} by api")
    public void delete_sku_in_product(String idSKU, String idProduct) {
        if (idSKU.equals("")) {
            idSKU = Serenity.sessionVariableCalled("ID SKU Admin");
            System.out.println("ID SKU = " + Serenity.sessionVariableCalled("ID SKU Admin"));
        }
        if (idSKU != null) {
            if (idSKU.contains("random")) {
                idSKU = Serenity.sessionVariableCalled("itemCode" + idSKU);
            }
            Response response = productAdminAPI.callDeleteSKU(idSKU);
            JsonPath jsonPath = response.jsonPath();
            String message = jsonPath.get("message");
            Ensure.that(message).equals("Product variant deleted");
        }
    }

    @And("Admin delete all sku in product id {string} by api")
    public void delete_all_sku_in_product(String idProduct) {
        Response response1 = productAdminAPI.callProductDetail(idProduct);
        List<String> listSKUID = productAdminAPI.getAllSkuId(response1);
        for (String sku : listSKUID) {
            Response response = productAdminAPI.callDeleteSKU(sku);
            JsonPath jsonPath = response.jsonPath();
            String message = jsonPath.get("message");
            Ensure.that(message).equals("Product variant deleted");
        }
    }

    @And("Admin delete product id {string} by api")
    public void delete_product(String idProduct) {
        if (idProduct.equals("")) {
            idProduct = Serenity.sessionVariableCalled("ID Product Admin");
        }
        Response response = productAdminAPI.callDeleteProduct(idProduct);
        JsonPath jsonPath = response.jsonPath();
        String message = jsonPath.get("message");
        Ensure.that(message).equals("Product deleted");
    }

    @And("Create product by api with file {string} and info")
    public void createProduct(String file, DataTable table) throws Exception {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        //get data Create Product
        JsonNode dataFromJson = commonHandle.readJsonNodeFile(GVs.PATH_ADMIN + file);
        JSONObject jsonObject = new JSONObject(dataFromJson.toString());

        // set data từ cucumber vào object
        Set<String> key = list.get(0).keySet();
        for (String s : key) {
            if (s.contains("name")) {
                if (list.get(0).get("name").contains("random product")) {
                    String name = list.get(0).get("name") + CommonTask.getDateTimeString();
                    CommonHandle.updateJson1(jsonObject, s, "Auto Product Admin Api 01", name);
                    Serenity.setSessionVariable("Product random").to(name);
                } else
                    CommonHandle.updateJson1(jsonObject, s, "Auto Product Admin Api 01", list.get(0).get(s));
            }
            if (key.contains("brand_id")) {
                if (list.get(0).get(s).contains("create by api")) {
                    CommonHandle.updateJson1(jsonObject, s, "3002", Serenity.sessionVariableCalled("ID of Brand").toString());
                } else
                    CommonHandle.updateJson1(jsonObject, s, "3002", list.get(0).get(s));
            }
        }

        // lấy endpoint và port từ file config
        Response response = productAdminAPI.callCreateProduct(jsonObject, UrlAdminAPI.CREATE_PRODUCT);
        // lấy ID của product mới tạo
        productAdminAPI.getIDProduct(response);
        productAdminAPI.getIDProduct(list.get(0).get("name"), response);
        productAdminAPI.getRegionMOQ(response);
    }

    @And("Admin search product name {string} by api")
    public void search_product(String name) {
        Response response = productAdminAPI.searchProduct(name);
        List<String> product = productAdminAPI.getIdProduct(response);
    }

    @And("Admin delete product name {string} by api")
    public void delete_products(String name) {
        List<String> listID = Serenity.sessionVariableCalled("ID Product API");
        if (listID.size() != 0) {
            productAdminAPI.callDeleteProduct(listID);
        }
    }

    @And("Admin get ID SKU by name {string} from product id {string} by API")
    public void get_id_sku_from_product_by_API(String skuName, String productID) {
        if (productID.equals("")) {
            productID = Serenity.sessionVariableCalled("ID Product Admin");
        }
        if (skuName.equals("")) {
            skuName = Serenity.sessionVariableCalled("SKU inventory");
        }
        Response response = productAdminAPI.callDetailProduct(productID);
        String skuID = productAdminAPI.getIdSkuByName(response, skuName);
        System.out.println("SKU ID = " + skuID);
        Serenity.setSessionVariable("ID SKU Admin").to(skuID);
    }

    @And("Admin get ID SKU by id {string} from product id {string} by API")
    public void get_id_sku_from_sku_ID_by_API(String skuID, String productID) {
        if (productID.equals("")) {
            productID = Serenity.sessionVariableCalled("ID Product Admin");
        }
        if (skuID.equals("")) {
            skuID = Serenity.sessionVariableCalled("ID SKU Admin");
        }
        Response response = productAdminAPI.callDetailProduct(productID);
        String skuID1 = productAdminAPI.getIdSkuByID(response, skuID);
        System.out.println("SKU ID = " + skuID1);
        Serenity.setSessionVariable("ID SKU Admin").to(skuID1);

    }

    @And("Admin search product recommendation Buyer id {string} by api")
    public void search_products_recommendation(String id) {
        productAdminAPI.callGetRecommendationByBuyerId(id);
    }

    @And("Admin search product recommendation Head Buyer id {string} by api")
    public void search_products_recommendation2(String id) {
        productAdminAPI.callGetRecommendationByHeadBuyerId(id);
    }

    @And("Admin delete product recommendation by api")
    public void delete_products_recommendation() {
        List<String> listID = Serenity.sessionVariableCalled("List id Recommendation");
        productAdminAPI.callDeleteProductRecommendation(listID);
    }

    @And("Admin create recommendation by api")
    public void create_recommendation(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        HashMap<String, String> map2 = new HashMap<String, String>(list.get(0));
        String prdId = list.get(0).get("product_id");
        if (list.get(0).get("product_id").contains("create by api")) {
            prdId = Serenity.sessionVariableCalled("ID Product Admin").toString();
            map2.replace("product_id", prdId);
        }
        map.putIfAbsent("buyers_recommended_product", map2);
        productAdminAPI.getIdRecommended(productAdminAPI.callCreateRecommendation(map));

    }

    @And("Admin edit recommendation by api")
    public void edit_recommendation(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        HashMap<String, String> map2 = new HashMap<String, String>(list.get(0));
        String prdId = list.get(0).get("product_id");
        String id = list.get(0).get("id");
        if (list.get(0).get("product_id").contains("create by api")) {
            prdId = Serenity.sessionVariableCalled("ID Product Admin").toString();
            map2.replace("product_id", prdId);
        }
        if (list.get(0).get("id").contains("create by api")) {
            id = Serenity.sessionVariableCalled("Id of Recommended Product api").toString();
            map2.replace("id", id);
        }
        map.putIfAbsent("buyers_recommended_product", map2);
        productAdminAPI.callEditRecommendation(id, map);

    }

    @And("Admin change state of product id {string} to {word} by api")
    public Response delete_products_recommendation(String id, String state) {
        if (id.contains("random")) {
            id = Serenity.sessionVariableCalled("ID Product Admin");
        }
        Response response = productAdminAPI.changeStateProduct(id);
        return response;
    }

    @And("Admin deactivate all product name {string} by api")
    public Response delete_products_recommendation(String product) {
        Response response = productAdminAPI.searchProduct(product);
        List<String> products = productAdminAPI.getIdProductActive(response);
        for (String id : products){
            productAdminAPI.changeStateProduct(id);
        }
        return response;
    }

    @And("Change state of product id: {string} to {string}")
    public void changeStateProductActive(String id, String state) {
        String status = productAdminAPI.getState(productAdminAPI.callProductDetail(id));
        if (!status.equals(state)) {
            Response response = productAdminAPI.changeStateProduct(id);
        } else {
            System.out.println("Currently state of product is " + state);
        }
    }

    @And("Admin set regional moq of product {string}")
    public void set_regional_moq_of_product(String productID, DataTable dt) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(dt);
        if (productID.contains("create by api")) {
            productID = Serenity.sessionVariableCalled("ID Product Admin");
        }
        Map<String, Object> body = productAdminAPI.setChangeRegionMoqModel(productID, list);
        Response response = productAdminAPI.callChangeRegionMOQ(productID, body);
    }

    /**
     * Tax
     */

    @And("Admin add tax to product {string}")
    public void add_product_tax_by_api(String id, DataTable dt) {
        AddTax product = ProductAdminAPI.setAddTaxModel(dt);
        Response response = ProductAdminAPI.callAddTax(id, product);
    }

    @And("Admin delete all tax of product {string}")
    public void delete_product_tax_by_api(String idProduct) {
        // Get detail product để lấy list tax
        Response response = productAdminAPI.callProductDetail(idProduct);
        // get list id tax từ response get detail
        List<String> taxList = productAdminAPI.getListProductTax(response);
        // nếu có list tax thì delete
        if (taxList.size() > 0) {
            // set model delete tax
            DeleteTax deleteTax = productAdminAPI.setDeleteTaxModel(taxList, idProduct);
            // send request delete tax
            Response response1 = productAdminAPI.callDeleteTax(idProduct, deleteTax);
        }
    }

    @And("Admin get detail all tax of product {string}")
    public void get_product_detail_tax_by_api(String idProduct) {
        Response response1 = productAdminAPI.callProductDetail(idProduct);

    }

    @And("Admin edit product category id {string} api")
    public void editProductCategory(String idProduct, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> map2 = new HashMap<>();
        map2.putIfAbsent("name", list.get(0).get("name"));
        map2.putIfAbsent("pull_threshold", list.get(0).get("pull_threshold"));
        map.putIfAbsent("product_category", map2);
        Response response1 = productAdminAPI.callEditProductCategory(idProduct, map);

    }

    @And("Admin add tag to product {string} by api")
    public void add_tags_product(String idProduct, DataTable table) {
        if (idProduct.equals("create by api"))
            idProduct = Serenity.sessionVariableCalled("ID Product Admin");
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        Response response1 = productAdminAPI.callProductDetail(idProduct);
        List<Map<String, Object>> list_Tags = ProductAdminAPI.getListProductTags(response1);
        if (list_Tags.size() > 0) {
            int i = 0;
            for (i = i; i < list_Tags.size(); i++) {
                map.put("product[product_tags_attributes][" + i + "][id]", list_Tags.get(i).get("id"));
                map.put("product[product_tags_attributes][" + i + "][tag_id]", list_Tags.get(i).get("tag_id"));
                map.put("product[product_tags_attributes][" + i + "][tag_name]", list_Tags.get(i).get("tag_name"));
                map.put("product[product_tags_attributes][" + i + "][expiry_date]", CommonHandle.setDate2(list_Tags.get(i).get("expiry_date").toString(), "yyyy-MM-dd"));
                i++;
            }
            for (int k = 0; k < list.size(); k++) {
                map.put("product[product_tags_attributes][" + (i + k) + "][tag_id]", list.get(k).get("tag_id"));
                map.put("product[product_tags_attributes][" + (i + k) + "][tag_name]", list.get(k).get("tag_name"));
                map.put("product[product_tags_attributes][" + (i + k) + "][expiry_date]", CommonHandle.setDate2(list.get(k).get("expiry_date"), "yyyy-MM-dd"));
            }
        } else
            for (int i = 0; i < list.size(); i++) {
                map.put("product[product_tags_attributes][" + i + "][tag_id]", list.get(i).get("tag_id"));
                map.put("product[product_tags_attributes][" + i + "][tag_name]", list.get(i).get("tag_name"));
                map.put("product[product_tags_attributes][" + i + "][expiry_date]", CommonHandle.setDate2(list.get(i).get("expiry_date"), "yyyy-MM-dd"));
            }
        Response response = ProductAdminAPI.callEditProductTags(idProduct, map);
    }

    @And("Admin add tag to SKU {string} by api")
    public void add_tags_sku(String idSKU, DataTable table) {
        if (idSKU.equals("create by api"))
            idSKU = Serenity.sessionVariableCalled("ID SKU Admin");
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        Response response1 = skuAPI.callDetailSKU(idSKU);
        List<Map<String, Object>> list_Tags = ProductAdminAPI.getListProductTags(response1);
        if (list_Tags.size() > 0) {
            int i = 0;
            for (Map<String, Object> tag : list_Tags) {
                map.put("product_variant[product_variants_tags_attributes][" + i + "][id]", list_Tags.get(i).get("id"));
                map.put("product_variant[product_variants_tags_attributes][" + i + "][tag_id]", list_Tags.get(i).get("tag_id"));
                map.put("product_variant[product_variants_tags_attributes][" + i + "][tag_name]", list_Tags.get(i).get("tag_name"));
                map.put("product_variant[tags_info][" + i + "][tag_id]", list.get(i).get("tag_id"));
                map.put("product_variant[tags_info][" + i + "]tag_name]", list.get(i).get("tag_name"));
                map.put("product_variant[tags_info][" + i + "][expiry_date]", CommonHandle.setDate2(list.get(i).get("expiry_date"), "yyyy-MM-dd"));
//                map.put("product[product_variants_tags_attributes][" + i + "][expiry_date]", CommonHandle.setDate2(list_Tags.get(i).get("expiry_date").equals(null)?"":list_Tags.get(i).get("expiry_date").toString(), "yyyy-MM-dd"));
                i++;
            }
            for (int k = 0; k < list.size(); k++) {
                map.put("product_variant[product_variants_tags_attributes][" + (i + k) + "][tag_id]", Integer.parseInt(list.get(k).get("tag_id")));
                map.put("product_variant[product_variants_tags_attributes][" + (i + k) + "][tag_name]", list.get(k).get("tag_name"));
                map.put("product_variant[product_variants_tags_attributes][" + (i + k) + "][expiry_date]", CommonHandle.setDate2(list.get(k).get("expiry_date"), "yyyy-MM-dd"));
                map.put("product_variant[tags_info][" + (i + k) + "][tag_id]", Integer.parseInt(list.get(k).get("tag_id")));
                map.put("product_variant[tags_info][" + (i + k) + "]tag_name]", list.get(k).get("tag_name"));
                map.put("product_variant[tags_info][" + (i + k) + "][expiry_date]", CommonHandle.setDate2(list.get(k).get("expiry_date"), "yyyy-MM-dd"));
            }
        } else
            for (int i = 0; i < list.size(); i++) {
                map.put("product_variant[product_variants_tags_attributes][" + i + "][tag_id]", Integer.parseInt(list.get(i).get("tag_id")));
                map.put("product_variant[product_variants_tags_attributes][" + i + "][tag_name]", list.get(i).get("tag_name"));
                map.put("product_variant[product_variants_tags_attributes][" + i + "][expiry_date]", CommonHandle.setDate2(list.get(i).get("expiry_date"), "yyyy-MM-dd"));
//                map.put("product_variant[tag_ids][]", null);
                map.put("product_variant[tags_info][" + i + "][tag_id]", Integer.parseInt(list.get(i).get("tag_id")));
                map.put("product_variant[tags_info][" + i + "]tag_name]", list.get(i).get("tag_name"));
                map.put("product_variant[tags_info][" + i + "][expiry_date]", CommonHandle.setDate2(list.get(i).get("expiry_date"), "yyyy-MM-dd"));
            }
        Response response = skuAPI.callEditSKU(idSKU, map);
    }

    @And("Admin update qualities of SKU {string} by api")
    public void add_qualities_sku(String idSKU, DataTable table) {
        if (idSKU.equals("create by api"))
            idSKU = Serenity.sessionVariableCalled("ID SKU Admin");
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        Response response1 = skuAPI.callDetailSKU(idSKU);
        List<Integer> list_qualities = ProductAdminAPI.getListQualities(response1);
        if (list.get(0).get("id").contains("create by api")) {
            list_qualities.add(Integer.parseInt(Serenity.sessionVariableCalled("ID PRODUCT QUALITIES API")));
        } else list_qualities.add(Integer.parseInt(list.get(0).get("id")));
        String param = list_qualities.get(0).toString();
        for (int i = 1; i < list_qualities.size(); i++) {
            param = param + "," + list_qualities.get(i).toString();
        }
        map.put("product_variant[quality_ids]", param);
        Response response = skuAPI.callEditSKU(idSKU, map);
    }

    @And("Admin update package size of product {string} by api")
    public void update_package_size(String idProduct, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (idProduct.equals("create by api")) {
            idProduct = Serenity.sessionVariableCalled("ID Product Admin");
        }
        Map<String, String> map = new HashMap<>();
        String idPz = list.get(0).get("product[package_size_id]");
        if (list.get(0).get("product[package_size_id]").equals("create by api")) {
            idPz = Serenity.sessionVariableCalled("ID PRODUCT PACKAGE SIZE API").toString();
        }
        map.put("product[package_size_id]", idPz);
        Response response = productAdminAPI.callEditProduct(idProduct, map);
    }

    @And("Admin update product info {string} by api")
    public void update_product(String idProduct, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (idProduct.equals("create by api")) {
            idProduct = Serenity.sessionVariableCalled("ID Product Admin");
        }
        Response response = productAdminAPI.callEditProduct(idProduct, list.get(0));
    }

    /**
     * @param idsku
     * @param table
     */
    @And("Admin update SKU info {string} by api")
    public void update_sku(String idsku, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (idsku.equals("create by api")) {
            idsku = Serenity.sessionVariableCalled("ID SKU Admin");
        }
        Response response = productAdminAPI.callEditSKU(idsku, list.get(0));
    }
}
