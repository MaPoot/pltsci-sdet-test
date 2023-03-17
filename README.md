# Execute project from IntelliJ

Click on Maven tab and select verify

# Execution from Maven

Execute test with default environment variables

```
mvn verify -f pom.xml
```

Execute test with different environment variable. Example:

```
mvn verify -Denvironment=test -f pom.xml
```

Ones the execution is complete you can review the full report in /target/site/serenity/index.html

Example:

```
[INFO] Test results for 26 tests generated in 4.7 secs in directory: file:/C:/Users/manuelp/Documents/GitHub/pltsci-sdet-test/target/site/serenity/
[INFO] ------------------------------------------------
[INFO] | SERENITY TESTS:               | ERROR
[INFO] ------------------------------------------------
[INFO] | Test scenarios executed       | 18
[INFO] | Total Test cases executed     | 26
[INFO] | Tests passed                  | 26
[INFO] | Tests failed                  | 0
[INFO] | Tests with errors             | 0
[INFO] | Tests compromised             | 0
[INFO] | Tests aborted                 | 0
[INFO] | Tests pending                 | 0
[INFO] | Tests ignored/skipped         | 0
[INFO] ------------------------------- | --------------
[INFO] | Total Duration| 15s 378ms
[INFO] | Fastest test took| 007ms
[INFO] | Slowest test took| 3s 370ms
[INFO] ------------------------------------------------
[INFO] 
[INFO] SERENITY REPORTS
[INFO]   - Full Report: file:///C:/Users/manuelp/Documents/GitHub/pltsci-sdet-test/target/site/serenity/index.html

```

# Environment-specific configurations
We can configure environment-specific properties and options, so that the tests can be run in different environments. Here, we configure three environments, __default__ and __test__, with different starting URLs for each:
```
environments {
  default{
    api.hover.url = "http://localhost:8083/v1"
  }
  test{
    api.hover.url = "http://localhost:8080/v1"
  }
}
```

## Install MVN

You can refer to this url https://maven.apache.org/install.html

Detailed steps are:

Have a JDK installation on your system. Either set the JAVA_HOME environment variable pointing to your JDK installation or have the java executable on your PATH.

Extract distribution archive in any directory

```
unzip apache-maven-3.9.0-bin.zip
```

or

```
tar xzvf apache-maven-3.9.0-bin.tar.gz
```

Alternatively use your preferred archive extraction tool.

Add the bin directory of the created directory apache-maven-3.9.0 to the PATH environment variable

Confirm with mvn -v in a new shell. The result should look similar to

```
1. Apache Maven 3.9.0 (9b58d2bad23a66be161c4664ef21ce219c2c8584)
2. Maven home: /opt/apache-maven-3.9.0
3. Java version: 1.8.0_45, vendor: Oracle Corporation
4. Java home: /Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home/jre
5. Default locale: en_US, platform encoding: UTF-8
6. OS name: "mac os x", version: "10.8.5", arch: "x86_64", family: "mac"
```

# Serenity and Cucumber

Serenity BDD is a library that makes it easier to write high quality automated acceptance tests, with powerful reporting and living documentation features. It has strong support for both web testing with Selenium, and API testing using RestAssured.

Serenity strongly encourages good test automation design, and supports several design patterns, including classic Page Objects, the newer Lean Page Objects/ Action Classes approach, and the more sophisticated and flexible Screenplay pattern.

The latest version of Serenity supports Cucumber 6.x.

### The project directory structure
The project has build scripts for both Maven and Gradle, and follows the standard directory structure used in most Serenity projects:

```
src
  + test
    + java
      + pojo
        + cleaningSessions
      + runner                    Test runners
      + steps                     Test steps
      + utils                     Utils for test
    + resources
      + features                   Feature files
        + apis                     
          + cleaningSession
```

Serenity 3.6.12 introduced integration with REST Assured

## Sample scenario
Both variations of the sample project uses the sample Cucumber scenario. In this scenario, Sergey (who likes to search for stuff) is performing a search on the internet:

```Gherkin
Feature: Search by keyword

  Scenario: Searching for a term
    Given Sergey is researching things on the internet
    When he looks up "Cucumber"
    Then he should see information about "Cucumber"
```

### The implementation
The implementation code is necessary to implement the Gherkin phrases. Here is an example:
```java
    @Given("{actor} is researching things on the internet")
    public void researchingThings(Actor actor) {
        actor.wasAbleTo(NavigateTo.theWikipediaHomePage());
    }

    @When("{actor} looks up {string}")
    public void searchesFor(Actor actor, String term) {
        actor.attemptsTo(
                LookForInformation.about(term)
        );
    }

    @Then("{actor} should see information about {string}")
    public void should_see_information_about(Actor actor, String term) {
        actor.attemptsTo(
                Ensure.that(WikipediaArticle.HEADING).hasText(term)
        );
    }
```

The main advantage of the approach used in this example is not in the lines of code written, although Serenity does reduce a lot of the boilerplate code that you would normally need to write in a web test. The real advantage is in the use of many small, stable classes, each of which focuses on a single job. This application of the _Single Responsibility Principle_ goes a long way to making the test code more stable, easier to understand, and easier to maintain.

## Executing the tests
To run the sample project, you can either just run the `CucumberTestSuite` test runner class, or run either `mvn verify` or `gradle test` from the command line.

By default, the tests will run using Chrome. You can run them in Firefox by overriding the `driver` system property, e.g.
```json
$ mvn clean verify -f pom.xml
```

The test results will be recorded in the `target/site/serenity` directory.

## Generating the reports

The reports are also integrated into the Maven build process: the following code in the `pom.xml` file causes the reports to be generated automatically once all the tests have completed when you run `mvn verify`?

```
             <plugin>
                <groupId>net.serenity-bdd.maven.plugins</groupId>
                <artifactId>serenity-maven-plugin</artifactId>
                <version>${serenity.maven.version}</version>
                <configuration>
                    <tags>${tags}</tags>
                </configuration>
                <executions>
                    <execution>
                        <id>serenity-reports</id>
                        <phase>post-integration-test</phase>
                        <goals>
                            <goal>aggregate</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
```

You use the `environment` system property to determine which environment to run against. For example to run the tests in the staging environment, you could run:
```json
$ mvn clean verify -Denvironment=test -f pom.xml
```

See [**this article**](https://johnfergusonsmart.com/environment-specific-configuration-in-serenity-bdd/) for more details about this feature.

## Want to learn more?
For more information about Serenity BDD, you can read the [**Serenity BDD Book**](https://serenity-bdd.github.io/theserenitybook/latest/index.html), the official online Serenity documentation source. Other sources include:
* **[Learn Serenity BDD Online](https://expansion.serenity-dojo.com/)** with online courses from the Serenity Dojo Training Library
* **[Byte-sized Serenity BDD](https://www.youtube.com/channel/UCav6-dPEUiLbnu-rgpy7_bw/featured)** - tips and tricks about Serenity BDD
* For regular posts on agile test automation best practices, join the **[Agile Test Automation Secrets](https://www.linkedin.com/groups/8961597/)** groups on [LinkedIn](https://www.linkedin.com/groups/8961597/) and [Facebook](https://www.facebook.com/groups/agiletestautomation/)
* [**Serenity BDD Blog**](https://johnfergusonsmart.com/category/serenity-bdd/) - regular articles about Serenity BDD

