package steps.api.admin.vendor;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.vendor.AdminAllVendorAPI;
import cucumber.tasks.api.admin.vendor.VendorAdminAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.List;
import java.util.Map;

public class AllVendorsAPIStepDefinitions {

    CommonRequest commonRequest = new CommonRequest();

    AdminAllVendorAPI adminAllVendorAPI = new AdminAllVendorAPI();
    VendorAdminAPI vendorAdminAPI = new VendorAdminAPI();

    @And("Admin search all vendor by API")
    public void admin_search_all_vendor_by_api(DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Response response = adminAllVendorAPI.searchAllVendor(infos.get(0));
        adminAllVendorAPI.getListAllVendorId(response, infos.get(0).get("q[full_name]").toString());
    }

    @And("Admin delete vendor by API")
    public void delete_vendor_by_api() {
        List<String> vendorList = Serenity.sessionVariableCalled("List Id ALl Vendor API");
        if (vendorList.size() > 0)
            for (String vendor : vendorList) {
                adminAllVendorAPI.callDeleteVendorCompany(vendor);
            }
    }

    @And("Admin change info of vendor {string}")
    public void admin_change_general_information_of_vendor_company(String vendorID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Map<String, Object> vendor = adminAllVendorAPI.setEditVendor(infos.get(0));
        vendorAdminAPI.callUpdateVendor(vendorID, vendor);
    }


}
