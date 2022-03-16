package model.sports;

public class Bicycling extends SpaceTime implements Activity {

    public Bicycling(double distanceKm, double timeMin) {
        super(distanceKm, timeMin);
    }

    @Override
    public double mets() {
        if (getSpeedKph() <= 8.9) {
            return 3.5 * getTimeMin() / 60;
        }
        if (getSpeedKph() > 8.9 && getSpeedKph() <= 15.1) {
            return 5.8 * getTimeMin() / 60;
        }
        if (getSpeedKph() > 15.1 && getSpeedKph() <= 19.2) {
            return 6.8 * getTimeMin() / 60;
        }
        if (getSpeedKph() > 19.2 && getSpeedKph() <= 22.4) {
            return 8 * getTimeMin() / 60;
        }
        if (getSpeedKph() > 22.4 && getSpeedKph() <= 25.7) {
            return 10 * getTimeMin() / 60;
        }
        if (getSpeedKph() > 25.7 && getSpeedKph() <= 32.1) {
            return 12 * getTimeMin() / 60;
        }
        return 15.8 * getTimeMin() / 60;

    }

    @Override
    public String toString() {
        return "Bicycling: "+super.toString();
    }
}
