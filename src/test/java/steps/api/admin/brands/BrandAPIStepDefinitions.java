package steps.api.admin.brands;

import cucumber.models.api.admin.BrandCommisstionAttributes;
import cucumber.tasks.api.admin.brand.AdminBrandAPI;
import io.cucumber.java.en.*;
import cucumber.models.web.Admin.brand.createbrand.BrandModel;
import cucumber.models.web.Admin.brand.createbrand.CreateBrandModel;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BrandAPIStepDefinitions {
    AdminBrandAPI brandAPI = new AdminBrandAPI();

    @And("Admin create brand by API")
    public void create_brand_by_API(List<BrandModel> brandModels) {

        if (brandModels.get(0).getName().contains("random")) {
            brandModels.get(0).setName(brandModels.get(0).getName() + CommonTask.getDateTimeString());
        }
        if (brandModels.get(0).getVendor_company_id() == 0) {
            brandModels.get(0).setVendor_company_id(Integer.parseInt(Serenity.sessionVariableCalled("ID of Vendor company")));
        }

        CreateBrandModel createBrandAPI = new CreateBrandModel(brandModels.get(0));

        Response response = brandAPI.callCreateBrand(createBrandAPI, UrlAdminAPI.CREATE_BRAND);
        brandAPI.getBrandID(response);
    }

    @And("Admin delete brand {string} by API")
    public void delete_brand_by_API(String brandID) {
        String id = brandID;
        if (brandID.equals("")) {
            id = Serenity.sessionVariableCalled("ID of Brand");
        }
        brandAPI.callDeleteBrand(UrlAdminAPI.DELETE_BRAND(id));
    }

    @And("Admin change state of brand {string} to {string} by API")
    public void update_brand_by_API(String brandID, String state) {
        String id = brandID;
        if (brandID.equals("")) {
            id = Serenity.sessionVariableCalled("ID of Brand");
        }
        Response response = brandAPI.callChangeStateBrand(UrlAdminAPI.STATE_BRAND(id));
        if (state.equals("active")) {
            if (brandAPI.checkInActive(response))
                brandAPI.callChangeStateBrand(UrlAdminAPI.STATE_BRAND(id));
        } else {
            if (!brandAPI.checkInActive(response))
                brandAPI.callChangeStateBrand(UrlAdminAPI.STATE_BRAND(id));
        }

    }

    @And("Admin search brand name {string} by api")
    public void search_product(String name) {
        Response response = brandAPI.searchBrand(name);
        brandAPI.getListBrandId(response);
    }

    @And("Admin delete brand by API")
    public void delete_brand_name_by_API() {
        List<String> listID = Serenity.sessionVariableCalled("List Id Brand API");
        if (listID.size() != 0) {
            brandAPI.callDeleteBrands(listID);
        }
    }

    @And("Admin edit brand {string} by API")
    public void edit_brand_by_API(String brandID, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        if (brandID.equals("")) {
            brandID = Serenity.sessionVariableCalled("ID of Brand");
        }
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("name", infos.get(0).get("name"));
        map.putIfAbsent("description", infos.get(0).get("description"));
        map.putIfAbsent("city", infos.get(0).get("city"));
        map.putIfAbsent("micro_description", infos.get(0).get("micro_description"));
        map.putIfAbsent("address_state_id", infos.get(0).get("address_state_id"));

        Map<String, Object> brand = new HashMap<>();
        brand.putIfAbsent("brand", map);
        Response response = brandAPI.callEditBrand(brand, UrlAdminAPI.EDIT_BRAND(brandID));
        brandAPI.getBrandID(response);
    }

    @And("Admin set Store specific pricing of brand by API")
    public void setStorePricing(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> commission = new HashMap<>();
        List<Map<String, Object>> commissions = new ArrayList<>();
        Map<String, Object> brand_stores_commission = new HashMap<>();
        List<Integer> stores = new ArrayList<>();
        commission.put("percentage", list.get(0).get("percentage"));
        commission.put("expiry_date", CommonHandle.setDate2(list.get(0).get("expiry_date"), "yyyy-MM-dd"));
        commission.put("start_date", CommonHandle.setDate2(list.get(0).get("start_date"), "yyyy-MM-dd"));
        commissions.add(commission);
        stores.add(Integer.parseInt(list.get(0).get("store_ids")));
//        Map<String, Object> brand_stores_commission = new HashMap<>();
        brand_stores_commission.put("brand_id", list.get(0).get("brand_id"));
        brand_stores_commission.put("commissions", commissions);
        brand_stores_commission.put("store_ids", stores);
        map.put("brand_stores_commission", brand_stores_commission);
        brandAPI.callSetStorePricingBrand(map, UrlAdminAPI.BRAND_STORE_PRICING);
    }

    @And("Admin delete Store specific pricing of brand by API")
    public void deleteStorePricing(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
//        Get list commission of brand
        List<Integer> storeCommissionIds = brandAPI.getBrandStoreCommissionId(brandAPI.callDetailBrand(list.get(0).get("brand_id")));
        if (storeCommissionIds.size() > 0) {
            Map<String, Object> map = new HashMap<>();
            Map<String, Object> commission = new HashMap<>();
            List<Map<String, Object>> commissions = new ArrayList<>();
            Map<String, Object> brand_stores_commission = new HashMap<>();
            List<Integer> stores = new ArrayList<>();
            commission.put("percentage", "");
            commission.put("expiry_date", "");
            commission.put("start_date", "");
            commission.put("id", storeCommissionIds.get(0));
            commissions.add(commission);
            stores.add(Integer.parseInt(list.get(0).get("store_ids")));
            brand_stores_commission.put("brand_id", Integer.parseInt(list.get(0).get("brand_id")));
            brand_stores_commission.put("commissions", commissions);
            brand_stores_commission.put("store_ids", stores);
            map.put("brand_stores_commission", brand_stores_commission);
            brandAPI.callDeleteStorePricingBrand(map, UrlAdminAPI.BRAND_STORE_PRICING);
        }
    }

    @And("Admin set Company specific pricing of brand by API")
    public void setCompanyPricing(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        List<Map<String, Object>> commissions = new ArrayList<>();
        Map<String, Object> commission = new HashMap<>();
        List<Integer> buyer_company_ids = new ArrayList<>();
        buyer_company_ids.add(Integer.parseInt(list.get(0).get("buyer_company_ids")));
        commission.put("percentage", list.get(0).get("percentage"));
        commission.put("expiry_date", CommonHandle.setDate2(list.get(0).get("expiry_date"), "yyyy-MM-dd"));
        commission.put("start_date", CommonHandle.setDate2(list.get(0).get("start_date"), "yyyy-MM-dd"));
        commissions.add(commission);
        map.put("brand_id", list.get(0).get("brand_id"));
        map.put("commissions", commissions);
        map.put("buyer_company_ids", buyer_company_ids);
        Map<String, Object> brand_buyer_company_commission = new HashMap<>();
        brand_buyer_company_commission.put("brand_buyer_company_commission", map);
        brandAPI.callSetCompanyPricingBrand(brand_buyer_company_commission, UrlAdminAPI.BRAND_COMPANY_PRICING);
    }

    @And("Admin delete Company specific pricing of brand by API")
    public void deleteCompanyPricing(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        List<Integer> companyCommissionIds = brandAPI.getBrandCompanyCommissionId(brandAPI.callDetailBrand(list.get(0).get("brand_id")));
        if (companyCommissionIds.size() > 0) {
            Map<String, Object> map = new HashMap<>();
            List<Map<String, Object>> commissions = new ArrayList<>();
            Map<String, Object> commission = new HashMap<>();
            List<Integer> buyer_company_ids = new ArrayList<>();
            buyer_company_ids.add(Integer.parseInt(list.get(0).get("buyer_company_ids")));
            commission.put("percentage", "");
            commission.put("expiry_date", "");
            commission.put("start_date", "");
            commission.put("id", companyCommissionIds.get(0));
            commissions.add(commission);
            map.put("brand_id", Integer.parseInt(list.get(0).get("brand_id")));
            map.put("commissions", commissions);
            map.put("buyer_company_ids", buyer_company_ids);
            Map<String, Object> brand_buyer_company_commission = new HashMap<>();
            brand_buyer_company_commission.put("brand_buyer_company_commission", map);
            brandAPI.callDeleteCompanyPricingBrand(brand_buyer_company_commission, UrlAdminAPI.BRAND_COMPANY_PRICING);
        }
    }

    @And("Admin delete Fixed pricing of brand {string} by API")
    public void deleteFixedBrandPricing(String brandId) {
        Map<String, Object> map = new HashMap<>();
        BrandCommisstionAttributes brandCommisstionAttributes = brandAPI.getBrandCommissionAttributes(brandAPI.callDetailOfBrand(UrlAdminAPI.ADMIN_BRAND_DETAIL(brandId)));
        map.put("brand[brand_commission_attributes][id]", brandCommisstionAttributes.getId());
        map.put("brand[brand_commission_attributes][percentage]", brandCommisstionAttributes.getPercentage());
        map.put("brand[brand_commission_attributes][_destroy]", "true");
        brandAPI.callDeleteFixedPricingBrand(brandId, map);
    }

    @And("Admin set Fixed pricing of brand {string} with {string} by API")
    public void setFixedBrandPricing(String brandId, String percent) {
        Map<String, Object> map = new HashMap<>();
        map.put("brand[brand_commission_attributes][percentage]", percent);
        brandAPI.callSetFixedPricingBrand(brandId, map);
    }

    @And("Change state of Brand id: {string} to {string}")
    public void changeStateBrandActive(String id, String state) {
        String basePath = UrlAdminAPI.ADMIN_BRAND_DETAIL(id);
        String status = brandAPI.getState(brandAPI.callDetailOfBrand(basePath));
        if (!status.equals(state)) {
            brandAPI.callChangeState(id);
        } else {
            System.out.println("Currently state of brand is " + state);
        }
    }

}
