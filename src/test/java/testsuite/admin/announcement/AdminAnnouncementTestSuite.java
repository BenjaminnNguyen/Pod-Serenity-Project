package testsuite.admin.announcement;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        plugin = {"pretty", "rerun:rerun/failed_scenarios.txt"},
        tags = "@feature=AdminAnnouncement",
        features = "src/test/resources/features/admin/announcement",
        glue = {"steps"}
)
public class AdminAnnouncementTestSuite {
}
