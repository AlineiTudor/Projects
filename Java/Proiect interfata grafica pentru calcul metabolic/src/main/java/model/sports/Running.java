package model.sports;

public class Running extends SpaceTime implements Activity {

    public Running(double distanceKm, double timeMin) {
        super(distanceKm, timeMin);
    }

    @Override
    public double mets() {
        if (getSpeedKph() <= 6.4) {
            return 6*getTimeMin()/60;
        }
        if (getSpeedKph() > 6.4 && getSpeedKph()<=8) {
            return 8.3*getTimeMin()/60;
        }
        if (getSpeedKph() > 8 && getSpeedKph()<=8.4) {
            return 9*getTimeMin()/60;
        }
        if (getSpeedKph() > 8.4 && getSpeedKph()<=9.7) {
            return 9.8*getTimeMin()/60;
        }
        if (getSpeedKph() > 9.7 && getSpeedKph()<=10.8) {
            return 10.5*getTimeMin()/60;
        }
        if (getSpeedKph() > 10.8 && getSpeedKph()<=11.3) {
            return 11*getTimeMin()/60;
        }
        if (getSpeedKph() > 11.3 && getSpeedKph()<=12.1) {
            return 11.5*getTimeMin()/60;
        }
        if (getSpeedKph() > 12.1 && getSpeedKph()<=12.9) {
            return 11.8*getTimeMin()/60;
        }
        if (getSpeedKph() > 12.9 && getSpeedKph()<=13.8) {
            return 12.3*getTimeMin()/60;
        }
        if (getSpeedKph() > 13.8 && getSpeedKph()<=14.5) {
            return 12.8*getTimeMin()/60;
        }
        if (getSpeedKph() > 14.5 && getSpeedKph()<=16.1) {
            return 14.5*getTimeMin()/60;
        }
        if (getSpeedKph() >16.1 && getSpeedKph()<=17.7) {
            return 16*getTimeMin()/60;
        }
        if (getSpeedKph() > 17.7 && getSpeedKph()<=19.3) {
            return 19*getTimeMin()/60;
        }
        if (getSpeedKph() > 19.3 && getSpeedKph()<=20.9) {
            return 19.8*getTimeMin()/60;
        }
        if (getSpeedKph() > 20.9 && getSpeedKph()<=22.5) {
            return 23*getTimeMin()/60;
        }
        return 28*getTimeMin()/60;

    }

    @Override
    public String toString() {
        return "Running: " + super.toString();
    }
}
