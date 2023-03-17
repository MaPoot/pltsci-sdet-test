package runner;

import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
        features = {
                "src/test/resources/features/"
        },
        glue = "steps",
        plugin = {
                "pretty",
        },
        tags = "not @Ignore"
)
public class Runner {
    public static void main(String[] args) {

    }
}
