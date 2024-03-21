//package cucumber.config;
//
//import com.epam.ta.reportportal.ws.model.log.SaveLogRQ;
//import com.github.invictum.reportportal.Utils;
//import com.github.invictum.reportportal.log.unit.Attachment;
//import com.github.invictum.reportportal.log.unit.Error;
//import com.github.invictum.reportportal.log.unit.Rest;
//import com.github.invictum.reportportal.log.unit.Selenium;
//import net.serenitybdd.core.Serenity;
//import net.thucydides.core.model.ReportData;
//import net.thucydides.core.model.TestStep;
//import org.openqa.selenium.json.Json;
//
//import java.util.*;
//import java.util.function.Function;
//
//public class ReportPortal {
//    public static Function<TestStep, Collection<SaveLogRQ>> logs() {
//        return (step) -> {
//            Set<SaveLogRQ> logs = new HashSet();
//            if (!step.getReportEvidence().isEmpty()) {
//                Date stepStartTime = Date.from(step.getStartTime().toInstant());
//                Iterator var3 = step.getReportEvidence().iterator();
//                while (var3.hasNext()) {
//                    ReportData reportData = (ReportData) var3.next();
//                    try {
//                        SaveLogRQ log = new SaveLogRQ();
//                        log.setMessage(reportData.getTitle() + ": " + reportData.getContents());
//                        log.setLogTime(stepStartTime);
//                        log.setLevel(Utils.logLevel(step.getResult()));
//                        logs.add(log);
//                    } catch (Exception exception) {
//                    }
//                }
//            }
//            return logs;
//        };
//    }
//
//    public static Function<TestStep, Collection<SaveLogRQ>>[] myUnits() {
//        return new Function[]{Attachment.screenshots(), Rest.restQuery(), Error.basic(), Attachment.htmlSources(), Selenium.allLogs(), logs()};
//    }
//
//    public static void addLogs(String title, Object object) {
//        Json json = new Json();
//        Serenity.recordReportData().asEvidence().withTitle(title).andContents(json.toJson(object));
//    }
//
//    public static void addLogs(String title, String content) {
//        Serenity.recordReportData().asEvidence().withTitle(title).andContents(content);
//    }
//
//}