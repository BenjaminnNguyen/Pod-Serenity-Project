package steps.api.admin.vendor;

import cucumber.tasks.api.CommonHandle;
import io.cucumber.java.en.*;
import cucumber.models.web.Admin.Vendors.VendorCompanyRegionMovsAttributes;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.vendor.VendorAdminAPI;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class VendorCompanyAPIStepDefinications {
    CommonRequest commonRequest = new CommonRequest();

    VendorAdminAPI vendorAdminAPI = new VendorAdminAPI();

    @Given("Admin update limit type of vendor company {string} to {string} by api")
    public void updateLimitType(String id, String type) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("vendor_company[limit_type]", type);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_UPDATE_VENDOR_COMPANY(id), map, "PUT");
//        System.out.println("RESPONSE UPDATE REGION LIMIT " + response.prettyPrint());
//        Serenity.recordReportData().withTitle("RESPONSE UPDATE REGION LIMIT  ").andContents(response.prettyPrint());
    }

    @Given("Admin update limit region id {string} of vendor company {string} to {string} by api")
    public void updateLimitValue(String region, String id, String value) {
        Map<String, Object> map = new HashMap<>();
        map.putIfAbsent("vendor_company[vendor_company_region_movs_attributes][0][id]", getRegionMOV(id, region));
        map.putIfAbsent("vendor_company[vendor_company_region_movs_attributes][0][region_id]", region);
        map.putIfAbsent("vendor_company[vendor_company_region_movs_attributes][0][mov_cents]", value);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_UPDATE_VENDOR_COMPANY(id), map, "PUT");
//        System.out.println("RESPONSE UPDATE REGION LIMIT " + response.prettyPrint());
//        Serenity.recordReportData().withTitle("RESPONSE UPDATE REGION LIMIT  ").andContents(response.prettyPrint());
    }

    public String getRegionMOV(String region, String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_UPDATE_VENDOR_COMPANY(region), "GET");
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> listVendor = jsonPath.get("vendor_company_region_movs_attributes");
        String i = "";
        for (Map<String, Object> map : listVendor) {
            if (map.get("region_id").toString().equals(id))
                i = map.get("id").toString();
        }
        return i;
    }

    @And("Admin change info of regions mov attributes with vendorID {string}")
    public void admin_change_regions_mov_attributes(String vendorID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Map<String, Object> vendor_company = vendorAdminAPI.setVendorRegionMovAttribute(infos);
        vendorAdminAPI.callChangeRegionMov(vendorID, vendor_company);
    }

    @And("Admin create vendor company by API")
    public void createVendorCompany(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);

        Map<String, Object> vendorCompany = vendorAdminAPI.setCreateVendorModel(infos.get(0));

        Response response = vendorAdminAPI.callCreateVendorCompany(vendorCompany);

        vendorAdminAPI.getIdVendorCompany(response);

    }

    @And("Admin delete vendor company by API")
    public void deleteVendorCompany() {
        List<String> ids = Serenity.sessionVariableCalled("List Id Vendor Company API");
        if (ids.size() > 0)
            vendorAdminAPI.callDeleteVendorCompany(ids);

    }

    @And("Admin search vendor company by API")
    public void searchVendorCompany(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Response response = vendorAdminAPI.searchVendorCompany(infos.get(0));
        vendorAdminAPI.getListVendorCompanyId(response, infos.get(0).get("q[name]").toString());
    }

    @And("Admin set region mov for vendor company API")
    public void setRegionMov(DataTable table) {
        List<VendorCompanyRegionMovsAttributes> list = table.asList(VendorCompanyRegionMovsAttributes.class);
        vendorAdminAPI.setVendorRegionMovsAttributes(list);
    }

    @And("Admin change general information of vendor company {string}")
    public void admin_change_general_informatio_of_vendor_company(String vendorID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Map<String, Object> vendor_company = vendorAdminAPI.setEditVendorCompany(infos.get(0));
        vendorAdminAPI.callChangeRegionMov(vendorID, vendor_company);
    }

    @And("Admin change address of vendor company {string}")
    public void admin_change_address_of_vendor_company(String vendorID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        // get detail để lấy id của address
        Response response = vendorAdminAPI.callDetailVendorCompany(vendorID);
        vendorAdminAPI.getIdAddress(response);
        Map<String, Object> vendor_company = vendorAdminAPI.setEditAddress(infos.get(0));
        vendorAdminAPI.callChangeRegionMov(vendorID, vendor_company);
    }
}
