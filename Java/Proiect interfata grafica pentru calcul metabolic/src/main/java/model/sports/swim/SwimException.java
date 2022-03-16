package model.sports.swim;

public class SwimException extends Exception {
    public SwimException(String style){
        super("Swimming style "+style+" not found");
    }
}
