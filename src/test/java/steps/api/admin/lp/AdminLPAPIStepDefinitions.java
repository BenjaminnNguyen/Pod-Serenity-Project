package steps.api.admin.lp;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.AdminLPAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminLPAPIStepDefinitions {



    @And("Admin search lp company by api")
    public void admin_search_lp_company(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        AdminLPAPI adminLPAPI = new AdminLPAPI();
        Response response = adminLPAPI.callSearchLPCompany(infoObj.get(0));
        //lấy ra list ID claim
        adminLPAPI.getIdsLPCompany(response);
    }

    @And("Admin delete lp company by api")
    public void admin_delete_claim_by_api() {
        List<String> listId = Serenity.sessionVariableCalled("List LP Company id api");
        AdminLPAPI adminLPAPI = new AdminLPAPI();
        for (String id : listId) {
            adminLPAPI.callDeleteLPCompany(id);
        }
    }

    @And("Admin create lp company by api")
    public void admin_create_lp_company(DataTable table) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(table);
        AdminLPAPI adminLPAPI = new AdminLPAPI();

        Map<String, Object> object = new HashMap<>();
        List<String> roles = new ArrayList<>();
        Map<String, Object> logistics_company = new HashMap<>();
        object.put("business_name", list.get(0).get("business_name"));
        object.put("contact_number", list.get(0).get("contact_number"));
        if (list.get(0).get("roles_name").toString().contains("driver"))
            roles.add("driver");
        if (list.get(0).get("roles_name").toString().contains("warehousing"))
            roles.add("warehousing");
        object.put("roles_name", roles);

        logistics_company.put("logistics_company", object);
        Response response = adminLPAPI.callCreateLPCompany(logistics_company);
        String id = adminLPAPI.getIdLPCompany(response);
        Serenity.setSessionVariable("LP Company id api" + list.get(0).get("business_name")).to(id);
    }

    @And("Admin create lp by api")
    public void admin_create_lp(DataTable table) {
        List<Map<String, Object>> list = CommonHandle.convertDataTable(table);
        AdminLPAPI adminLPAPI = new AdminLPAPI();

        Map<String, Object> object = new HashMap<>();
        List<String> roles = new ArrayList<>();
        Map<String, Object> logistics_partner = new HashMap<>();
        String lpCompanyId = list.get(0).get("logistics_company_id").toString().contains("create by api")
                ? Serenity.sessionVariableCalled("LP Company id api") : list.get(0).get("logistics_company_id").toString();
        object.put("first_name", list.get(0).get("first_name"));
        object.put("last_name", list.get(0).get("last_name"));
        object.put("contact_number", list.get(0).get("contact_number"));
        object.put("email", list.get(0).get("email"));
        object.put("password", list.get(0).get("password"));
        object.put("logistics_company_id", lpCompanyId);

        logistics_partner.put("logistics_partner", object);
        Response response = adminLPAPI.callCreateLP(logistics_partner);
        String id = adminLPAPI.getIdLP(response);
        Serenity.setSessionVariable("LP id api" + list.get(0).get("email")).to(id);
    }

    @And("Admin change general information of lp {string}")
    public void admin_change_general_information_of_lp(String lpID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        AdminLPAPI adminLPAPI = new AdminLPAPI();

        Map<String, Object> editLP = adminLPAPI.setEditLP(infos.get(0));
        adminLPAPI.callEditLP(lpID, editLP);
    }

    @And("Admin change general information of lp company {string}")
    public void admin_change_general_information_of_lp_company(String lpCompanyID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        AdminLPAPI adminLPAPI = new AdminLPAPI();

        Map<String, Object> editLP = adminLPAPI.setEditLPCompany(infos.get(0));
        adminLPAPI.callEditLPCompany(lpCompanyID, editLP);
    }
}
