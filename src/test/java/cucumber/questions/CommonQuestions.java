package cucumber.questions;

import cucumber.singleton.GVs;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Question;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.annotations.Subject;
import net.serenitybdd.screenplay.questions.Text;
import net.serenitybdd.screenplay.targets.Target;
import net.serenitybdd.screenplay.waits.Wait;
import net.thucydides.core.webelements.Checkbox;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.CoreMatchers.equalTo;

public class CommonQuestions {
    /**
     * Hàm thực hiện validate
     *
     * @param patternStr  Pattern để thực hiện validate
     * @param target      Element lấy giá trị để thực hiện validate
     * @param errorTarget Element hiển thị lỗi của Element
     * @return Chính xác hoặc không
     */
    public static Question<Boolean> TextFieldValidation(String patternStr, Target target, Target errorTarget) {

        return new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {
                Pattern pattern = Pattern.compile(patternStr);

                String input = target.resolveFor(actor).getTextValue();

                Matcher matcher = pattern.matcher(input);

                if (matcher.matches()) {
                    // Valid. errorTarget không nên hiện ra
                    if (errorTarget.resolveFor(actor).isVisible()) {
                        return false;
                    }

                    return true;
                } else {
                    // Invalid. errorTarget nên hiện ra
                    if (errorTarget.resolveFor(actor).isVisible()) {
                        return true;
                    }

                    return false;
                }
            }
        };
    }

    /**
     * Chuyển từ Question về Performable. Để có thể drop nếu xảy ra lỗi ở bước này
     * trong hàm attempto
     */
    public static Performable AskForTextFieldValidation(String patternStr, Target target, Target errorTarget) {
        return Wait.until(CommonQuestions.TextFieldValidation(patternStr, target, errorTarget), equalTo(true))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Kiểm tra xem autocomplete đã chọn bản ghi nào chưa. Autocomplete bắt buộc
     * phải chọn giá trị
     *
     * @param target
     * @param removeButtonTarget
     * @param errorTarget
     * @return
     */
    public static Question<Boolean> AutocompleteValidation(Target target, Target removeButtonTarget,
                                                           Target errorTarget) {
        return new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {
                if (removeButtonTarget.resolveFor(actor).isVisible()) {
                    // Đã chọn giá trị. Error Target nên ẩn đi
                    if (errorTarget.resolveFor(actor).isVisible()) {
                        return false;
                    }
                    return true;
                } else {
                    // Chưa chọn giá trị. Error Target nên hiện lên
                    if (errorTarget.resolveFor(actor).isVisible()) {
                        return true;
                    }
                    return false;
                }
            }
        };
    }

    /**
     * Chuyển từ Question về Performable để cho thể check trong AttempTo
     */
    public static Performable AskForAutocompleteValidation(Target target, Target removeButtonTarget,
                                                           Target errorTarget) {
        return Wait.until(CommonQuestions.AutocompleteValidation(target, removeButtonTarget, errorTarget),
                equalTo(true)).forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Hàm kiểm tra đã chọn giá trị trong selector hay chưa
     *
     * @param target      Selector chính
     * @param errorTarget Element hiển thị lỗi của selector
     * @return
     */
    public static Question<Boolean> SelectorValidation(Target target, Target errorTarget) {
        return new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {
                if (target.resolveFor(actor).containsElements("//span[contains(@class,'mat-select-value-text')]")) {
                    // Đã chọn giá trị. Error Target nên ẩn đi
                    if (errorTarget.resolveFor(actor).isVisible()) {
                        return false;
                    }
                    return true;
                } else {
                    // Chưa chọn giá trị. Error Target nên hiện lên
                    if (errorTarget.resolveFor(actor).isVisible()) {
                        return true;
                    }
                    return false;
                }
            }
        };
    }

    /**
     * Chuyển từ Question về Perfomable để có thể check trong AttempTo
     */
    public static Performable AskForSelectorValidation(Target target, Target errorTarget) {
        return Wait.until(CommonQuestions.SelectorValidation(target, errorTarget), equalTo(true))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Kiểm tra xem object có null hay không
     *
     * @param value
     * @return if null return true: false
     */
    public static Question<Boolean> isNull(Object value) {
        return new Question<Boolean>() {

            @Subject("Giá trị của bảng")
            public Boolean answeredBy(Actor actor) {
                if (value == null)
                    return true;
                else
                    return false;
            }
        };
    }

    public static Question<Boolean> isControlDisplay(Target target) {
        return Question.about("'Kiểm tra hiển thị element " + target.getName() + "'").answeredBy(new Question<Boolean>() {
            @Override
            public Boolean answeredBy(Actor actor) {
                if (target.resolveAllFor(theActorInTheSpotlight()).size() != 0)
                    return true;
                else
                    return false;
            }
        });
    }

    public static Question<Boolean> isControlDisplay(Target target, Integer seconds) {
        return Question.about("'Kiểm tra hiển thị element " + target.getName() + " after '" + seconds + " seconds").answeredBy(new Question<Boolean>() {
            @Override
            public Boolean answeredBy(Actor actor) {
                if (AskForElementIsDisplay(target, true).equals(true))
                    return true;
                else
                    return false;
            }
        });
    }

    public static Question<Boolean> isChecked(Target target) {
        return Question.about("'Kiểm tra hiển thị element " + target.getName() + "'").answeredBy(new Question<Boolean>() {
            @Override
            public Boolean answeredBy(Actor actor) {
                WebElementFacade e = target.resolveFor(actor);
                Checkbox checkbox = new Checkbox(e);
                return checkbox.isChecked();
            }
        });
    }

    public static Question<Boolean> isControlUnDisplay(Target target) {
        return Question.about("'Kiểm tra element " + target.getName() + "không hiển thị'").answeredBy(new Question<Boolean>() {
            @Override
            public Boolean answeredBy(Actor actor) {
                if (target.resolveAllFor(theActorInTheSpotlight()).size() == 0)
                    return true;
                else
                    return false;
            }
        });
    }

    public static Question<Boolean> isDisabled(Target target) {
        return Question.about("'Kiểm tra element " + target.getName() + "disabled'").answeredBy(new Question<Boolean>() {
            @Override
            public Boolean answeredBy(Actor actor) {
                return target.resolveFor(actor).isDisabled();

            }
        });
    }

    public static Question<Boolean> isClickAble(Target target) {
        return Question.about("'Kiểm tra element " + target.getName() + "không thể click'").answeredBy(new Question<Boolean>() {
            @Override
            public Boolean answeredBy(Actor actor) {
                if (target.resolveFor(actor).isDisabled())
                    return false;
                if (target.resolveFor(actor).isClickable())
                    return true;
                else
                    return false;
            }
        });
    }

    /**
     * Chuyển từ Question về Perfomable để có thể check trong AttempTo
     */
    public static Performable AskForElementIsDisplay(Target target, boolean value) {
        return Wait.until(CommonQuestions.isControlDisplay(target), equalTo(value))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Chuyển từ Question về Perfomable để có thể check trong AttempTo
     */
    public static Performable AskForInputValueEquals(Target target, String value) {
        return Wait.until(CommonQuestions.targetText(target), equalTo(value))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }


    /**
     * Lấy giá trị text
     *
     * @param target Đối tượng muốn truy vấn giá trị
     * @return text của element
     */
    public static Question<String> targetText(Target target) {
        return Question.about("'Text of Element " + target.getName() + "'").answeredBy(new Question<String>() {

            @Override
            public String answeredBy(Actor actor) {
                if (target.resolveFor(actor).isEnabled()) {
                    String text = target.resolveFor(actor).getTextContent().trim();
                    System.out.println("expected**: " + text);
//                    Serenity.recordReportData().withTitle("Text actual").andContents(text);
                    return text;
                } else {
                    String text = target.resolveFor(actor).getAttribute("value").trim();
                    System.out.println("expected value **: " + text);
//                    Serenity.recordReportData().withTitle("Text actual").andContents(text);
                    return text;
                }
            }
        });
    }

    /**
     * Lấy giá trị text
     *
     * @param target Đối tượng muốn truy vấn giá trị
     * @return text của element
     */
    public static Question<String> targetTextExceptString(Target target, String str) {
        return Question.about("'Text of Element " + target.getName() + "'").answeredBy(new Question<String>() {

            @Override
            public String answeredBy(Actor actor) {
                if (target.resolveFor(actor).isEnabled()) {
                    String text = target.resolveFor(actor).getTextContent().trim().replaceAll(str, "");
                    System.out.println("expected**: " + text);
//                    Serenity.recordReportData().withTitle("Text actual").andContents(text);
                    return text;
                } else {
                    String text = target.resolveFor(actor).getAttribute("value").trim().replaceAll(str, "");
                    System.out.println("expected value **: " + text);
//                    Serenity.recordReportData().withTitle("Text actual").andContents(text);
                    return text;
                }
            }
        });
    }


    public static Performable AskForNumberElement(Target target, int value) {
        return Wait.until(CommonQuestions.getNumElement(target), equalTo(value))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Chuyển từ Question về Perfomable để có thể check trong AttempTo
     */
    public static Performable AskForTextEquals(Target target, String value) {
        if (CommonQuestions.textEquals(target, value).answeredBy(theActorInTheSpotlight()).equals(false)) {
            Serenity.recordReportData().withTitle(target.resolveFor(theActorInTheSpotlight()).getTextContent().trim()).andContents(value);
        }
        return Wait.until(CommonQuestions.textEquals(target, value), equalTo(true))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Chuyển từ Question về Perfomable để có thể check trong AttempTo
     */
    public static Performable AskForTextContains(Target target, String value) {
        return Wait.until(CommonQuestions.textContains(target, value), equalTo(true))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Kiểm tra xem giá trị của đối tượng có bằng giá trị truyền vào không ?
     *
     * @param target
     * @param value
     * @return
     */
    public static Question<Boolean> textEquals(Target target, String value) {
        return new Question<Boolean>() {
            public Boolean answeredBy(Actor actor) {

                String input = Text.of(target).answeredBy(actor).toString();

                return input.equals(value);
            }
        };
    }

    /**
     * Kiểm tra xem có bao nhiêu đối tượng đang hiển thị ?
     *
     * @param target
     * @return
     */
    public static Question<Integer> getNumElement(Target target) {
        return new Question<Integer>() {
            public Integer answeredBy(Actor actor) {

                Integer input = target.resolveAllFor(actor).size();

                return input;
            }
        };
    }

    /**
     * Kiểm tra xem giá trị của đối tượng có bằng giá trị truyền vào không ?
     *
     * @param target
     * @param value
     * @return
     */
    public static Question<Boolean> textContains(Target target, String value) {
        return new Question<Boolean>() {

            @Subject("Text contains {value}")
            public Boolean answeredBy(Actor actor) {
                String input = Text.of(target).answeredBy(actor).toString();
                return input.contains(value);
            }
        };
    }

    /**
     * Chuyển từ Question về Perfomable để có thể check trong AttempTo
     */
    public static Performable AskForTextValidation(Target target, String value) {
        return Wait.until(CommonQuestions.textValidation(target, value), equalTo(true))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Kiểm tra xem giá trị của đối tượng có match với pattern không ?
     *
     * @param target
     * @param validation
     * @return
     */
    public static Question<Boolean> textValidation(Target target, String validation) {
        return new Question<Boolean>() {

            @Subject("text Validation")
            public Boolean answeredBy(Actor actor) {
                Pattern pattern = Pattern.compile(validation);

                String input = Text.of(target).answeredBy(actor).toString();

                Matcher matcher = pattern.matcher(input);

                return matcher.matches();
            }
        };
    }

    /**
     * Lấy title của page
     *
     * @return
     */
    public static Question<String> pageTitle() {
        return new Question<String>() {
            @Override
            public String answeredBy(Actor actor) {
                return BrowseTheWeb.as(actor).getTitle();
            }
        };
    }

    public static Performable AskForPageTitle(String title) {
        return Wait.until(CommonQuestions.pageTitle(), equalTo(title))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    /**
     * Lấy giá trị attribute bất kỳ
     *
     * @param target    Đối tượng muốn truy vấn giá trị
     * @param attribute Attribute muốn truy vấn giá trị
     * @return text của element
     */
    public static Question<String> attributeText(Target target, String attribute) {
        return Question.about("Giá trị attribute '" + attribute + "' của '" + target.getName() + "'").answeredBy(new Question<String>() {

            @Override
            public String answeredBy(Actor actor) {
                String text = target.resolveFor(actor).getAttribute(attribute).trim();
                return text;
            }
        });
    }

    /**
     * Chuyển từ Question về Perfomable để có thể check giá trị attribute
     */
    public static Performable AskForAttributeText(Target target, String attribute, String value) {
        return Wait.until(CommonQuestions.attributeText(target, attribute), equalTo(value))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    public static Performable AskForAttributeContainText2(Target target, String attribute, String value) {
        return Wait.until(CommonQuestions.attributeText(target, attribute), containsString(value))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    public static Question<Boolean> AskForAttributeContainText(Target target, String attribute, String value) {
        return Question.about("Ask For Attribute Contain Text " + value + " of target " + target).answeredBy(new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {
                return target.resolveFor(actor).getAttribute(attribute).contains(value);
            }
        });
    }

    /**
     * Lấy giá trị text
     *
     * @param elementFacade Đối tượng muốn truy vấn giá trị
     * @return text của element
     */
    public static Question<String> webElementFacadeText(WebElementFacade elementFacade) {
        return Question.about("'Text của Element ").answeredBy(new Question<String>() {

            @Override
            public String answeredBy(Actor actor) {
                if (elementFacade.isEnabled()) {
                    return elementFacade.getTextContent().trim();
                } else {
                    return elementFacade.getAttribute("value").trim();
                }
            }
        });
    }

    /**
     * Lấy giá trị text
     *
     * @param elementFacade Đối tượng muốn truy vấn giá trị
     * @return text của element
     */
    public static Question<String> webElementFacadeAttributeText(WebElementFacade elementFacade, String attribute) {
        return Question.about("'Text của Element ").answeredBy(new Question<String>() {

            @Override
            public String answeredBy(Actor actor) {
                return elementFacade.getAttribute(attribute);
            }
        });
    }

    /*Lấy trá trị text của API*/
    public static Question<String> getText(String values) {
        if (values == null) {
            values = "";
        }
        String finalValues = values;
        return Question.about(values).answeredBy(new Question<String>() {
            @Override
            public String answeredBy(Actor actor) {
                return finalValues;
            }
        });
    }

    public static String getText(Actor actor, Target target) {
        return target.resolveFor(actor).getText();
    }

    /**
     * Lấy giá trị value
     *
     * @param target Đối tượng muốn truy vấn giá trị
     * @return text của element
     */
    public static Question<String> targetValue(Target target) {
        return Question.about("'Value của Element " + target.getName() + "'").answeredBy(new Question<String>() {

            @Override
            public String answeredBy(Actor actor) {
                if (target.resolveFor(actor).isEnabled()) {
                    String text = target.resolveFor(actor).getValue().trim();
                    System.out.println("expected**: " + text);
                    return text;
                } else {
                    String text = target.resolveFor(actor).getAttribute("value").trim();
                    System.out.println("expected**: " + text);
                    return text;
                }
            }
        });
    }

    /**
     * Lấy giá trị value
     *
     * @param target Đối tượng muốn truy vấn giá trị
     * @return text của element
     */
    public static String targetValue(Actor actor, Target target) {

        if (target.resolveFor(actor).isEnabled()) {
            String text = target.resolveFor(actor).getValue().trim();
            System.out.println("expected**: " + text);
            return text;
        } else {
            String text = target.resolveFor(actor).getAttribute("value").trim();
            System.out.println("expected**: " + text);
            return text;
        }

    }

    public static String getValueTextBoxByJavaScript(Actor t, Target target) {
        return (String) BrowseTheWeb.as(t).evaluateJavascript("return arguments[0].value;", new Object[]{target.resolveFor(t)});

    }

    /**
     * Chuyển từ Question về Perfomable để có thể check trong AttempTo
     */
    public static Performable AskForValueEquals(Target target, String value) {
        return Wait.until(CommonQuestions.targetValue(target), equalTo(value))
                .forNoMoreThan(GVs.HTTP_TIMEOUT).seconds();
    }

    public static Question<Boolean> AskForContainValue(List<Object> list, Object value) {
        return Question.about("").answeredBy(new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {
                boolean contain = list.contains(value);
                return contain;
            }
        });
    }

    public static Question<Boolean> AskForEqualValue(Object value, Object value2) {
        return Question.about("").answeredBy(new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {
                boolean equals = Objects.equals(value, value2);
                return equals;
            }
        });
    }

    public static Question<Boolean> AskForAttributeValue(Target target, String value) {
        return Question.about("").answeredBy(new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {
                boolean check = target.resolveFor(actor).getValue().equalsIgnoreCase(value);
                return check;
            }
        });
    }

    public static Question<Boolean> AskForContainValue(String OriginalString, String containString) {
        return Question.about("").answeredBy(new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {

                Serenity.recordReportData().withTitle("actual").andContents(OriginalString);
                Serenity.recordReportData().withTitle("expected ").andContents(containString);

                boolean contain = OriginalString.contains(containString);
                if (contain == false) {
                    System.out.println("Expected is contain: " + containString + "But was: " + OriginalString);
                }
                return contain;
            }
        });
    }

    public static Question<Boolean> AskForContainValue(String OriginalString, String... containString) {
        return Question.about("").answeredBy(new Question<Boolean>() {

            @Override
            public Boolean answeredBy(Actor actor) {
                boolean contain = false;
                if (containString.length >= 1) {
                    for (String i : containString) {
                        Serenity.recordReportData().withTitle("actual").andContents(OriginalString);
                        Serenity.recordReportData().withTitle("expected ").andContents(i);
                        contain = OriginalString.contains(i);
                    }
                }
//                boolean contain = OriginalString.contains(containString);
                return contain;
            }
        });
    }

    public static Question<Boolean> AskForElementIsDisable(Target target) {
        return Question.about("'Check Element " + target.getName() + "' is Disable").answeredBy(new Question<Boolean>() {
            @Override
            public Boolean answeredBy(Actor actor) {
                WebElementFacade e = target.resolveFor(actor);
                if (e.isEnabled() || e.isClickable()) {
                    return false;
                } else {
                    return true;
                }
            }
        });
    }

    //    @And("Check file {string} existed on {string}")
    public static Question<Boolean> checkFileExist(String fileName, String path_) {
        return Question.about("'Check file " + fileName + " is exists on folder " + path_).answeredBy(new Question<Boolean>() {
            @Override
            public Boolean answeredBy(Actor actor) {

                Path path__ = Paths.get(path_ + fileName);
                try {
                    Files.getLastModifiedTime(path__);
                    if (Files.exists(path__)) {
                        return true;
                        // file exist
                    } else {
                        return false;
                        // file is not exist
                    }
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }

            }
        });
    }
}
