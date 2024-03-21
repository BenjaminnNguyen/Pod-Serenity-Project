package steps.api.admin.products;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.AdminTagsAPI;
import cucumber.tasks.api.admin.products.AdminProductQualitiesAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminProductQualitiesAPIStepDefinitions {

    AdminProductQualitiesAPI adminProductQualitiesAPI = new AdminProductQualitiesAPI();

    @And("Admin create product qualities by api")
    public void admin_create_ta_by_api(DataTable dt) {
        List<Map<String, Object>> table = CommonHandle.convertDataTable(dt);
        Map<String, Object> body = new HashMap<>();
        Map<String, Object> product_quality = new HashMap<>();
        product_quality.put("name", table.get(0).get("name"));
        body.put("product_quality", product_quality);
        Response response = adminProductQualitiesAPI.callCreateProductQualities(body);
        adminProductQualitiesAPI.getProductQualitiesId(response);
    }

    @And("Admin delete product qualities by api")
    public void admin_delete_product_qualities_by_api() {
        String id = Serenity.sessionVariableCalled("ID PRODUCT QUALITIES API");
        adminProductQualitiesAPI.callDeleteProductQualities(id);
    }

    @And("Admin delete product qualities name {string} by api")
    public void admin_delete_product_qualities_by_api(String name) {
        List<Map<String, Object>> list = adminProductQualitiesAPI.callGetIdProductQualities();
        for (Map<String, Object> map : list) {
            if (map.get("name").toString().equalsIgnoreCase(name)) {
                adminProductQualitiesAPI.callDeleteProductQualities(map.get("id").toString());
            }
        }
    }

    @And("Admin edit product qualities name {string} by api")
    public void admin_edit_product_qualities_by_api(String name, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        List<Map<String, Object>> productQualities = adminProductQualitiesAPI.callGetIdProductQualities();
        Map<String, Object> map = new HashMap<>();
        map.put("product_quality", list.get(0));
        for (Map<String, Object> pd : productQualities) {
            if (pd.get("name").toString().equalsIgnoreCase(name)) {
                adminProductQualitiesAPI.callEditProductQualities(pd.get("id").toString(), map);
            }
        }
    }
}
