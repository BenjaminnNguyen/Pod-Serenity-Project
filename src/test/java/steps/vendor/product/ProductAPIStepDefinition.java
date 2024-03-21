package steps.vendor.product;

import com.fasterxml.jackson.databind.JsonNode;
import io.cucumber.java.en.*;
import cucumber.singleton.GVs;
import cucumber.singleton.UrlAPI;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.products.ProductAdminAPI;
import cucumber.tasks.api.vendor.ProductAPI;
import io.cucumber.datatable.DataTable;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
//import okhttp3.Response;
import org.json.JSONObject;

import java.util.List;
import java.util.Map;

public class ProductAPIStepDefinition {

    CommonHandle commonHandle = new CommonHandle();
    ProductAPI productAPI = new ProductAPI();
    ProductAdminAPI productAdminAPI = new ProductAdminAPI();

    @And("Create product by api with name {string} with file {string}")
    public void test_read_json(String nameProduct, String file) throws Exception {
        //get data Create Product
        JsonNode dataFromJson = commonHandle.readJsonNodeFile(GVs.VALIDATE_INPUT_FILE_PATH + file);
        JSONObject jsonObject = new JSONObject(dataFromJson.toString());
        // set data từ cucumber vào object
        CommonHandle.updateJson1(jsonObject, "name", "Test Product Read Json", nameProduct);

        // lấy endpoint và port từ file config
        Response response = productAPI.callCreateProduct(jsonObject, UrlAPI.CREATE_PRODUCT);
        // lấy ID của product mới tạo
        productAPI.getIDProduct(response);
    }

    @And("Admin create product by api with info")
    public void test_read_json(DataTable dt) throws Exception {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        //get data Create Product
        JsonNode dataFromJson = commonHandle.readJsonNodeFile(GVs.VALIDATE_INPUT_FILE_PATH + list.get(0).get("fileName"));
        JSONObject jsonObject = new JSONObject(dataFromJson.toString());
        // set data từ cucumber vào object
        CommonHandle.updateJson1(jsonObject, "name", "Test Product Read Json", list.get(0).get("product"));
        CommonHandle.updateJson1(jsonObject, "brand_id", "2697", list.get(0).get("brandID"));

        // lấy endpoint và port từ file config
        Response response = productAPI.callCreateProduct(jsonObject, UrlAdminAPI.CREATE_PRODUCT);
        // lấy ID của product mới tạo
        productAdminAPI.getIDProduct(response);
    }

    @And("Delete product just created")
    public void delete_product() {
        String id = Serenity.sessionVariableCalled("ID Product admin");
        Response response = productAPI.callDeleteProduct(UrlAPI.DELETE_PRODUCT(id));
    }
}

