package cucumber.questions;

import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Question;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.annotations.Subject;

/**
 * Thực hiện truy vấn đến title của trang hiện tại để thực hiện so sánh
 */
@Subject("Tiêu để của trang")
public class PageTitleQuestions implements Question<String> {
    @Override
    public String answeredBy(Actor actor) {
        return BrowseTheWeb.as(actor).getTitle();
    }
    public static Question<String> value() { return new PageTitleQuestions(); }
}