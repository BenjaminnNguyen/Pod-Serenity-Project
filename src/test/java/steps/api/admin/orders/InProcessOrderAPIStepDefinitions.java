package steps.api.admin.orders;

import cucumber.models.api.admin.orders.CreateOrder;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.order.InProcessOrderAdminAPI;
import cucumber.tasks.api.admin.order.OrdersAdminAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InProcessOrderAPIStepDefinitions {


    @And("Admin create in process order by API")
    public void admin_create_in_process_order_by_api(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        InProcessOrderAdminAPI inProcessOrderAdminAPI = new InProcessOrderAdminAPI();
        OrdersAdminAPI ordersAdminAPI = new OrdersAdminAPI();

        CreateOrder createOrder = ordersAdminAPI.setCreateOrderModel(infos.get(0));
        Response response = inProcessOrderAdminAPI.callCreateInProcessOrder(createOrder);
        inProcessOrderAdminAPI.getIdOrderCreated(response);
    }

    @And("Admin search order in process by API")
    public void admin_search_order_by_API(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        InProcessOrderAdminAPI inProcessOrderAdminAPI = new InProcessOrderAdminAPI();

        HashMap<String, Object> info1 = CommonTask.setValueRandom1(infoObj.get(0), "q[order_number]", Serenity.sessionVariableCalled("Number Order API"));

        Response response = inProcessOrderAdminAPI.callSearchInProcessOrder(info1);
        Serenity.setSessionVariable("Response search in-process order").to(response);
    }

    @And("Admin get number order of order in process by API")
    public void admin_get_number_order_by_API() {
        InProcessOrderAdminAPI inProcessOrderAdminAPI = new InProcessOrderAdminAPI();

        String idInprocessOrder = Serenity.sessionVariableCalled("ID Order In Process API").toString();
        Response response = Serenity.sessionVariableCalled("Response search in-process order");
        inProcessOrderAdminAPI.getNumberOrder(response, idInprocessOrder);
    }

    @And("Admin get id order from detail of order in process {string} by API")
    public void admin_search_order_by_API(String id) throws InterruptedException {
        if (id.equals("")) {
            id =  Serenity.sessionVariableCalled("ID Order In Process API").toString();
        }
        String idOrder = null;
        InProcessOrderAdminAPI inProcessOrderAdminAPI = new InProcessOrderAdminAPI();
        while(idOrder == null) {
            Response response = inProcessOrderAdminAPI.callDetailInProcessOrder(id);
            idOrder = inProcessOrderAdminAPI.getNumberOrderFromDetail(response);
            Thread.sleep(5000);
        }
        System.out.println("ID Order " + idOrder);
        Serenity.setSessionVariable("Id Order").to(idOrder);
    }
}
