package cucumber.tasks.api.admin.vendor;

import cucumber.models.web.Admin.Vendors.VendorCompanyRegionMovsAttributes;
import cucumber.models.web.Admin.sample.AddressAttributes;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.Utility;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class VendorAdminAPI {
    CommonRequest commonRequest = new CommonRequest();


    public Response callChangeRegionMov(String vendorID, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody2(UrlAdminAPI.ADMIN_UPDATE_VENDOR_COMPANY(vendorID), map, "PUT");
        System.out.println("response "  + response.prettyPrint());
//        Serenity.recordReportData().withTitle("RESPONSE CHANGE REGION MOV ATTRIBUTE ").andContents(response.prettyPrint());
        return response;
    }

    public Response callUpdateVendorCompany(String vendorID, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_UPDATE_VENDOR_COMPANY(vendorID), map, "PUT");
//        Serenity.recordReportData().withTitle("RESPONSE UPDATE VENDOR ").andContents(response.prettyPrint());
        return response;
    }

    public Response callUpdateVendor(String vendorID, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_ALL_VENDOR(vendorID), map, "PUT");
//        Serenity.recordReportData().withTitle("RESPONSE UPDATE VENDOR ").andContents(response.prettyPrint());
        return response;
    }

    public void callDeleteVendorCompany(List<String> vendor) {
        for (String s : vendor) {
            Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_UPDATE_VENDOR_COMPANY(s), "DELETE");
//            System.out.println("RESPONSE DELETE VENDOR_COMPANY " + response.prettyPrint());
//            Serenity.recordReportData().withTitle("RESPONSE DELETE VENDOR_COMPANY: ").andContents(response.prettyPrint());
        }
    }


    public Response callDetailVendorCompany(String vendorID) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_UPDATE_VENDOR_COMPANY(vendorID), "GET");
//        Serenity.recordReportData().withTitle("RESPONSE UPDATE VENDOR ").andContents(response.prettyPrint());
        return response;
    }

    public Map<String, Object> setAddress(Map<String, Object> map) {
        Map<String, Object> address = new HashMap<>();
        address.putIfAbsent("address_state_id", Integer.parseInt((String) map.get("address_state_id")));
        address.putIfAbsent("street1", map.get("street1"));
        address.putIfAbsent("street2", map.get("street2"));
        address.putIfAbsent("city", map.get("city"));
        address.putIfAbsent("zip", Integer.parseInt((String) map.get("zip")));
        address.putIfAbsent("country_name", map.get("country_name"));

//        AddressAttributes addressAttributes = new AddressAttributes(map.get("address_state_id").toString(), map.get("street1").toString(), map.get("street2").toString(), map.get("city").toString(), map.get("zip").toString());
        return address;
    }

    public void setVendorRegionMovsAttributes(List<VendorCompanyRegionMovsAttributes> regions) {
        List<VendorCompanyRegionMovsAttributes> regionMovsAttributes = regions;
        Serenity.setSessionVariable("List regions mov").to(regionMovsAttributes);
    }

    public String getIdVendorCompany(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        System.out.println("ID of Vendor company = " + id);
        Serenity.setSessionVariable("ID of Vendor company").to(id);
        return id;
    }

    public Response callCreateVendorCompany(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_VENDOR_COMPANY, map, "POST");
        Serenity.recordReportData().withTitle("RESPONSE CREATE VENDOR COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public Map<String, Object> setCreateVendorModel(Map<String, Object> map) {
        Map<String, Object> vendorCompany = new HashMap<>();
        Map<String, Object> vendorCompanyInfo = new HashMap<>();
        List<Map<String, Object>> regionMov = Serenity.sessionVariableCalled("List regions mov");
        vendorCompanyInfo.putIfAbsent("address_attributes", setAddress(map));
        vendorCompanyInfo.putIfAbsent("vendor_company_region_movs_attributes", regionMov);
        vendorCompanyInfo.putIfAbsent("vendor_companies_tags_attributes", new ArrayList<>());
        vendorCompanyInfo.putIfAbsent("referral_buyer_company_ids", new ArrayList<>());
        vendorCompanyInfo.putIfAbsent("name", map.get("name").toString().contains("random") ? map.get("name").toString() + CommonTask.getDateTimeString() : map.get("name").toString());
        vendorCompanyInfo.putIfAbsent("contact_number", map.get("contact_number"));
        vendorCompanyInfo.putIfAbsent("show_all_tabs", map.get("show_all_tabs"));
        vendorCompanyInfo.putIfAbsent("limit_type", map.get("limit_type"));
        vendorCompanyInfo.putIfAbsent("email", Utility.getRandomString(4) + map.get("email"));
        vendorCompany.putIfAbsent("vendor_company", vendorCompanyInfo);
        return vendorCompany;
    }

    public Map<String, Object> setVendorRegionMovAttribute(List<Map<String, Object>> infos) {
        List<Map<String, Object>> vendor_company_region_movs_attributes = new ArrayList<>();
        for (Map<String, Object> item : infos) {
            Map<String, Object> movAttribute = new HashMap<>();
            movAttribute.putIfAbsent("id", item.get("id"));
            movAttribute.putIfAbsent("region_id", item.get("region_id"));
            movAttribute.putIfAbsent("region_name", item.get("region_name"));
            movAttribute.putIfAbsent("region_type", item.get("region_type"));
            movAttribute.putIfAbsent("mov_cents", item.get("mov_cents"));
            movAttribute.putIfAbsent("mov_currency", item.get("mov_currency"));

            vendor_company_region_movs_attributes.add(movAttribute);
        }
        Map<String, Object> vendor_company = new HashMap<>();
        vendor_company.putIfAbsent("vendor_company_region_movs_attributes", vendor_company_region_movs_attributes);
        return vendor_company;
    }

    public Response searchVendorCompany(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_VENDOR_COMPANY, map, "GET");
        System.out.println("RESPONSE SEARCH VENDOR COMPANY: " + response.prettyPrint());
        Serenity.recordReportData().withTitle("RESPONSE SEARCH VENDOR COMPANY: ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getListVendorCompanyId(Response response, String name) {
        List<String> vendor = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            if (item.get("name").equals(name)) {
                vendor.add(item.get("id").toString());
            }
        }
        Serenity.setSessionVariable("List Id Vendor Company API").to(vendor);
        return vendor;
    }

    public int getIdAddress(Response response) {
        int idAddress;
        JsonPath jsonPath = response.jsonPath();
        HashMap address_attributes = jsonPath.get("address_attributes");
        idAddress = (int) address_attributes.get("id");

        Serenity.setSessionVariable("Id Vendor Address").to(idAddress);
        return idAddress;
    }

    public Map<String, Object> setEditVendorCompany(Map<String, Object> info) {
        Map<String, Object> vendorCompany = new HashMap<>();
        Map<String, Object> vendorCompanyInfo = new HashMap<>();
        vendorCompanyInfo = info;
        vendorCompanyInfo.putIfAbsent("referral_buyer_company_ids", new ArrayList<>());

        vendorCompany.putIfAbsent("vendor_company", vendorCompanyInfo);

        return vendorCompany;
    }

    public Map<String, Object> setEditAddress(Map<String, Object> info) {
        Map<String, Object> vendorCompany = new HashMap<>();
        Map<String, Object> address_attributes = new HashMap<>();
        Map<String, Object> temp = info;
        temp.putIfAbsent("id", Serenity.sessionVariableCalled("Id Vendor Address"));
        address_attributes.putIfAbsent("address_attributes", info);
        vendorCompany.putIfAbsent("vendor_company", address_attributes);

        return vendorCompany;
    }
}
