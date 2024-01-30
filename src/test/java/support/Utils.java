package support;

public class Utils {

    public static void waitForSec(double sek){
        try {
            Thread.sleep((int)(sek * 1000));
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

}
