package steps.api.admin.products;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.products.AdminProductPackageSizeAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminProductPackageSizeAPIStepDefinitions {

    AdminProductPackageSizeAPI adminProductPackageSizeAPI = new AdminProductPackageSizeAPI();

    @And("Admin create product package size by api")
    public void admin_create_ta_by_api(DataTable dt) {
        List<Map<String, Object>> table = CommonHandle.convertDataTable(dt);
        Map<String, Object> body = new HashMap<>();
        Map<String, Object> package_size = new HashMap<>();
        package_size.put("name", table.get(0).get("name"));
        body.put("package_size", package_size);
        Response response = adminProductPackageSizeAPI.callCreateProductPackageSize(body);
        adminProductPackageSizeAPI.getProductPackageSizeId(response);
    }

    @And("Admin delete product package size by api")
    public void admin_delete_product_package_by_api() {
        String id = Serenity.sessionVariableCalled("ID PRODUCT PACKAGE SIZE API");
        adminProductPackageSizeAPI.callDeleteProductPackageSize(id);
    }

    @And("Admin delete product package size name {string} by api")
    public void admin_delete_product_package_by_api(String name) {
        List<Map<String, Object>> list = adminProductPackageSizeAPI.callGetIdProductPackageSize();
        for (Map<String, Object> map : list) {
            if (map.get("name").toString().equalsIgnoreCase(name)) {
                adminProductPackageSizeAPI.callDeleteProductPackageSize(map.get("id").toString());
            }
        }
    }

    @And("Admin edit product package size name {string} by api")
    public void admin_edit_product_package_by_api(String name, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        List<Map<String, Object>> productPackageSize = adminProductPackageSizeAPI.callGetIdProductPackageSize();
        Map<String, Object> map = new HashMap<>();
        map.put("package_size", list.get(0));
        for (Map<String, Object> pd : productPackageSize) {
            if (pd.get("name").toString().equalsIgnoreCase(name)) {
                adminProductPackageSizeAPI.callEditProductPackageSize(pd.get("id").toString(), map);
            }
        }
    }
}
