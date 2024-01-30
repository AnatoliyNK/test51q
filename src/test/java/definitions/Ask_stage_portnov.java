package definitions;

import io.cucumber.java.en.*;
import org.openqa.selenium.*;

import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.io.*;

import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.*;

import java.time.Duration;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import static support.TestContext.getDriver;


public class Ask_stage_portnov {

    @Then("I click on element User s Management")
    public void iChangeDownloadDirectory() {
        getDriver().findElement(By.xpath("//*[text()=\"User's Management\"]/../../..")).click();
    }

//    @Then("^I type \"([^\"]*)\" into element with xpath \"([^\"]*)\" using JavaScript$")
//    public void iTypeIntoElementWithXpath(String text, String xpath) {
//
//        WebElement element = getDriver().findElement(By.xpath(xpath));
//        JavascriptExecutor executor = (JavascriptExecutor) getDriver();
//        //executor.executeScript("arguments[0].click();", element);
//
//        //JavascriptExecutor j = (JavascriptExecutor)driver;
//        executor.executeScript ("arguments[0].value='" + text + "'", element);
//
//
//    }

    @Then("I add Quiz questions from XLSX {string}")
    public void iAddQuizQuestionsFromXLSX(String fileName) throws IOException {

        LastLine lastLine = new LastLine();
        String cellValue = "";
        String xpath = "//*[contains(text(), 'add_circle')]/../.."; //BUTTON ADD
        int numberOfQuestion = 0;
        int numberOfQuestionWhithSingleOptions = 0, numberOfQuestionWhithMultiOptions = 0;
        double waitingTimeSec = 0.3;

        //int[] countsOfQuestionsOptions = new int[99]; // Overflow but it better
        int[] countsOfQuestionsSingeOptions = new int[99], countsOfQuestionsMultipleOptions = new int[99]; // Overflow but it better

        FileInputStream file = new FileInputStream(new File(fileName));

        //Create Workbook instance holding reference to .xlsx file
        XSSFWorkbook workbook = new XSSFWorkbook(file);

        //Get first/desired sheet from the workbook
        XSSFSheet sheet = workbook.getSheetAt(0);

        //Iterate through each rows one by one
        Iterator<Row> rowIterator = sheet.iterator();

        JavascriptExecutor executor = (JavascriptExecutor) getDriver();


        while (rowIterator.hasNext()) {


            Row row = rowIterator.next();
//            System.out.println(row.getRowNum());
            if (row.getRowNum()==0) {
                continue;
            }


            //For each row, iterate through all the columns
            Iterator<Cell> cellIterator = row.cellIterator();

            while (cellIterator.hasNext()) {

                Cell cell = cellIterator.next();

                switch (cell.getCellType()) {

                    case NUMERIC:
                        cellValue = Double.toString(cell.getNumericCellValue());
                        break;
                    case STRING:
                        cellValue = cell.getStringCellValue();
                        break;
                    case BLANK:
                        continue;

                }

                switch (cell.getColumnIndex()) {

                    case 0:
                        break;
                    case 1:
                        lastLine.type = cellValue;
                        break;
                    case 2:
                        lastLine.question = cellValue;
                        break;
                    case 3:
                        lastLine.textInOptions = cellValue;
                        break;
                    case 4:
                        lastLine.correctOption = cellValue;
                        break;
                    case 5:
                        lastLine.includeOther = cellValue;
                        break;
                    case 6:
                        lastLine.showStopper = cellValue;
                        break;
                    case 7:
                        lastLine.points = cellValue;
                        break;
                }



            }
            //System.out.println(lastLine.getString());

            // Wait and press button "Add Question
            new WebDriverWait(getDriver(), Duration.ofSeconds(10), Duration.ofMillis(200)).until(ExpectedConditions.presenceOfElementLocated(By.xpath(xpath)));
            getDriver().findElement(By.xpath(xpath)).click();


            //*[contains(@placeholder,'Question')]
            // Text Question
            waitForSec(waitingTimeSec);
            if (lastLine.type.equals("Textual")) {
                webElementNumber("//*[contains(text(),'Textual')]/../..", numberOfQuestion).click();
            } else if (lastLine.type.equals("Single Choice")) {
                webElementNumber("//*[contains(text(),'Single-Choice')]/../..", numberOfQuestion).click();
            } else if (lastLine.type.equals("Multiple-choice")) {
                webElementNumber("//*[contains(text(),'Multiple-Choice')]/../..", numberOfQuestion).click();
            }


            toClipboard(lastLine.question);
            webElementNumber("//*[contains(@placeholder,'Question')]", numberOfQuestion).sendKeys(Keys.chord(Keys.LEFT_CONTROL, "v"));
            waitForSec(waitingTimeSec);

            float tekPoints = 5;
            while (tekPoints > Float.parseFloat(lastLine.points)) {
                webElementNumber("//*[@class='mat-slider-thumb']/../../..", numberOfQuestion).sendKeys(Keys.LEFT);
                tekPoints --;
            }
            while (tekPoints < Float.parseFloat(lastLine.points)) {
                webElementNumber("//*[@class='mat-slider-thumb']/../../..", numberOfQuestion).sendKeys(Keys.RIGHT);
                tekPoints ++;
            }


            if (lastLine.showStopper.equals("Yes")){
                webElementNumber("//*[contains(text(),\"Show-Stopper\")]/../../div",  numberOfQuestion-numberOfQuestionWhithMultiOptions).click();
            }
            if(lastLine.includeOther.equals("Yes")){
                webElementNumber("//*[contains(text(),\"text area option for this question\")]/../div[1]",  numberOfQuestionWhithSingleOptions + numberOfQuestionWhithMultiOptions).click();
            }


            if (lastLine.type.equals("Single Choice") || lastLine.type.equals("Multiple-choice")) {

                String[] options = lastLine.textInOptions.split("\n");

                for (int count = 2; count<options.length; count++ ){
                    waitForSec(waitingTimeSec);
                    webElementNumber("//*[contains(text(),'Add Option')]/..", numberOfQuestionWhithSingleOptions + numberOfQuestionWhithMultiOptions).click();
                }

                //******
                int numberOfOption = 0;
                for (String option: options){
                    numberOfOption ++;

                    waitForSec(waitingTimeSec);

                    toClipboard(option);

                    webElementNumber(
                            "//*[contains(@placeholder,'Option "+ numberOfOption +"*')]/../textarea",
                            countsOfQuestionsSingeOptions[numberOfOption-1] + countsOfQuestionsMultipleOptions[numberOfOption-1]
                        ).sendKeys(Keys.chord(Keys.LEFT_CONTROL, "v"));

                    waitForSec(waitingTimeSec);

                    //if (lastLine.correctOption.contains(Integer.toString(numberOfOption))){
                        if(lastLine.type.equals("Single Choice")) {
                            if (lastLine.correctOption.contains(Integer.toString(numberOfOption))){
                                webElementNumber("//*[contains(text(),'Option " + numberOfOption + "*')]/../../../../../../mat-radio-button/label/div[1]", countsOfQuestionsSingeOptions[numberOfOption-1]).click();
                            }
                            countsOfQuestionsSingeOptions[numberOfOption-1]++;
                        }else {
                            if (lastLine.correctOption.contains(Integer.toString(numberOfOption))){
                                webElementNumber("//*[contains(text(),'Option " + numberOfOption + "*')]/../../../../../../mat-checkbox/label/div[1]", countsOfQuestionsMultipleOptions[numberOfOption-1]).click();
                            }
                            countsOfQuestionsMultipleOptions[numberOfOption-1]++;
                        }
                    //}

                }



                if(lastLine.type.equals("Single Choice")) {
                    numberOfQuestionWhithSingleOptions++;
                }else {
                    numberOfQuestionWhithMultiOptions++;
                }
            }
            numberOfQuestion++;
//            else if (lastLine.type.equals("Multiple-choice")) {
//                webElementNumber("//*[contains(text(),'Multiple-Choice')]/../..", numberOfQuestion).click();
//            }



        }
        file.close();

    }

