package support;


//import io.cucumber.junit.Cucumber;
//import io.cucumber.junit.CucumberOptions;


//import org.junit.BeforeClass;
//import org.junit.AfterClass;
//import org.junit.runner.RunWith;


//import io.cucumber.junit.Cucumber;
import io.cucumber.testng.CucumberOptions;
//import org.junit.runner.RunWith;
import org.testng.annotations.*;

//@RunWith(Cucumber.class)
@CucumberOptions(
        plugin = {"pretty", "html:target/cucumber", "json:target/cucumber/report.json"},
        features = {"src/test/resources/features"},
        glue = {"definitions", "support"},
        tags = "{@predefined}" // same as VM option -Dcucumber.options="--tags @predefined"
)
public class TestRunner {
    @BeforeClass
    public static void setup() {
        System.out.println("BeforeAll");
    }

    @AfterClass
    public static void teardown() {
        System.out.println("AfterAll");
    }
}
