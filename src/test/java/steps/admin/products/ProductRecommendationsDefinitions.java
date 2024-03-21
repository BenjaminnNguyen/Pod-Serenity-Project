package steps.admin.products;

import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.products.HandleProductRecommendations;
import cucumber.tasks.common.*;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.products.AdminProductRecommendationsPage;
import cucumber.user_interface.admin.products.AdminAllProductsPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.chrome.ChromeOptions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.*;

public class ProductRecommendationsDefinitions {

    @And("Admin search product recommendations with buyer: {string}")
    public void searchRecommendations(String buyer) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.filter(buyer)
        );
    }

    @And("Admin reset filter product recommendations")
    public void searchRecommendations() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.resetFilter()
        );
    }

    @And("Admin check product recommendations list")
    public void searchRecommendations(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(map.get("product"), "name")), containsString(map.get("product"))),
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(map.get("product"), "buyer")), containsString(map.get("buyer"))),
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(map.get("product"), "brand")), containsString(map.get("brand"))),
                    seeThat(CommonQuestions.targetText(AdminAllProductsPage.DYNAMIC_TABLE(map.get("product"), "comment")), containsString(map.get("comment")))
            );
        }
    }

    @And("Admin input product recommendations")
    public void createRecommendations(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.create(list)
        );
    }

    @And("Admin confirm create product recommendations")
    public void confirmCreateRecommendations() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.confirmCreate()
        );
    }

    @And("Admin confirm update product recommendations")
    public void confirmUpdateRecommendations() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.confirmUpdate()
        );
    }

    @And("Admin open create product recommendations popup")
    public void openCreateRecommendations() {
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.openCreate()
        );
    }

    @And("Admin open edit product recommendations {string}")
    public void openEditRecommendations(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.openEdit(name)
        );
    }

    @And("Admin click edit button product recommendations {string}")
    public void clickEditRecommendations(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.clickEdit(name)
        );
    }

    @And("Admin {string} delete product recommendations {string}")
    public void deleteRecommendations(String type, String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.delete(name, type)
        );
    }

    @And("Admin check region of Buyer {string} create recommendation")
    public void checkRegionBuyerCreateRecommendations(String buyer, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleProductRecommendations.openCreate(),
                Ensure.that(AdminProductRecommendationsPage.DYNAMIC_FIELD("Product")).isDisabled(),
                Enter.theValue(buyer).into(AdminProductRecommendationsPage.DYNAMIC_FIELD("Buyer")),
                CommonTask.ChooseValueFromSuggestions(buyer),
                CommonWaitUntil.isEnabled(AdminProductRecommendationsPage.DYNAMIC_FIELD("Product"))
        );
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AdminProductRecommendationsPage.DYNAMIC_REGION(map.get("region"))), equalToIgnoringCase(map.get("title")))
            );
        }
    }

    @And("Admin check recommendation info")
    public void checkBuyerCreateRecommendations(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.attributeText(AdminProductRecommendationsPage.DYNAMIC_FIELD("Buyer"), "value"), containsString(list.get(0).get("buyer"))),
                seeThat(CommonQuestions.attributeText(AdminProductRecommendationsPage.DYNAMIC_FIELD("Product"), "value"), containsString(list.get(0).get("product"))),
                seeThat(CommonQuestions.attributeText(AdminProductRecommendationsPage.DYNAMIC_FIELD("Comment"), "value"), containsString(list.get(0).get("comment")))
        );
    }

    @And("Admin input invalid {string} recommendation")
    public void enter_invalid_buyer(String type, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTask.enterInvalidToDropdown(AdminProductRecommendationsPage.DYNAMIC_FIELD(type), item.get("field")),
                    Click.on(AdminProductRecommendationsPage.DYNAMIC_FIELD("Comment"))
            );
        }
    }


    @And("Admin export file")
    public void exportFile() {
        String current = System.getProperty("user.dir");
        System.out.println("Current working directory in Java : " + current);
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Export")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Exporting will cost a lot of system resources. If you need large-sized data, please contact Jungmin first. If you still want to proceed, type ")),
                Enter.theValue("I UNDERSTAND").into(CommonAdminForm.DYNAMIC_DIALOG_INPUT()),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")),
                WindowTask.threadSleep(1000)
//                CommonFile.waitForTheExcelFileToDownload("product-recommendations-" + Utility.getTimeNow("MM_dd_yy"))
//                HandlePromotions.closeCreateForm()
        );
    }

    @And("Admin check export file")
    public void checkExportFile() {
        String current = System.getProperty("user.dir");
        System.out.println("Current working directory in Java : " + current);
        CommonFile.waitForTheFileToDownload("product-recommendations-" + Utility.getTimeNow("MM_dd_yy"));
    }

    @And("Admin set directory file")
    public void directoryFile() {
        String current = System.getProperty("user.dir");
        String otherFolder = current + "\\src\\test\\resources\\files\\download\\";
//        String otherFolder = current + File.separator + "src\\test\\resources\\files\\download";
        System.out.println("Current working directory in Java : " + otherFolder);
        ChromeOptions options = new ChromeOptions();
        HashMap<String, Object> chromePrefs = new HashMap<>();
        chromePrefs.put("download.default_directory", otherFolder);
        chromePrefs.put("prompt_for_download", false);
        options.setExperimentalOption("prefs", chromePrefs);
    }
}
