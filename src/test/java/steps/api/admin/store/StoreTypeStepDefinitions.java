package steps.api.admin.store;

import cucumber.tasks.admin.store.HandleStoreType;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.store.HandleStoreTypeAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.List;
import java.util.Map;

public class StoreTypeStepDefinitions {

    @And("Admin get store type {string} by API")
    public void get_store_type_by_api(String storeType) {
        HandleStoreTypeAPI handleStoreType = new HandleStoreTypeAPI();
        Response response = handleStoreType.callGetStoreType();
        handleStoreType.getIdStoreType(response, storeType);
    }

    @And("Admin delete store type by API")
    public void delete_store_type_by_api() {
        HandleStoreTypeAPI handleStoreType = new HandleStoreTypeAPI();
        String idStoreType = Serenity.sessionVariableCalled("ID Store Type API");
        if (idStoreType != null) {
            handleStoreType.callDeleteStoreType(idStoreType);
        }

    }
}
