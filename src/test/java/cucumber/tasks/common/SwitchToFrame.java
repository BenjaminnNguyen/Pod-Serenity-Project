package cucumber.tasks.common;

import lombok.AllArgsConstructor;
import net.serenitybdd.markers.CanBeSilent;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.Tasks;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.WebElement;

@AllArgsConstructor
public class SwitchToFrame implements Task, CanBeSilent {
    Target target;
    @Override
    public <T extends Actor> void performAs(T actor) {
        WebElement frame = target.resolveFor(actor);
        actor.attemptsTo(
                Switch.toFrame(frame)
        );
    }

    @Override
    public boolean isSilent() {
        return true;
    }
    public static SwitchToFrame withTarget(Target target){
        return Tasks.instrumented(SwitchToFrame.class,target);
    }
}
