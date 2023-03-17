package steps;

import com.fasterxml.jackson.databind.ObjectMapper;
import net.serenitybdd.core.environment.EnvironmentSpecificConfiguration;
import net.thucydides.core.environment.SystemEnvironmentVariables;
import net.thucydides.core.util.EnvironmentVariables;

public class BaseSteps {
    protected static final EnvironmentSpecificConfiguration variables = new EnvironmentSpecificConfiguration(SystemEnvironmentVariables.createEnvironmentVariables());
    protected static final ObjectMapper mapper = new ObjectMapper();
}
