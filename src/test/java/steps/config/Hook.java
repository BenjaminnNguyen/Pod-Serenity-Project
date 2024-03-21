package steps.config;

import com.fasterxml.jackson.databind.ObjectMapper;
//import com.github.invictum.reportportal.LogsPreset;
//import com.github.invictum.reportportal.ReportIntegrationConfig;
//import cucumber.config.ReportPortal;
import cucumber.models.User;
import cucumber.models.api.CreateAnnouncements;
import cucumber.models.api.CreateInventory;
import cucumber.models.web.Admin.Products.sku.StoreConfigAttributes;
import cucumber.models.web.Admin.brand.createbrand.BrandModel;
import io.cucumber.java.*;
import net.serenitybdd.cucumber.suiteslicing.SerenityTags;
import net.serenitybdd.screenplay.actors.OnStage;
import net.serenitybdd.screenplay.actors.OnlineCast;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Map;

public class Hook {

    @Before
    public void before() {
        //Report portal config log
//        LogsPreset preset = LogsPreset.CUSTOM;
//        preset.register(ReportPortal.myUnits());
//        ReportIntegrationConfig.get().usePreset(preset);
        OnStage.setTheStage(new OnlineCast());
        SerenityTags.create().tagScenarioWithBatchingInfo();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    @DefaultParameterTransformer
    @DefaultDataTableEntryTransformer(replaceWithEmptyString = "[blank]")
    @DefaultDataTableCellTransformer(replaceWithEmptyString = "[blank]")
    public Object transformer(Object fromValue, Type toValueType) {
        return objectMapper.convertValue(fromValue, objectMapper.constructType(toValueType));
    }

}