    @Then("I check Quiz questions from XLSX {string}")
    public void iCheckQuizQuestionsFromXLSX(String fileName) throws IOException {


        LastLine lastLine = new LastLine();
        String cellValue = "";
        String xpath = "//*[contains(text(), 'add_circle')]/../.."; //BUTTON ADD
        int numberOfQuestion = 0;

        double waitingTimeSec = 0.3;

        FileInputStream file = new FileInputStream(new File(fileName));

        //Create Workbook instance holding reference to .xlsx file
        XSSFWorkbook workbook = new XSSFWorkbook(file);

        //Get first/desired sheet from the workbook
        XSSFSheet sheet = workbook.getSheetAt(0);

        //Iterate through each rows one by one
        Iterator<Row> rowIterator = sheet.iterator();

        JavascriptExecutor executor = (JavascriptExecutor) getDriver();


        List<WebElement> webElements = getDriver().findElements(By.xpath("//MAT-CARD/H3"));



        while (rowIterator.hasNext()) {


            Row row = rowIterator.next();
//            System.out.println(row.getRowNum());
            if (row.getRowNum()==0) {
                continue;
            }


            //For each row, iterate through all the columns
            Iterator<Cell> cellIterator = row.cellIterator();

            while (cellIterator.hasNext()) {

                Cell cell = cellIterator.next();

                switch (cell.getCellType()) {

                    case NUMERIC:
                        cellValue = Double.toString(cell.getNumericCellValue());
                        break;
                    case STRING:
                        cellValue = cell.getStringCellValue();
                        break;
                    case BLANK:
                        continue;

                }

                switch (cell.getColumnIndex()) {

                    case 0:
                        break;
                    case 1:
                        lastLine.type = cellValue;
                        break;
                    case 2:
                        lastLine.question = cellValue;
                        break;
                    case 3:
                        lastLine.textInOptions = cellValue;
                        break;
                    case 4:
                        lastLine.correctOption = cellValue;
                        break;
                    case 5:
                        lastLine.includeOther = cellValue;
                        break;
                    case 6:
                        lastLine.showStopper = cellValue;
                        break;
                    case 7:
                        lastLine.points = cellValue;
                        break;
                }



            }
            //System.out.println(lastLine.getString());

            if (webElements.get(numberOfQuestion).getText().equals(lastLine.question)) {
                System.out.println("q" + (numberOfQuestion+1) + " = OK");
            }else {
                int t = 0;
                t = t/0;
            }


            numberOfQuestion++;

        }
        file.close();
    }



