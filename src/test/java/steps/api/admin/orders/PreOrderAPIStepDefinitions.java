package steps.api.admin.orders;

import cucumber.tasks.api.CommonHandle;
import io.cucumber.java.en.*;
import cucumber.tasks.api.admin.PreOrderAdminAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PreOrderAPIStepDefinitions {
    PreOrderAdminAPI preOrderAdminAPI = new PreOrderAdminAPI();
    @And("Admin search pre order with info by api")
    public void admin_search_pre_order_with_info_by_api(DataTable dt) {
        List<Map<String, Object>> info = CommonHandle.convertDataTable(dt);
        HashMap<String, Object> info1 = CommonTask.setValueRandom1(info.get(0), "q[number]", Serenity.sessionVariableCalled("ID PreOrder"));
        Response response = preOrderAdminAPI.callSearchPreOrder(info1);
        Serenity.setSessionVariable("Response Search Pre Order").to(response);
    }

}
