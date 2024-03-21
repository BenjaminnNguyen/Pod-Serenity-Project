package cucumber.questions.Admin.Brands;

import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Question;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class BrandCatalogInfo {
    public static Question<Boolean> noShowAnyBrand() {
        return new There_Is_Not_Any_Brand_Will_Show();
    }

    public static class There_Is_Not_Any_Brand_Will_Show implements Question<Boolean>
    {
        @Override
        public Boolean answeredBy(Actor actor) {
            Target BRANDS = Target.the("").located(By.cssSelector("div.brand-card"));
            boolean isnoBrand = BRANDS.resolveAllFor(actor).size() == 0;
            return isnoBrand;
        }
    }
}