    private void toClipboard(String question) {
        StringSelection selection = new StringSelection(question);
        Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
        clipboard.setContents(selection, selection);
    }

    public WebElement webElementNumber (String xpath, int number){
        int i = 0;
        while (getDriver().findElements(By.xpath(xpath)).size() <= number) {
            if (i==50){
                break;
            }
            waitForSec(0.25);
            i++;
        }
            return getDriver().findElements(By.xpath(xpath)).get(number);
    }

    public void waitForSec(double sek){
        try {
            Thread.sleep((int)(sek * 1000));
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    @Given("I activate user with email \"([^\"]*)\"$")
    public void iActivateUserWith(String email) {

        String sqlSelectAllPersons = "SELECT * FROM users WHERE email IN ('" + email + "');";
        String connectionUrl = "jdbc:mysql://44.205.92.189:3307/application";
        String baseURL = "http://ask-stage.portnov.com/api/v1";

        try (Connection conn = DriverManager.getConnection(connectionUrl +"?&useSSL=false", "testuser", "password");
             PreparedStatement ps = conn.prepareStatement(sqlSelectAllPersons);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                long id = rs.getLong("id");
                String activationCode = rs.getString("activationCode");
                //getDriver().get(baseURL + "/activate/" + id + "/" + activationCode);

                URL url = new URL(baseURL + "/activate/" + id + "/" + activationCode);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();

                con.setRequestMethod("GET");
                con.setRequestProperty("User-Agent", "USER_AGENT");
                int responseCode = con.getResponseCode();
                System.out.println("Activation request response code: " + responseCode);
                if (responseCode == HttpURLConnection.HTTP_OK) {
                    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    String inputLine;
                    StringBuffer response = new StringBuffer();
                    while ((inputLine = in.readLine()) != null) {
                        response.append(inputLine);
                    }
                    in.close();
                    System.out.println(response);
                } else {
                    System.out.println("Error occurred while trying to send get request");
                }






            }

        } catch (SQLException e) {
            System.out.println(e);
        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }




    class  LastLine{
    public String type = "";
    public String question = "";
    public String textInOptions = "";
    public String correctOption = "";
    public String includeOther = "";
    public String showStopper = "";
    public String points = "";

    public String getString(){
        return "|" + type + " | " + question + " | " + textInOptions + " | " + correctOption +
                " | " + includeOther + " | " + showStopper + " | " + points + " |";
    }
    //textInOptions.split("\n")[0].replace(". ", "☺").split("☺")[1]
}

}

