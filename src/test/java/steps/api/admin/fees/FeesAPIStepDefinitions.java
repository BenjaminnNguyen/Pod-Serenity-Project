package steps.api.admin.fees;

import cucumber.tasks.admin.fees.HandleAdminFees;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.fees.HandleAdminFeesAPI;
import cucumber.tasks.api.admin.financial.HandleCreditMemoTypeAPI;
import cucumber.tasks.api.admin.financial.HandleStoreAdjustmentTypeAPI;
import cucumber.tasks.api.admin.financial.HandleVendorAdjustmentTypeAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import javax.xml.crypto.Data;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class FeesAPIStepDefinitions {
    HandleAdminFeesAPI handleAdminFees = new HandleAdminFeesAPI();

    @And("Admin search fees by api")
    public void search_fees_by_api(String name) {
        Map<String, Object> map = new HashMap<>();
        String id = null;
        int page = 1;
        while (id == null) {
            map.put("page", page);
            // search page
            Response response = handleAdminFees.callSearchFees(map);
            id = handleAdminFees.getId(response, name);
            if (id != null) {
                break;
            }
            if (page == 5) {
                System.out.println("Không tìm thấy fee");
                break;
            }
            // tăng page lên 1
            page++;
        }
        Serenity.setSessionVariable("ID Fee api").to(id);
    }

    @And("Admin delete fee by api")
    public void delete_fee_by_api() {
        String id = Serenity.sessionVariableCalled("ID Fee api");
        if (id != null) {
            handleAdminFees.callDeleteFee(id);
        }
    }

    @And("Admin update small order surcharge by api")
    public void small_order_surcharge_by_api(DataTable table) {
        List<Map<String, Object>> info = CommonHandle.convertDataTable(table);
        Map<String, Object> small_order_surcharge_structure = new HashMap<>();
        small_order_surcharge_structure.put("small_order_surcharge_structure", info.get(0));
        handleAdminFees.callUpdateSmallOrderSurcharge("1", small_order_surcharge_structure);
    }
}
