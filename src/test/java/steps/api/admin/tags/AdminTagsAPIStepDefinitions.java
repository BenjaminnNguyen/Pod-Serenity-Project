package steps.api.admin.tags;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.AdminTagsAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminTagsAPIStepDefinitions {

    AdminTagsAPI adminTagsAPI = new AdminTagsAPI();

    @And("Admin create tag by api")
    public void admin_create_tag_by_api(DataTable dt) {
        List<Map<String, Object>> table = CommonHandle.convertDataTable(dt);
        Map<String, Object> body = new HashMap<>();
        String[] tagTargetId = table.get(0).get("tag_target_ids").toString().split(",");
        List<Integer> tagTargetIds = new ArrayList<>();
        for (String id : tagTargetId) {
            tagTargetIds.add(Integer.parseInt(id));
        }
        Map<String, Object> tag = new HashMap<>();
        tag.put("name", table.get(0).get("name"));
        tag.put("description", table.get(0).get("description"));
        tag.put("permission", table.get(0).get("permission"));
        tag.put("tag_target_ids", tagTargetIds);
        body.put("tag", tag);
        Response response = adminTagsAPI.callCreateTags(body);
        adminTagsAPI.getTagId(response);
    }

    @And("Admin remove assign tag by api {string}")
    public void admin_remove_tag_by_api(String id) {
        if (id.equals("create by api")) {
            List<String> listId = Serenity.sessionVariableCalled("ID Tags API");
            for (String tagId : listId) {
                admin_remove_tag(tagId);
            }
        } else admin_remove_tag(id);
    }

    public void admin_remove_tag(String tagId) {
        Response response = adminTagsAPI.callDetailTags(tagId);
        JsonPath jsonPath = response.jsonPath();
        Map<String, Object> tag1 = jsonPath.get("tag");
        List<Map<String, Object>> used_targets = (List<Map<String, Object>>) tag1.get("used_targets");
        for (Map<String, Object> used_target : used_targets) {
            if (used_target.get("target").toString().equals("buyer") && used_target.get("used").equals(true)) {
                Response response2 = adminTagsAPI.callSearchRelatedTags("buyers", tagId);
                adminTagsAPI.removeTagTargetBuyer(tagId, response2);
            }
            if (used_target.get("target").toString().equals("buyer_company") && used_target.get("used").equals(true)) {
                Response response2 = adminTagsAPI.callSearchRelatedTags("buyer_companies", tagId);
                adminTagsAPI.removeTagTargetBuyerCompany(tagId, response2);
            }
            if (used_target.get("target").toString().equals("store") && used_target.get("used").equals(true)) {
                Response response2 = adminTagsAPI.callSearchRelatedTags("stores", tagId);
                adminTagsAPI.removeTagTargetStore(tagId, response2);
            }
            if (used_target.get("target").toString().equals("vendor") && used_target.get("used").equals(true)) {
                Response response2 = adminTagsAPI.callSearchRelatedTags("vendors", tagId);
                adminTagsAPI.removeTagTargetVendor(tagId, response2);
            }
            if (used_target.get("target").toString().equals("vendor_company") && used_target.get("used").equals(true)) {
                Response response2 = adminTagsAPI.callSearchRelatedTags("vendor_companies", tagId);
                adminTagsAPI.removeTagTargetVendorCompany(tagId, response2);
            }
            if (used_target.get("target").toString().equals("brand") && used_target.get("used").equals(true)) {
                Response response2 = adminTagsAPI.callSearchRelatedTags("brands", tagId);
                adminTagsAPI.removeTagTargetBrand(tagId, response2);
            }
            if (used_target.get("target").toString().equals("product") && used_target.get("used").equals(true)) {
                Response response2 = adminTagsAPI.callSearchRelatedTags("products", tagId);
                adminTagsAPI.removeTagTargetProduct(tagId, response2);
            }
            if (used_target.get("target").toString().equals("product_variant") && used_target.get("used").equals(true)) {
                Response response2 = adminTagsAPI.callSearchRelatedTags("product_variants", tagId);
                adminTagsAPI.removeTagTargetProductVariant(tagId, response2);
            }
        }
    }

    @And("Admin search tags by api")
    public void admin_search_tag_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        Response response = adminTagsAPI.callSearchTags(infoObj.get(0));
        adminTagsAPI.getTagIds(response);
    }

    @And("Admin delete tag by api")
    public void admin_delete_tag_by_api() {
        List<String> listId = Serenity.sessionVariableCalled("ID Tags API");
        for (String id : listId) {
            adminTagsAPI.callDeleteTag(id);
        }
    }

}
