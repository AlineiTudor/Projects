package model;

public final class CaloriesBurnedUtil {
    public static final double determineCalories(int bmr,double mets){
        return bmr*mets/24;
    }
}
