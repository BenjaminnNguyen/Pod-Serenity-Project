package cucumber.tasks.common;

import cucumber.models.User;
import cucumber.models.api.SignIn;
import cucumber.singleton.GVs;
import cucumber.singleton.user.PodFood;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.HomePageForm;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.*;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.targets.Target;
import net.serenitybdd.screenplay.ui.Link;
import net.thucydides.core.webdriver.ThucydidesWebDriverSupport;
import net.thucydides.core.webdriver.WebDriverFacade;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;

import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.List;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class CommonTask {
    /**
     * Upload file bằng robot
     *
     * @param path
     * @throws Exception
     */
    public static void uploadFile(String path) throws Exception {
        String root = System.getProperty("user.dir");
        String otherFolder = root + path;
        Robot robot = new Robot();
        StringSelection stringSelection = new StringSelection(otherFolder);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
        robot.setAutoDelay(1000);
        //native key strokes for CTRL, V and ENTER keys
        robot.keyPress(KeyEvent.VK_CONTROL);
        robot.keyPress(KeyEvent.VK_V);

        robot.keyRelease(KeyEvent.VK_CONTROL);
        robot.keyRelease(KeyEvent.VK_V);

        robot.setAutoDelay(1000);

        robot.keyPress(KeyEvent.VK_ENTER);
        robot.keyRelease(KeyEvent.VK_ENTER);
    }

    public static User setUser(String email, String pass) {
        return new User(email, pass);
    }

    public static User getUser(String name) {
        User user = null;
        SignIn signIn = null;
        GVs.AccountType actor = GVs.AccountType.valueOf(name.toUpperCase());
        switch (actor) {
            case THUYEXAM:
                user = PodFood.thuyExam();
                break;
            case ADMIN:
                user = PodFood.admin();
                break;
            case BAO_ADMIN:
                user = PodFood.baoAdmin();
                break;
            case BAO_ADMIN2:
                user = PodFood.baoAdmin2();
                break;
            case BAO_ADMIN3:
                user = PodFood.baoAdmin3();
                break;
            case BAO_ADMIN4:
                user = PodFood.baoAdmin4();
                break;
            case BAO_ADMIN5:
                user = PodFood.baoAdmin5();
                break;
            case BAO_ADMIN6:
                user = PodFood.baoAdmin6();
                break;
            case BAO_ADMIN7:
                user = PodFood.baoAdmin7();
                break;
            case BAO_ADMIN8:
                user = PodFood.baoAdmin8();
                break;
            case BAO_ADMIN9:
                user = PodFood.baoAdmin9();
                break;
            case BAO_ADMIN10:
                user = PodFood.baoAdmin10();
                break;
            case BAO_ADMIN11:
                user = PodFood.baoAdmin11();
                break;
            case BAO_ADMIN12:
                user = PodFood.baoAdmin12();
                break;
            case BAO_ADMIN13:
                user = PodFood.baoAdmin13();
                break;
            case BAO_ADMIN14:
                user = PodFood.baoAdmin14();
                break;
            case BAO_ADMIN15:
                user = PodFood.baoAdmin15();
                break;
            case BAO_ADMIN16:
                user = PodFood.baoAdmin16();
                break;
            case BAO_ADMIN17:
                user = PodFood.baoAdmin17();
                break;
            case BAO_ADMIN18:
                user = PodFood.baoAdmin18();
                break;
            case BAO_ADMIN19:
                user = PodFood.baoAdmin19();
                break;
            case BAO_ADMIN20:
                user = PodFood.baoAdmin20();
                break;
            case BAO_ADMIN21:
                user = PodFood.baoAdmin21();
                break;
            case BAO_ADMIN22:
                user = PodFood.baoAdmin22();
                break;
            case BAO_ADMIN23:
                user = PodFood.baoAdmin23();
                break;
            case BAO_ADMIN24:
                user = PodFood.baoAdmin24();
                break;
            case BAO_ADMIN25:
                user = PodFood.baoAdmin25();
                break;
            case BAO_ADMIN26:
                user = PodFood.baoAdmin26();
                break;
            case BAO_ADMIN27:
                user = PodFood.baoAdmin27();
                break;
            case BAO_ADMIN28:
                user = PodFood.baoAdmin28();
                break;
            case BAO_ADMIN29:
                user = PodFood.baoAdmin29();
                break;
            case BAO_ADMIN30:
                user = PodFood.baoAdmin30();
                break;
            case NGOC_ADMIN:
                user = PodFood.ngocAdmin();
                break;
            case NGOC_ADMIN_01:
                user = PodFood.ngocAdmin01();
                break;
            case NGOC_ADMIN_02:
                user = PodFood.ngocAdmin02();
                break;
            case NGOC_ADMIN_03:
                user = PodFood.ngocAdmin03();
                break;
            case NGOC_ADMIN_04:
                user = PodFood.ngocAdmin04();
                break;
            case NGOC_ADMIN_05:
            case NGOC_ADMIN_05A:
                user = PodFood.ngocAdmin05();
                break;
            case NGOC_ADMIN_06:
                user = PodFood.ngocAdmin06();
                break;
            case NGOC_ADMIN_07:
                user = PodFood.ngocAdmin07();
                break;
            case NGOC_ADMIN_08:
                user = PodFood.ngocAdmin08();
                break;
            case NGOC_ADMIN_09:
                user = PodFood.ngocAdmin09();
                break;
            case NGOC_ADMIN_10:
                user = PodFood.ngocAdmin10();
                break;
            case NGOC_ADMIN_11:
                user = PodFood.ngocAdmin11();
                break;
            case NGOC_ADMIN_12:
                user = PodFood.ngocAdmin12();
                break;
            case NGOC_ADMIN_13:
                user = PodFood.ngocAdmin13();
                break;
            case NGOC_ADMIN_14:
                user = PodFood.ngocAdmin14();
                break;
            case NGOC_ADMIN_15:
                user = PodFood.ngocAdmin15();
                break;
            case NGOC_ADMIN_16:
                user = PodFood.ngocAdmin16();
                break;
            case NGOC_ADMIN_17:
                user = PodFood.ngocAdmin17();
                break;
            case NGOC_ADMIN_18:
                user = PodFood.ngocAdmin18();
                break;
            case NGOC_ADMIN_19:
                user = PodFood.ngocAdmin19();
                break;
            case NGOC_ADMIN_20:
                user = PodFood.ngocAdmin20();
                break;
            case NGOC_ADMIN_21:
                user = PodFood.ngocAdmin21();
                break;
            case NGOC_ADMIN_22:
                user = PodFood.ngocAdmin22();
                break;
            case NGOC_ADMIN_23:
                user = PodFood.ngocAdmin23();
                break;
            case NGOC_ADMIN_24:
                user = PodFood.ngocAdmin24();
                break;
            case NGOC_ADMIN_25:
                user = PodFood.ngocAdmin25();
                break;
            case NGOC_BUYER_CHICAGO1:
                user = PodFood.ngocbuyerchicago1();
                break;
            case NGOC_BUYER_NY1:
                user = PodFood.ngocbuyerny1();
                break;
            case NGOC_SLACK:
                user = PodFood.ngoc_slack();
                break;
        }
        return user;
    }

    public static String formatAmountDisplay(String amount) {
        BigDecimal amountBigDecimal = amount == null || amount.length() == 0
                ? BigDecimal.ZERO : new BigDecimal(amount);
        return formatAmountDisplay(amountBigDecimal);
    }

    public static String formatAmountDisplay(BigDecimal amount) {
        NumberFormat nf = new DecimalFormat("###,###,###,###,###");
        return nf.format(amount);
    }

    public static void get_current_time() {
        //2021-03-23 16:45:00
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        LocalDateTime now = LocalDateTime.now();
        System.out.println("current Date and Time:: " + dtf.format(now));
        Serenity.setSessionVariable("Thời gian tạo giao dịch").to(dtf.format(now));
    }

    public static Task chooseItemInDropdown(Target parentTarget, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown",
                CommonWaitUntil.isClickable(parentTarget),
                Scroll.to(parentTarget),
                Click.on(parentTarget),
                CommonWaitUntil.isVisible(childTarget),
                Scroll.to(childTarget),
                Click.on(childTarget)
        );
    }

    public static Task chooseItemInDropdown1(Target parentTarget, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown",
                CommonWaitUntil.isClickable(parentTarget),
                Click.on(parentTarget),
                CommonWaitUntil.isVisible(childTarget),
                Click.on(childTarget).afterWaitingUntilEnabled()
        );
    }

    public static Task chooseItemInDropdown2(Target parentTarget, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown",
                CommonWaitUntil.isClickable(parentTarget),
                Click.on(parentTarget),
                Check.whether(valueOf(childTarget), isCurrentlyVisible())
                        .andIfSo(Click.on(childTarget))
                        .otherwise(JavaScriptClick.on(childTarget))
        );
    }

    public static Task clearFieldByKeyboard(Target parentTarget) {
        return Task.where("Chọn giá trị trong dropdown",
                CommonWaitUntil.isClickable(parentTarget),
                Click.on(parentTarget),
                Enter.theValue(Keys.chord(Keys.COMMAND, "a")).into(parentTarget).thenHit(Keys.DELETE)


        );
    }

    public static Performable clearFieldByJavaScript(Target target) {
        return new Performable() {
            @Override
            public <T extends Actor> void performAs(T t) {
                BrowseTheWeb.as(t).evaluateJavascript("arguments[0].value = \"\";", target.resolveFor(t));

            }
        };
    }


    public static Performable clearFieldByEnterKey(Target target) {
        return new Performable() {
            @Override
            public <T extends Actor> void performAs(T t) {
                t.attemptsTo(
                        Clear.field(target),
                        Enter.theValue("1").into(target).thenHit(Keys.BACK_SPACE),
                        Click.on(target)
                );
            }
        };
    }

    public static Task chooseItemInDropdown3(Target parentTarget, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown",
                CommonWaitUntil.isClickable(parentTarget),
                Click.on(parentTarget),
                WindowTask.threadSleep(500),
                JavaScriptClick.on(childTarget)
        );
    }

    public static Performable chooseItemInDropdown4(Target parentTarget, String... value) {
        return Task.where("Chọn giá trị trong dropdown",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isClickable(parentTarget),
                            Click.on(parentTarget)
                    );
                    for (String target : value) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(target)),
                                JavaScriptClick.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(target))
                        );
                    }
                }
        );
    }

    public static Task chooseItemInDropdownWithValueInput(Target parentTarget, String value, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown với giá trị nhập vào",
                Scroll.to(parentTarget),
                CommonWaitUntil.isEnabled(parentTarget),
                Click.on(parentTarget),
                Enter.theValue(value).into(parentTarget),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isVisible(childTarget),
                Scroll.to(childTarget),
                Click.on(childTarget).afterWaitingUntilEnabled()
        );
    }

    public static Task chooseItemInDropdownWithValueInput2(Target parentTarget, String value, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown với giá trị nhập vào",
                Scroll.to(parentTarget),
                CommonWaitUntil.isEnabled(parentTarget),
                Click.on(parentTarget),
                Enter.keyValues(value).into(parentTarget).then(
                        WindowTask.threadSleep(500)
                ),
                CommonWaitUntil.isVisible(childTarget),
                Click.on(childTarget)
        );
    }

    public static Task chooseItemInDropdownWithValueInput3(Target parentTarget, String value, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown với giá trị nhập vào",
                Scroll.to(parentTarget),
                CommonWaitUntil.isEnabled(parentTarget),
                Click.on(parentTarget),
                Enter.theValue(value).into(parentTarget),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isVisible(childTarget),
                Scroll.to(childTarget),
                JavaScriptClick.on(childTarget)
        );
    }

    public static Task chooseItemInDropdownWithValueInput1(Target parentTarget, String value, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown với giá trị nhập vào",
                CommonWaitUntil.isEnabled(parentTarget),
                Click.on(parentTarget),
                Enter.theValue(value).into(parentTarget),
                CommonWaitUntil.isVisible(childTarget),
                WindowTask.threadSleep(500),
                Click.on(childTarget)
        );
    }

    public static Task chooseItemInDropdownWithValueInput4(Target parentTarget, String value, Target childTarget) {
        return Task.where("Chọn giá trị trong dropdown với giá trị nhập vào",
                CommonWaitUntil.isEnabled(parentTarget),
                Click.on(parentTarget),
                Enter.theValue(value).into(parentTarget),
                CommonWaitUntil.isVisible(childTarget),
                WindowTask.threadSleep(1000),
                Click.on(childTarget)
        );
    }

    public static void HoverToElementUsingSelenium(String xpath) {
        WebDriver driver = ((WebDriverFacade) ThucydidesWebDriverSupport.getDriver()).getProxiedDriver();
        WebElement element = driver.findElement(By.xpath(xpath));
        Actions actions = new Actions(driver);
        actions.moveToElement(element).build().perform();
        actions.click();
    }

    public static Task ChooseValueFromSuggestions(String value) {
        String xpath = "(//ul/li//*[text()='%s'])[last()]";
        Target target = Target.the("").locatedBy(String.format(xpath, value));
        return Task.where("Choose Value From Suggestions",
                CommonWaitUntil.isVisible(target),
                Scroll.to(target),
                Click.on(target)
        );
    }

    public static Task ChooseValueFromSuggestionsWithJS(String value) {
        String xpath = "(//ul/li//*[text()='%s'])[last()]";
        return Task.where("Choose Value From Suggestions",
                CommonWaitUntil.isCurrentVisible(String.format(xpath, value)),
                JavaScriptClick.on(String.format(xpath, value))
        );
    }

    public static String getDateTimeString() {
        //khai báo đối tượng current thuộc class LocalDateTime
        LocalDateTime current = LocalDateTime.now();
        //sử dụng class DateTimeFormatter để định dạng ngày giờ theo kiểu pattern
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMddHHmmss");
        //sử dụng phương thức format() để định dạng ngày giờ hiện tại rồi gán cho chuỗi formatted
        String formatted = current.format(formatter);
        //hiển thị chuỗi formatted ra màn hình
        System.out.println("Ngày giờ hiện tại: " + formatted);
        return formatted;
    }

    public static String randomAlphaNumeric(int numberOfCharactor) {
        StringBuilder sb = new StringBuilder();
        String alpha = "abcdefghijklmnopqrstuvwxyz"; // a-z
        String alphaUpperCase = alpha.toUpperCase(); // A-Z
        String digits = "0123456789"; // 0-9
        String ALPHA_NUMERIC = alpha + alphaUpperCase + digits;
        Random generator = new Random();

        for (int i = 0; i < numberOfCharactor; i++) {
            char ch = ALPHA_NUMERIC.charAt(generator.nextInt((ALPHA_NUMERIC.length() - 1) - 0 + 1) + 0);
            sb.append(ch);
        }

        return sb.toString();
    }

    public static HashMap<String, String> setValueRandom(Map<String, String> list, String key, String value) {
        HashMap<String, String> info = new HashMap<>(list);
        if (info.get(key).contains("random")) {
            info.replace(key, info.get(key), value);
        }
        System.out.println("Value = " + value);
        return info;
    }

    public static HashMap<String, Object> setValueRandom1(Map<String, Object> list, String key, String value) {
        HashMap<String, Object> info = new HashMap<>(list);
        if (info.get(key).toString().contains("random")) {
            info.replace(key, "random", value);
        }
        System.out.println("Value = " + value);
        return info;
    }

    public static HashMap<String, String> setValueRandom2(Map<String, String> list, String key, String oldValue, String newValue) {
        HashMap<String, String> info = new HashMap<>(list);
        if (info.get(key).contains("random")) {
            info.replace(key, oldValue, newValue);
        }
        System.out.println("Value = " + newValue);
        return info;
    }

    public static HashMap<String, String> setValue(Map<String, String> list, String key, String oldValue, String newValue, String condition) {
        HashMap<String, String> info = new HashMap<>(list);
        if (info.get(key).equals(condition)) {
            info.replace(key, oldValue, newValue);
        }
        System.out.println("Value = " + newValue);
        return info;
    }

    public static HashMap<String, Object> setValue1(Map<String, Object> list, String key, Object oldValue, String newValue, String condition) {
        HashMap<String, Object> info = new HashMap<>(list);
        if (info.get(key).equals(condition)) {
            info.replace(key, oldValue, newValue);
        }
        System.out.println("Value = " + newValue);
        return info;
    }

    public static HashMap<String, String> setValue2(Map<String, String> list, String key, String oldValue, String newValue, String condition) {
        HashMap<String, String> info = new HashMap<>(list);
        if (info.get(key).toString().contains(condition)) {
            info.replace(key, oldValue, newValue);
        }
        System.out.println("Value = " + newValue);
        return info;
    }

    public static Performable pressESC() {
        return new DriverTask(driver -> {
            Robot robot = null;
            try {
                robot = new Robot();
            } catch (AWTException e) {
                e.printStackTrace();
            }
            robot.setAutoDelay(1000);
            //native key strokes for CTRL, V and ENTER keys
            robot.keyPress(KeyEvent.VK_ESCAPE);
            robot.keyRelease(KeyEvent.VK_ESCAPE);
        });
    }

    public static Performable moveSlider() {
        return new DriverTask(driver -> {
            Actions actions = new Actions(driver);
            actions.sendKeys(Keys.ARROW_DOWN).build().perform();
        });
    }

    public static Performable setSessionVariable(String varName, String value) {
        return new Performable() {
            @Override
            public <T extends Actor> void performAs(T t) {
                Serenity.setSessionVariable(varName).to(value);
            }
        };
    }

    public static Task enterInvalidToDropdown(Target target, String value) {
        return Task.where("Enter invalid to drowpdown",
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                Enter.keyValues(value).into(target),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA1),
                Ensure.that(CommonAdminForm.NO_DATA1).isDisplayed()
        );
    }

    public static Task enterInvalidToDropdown2(Target target, String value) {
        return Task.where("Enter invalid to drowpdown",
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                Enter.keyValues(value).into(target),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA),
                Ensure.that(CommonAdminForm.NO_DATA).isDisplayed()
        );
    }

    public static Performable loop(int numCircle, Performable performable) {
        return new Performable() {
            @Override
            public <T extends Actor> void performAs(T t) {
                for (int i = 0; i < numCircle; i++) {
                    Task.where("", performable);
                }
            }
        };
    }

    /**
     * Dung trong re turn Task
     *
     * @param varName
     * @param value
     * @return
     */
    public static Interaction setSessionVariableInteraction(String varName, String value) {
        return Interaction.where("set variable", setSessionVariable(varName, value));
    }

    public static Task bypassPolicyPopup() {
        return Task.where("By pass popup policy",
                Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.I_ACCEPT),
                                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                                        .andIfSo(
                                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                                Click.on(HomePageForm.CLOSE_POPUP),
                                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                                        ),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                Click.on(HomePageForm.CLOSE_POPUP),
                                Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                                        .andIfSo(
                                                Click.on(HomePageForm.I_ACCEPT),
                                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                                        )
                        )
        );
    }

    public static Performable scroll() {
        return Task.where("{0} sroll",
                actor -> {
                    BrowseTheWeb.as(actor).evaluateJavascript("window.scrollBy(0,document.body.scrollHeight)", "");
                });
    }

    public static Task chooseMultiItemInDropdown(Target parentTarget, String value, Target childTarget) {
        return Task.where("Choose multi item in dropdown",
                CommonWaitUntil.isEnabled(parentTarget),
                Click.on(parentTarget),
                Enter.theValue(value).into(parentTarget),
                CommonWaitUntil.isVisible(childTarget),
                WindowTask.threadSleep(500),
                Click.on(childTarget),
                Click.on(parentTarget)
        );
    }

    public static Task chooseMultiWithOneItemInDropdown(Target parentTarget, String value, Target childTarget) {
        return Task.where("Choose multi with one item in dropdown",
                CommonWaitUntil.isEnabled(parentTarget),
                Click.on(parentTarget),
                Enter.theValue(value).into(parentTarget),
                CommonWaitUntil.isVisible(childTarget),
                WindowTask.threadSleep(500),
                Click.on(childTarget),
                WindowTask.threadSleep(500),
                JavaScriptClick.on(parentTarget)
        );
    }

    public static Task swipeTarget(Target fromTarget, Target toTarget) {
        return Task.where("swipe Target from " + fromTarget.getName() + " to " + toTarget.getName(),
                CommonWaitUntil.isVisible(fromTarget),
                Drag.from(fromTarget).to(toTarget)
        );
    }

    public static Performable chooseMultiItemInDropdown1(Target parentTarget, List<Map<String, String>> infos) {
        return Task.where("Choose multi item in dropdown",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isEnabled(parentTarget),
                            JavaScriptClick.on(parentTarget)
                    );
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("value"))),
                                Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("value"))),
                                WindowTask.threadSleep(500)
                        );
                    }

                    actor.attemptsTo(
                            JavaScriptClick.on(parentTarget)
                    );
                }
        );
    }

    public static Task clearTextbox(Target target) {
        return Task.where("Choose multi item in dropdown",
                Enter.theValue("a").into(target),
                Hit.the(Keys.BACK_SPACE).into(target)
        );
    }

    public static Performable clearTextboxMultiDropdown(Target target) {
        return Task.where("Clear textbox multi dropdown",
                actor -> {
                    List<WebElementFacade> elements = target.resolveAllFor(theActorInTheSpotlight());
                    for (WebElementFacade element : elements) {
                        actor.attemptsTo(
                                Click.on(element).afterWaitingUntilEnabled(),
                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public CommonTask performWithContainKey(Map<String, String> map, String key, Performable... performables) {
        if (map.containsKey(key)) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(map.get(key).isEmpty()).otherwise(
                            performables
                    )
            );
        } else System.out.println("Datatable does not contain the key: " + key);
        return this;
    }



}