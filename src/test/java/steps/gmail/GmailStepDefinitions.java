package steps.gmail;

import cucumber.tasks.api.CommonHandle;
import cucumber.user_interface.admin.CommonAdminForm;
import io.cucumber.java.Before;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.singleton.GVs;;
import cucumber.tasks.common.*;
import cucumber.tasks.email.HandleEmail;
import cucumber.user_interface.beta.LoginGmailPage;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.gmail.GmailDetailPage;
import cucumber.user_interface.gmail.PaymentConfirmationPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.actors.OnStage;
import net.serenitybdd.screenplay.actors.OnlineCast;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.thucydides.core.util.EnvironmentVariables;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isNotVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;
import static org.hamcrest.CoreMatchers.containsString;


public class GmailStepDefinitions {
    public static EnvironmentVariables env;

    @Before()
    public void set_the_stage() {
        OnStage.setTheStage(new OnlineCast());
        String enviroment = null;
        if (System.getProperty("environment") == null) {
            enviroment = "default";
        } else {
            enviroment = System.getProperty("environment");
        }
        GVs.ENVIRONMENT = enviroment;
    }

    @And("{word} search email with sender {string}")
    public static void search_email_sender(String actor, String sender) {
        theActorCalled(actor).attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(LoginGmailPage.SEARCH_BOX)).andIfSo(
                        Clear.field(LoginGmailPage.SEARCH_BOX),
                        Enter.theValue(sender).into(LoginGmailPage.SEARCH_BOX).thenHit(Keys.ENTER)
                )
        );

        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @And("{word} search email with order {string}")
    public static void search_email_order(String actor, String value) {
        if (value.equals("create by admin")) {
            value = Serenity.sessionVariableCalled("ID Order");
        }
        if (value.equals("create by api")) {
            value = Serenity.sessionVariableCalled("ID Order");
        }
        if (value.contains("index")) {
            value = Serenity.sessionVariableCalled("Number Order API" + value.substring(value.length() - 1));
        }
        if (value.contains("sample request")) {
            value = Serenity.sessionVariableCalled("Sample request number");
        }

        theActorCalled(actor).attemptsTo(
                HandleEmail.search(value)
        );
    }

    @And("{word} search email with withdrawal {string}")
    public static void search_email_withdrawal(String actor, String value) {
        if (value.equals("create by api")) {
            value = Serenity.sessionVariableCalled("Withdrawal Request Number");
        }

        theActorCalled(actor).attemptsTo(
                HandleEmail.search(value)
        );

    }

    @And("{word} search email with drop {string}")
    public static void search_email_drop(String actor, String store) {
        String dropID = Serenity.sessionVariableCalled("Drop Number" + store);

        theActorCalled(actor).attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(LoginGmailPage.SEARCH_BOX)).andIfSo(
                        Clear.field(LoginGmailPage.SEARCH_BOX),
                        Enter.theValue(dropID).into(LoginGmailPage.SEARCH_BOX).thenHit(Keys.ENTER)
                )
        );
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @And("{word} search email with title {string}")
    public static void search_email_title(String actor, String value) {
        String title = value;
        if (value.contains("admin create claim")) {
            String claimID = Serenity.sessionVariableCalled("Claim ID");
            title = "Your claim has been received - Ref. " + claimID;
        }
        if (value.contains("qa create claim")) {
            String claimID = Serenity.sessionVariableCalled("Claim ID");
            title = "New vendor claim received " + claimID;
        }
        if (value.contains("admin dispose donate")) {
            String disposeNumber = Serenity.sessionVariableCalled("Inventory Request Number API");
            title = "Donation/Disposal request " + disposeNumber + " has been approved";
        }
        if (value.contains("dispose donate complete")) {
            String disposeNumber = Serenity.sessionVariableCalled("Inventory Request Number API");
            title = "Donation/Disposal request " + disposeNumber + " has been completely processed";
        }
        if (value.contains("Daily finance files")) {
            title = "Daily finance files " + CommonHandle.setDate2("currentDate", "yyyy-dd-MM");
        }

        theActorCalled(actor).attemptsTo(
                HandleEmail.search(title)
        );
    }

    @And("{word} search email shipment to pod inbound")
    public static void search_email_shipment_to_pod_inbound(String actor) {
        String sender = Serenity.sessionVariableCalled("Inventory_Reference");
        theActorCalled(actor).attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(LoginGmailPage.SEARCH_BOX)).andIfSo(
                        Clear.field(LoginGmailPage.SEARCH_BOX),
                        Enter.theValue(sender).into(LoginGmailPage.SEARCH_BOX).thenHit(Keys.ENTER)
                )
        );
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @And("QA go to first email with title {string}")
    public static void go_to_first_email(String title) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LoginGmailPage.FIRST_EMAIL),
                Click.on(LoginGmailPage.FIRST_EMAIL),
                WindowTask.threadSleep(2000)
        );
    }

    @And("QA go to detail email {string}")
    public static void go_to_email_with_title(String type) {
        String title = type;
        if (type.equals("order fulfill")) {
            String orderID = Serenity.sessionVariableCalled("ID Invoice");
            title = "Order " + orderID.substring(7) + " will be fulfilled when your inventory is received";
        }
        if (type.equals("eta order")) {
            String orderID = Serenity.sessionVariableCalled("ID Order");
            title = "Your estimated arrival date of order #" + orderID;
        }
        if (type.equals("order details")) {
            String orderID = Serenity.sessionVariableCalled("ID Order");
            title = "Order details - #" + orderID;
        }
        if (type.equals("new pod direct order")) {
            String orderID = Serenity.sessionVariableCalled("ID Order");
            title = "New Pod Direct Order " + orderID + "!";
        }
        if (type.equals("sample request")) {
            String orderID = Serenity.sessionVariableCalled("Sample request number");
            title = "Sample Request details - #" + orderID;
        }
        if (type.equals("upload inbound pod")) {
            String inboundNumber = Serenity.sessionVariableCalled("Number Inbound Inventory api");
            title = "POD uploaded - Inbound Inventory " + inboundNumber;
        }
        if (type.equals("upload inbound wpl")) {
            String inboundNumber = Serenity.sessionVariableCalled("Number Inbound Inventory api");
            title = "New signed WPL uploaded";
        }
        if (type.equals("approval needed withdrawal")) {
            String inboundNumber = Serenity.sessionVariableCalled("Withdrawal Request Number");
            title = inboundNumber + " - Approval Needed for New Inventory Withdrawal Request";
        }
        if (type.equals("approved withdrawal")) {
            String withdrawalRequestNumber = Serenity.sessionVariableCalled("Withdrawal Request Number");
            title = "Inventory Withdrawal Request Approved - " + withdrawalRequestNumber;
        }
        if (type.equals("new pickup appointment withdrawal")) {
            String withdrawalRequestNumber = Serenity.sessionVariableCalled("Withdrawal Request Number");
            title = "New Pickup Appointment - " + withdrawalRequestNumber;
        }
        if (type.equals("lp complete withdrawal")) {
            String withdrawalRequestNumber = Serenity.sessionVariableCalled("Withdrawal Request Number");
            title = "Inventory Withdrawal Request Completed - " + withdrawalRequestNumber;
        }
        if (type.equals("sample request cancel")) {
            String sampleRequest = Serenity.sessionVariableCalled("Number of Sample api");
            title = "Sample request canceled - " + sampleRequest;
        }
        if (type.equals("admin create claim")) {
            String claimID = Serenity.sessionVariableCalled("Claim ID");
            title = "Your claim has been received - Ref. " + claimID;
        }
        if (type.contains("qa create claim")) {
            String claimID = Serenity.sessionVariableCalled("Claim ID");
            title = "New vendor claim received " + claimID;
        }
        if (type.contains("admin dispose donate")) {
            String disposeNumber = Serenity.sessionVariableCalled("Inventory Request Number API");
            title = "Donation/Disposal request " + disposeNumber + " has been approved";
        }
        if (type.contains("dispose donate complete")) {
            String disposeNumber = Serenity.sessionVariableCalled("Inventory Request Number API");
            title = "Donation/Disposal request " + disposeNumber + " has been completely processed";
        }
        if (type.contains("Daily finance files")) {
            title = "Daily finance files " + CommonHandle.setDate2("currentDate", "yyyy-dd-MM");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleEmail.goToDetail(title)
        );
    }

    @And("QA go to detail email inbound submit")
    public static void qa_go_to_email_submit_inbound(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        String title = "New Inbound " + infos.get(0).get("brand") + " - ETA " + CommonHandle.setDate2(infos.get(0).get("currentDate"), "MM/dd/yyyy");
        System.out.println("Title mail submit inbound" + title);

        theActorInTheSpotlight().attemptsTo(
                HandleEmail.goToDetail(title)
        );
    }

    @And("go to email with title {string}")
    public static void go_to_with_title_email(String title) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LoginGmailPage.EMAIL_WITH_TITLE(title)),
                Click.on(LoginGmailPage.EMAIL_WITH_TITLE(title)),
                WindowTask.threadSleep(2000)
        );
    }

    @And("verify email")
    public static void verify_email(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        List<WebElementFacade> test = LoginGmailPage.EXPAND_EMAIL_CONTENT2.resolveAllFor(theActorInTheSpotlight());

        if (test.size() > 0) {
            theActorInTheSpotlight().attemptsTo(
                    Scroll.to(test.get(test.size() - 1)).andAlignToBottom()
            );
            if (test.get(test.size() - 1).isDisplayed()) {
                test.get(test.size() - 1).click();
            }
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("vendorCompany"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("brandName"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name")))
        );
        theActorInTheSpotlight().attemptsTo(
                Check.whether(list.get(0).get("productName").length() != 0).andIfSo(
                        CommonQuestions.AskForTextContains(LoginGmailPage.EMAIL_CONTENT, list.get(0).get("productName"))
                )
        );
    }

    @And("verify order summary in email Create Order")
    public static void verify_email_create_order(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());
//        Serenity.setSessionVariable("orderDate").to("Wed, 11 May 2022, 03:07AM");
//        Serenity.setSessionVariable("ID Invoice").to("220511438");
        String idInvoice = Serenity.sessionVariableCalled("ID Invoice");
        idInvoice = idInvoice.substring(7);
        String a = list.get(0).get("orderDate") + Serenity.sessionVariableCalled("orderDate") + " " + list.get(0).get("orderDateState");
        theActorInTheSpotlight().should(
                seeThat("Check content of email buyerFromStorePlaceOrder", CommonQuestions.AskForContainValue(contents, list.get(0).get("buyerFromStorePlaceOrder"))),
                seeThat("Check content of email orderNumber", CommonQuestions.AskForContainValue(contents, list.get(0).get("orderNumber") + idInvoice)),
//                seeThat("Check content of email orderDate", CommonQuestions.AskForContainValue(contents, list.get(0).get("orderDate") + Serenity.sessionVariableCalled("orderDate") + " " + list.get(0).get("orderDateState"))),
                seeThat("Check content of email buyer", CommonQuestions.AskForContainValue(contents, list.get(0).get("buyer"))),
                seeThat("Check content of email managerBy", CommonQuestions.AskForContainValue(contents, list.get(0).get("managerBy")))

        );
    }

    @And("Verify items in order detail in email Create Order")
    public static void verify_item_in_order_detail_email_create_order(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());

        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(CommonQuestions.isControlDisplay(LoginGmailPage.SHOW_ITEM_ICON)).andIfSo(
                            Click.on(LoginGmailPage.SHOW_ITEM_ICON)
                    ),
                    Ensure.that(contents).contains(map.get("brand")),
                    Ensure.that(contents).contains(map.get("sku")),
                    Ensure.that(contents).contains(map.get("casePrice")),
                    Ensure.that(contents).contains(map.get("quantity")),
                    Ensure.that(contents).contains(map.get("total")),
                    Ensure.that(contents).contains(map.get("promotion"))
            );
        }

    }

    @And("Verify prices in order detail in email Create Order")
    public static void verify_prices_in_order_detail_email_create_order(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());
        if (list.get(0).get("smallOrderSurcharge").isEmpty() && list.get(0).get("logisticsSurcharge").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(contents).contains(list.get(0).get("orderValue")),
                    Ensure.that(contents).contains(list.get(0).get("discount")),
                    Ensure.that(contents).contains(list.get(0).get("subtotal")),
                    Ensure.that(contents).contains(list.get(0).get("bottleDeposit")),
                    Ensure.that(contents).contains(list.get(0).get("specialDiscount")),
                    Ensure.that(contents).contains(list.get(0).get("total"))
            );
        } else
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(contents).contains(list.get(0).get("orderValue")),
                    Ensure.that(contents).contains(list.get(0).get("discount")),
                    Ensure.that(contents).contains(list.get(0).get("subtotal")),
                    Ensure.that(contents).contains(list.get(0).get("smallOrderSurcharge")),
                    Ensure.that(contents).contains(list.get(0).get("logisticsSurcharge")),
                    Ensure.that(contents).contains(list.get(0).get("bottleDeposit")),
                    Ensure.that(contents).contains(list.get(0).get("specialDiscount")),
                    Ensure.that(contents).contains(list.get(0).get("total"))
            );
    }

    @And("Check customer information in email Create Order")
    public static void checkContentEmail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(contents).contains(list.get(0).get("shippingAddress")),
                Ensure.that(contents).contains(list.get(0).get("paymentInformation"))
        );
    }

    @And("Verify approved Inbound Inventory in Vendor email")
    public static void verify_email_approved_inbound(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());
        String num = "";
        String region = "Thank you for submitting your inbound inventory form -- your inbound is approved and we look forward to receiving it soon in " + list.get(0).get("region");
        if (list.get(0).get("number").isEmpty()) {
            num = "Your Inbound Reference #" + Serenity.sessionVariableCalled("Inventory_Reference").toString() + " must be included on your inbound shipment documents, including the BOL, and your carrier must reference this # when making a delivery appointment.";
        } else
            num = "Your Inbound Reference #" + list.get(0).get("number") + " must be included on your inbound shipment documents, including the BOL, and your carrier must reference this # when making a delivery appointment.";
        theActorInTheSpotlight().should(
                seeThat("check content of email", CommonQuestions.AskForContainValue(contents, num, region))
        );
    }

    @And("Verify approved Inbound Inventory in LP email")
    public static void verify_email_approved_inbound_lp(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("New Inbound " + list.get(0).get("brand") + " - ETA " + CommonHandle.setDate2(list.get(0).get("eta"), "MM/dd/yy"))).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("A new inbound warehouse packing list has been pushed to your dashboard as attached.")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Click the button below to view it in detail.")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Reply to this email if you have any questions.")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Packing List")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Pod Foods Inventory")).isDisplayed()
        );
    }

    @And("Verify submitted withdrawal Inventory email")
    public static void verify_email_submitted_withdrawal(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> map = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Withdrawal Request Number"), "create by api");
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT(map.get("number") + " - Approval Needed for New Inventory Withdrawal Request")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("New inventory withdrawal request submitted as below.")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Withdrawal Number:")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT(map.get("number"))).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT(map.get("brand"))).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT(map.get("region"))).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Link:")).isDisplayed()
        );
    }

    @And("Verify approved withdrawal Inventory email to LP")
    public static void verify_email_submitted_withdrawal_lp(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> map = CommonTask.setValue(list.get(0), "number", list.get(0).get("number"), Serenity.sessionVariableCalled("Withdrawal Request Number"), "create by api");
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Inventory Withdrawal " + map.get("number"))).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Hi, " + map.get("name"))).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("A new inventory withdrawal request has been pushed to your dashboard.")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("Click the button below to view it in detail.")).isDisplayed(),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT("The Pod Foods Team")).isDisplayed(),
                Click.on(LoginGmailPage.EMAIL_CONTENT("View Request")),
                WindowTask.threadSleep(2000)
        );
    }

    @And("Verify arrived Inbound Inventory in Vendor email of Region {string}")
    public static void verify_email_arrived_inbound(String region) {
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());
        String text = "Great news! Your inbound shipment to our " + region + " distribution center has arrived.";
        theActorInTheSpotlight().should(
                seeThat("check content of email", CommonQuestions.AskForContainValue(contents, text))
        );
    }

    @And("Verify content Inbound Inventory in Vendor email of Region {string}")
    public static void verify_content_email_inbound(String region) {
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());
        String text = "Replenish inventory in " + region + " to avoid going out of stock.";
        theActorInTheSpotlight().should(
                seeThat("check content of email", CommonQuestions.AskForContainValue(contents, text))
        );
    }

    @And("Verify email new inbound inventory of user inventory with vendor company {string} in region {string}")
    public static void verify_email_user_inventory(String vendor, String region) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2), containsString(vendor + " submitted a new inbound inventory form for " + region))
        );
    }

    @And("User verify in in email paid")
    public static void verify_email_paid(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());

        theActorInTheSpotlight().should(
                seeThat("Check content of email buyerFromStorePlaceOrder", CommonQuestions.AskForContainValue(contents, list.get(0).get("buyerFromStorePlaceOrder"))),
                seeThat("Check content of email buyerFromStorePlaceOrder", CommonQuestions.AskForContainValue(contents, list.get(0).get("message")))
        );
    }

    @And("User verify email inventory")
    public static void verify_email_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat("Check content of email ", CommonQuestions.isControlDisplay(CommonVendorPage.DYNAMIC_P_ALERT(list.get(0).get("lp")))),
                seeThat("Check content of email ", CommonQuestions.targetText(LoginGmailPage.D_MAIL_INVENTORY("Region")), containsString(list.get(0).get("region"))),
                seeThat("Check content of email ", CommonQuestions.targetText(LoginGmailPage.D_MAIL_INVENTORY("Brand")), containsString(list.get(0).get("brand"))),
                seeThat("Check content of email ", CommonQuestions.targetText(LoginGmailPage.D_MAIL_INVENTORY("Product")), containsString(list.get(0).get("product"))),
                seeThat("Check content of email ", CommonQuestions.targetText(LoginGmailPage.D_MAIL_INVENTORY("SKU")), containsString(list.get(0).get("sku"))),
                seeThat("Check content of email ", CommonQuestions.targetText(LoginGmailPage.D_MAIL_INVENTORY("Lot code")), containsString(list.get(0).get("lotCode"))),
                seeThat("Check content of email ", CommonQuestions.targetText(LoginGmailPage.D_MAIL_INVENTORY("Original Q'ty")), containsString(list.get(0).get("qty"))),
                seeThat("Check content of email ", CommonQuestions.targetText(LoginGmailPage.D_MAIL_INVENTORY("Receiving date")), containsString(CommonHandle.setDate2(list.get(0).get("receivingDate"), "MM/dd/yyyy") + " " + list.get(0).get("time"))),
                seeThat("Check content of email ", CommonQuestions.targetText(LoginGmailPage.D_MAIL_INVENTORY("Expiry date")), containsString(CommonHandle.setDate2(list.get(0).get("expiryDate"), "MM/dd/yyyy") + " " + list.get(0).get("time")))
        );
    }

    @And("Verify email sample request")
    public static void verify_email_sample(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String contents = CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT2).answeredBy(theActorInTheSpotlight());

        theActorInTheSpotlight().should(
                seeThat("Check title of ", CommonQuestions.AskForContainValue(contents, list.get(0).get("title"))),
                seeThat("Check requestNum of email", CommonQuestions.AskForContainValue(contents, list.get(0).get("requestNum").isEmpty() ? list.get(0).get("requestNum") : list.get(0).get("requestNum") + Serenity.sessionVariableCalled("Number sample request").toString().replaceAll("#", ""))),
                seeThat("requestDate", CommonQuestions.AskForContainValue(contents, list.get(0).get("requestDate").isEmpty() ? list.get(0).get("requestDate") : Serenity.sessionVariableCalled("Sample Request Time").toString() + " " + list.get(0).get("requestDate"))),
                seeThat("buyer", CommonQuestions.AskForContainValue(contents, list.get(0).get("buyer"))),
                seeThat("managed", CommonQuestions.AskForContainValue(contents, list.get(0).get("managed"))),
                seeThat("details", CommonQuestions.AskForContainValue(contents, list.get(0).get("details"))),
                seeThat("customInformation", CommonQuestions.AskForContainValue(contents, list.get(0).get("customInformation")))
        );
    }

    @And("{word} search email with value {string}")
    public static void search_email_with_value(String actor, String sender) {
        if (sender.equals("Payment confirmation")) {
            String idOrder = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
            sender = sender + idOrder;
        }
        if (sender.equals("will be fulfilled when your inventory is received")) {
            String idOrder = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
            sender = "Order " + idOrder + idOrder.substring(5);
        }
        if (sender.equals("ID Invoice")) {
            String idOrder = Serenity.sessionVariableCalled("ID Invoice");
            sender = idOrder.substring(7);
        }
        if (sender.equals("ID Invoice")) {
            String idOrder = Serenity.sessionVariableCalled("ID Invoice");
            sender = idOrder.substring(7);
        }
        if (sender.equals("lp inventory lotcode")) {
            sender = Serenity.sessionVariableCalled("Lot Code");
        }
        if (sender.equals("sample request")) {
            sender = Serenity.sessionVariableCalled("Number sample request");
        }
        if (sender.equals("sample request api")) {
            sender = Serenity.sessionVariableCalled("Number of Sample api");
        }
        theActorCalled(actor).attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(LoginGmailPage.SEARCH_BOX)).andIfSo(
                        Clear.field(LoginGmailPage.SEARCH_BOX),
                        Enter.theValue(sender).into(LoginGmailPage.SEARCH_BOX).thenHit(Keys.ENTER)
                )
        );
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @And("verify info email payment confirmation")
    public static void verify_email_payment_confirmation(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String id = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line1") + id)),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line2") + id)),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("shippingAddress")))
        );
    }

    @And("verify order detail of payment confirmation")
    public static void verify_email_order_detail_payment_confirmation(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("brand")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("sku")),
                Ensure.that(PaymentConfirmationPage.D_PRICE("Subtotal")).text().contains(list.get(0).get("subtotal")),
                Ensure.that(PaymentConfirmationPage.D_PRICE("Bottle Deposit")).text().contains(list.get(0).get("bottelDeposit")),
                Ensure.that(PaymentConfirmationPage.D_PRICE("Discount")).text().contains(list.get(0).get("discount")),
                Check.whether(list.get(0).get("sos").equals(""))
                        .otherwise(
                                Ensure.that(PaymentConfirmationPage.D_PRICE("Small order surcharge")).text().contains(list.get(0).get("sos"))
                        ),
                Check.whether(list.get(0).get("sos").equals(""))
                        .otherwise(
                                Ensure.that(PaymentConfirmationPage.D_PRICE("Logistics surcharge")).text().contains(list.get(0).get("ls"))
                        ),
                Ensure.that(PaymentConfirmationPage.D_PRICE("Special discount")).text().contains(list.get(0).get("specialDiscount")),
                Ensure.that(PaymentConfirmationPage.PRICE_TOTAL).text().contains(list.get(0).get("total"))
        );
    }

    @And("verify info email order fulfilled")
    public static void verify_email_order_fulfilled(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line1"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line2")))
        );
    }

    @And("verify info order detail in fulfilled")
    public static void verify_email_order_detail_in_fulfilled(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String id = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line1") + id)),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line2") + id)),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("shippingAddress")))
        );
    }

    @And("Verify info email Financial Pending")
    public static void verify_email_order_financial_pending(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String idOrder = Serenity.sessionVariableCalled("ID Invoice");
        idOrder = idOrder.substring(7);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line1"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line2") + idOrder))
        );
    }

    @And("Verify info brand referral")
    public static void verify_email_brand_referral(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> list1 : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleEmail.search(list1.get("title") + " " + list1.get("brand")),
                    HandleEmail.goToDetailFirstEmail(),
                    // verify info
                    CommonWaitUntil.isVisible(GmailDetailPage.BRAND_REFERRAL_CONTENT(list1.get("line1"))),
                    Ensure.that(GmailDetailPage.BRAND_REFERRAL_CONTENT(list1.get("line1"))).text().contains(list1.get("line1")),
                    HandleEmail.goToInbox()
            );
        }

    }

    @And("QA verify info email ETA of order")
    public static void verify_email_eta_of_order(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line1") + " " + Serenity.sessionVariableCalled("ID Order").toString())),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line2"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(CommonHandle.setDate2(list.get(0).get("date"), "MM/dd/yyyy"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("timeZone"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Pod Foods supports brands of all stages, and as a result some items may have longer lead times than others and may take longer to arrive at our warehouse.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("To ensure freshness and get your order to you as fast as possible, in some cases your order may be broken up into separate deliveries.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("You can always find up-to-date ETAs of all your ordered items in the order's details in your Pod Foods Dashboard.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Please don't hesitate to reply to this email if you have any questions.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Sincerely,The Pod Foods"))
        );
    }

    @And("QA verify info email new purchase order received of drop")
    public static void verify_email_new_purchase_order_received(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String dropNumber = Serenity.sessionVariableCalled("Drop Number" + list.get(0).get("store"));
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("line1"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Date" + CommonHandle.setDate2(list.get(0).get("date"), "MM/dd/yyyy"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(dropNumber)),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("timeZone"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Store" + list.get(0).get("store"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Please reply directly to this email if you have any questions.Sincerely,The Pod Foods"))
        );
    }

    @And("QA verify info email order detail")
    public static void verify_email_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(list.get(0));
        if (list.get(0).get("order").equals("create by api")) {
            info = CommonTask.setValue(list.get(0), "order", list.get(0).get("order"), Serenity.sessionVariableCalled("ID Order"), "create by api");
        }

        if (list.get(0).get("order").equals("create by admin")) {
            info = CommonTask.setValue(list.get(0), "order", list.get(0).get("order"), Serenity.sessionVariableCalled("ID Order"), "create by admin");
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("store"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Order Number" + info.get("order"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(CommonHandle.setDate2(list.get(0).get("date"), "dd LLL yyyy"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("timeZone"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("buyer"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("brand"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("sku"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("price"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("quantity"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("total"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Your order is confirmed and will be delivered straight away!")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("You may view and export details about this order and more from your dashboard")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Thank you for your business.Sincerely,The Pod Foods Team"))
        );
    }

    @And("QA verify info email order detail for buyer")
    public static void verify_email_order_detail_for_buyer(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(list.get(0));
        if (list.get(0).get("order").equals("create by admin")) {
            info = CommonTask.setValue(list.get(0), "order", list.get(0).get("order"), Serenity.sessionVariableCalled("ID Order"), "create by admin");
        }
        if (list.get(0).get("order").equals("create by api")) {
            info = CommonTask.setValue(list.get(0), "order", list.get(0).get("order"), Serenity.sessionVariableCalled("ID Order"), "create by api");
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Thank you for your order with Pod Foods!")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Order Number" + info.get("order"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(CommonHandle.setDate2(list.get(0).get("date"), "dd LLL yyyy"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("timeZone"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Buyer" + list.get(0).get("buyer"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("You can expect your order to be delivered within 3-5 days. You can always find up-to-date ETAs and your order details in your Pod Foods Dashboard")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Please reply to this email or reach out to your Pod Foods Rep if you have any questions about your order.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Note: This is not an invoice.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Pod Express - These items will be consolidated and delivered to you from our warehouses and you will receive a paper invoice at receiving.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("brand"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("sku"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("upc"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("price"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("quantity"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("total")))
        );
    }

    @And("QA verify info email create brand")
    public static void verify_email_create_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Hi Pod Foods,")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("A new brand has been added from " + list.get(0).get("vendor"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("brand"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Please login to review."))
        );
    }

    @And("QA verify info email create product")
    public static void verify_email_create_product(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Hi Pod Foods,")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("A new product has been added from " + list.get(0).get("vendor"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("brand"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("product"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Please login to review."))
        );
    }

    @And("QA verify info email order paid as stripe success")
    public static void verify_email_order_paid_as_stripe_success(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Hi " + list.get(0).get("vendor"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("We have processed payment for your orders.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("You should see the payment in your bank account in 3-4 days.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Please login to your Dashboard and click on <Finances>, <Monthly Statements> to see your monthly statement for more information.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("If you have any questions, feel free to email payments@podfoods.co"))
        );
    }

    @And("QA expand all email")
    public static void expand_all_email() {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(valueOf(LoginGmailPage.EXPAND_ALL_EMAIL), isNotVisible())
                        .andIfSo(Click.on(LoginGmailPage.EXPAND_ALL_EMAIL))
        );
    }

    @And("QA verify info email order detail for admin")
    public static void verify_email_order_detail_for_admin(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(list.get(0));
        if (list.get(0).get("order").equals("create by admin")) {
            info = CommonTask.setValue(list.get(0), "order", list.get(0).get("order"), Serenity.sessionVariableCalled("ID Order"), "create by admin");
        }
        if (list.get(0).get("order").equals("create by api")) {
            info = CommonTask.setValue(list.get(0), "order", list.get(0).get("order"), Serenity.sessionVariableCalled("ID Order"), "create by api");
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("name"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("New Order Received!")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("buyer") + " from " + list.get(0).get("store") + " placed a new order.")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Order Summary")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Order Number" + info.get("order"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(CommonHandle.setDate2(list.get(0).get("date"), "dd LLL yyyy"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("timeZone"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Buyer" + list.get(0).get("buyer"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Managed by" + list.get(0).get("managedBy"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Order Details")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("brand"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("sku"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("price"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("quantity"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString(list.get(0).get("total"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Order value" + list.get(0).get("orderValue"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Discount" + list.get(0).get("discount"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Subtotal" + list.get(0).get("subTotal"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Small order surcharge" + list.get(0).get("sos"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Bottle Deposit" + list.get(0).get("bottle"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Special discount" + list.get(0).get("specialDiscount"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Total" + list.get(0).get("totalOrder"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Customer Information")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Shipping address" + list.get(0).get("address"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))), containsString("Shipping address" + list.get(0).get("paymentInfo")))


        );
    }

    @And("QA verify info email order detail of pod direct item")
    public static void verify_email_order_detail_of_pd(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(list.get(0));
        if (list.get(0).get("order").equals("create by api")) {
            info = CommonTask.setValue(list.get(0), "order", list.get(0).get("order"), Serenity.sessionVariableCalled("ID Order"), "create by api");
        }

        if (list.get(0).get("order").equals("create by admin")) {
            info = CommonTask.setValue(list.get(0), "order", list.get(0).get("order"), Serenity.sessionVariableCalled("ID Order"), "create by admin");
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi!"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Congrats on your Pod Direct order from " + list.get(0).get("store")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Please confirm order " + info.get("order") + " in your dashboard and ship it out ASAP."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Pod Direct fulfillment instructions may be found on the POD DIRECT section of our Brand Guide"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Please reach out to orders@podfoods.co for help or to report fulfillment issues."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Click here to login ASAP to confirm your order"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Order Number" + info.get("order")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(CommonHandle.setDate2(list.get(0).get("date"), "dd LLL yyyy")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Buyer" + info.get("buyer")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("timeZone")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("brand")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("sku")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("price")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("quantity")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("total")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Thank you.")
        );
    }

    @And("QA verify info email sample request detail for buyer")
    public static void verify_email_sample_request_detail_for_buyer(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi !"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("You’ve received a sample request from " + list.get(0).get("buyerCompany")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("The store is interested in sampling the following:"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("SAMPLE REQUEST DETAILS"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("product")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("sku")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Please send at least one retail unit (no need to send full cases!), ensuring the buyer is able to sample all requested SKUs."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Click the button below to begin fulfillment of this sample request."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("If you’re unable to fulfill this request, please click the button above and follow the steps to cancel the request."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("You’ll find sampling best practices on the SAMPLES section of our Brand Guide."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Thank you,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Pod Foods Vendor Success")
        );
    }

    @And("QA verify info email sample request detail for admin")
    public static void verify_email_sample_request_detail_for_admin(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi Pod Foods Co,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("New sample request received!"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("headBuyer") + " from " + list.get(0).get("buyerCompany") + " placed a new sample request."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("SAMPLE REQUEST SUMMARY"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Request Number " + Serenity.sessionVariableCalled("Sample request number")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Buyer " + list.get(0).get("buyer")),
                Check.whether(list.get(0).get("managedBy").isEmpty())
                        .otherwise(Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Managed by " + list.get(0).get("managedBy"))),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("SAMPLE REQUEST DETAILS"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("product")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("sku")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("COMMENTS"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("comment")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("CUSTOMER INFORMATION"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Shipping address " + list.get(0).get("address"))

        );
    }

    @And("QA verify info email new inventory needed")
    public static void verify_email_new_inventory_needed(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Congratulations!"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("A new Pod Foods Inventory Request(s) has been sent to your Vendor Dashboard."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Please log in and confirm a replenishment within 7 days."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("As a reminder, your new inventory must arrive at our warehouse within 21 days, or your product risks being OOS.")
        );
    }

    @And("QA verify info email inbound submit")
    public static void verify_email_inbound_submit() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("A new inbound warehouse packing list has been pushed to your dashboard as attached."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Click the button below to view it in detail."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Reply to this email if you have any questions.")
        );
    }

    @And("QA verify info email inbound process")
    public static void verify_email_inbound_process() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("The following inbound inventory is processed and ready for retail:"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(Serenity.sessionVariableCalled("Number Inbound Inventory api"))

        );
    }

    @And("QA verify info email inbound upload WPL")
    public static void verify_email_inbound_upload_wpl(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi, a signed WPL has been uploaded as below"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("LP : " + list.get(0).get("lp")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Vendor : " + list.get(0).get("vendorCompany")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Inbound Inventory no. : " + Serenity.sessionVariableCalled("Number Inbound Inventory api").toString())
        );
    }

    @And("QA verify info email admin-initiated-inbound-inventory-confirmed")
    public static void verify_email_admin_initiated_inbound_inventory_confirmed(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("brand") + " has reviewed admin-initiated replenishment request to New York Express and confirmed inbound inventory details.")
        );
    }

    @And("QA verify info email upload inbound pod")
    public static void verify_email_upload_inbound_pod() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("A POD has been uploaded for the inbound inventory"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(Serenity.sessionVariableCalled("Number Inbound Inventory api").toString())
        );
    }

    @And("QA verify info email vendor invite colleagues")
    public static void verify_email_vendor_invite_colleagues(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi, AT"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("vendor") + " invited you to join AT Vendor Order's Pod Foods account."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Click below to create your Pod Foods account:")
        );
    }

    @And("QA verify info email buyer invite colleagues")
    public static void verify_email_buyer_invite_colleagues(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi, auto"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("buyer") + " invited you to join ngoc cpn1's Pod Foods account."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Click below to create your Pod Foods account:")
        );
    }

    @And("QA verify info email credit limit exceeded")
    public static void verify_email_credit_limit_exceeded(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("The order below is pending with the credit limit exceeded."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Please check with the buyer and finance team to resolve this issue"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Buyer company : " + list.get(0).get("buyerCompany")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Store name : " + list.get(0).get("store")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Buyer email : " + list.get(0).get("emailBuyer"))
        );
    }

    @And("QA show trimmed content of email")
    public static void show_trimmed_content_of_email() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LoginGmailPage.SHOW_TRIMMED_CONTENT),
                Scroll.to(LoginGmailPage.SHOW_TRIMMED_CONTENT),
                Click.on(LoginGmailPage.SHOW_TRIMMED_CONTENT),
                WindowTask.threadSleep(2000)
        );
    }

    @And("QA verify info email vendor create withdrawal request")
    public static void verify_email_vendor_create_withdrawal_request(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("New inventory withdrawal request submitted as below."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(Serenity.sessionVariableCalled("Withdrawal Request Number")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Brand:" + list.get(0).get("brand")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Region:" + list.get(0).get("region"))
        );
    }

    @And("QA verify info email admin approve request")
    public static void verify_email_admin_approve_request() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi, Bao North cali"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Your inventory withdrawal request has been approved."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Our Inventory team will follow up with you shortly to provide your confirmed appointment date and time."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Please await confirmation."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("If you have any questions, please do not hesitate to contact us at inventory@podfoods.co")
        );
    }

    @And("QA verify info email vendor-inventory-withdrawal-time-update")
    public static void verify_email_vendor_inventory_withdrawal_time_update(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("We have updated the pickup appointment for your withdrawal request"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(Serenity.sessionVariableCalled("Withdrawal Request Number")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Pickup Date : " + CommonHandle.setDate2(list.get(0).get("pickupDate"), "yyyy-MM-dd")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Pickup Date : " + list.get(0).get("pickupTime"))
        );
    }

    @And("QA verify info email admin-inventory-withdrawal-completed")
    public static void verify_email_vendor_inventory_withdrawal_time_update() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Inventory withdrawal request completed."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("If you have any questions, please do not hesitate to contact us at inventory@podfoods.co")
        );
    }

    @And("QA verify info email password changed")
    public static void verify_email_password_changed(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Hello "),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains(list.get(0).get("mail")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("We're contacting you to notify you that your password has been changed.")
        );
    }

    @And("QA verify info email changed")
    public static void verify_email_changed(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Hello "),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains(list.get(0).get("vendor")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("We're contacting you to notify you that your email has been changed to " + list.get(0).get("vendorEdit"))
        );
    }

    @And("QA verify info email reset password")
    public static void verify_email_reset_password(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Hello"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains(list.get(0).get("email")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Someone has requested to change your password."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Please click the button below to change your password now."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("For security reasons, this link will expire after your first visit."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("If you did not make this request, please ignore this email or reply directly to this email if you have any questions.")
        );
    }

    @And("QA verify info email admin create store")
    public static void verify_email_admin_create_store(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("A new store has been added by " + list.get(0).get("email")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Name: " + list.get(0).get("store")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Buyer company: " + list.get(0).get("buyerCompany")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Region: " + list.get(0).get("region")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Address " + list.get(0).get("address")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Managed by: " + list.get(0).get("managedBy")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Launched by: " + list.get(0).get("launchedBy")),
                Check.whether(list.get(0).get("allPossibleDeliveryDays").isEmpty())
                        .otherwise(Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("All possible delivery days: " + list.get(0).get("allPossibleDeliveryDays"))),
                Check.whether(list.get(0).get("setDeliveryDays").isEmpty())
                        .otherwise(Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Set delivery weekdays: " + list.get(0).get("setDeliveryDays"))),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Receiving times: " + list.get(0).get("receivingTimes")),
                Check.whether(list.get(0).get("receivingNote").isEmpty())
                        .otherwise(Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Receiving Note: " + list.get(0).get("receivingNote"))),
                Check.whether(list.get(0).get("receivingNote").isEmpty())
                        .otherwise(Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("AP email: " + list.get(0).get("apEmail"))),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Small order surcharge: " + list.get(0).get("sos"))
        );
    }

    @And("QA verify info email lp create new inventory")
    public static void verify_email_lp_create_new_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Hi Pod Foods,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains(list.get(0).get("lp") + " received and added the inventory below in Admin,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Region " + list.get(0).get("region")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Brand " + list.get(0).get("brand")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Product " + list.get(0).get("product")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("SKU " + list.get(0).get("sku")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Lot code " + list.get(0).get("lotCode")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Original Q'ty " + list.get(0).get("quantity")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Receiving date " + CommonHandle.setDate2(list.get(0).get("receivingDate"), "MM/dd/yyyy")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Expiry date " + CommonHandle.setDate2(list.get(0).get("expiryDate"), "MM/dd/yyyy")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Please reply directly to this email if you have any questions.")
        );
    }

    @And("QA verify info email new credit note")
    public static void verify_email_email_new_credit_note(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Please find a credit note issued as attached. In order to use this credit, you are required to add the credit number to the list of invoices you would like to pay and subtract its amount from the balance due."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("If your payment method is by credit card, your credit card on file will be refunded the credit amount after you have sent us a notification containing the credit memo number."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("You can also login to your dashboard and click on <Credit Memos> to see your credit note for more information or click the button below."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT1(list.get(0).get("email"))).text().contains("Do not hesitate to contact us if you have any questions: payments@podfoods.co")
        );
    }

    @And("QA verify info email sample request cancel")
    public static void verify_email_sample_request_cancel() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi Auto,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Please be informed that the sample request " + Serenity.sessionVariableCalled("Number of Sample api").toString() + " has been canceled by the vendor. You can learn more about this by clicking the button below.")
        );
    }

    @And("QA verify info email new purchase request")
    public static void verify_email_new_purchase_request(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Hi Pod Foods,")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("A new purchase request number")),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString(list.get(0).get("email"))),
                seeThat(CommonQuestions.targetText(LoginGmailPage.EMAIL_CONTENT), containsString("Please login to review."))
        );
    }

    @And("QA verify info email vendor statement payments failed")
    public static void verify_email_vendor_statement_payments_failed(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Please find below the list of vendor companies Stripe failed to pay out"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("vendorCompany")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("message"))
        );
    }

    @And("QA verify info email lp upload pod")
    public static void verify_email_lp_upload_pod(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi, a POD has been uploaded as below"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("LP : " + list.get(0).get("lp")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Store : " + list.get(0).get("store")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Order no : " + Serenity.sessionVariableCalled("ID Order"))
        );
    }

    @And("QA verify info email lp document expired")
    public static void verify_email_lp_document_expired(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("The document for " + list.get(0).get("lpCompany") + " has expired as below."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("LP company : " + list.get(0).get("lpCompany")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Name : " + list.get(0).get("documentName"))
        );
    }

    @And("QA verify info email brand referred")
    public static void verify_email_brand_referred(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi, the store below referred a brand"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Store : " + list.get(0).get("store")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("brand")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Currently working"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("with the store?")
        );
    }

    @And("QA verify info email admin-store-refers-brand")
    public static void verify_email_admin_store_refers_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("The referred vendor has been onboarded as below"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Referring Store : " + list.get(0).get("store")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("brand"))
        );
    }

    @And("QA verify info email vendor-store-refers-brand")
    public static void verify_email_vendor_store_refers_brand(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(list.get(0).get("store") + "just reached out to us letting us know they would like to order your product from Pod Foods."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Providing both consolidated and direct distribution to retail, brands like yours use Pod Foods every day as the fully-operational wholesale arm of their business nationwide."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Register here or learn more on our website. Looking forward to working with you!")

        );
    }

    @And("QA verify info email create new ghost order")
    public static void verify_email_create_new_ghost_order() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("A new ghost order has been placed! As this is not a regular order, we will notify you when this ghost order is converted into a regular one.")
        );
    }

    @And("QA verify info email convert ghost order")
    public static void verify_email_convert_ghost_order() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("A ghost order has been converted into a regular order!")
        );
    }

    @And("QA verify info email new retail claim received")
    public static void verify_email_new_retail_claim_received(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Your claim has been received."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Reference Number : " + Serenity.sessionVariableCalled("Claim ID")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Issue : " + list.get(0).get("issue")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Our team will be in touch soon.")
        );
        if (list.get(0).containsKey("order")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Invoice Number : " + Serenity.sessionVariableCalled("Number Order API")),
                    Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Descriptions : " + list.get(0).get("description"))
            );
        }
    }

    @And("QA verify info email new qa retail claim received")
    public static void verify_email_new_qa_retail_claim_received(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("A new vendor claim has been received."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Claim # : " + Serenity.sessionVariableCalled("Claim ID")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Vendor company : " + list.get(0).get("vendorCompany")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Brand : " + list.get(0).get("brand")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Vendor email : " + list.get(0).get("vendorEmail")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Issue : " + list.get(0).get("issue")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Issue description : " + list.get(0).get("issueDescription"))
        );
    }

    @And("QA verify info email vendor-donation-disposal-approved")
    public static void verify_email_vendor_donation_disposal_approved() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Your inventory donation/disposal request has been approved."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("View Request")
        );
    }

    @And("QA verify info email admin-donation-disposal-approved")
    public static void verify_email_admin_donation_disposal_approved() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("A new inventory donation/disposal request has been submitted."),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("View Request")
        );
    }

    @And("QA verify info email LP-disposal-request-approved")
    public static void verify_email_lp_donation_disposal_approved(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Please coordinate disposal for all remaining cases of the following lot(s) you have on hand. Here is what we currently show as available in our system:"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(infos.get(0).get("region")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(infos.get(0).get("brand")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(infos.get(0).get("product")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(infos.get(0).get("sku")),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(infos.get(0).get("itemCode")),
                Check.whether(infos.get(0).get("expiryDate").isEmpty())
                        .otherwise(Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(Serenity.sessionVariableCalled("Lot Code").toString())),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(infos.get(0).get("quantity")),
                Check.whether(infos.get(0).get("expiryDate").isEmpty())
                        .otherwise(Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains(infos.get(0).get("expiryDate")))
        );
    }

    @And("QA verify info email vendor-donation-disposal-complete")
    public static void verify_email_vendor_donation_disposal_complete() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Hi,"),
                Ensure.that(LoginGmailPage.EMAIL_CONTENT).text().contains("Your inventory donation/disposal request has been donated or disposed per request.")
        );
    }
}
