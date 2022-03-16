package model.sports;

public class Walking extends SpaceTime implements Activity {

    public Walking(double distanceKm, double timeMin) {
        super(distanceKm, timeMin);
    }

    @Override
    public double mets() {
        if (getSpeedKph() <= 3) {
            return 2*getTimeMin()/60;
        }
        if (getSpeedKph() > 3 && getSpeedKph() <= 4) {
            return 2.5*getTimeMin()/60;
        }
        if(getSpeedKph()>4 && getSpeedKph()<=5) {
            return 3.5 * getTimeMin() / 60;
        }
        if(getSpeedKph()>5 && getSpeedKph()<=5.6){
            return 4.3*getTimeMin()/60;
        }
        if(getSpeedKph()>5.6 && getSpeedKph()<=6.4){
            return 5*getTimeMin()/60;
        }
        if(getSpeedKph()>6.4 && getSpeedKph()<=7.2){
            return 7*getTimeMin()/60;
        }
        return 8.3;
    }

    @Override
    public String toString() {
        return "Walking: " + super.toString();
    }
}
