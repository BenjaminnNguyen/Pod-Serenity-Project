package steps.api.admin.master;

import cucumber.tasks.api.admin.master.MasterAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.it.Ma;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MasterGeneralAPIStepDefinitions {

    MasterAPI masterAPI = new MasterAPI();


    @And("Admin set Kailua api")
    public void setKailua(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        Map<String, Object> map = new HashMap<>();
        map.put("admin_setting", list.get(0));
        masterAPI.callTurnKailua(map);
    }


}
