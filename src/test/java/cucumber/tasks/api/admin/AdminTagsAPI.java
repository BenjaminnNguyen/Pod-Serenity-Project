package cucumber.tasks.api.admin;

import cucumber.models.api.admin.TagTargetModel;
import cucumber.models.api.admin.TagsInfoModel;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.brand.AdminBrandAPI;
import cucumber.tasks.api.admin.buyers.AdminBuyerAccountAPI;
import cucumber.tasks.api.admin.buyers.AdminBuyerCompanyAPI;
import cucumber.tasks.api.admin.products.ProductAdminAPI;
import cucumber.tasks.api.admin.store.HandleStoreAdminAPI;
import cucumber.tasks.api.admin.vendor.VendorAdminAPI;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminTagsAPI {
    CommonRequest commonRequest = new CommonRequest();


    public Response callCreateTags(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_TAGS, map, "POST", 201);
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE TAG: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditTags(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.DELETE_TAGS(id), map, "PUT", 201);
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT TAG: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDetailTags(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_TAGS(id), "GET", 200);
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET TAG: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchTags(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_TAGS, map, "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH TAGS: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchRelatedTags(String endPoint, String tagId) {
        Map<String, Object> map = new HashMap<>();
        map.put("q[tag_ids][]", tagId);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.TAG_RELATE(endPoint), map, "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH TAGS: ").andContents(response.prettyPrint());
        return response;
    }

    public List<TagTargetModel> getTagInfo(Response response, String tagId) {
        JsonPath jsonPath = response.jsonPath();

        List<TagTargetModel> tagTargetModel = new ArrayList<>();
        List<Map<String, Object>> listResult = jsonPath.get("results");

        for (Map<String, Object> result : listResult) {
            List<Map<String, Object>> tags_info = (List<Map<String, Object>>) result.get("tags_info");
            List<TagsInfoModel> tagsInfoModels = new ArrayList<>();
            Integer id = (Integer) result.get("id");
            for (Map<String, Object> map : tags_info) {
                if (map.get("tag_id").toString().equals(tagId)) {
                    tagsInfoModels.add(new TagsInfoModel((Integer) map.get("id"), (Integer) map.get("tag_id"), map.get("tag_name").toString(), CommonHandle.valueToStringOrEmpty(map, "expiry_date")));
                }
            }
            tagTargetModel.add(new TagTargetModel(id, tagsInfoModels));
        }
        return tagTargetModel;
    }

    public List<String> getTagInfoBuyerId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<String> ids = new ArrayList<>();
        List<Map<String, Object>> listResult = jsonPath.get("results");
        for (Map<String, Object> result : listResult) {
            ids.add(result.get("id").toString());
        }
        return ids;
    }

    public void removeTagTargetBuyer(String tagId, Response response) {
        List<TagTargetModel> tagTargetModels = getTagInfo(response, tagId);
        for (TagTargetModel tagTargetModel : tagTargetModels) {
            Map<String, Object> map = new HashMap<>();
            map.put("buyers_tags_attributes", tagTargetModel.getTags_info());
            new AdminBuyerAccountAPI().callEditBuyer(tagTargetModel.getId().toString(), map);
        }
    }

    public void removeTagTargetBuyerCompany(String tagId, Response response) {
        List<TagTargetModel> tagTargetModels = getTagInfo(response, tagId);
        for (TagTargetModel tagTargetModel : tagTargetModels) {
            Map<String, Object> map = new HashMap<>();
            for (int i = 0; i < tagTargetModel.getTags_info().size(); i++) {
                map.put("buyer_company[buyer_companies_tags_attributes][" + i + "][id]", tagTargetModel.getTags_info().get(i).getId());
                map.put("buyer_company[buyer_companies_tags_attributes][" + i + "][tag_id]", tagTargetModel.getTags_info().get(i).getTag_id());
                map.put("buyer_company[buyer_companies_tags_attributes][" + i + "][tag_name]", tagTargetModel.getTags_info().get(i).getTag_name());
                map.put("buyer_company[buyer_companies_tags_attributes][" + i + "][expiry_date]", tagTargetModel.getTags_info().get(i).getExpiry_date());
                map.put("buyer_company[buyer_companies_tags_attributes][" + i + "][_destroy]", tagTargetModel.getTags_info().get(i).get_destroy());
            }
            new AdminBuyerCompanyAPI().callEditBuyerCompany(tagTargetModel.getId().toString(), map);
        }
    }

    public void removeTagTargetStore(String tagId, Response response) {
        List<TagTargetModel> tagTargetModels = getTagInfo(response, tagId);
        for (TagTargetModel storeId : tagTargetModels) {
            Map<String, Object> map = new HashMap<>();
            map.put("stores_tags_attributes", storeId.getTags_info());
            new HandleStoreAdminAPI().callEditStore(storeId.getId().toString(), map);
        }
    }

    public void removeTagTargetVendor(String tagId, Response response) {
        List<TagTargetModel> tagTargetModels = getTagInfo(response, tagId);
        for (TagTargetModel id : tagTargetModels) {
            Map<String, Object> map = new HashMap<>();
            map.put("vendors_tags_attributes", id.getTags_info());
            new VendorAdminAPI().callUpdateVendor(id.getId().toString(), map);
        }
    }

    public void removeTagTargetVendorCompany(String tagId, Response response) {
        List<TagTargetModel> tagTargetModels = getTagInfo(response, tagId);
        for (TagTargetModel tagTargetModel : tagTargetModels) {
            Map<String, Object> map = new HashMap<>();
            for (int i = 0; i < tagTargetModel.getTags_info().size(); i++) {
                map.put("vendor_company[vendor_companies_tags_attributes][" + i + "][id]", tagTargetModel.getTags_info().get(i).getId());
                map.put("vendor_company[vendor_companies_tags_attributes][" + i + "][tag_id]", tagTargetModel.getTags_info().get(i).getTag_id());
                map.put("vendor_company[vendor_companies_tags_attributes][" + i + "][tag_name]", tagTargetModel.getTags_info().get(i).getTag_name());
                map.put("vendor_company[vendor_companies_tags_attributes][" + i + "][expiry_date]", tagTargetModel.getTags_info().get(i).getExpiry_date());
                map.put("vendor_company[vendor_companies_tags_attributes][" + i + "][_destroy]", tagTargetModel.getTags_info().get(i).get_destroy());
            }
            new VendorAdminAPI().callUpdateVendorCompany(tagTargetModel.getId().toString(), map);
        }
    }

    public void removeTagTargetBrand(String tagId, Response response) {
        List<TagTargetModel> tagTargetModels = getTagInfo(response, tagId);
        for (TagTargetModel tagTargetModel : tagTargetModels) {
            Map<String, Object> map = new HashMap<>();
            for (int i = 0; i < tagTargetModel.getTags_info().size(); i++) {
                map.put("brand[brands_tags_attributes][" + i + "][id]", tagTargetModel.getTags_info().get(i).getId());
                map.put("brand[brands_tags_attributes][" + i + "][tag_id]", tagTargetModel.getTags_info().get(i).getTag_id());
                map.put("brand[brands_tags_attributes][" + i + "][tag_name]", tagTargetModel.getTags_info().get(i).getTag_name());
                map.put("brand[brands_tags_attributes][" + i + "][expiry_date]", tagTargetModel.getTags_info().get(i).getExpiry_date());
                map.put("brand[brands_tags_attributes][" + i + "][_destroy]", tagTargetModel.getTags_info().get(i).get_destroy());
            }
            new AdminBrandAPI().callEditBrand(tagTargetModel.getId().toString(), map);
        }

    }

    public void removeTagTargetProduct(String tagId, Response response) {
        List<TagTargetModel> tagTargetModels = getTagInfo(response, tagId);
        for (TagTargetModel tagTargetModel : tagTargetModels) {
            Map<String, Object> map = new HashMap<>();
            for (int i = 0; i < tagTargetModel.getTags_info().size(); i++) {
                map.put("product[product_tags_attributes][" + i + "][id]", tagTargetModel.getTags_info().get(i).getId());
                map.put("product[product_tags_attributes][" + i + "][tag_id]", tagTargetModel.getTags_info().get(i).getTag_id());
                map.put("product[product_tags_attributes][" + i + "][tag_name]", tagTargetModel.getTags_info().get(i).getTag_name());
                map.put("product[product_tags_attributes][" + i + "][expiry_date]", tagTargetModel.getTags_info().get(i).getExpiry_date());
                map.put("product[product_tags_attributes][" + i + "][_destroy]", tagTargetModel.getTags_info().get(i).get_destroy());
            }
            new ProductAdminAPI().callEditProductTags(tagTargetModel.getId().toString(), map);
        }
    }

    public void removeTagTargetProductVariant(String tagId, Response response) {
        List<TagTargetModel> tagTargetModels = getTagInfo(response, tagId);
        for (TagTargetModel tagTargetModel : tagTargetModels) {
            Map<String, Object> map = new HashMap<>();
            for (int i = 0; i < tagTargetModel.getTags_info().size(); i++) {
                map.put("product_variant[product_variants_tags_attributes][" + i + "][id]", tagTargetModel.getTags_info().get(i).getId());
                map.put("product_variant[product_variants_tags_attributes][" + i + "][tag_id]", tagTargetModel.getTags_info().get(i).getTag_id());
                map.put("product_variant[product_variants_tags_attributes][" + i + "][tag_name]", tagTargetModel.getTags_info().get(i).getTag_name());
                map.put("product_variant[product_variants_tags_attributes][" + i + "][expiry_date]", tagTargetModel.getTags_info().get(i).getExpiry_date());
                map.put("product_variant[product_variants_tags_attributes][" + i + "][_destroy]", tagTargetModel.getTags_info().get(i).get_destroy());
            }
            new ProductAdminAPI().callEditSKU2(tagTargetModel.getId().toString(), map);
        }
    }

    public List<String> getTagIds(Response response) {
        List<String> listId = new ArrayList<String>();
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> listResult = jsonPath.get("results");
        for (Map<String, Object> item : listResult) {
            listId.add(item.get("id").toString());
        }
        Serenity.setSessionVariable("ID Tags API").to(listId);
        return listId;
    }

    public String getTagId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        Map<String, Object> listResult = jsonPath.get("tag");
        String id = listResult.get("id").toString();
        Serenity.setSessionVariable("ID Tag API").to(id);
        return id;
    }

    public Response callDeleteTag(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_TAGS(id), "DELETE");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE TAGS: ").andContents(response.prettyPrint());
        return response;
    }
}
