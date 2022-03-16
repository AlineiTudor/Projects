package model.sports;

public class SpaceTime {
    private double distanceKm;
    private double speedKph;
    private double timeMin;

    public SpaceTime() {
        this.distanceKm=0;
        this.timeMin=0;
        this.speedKph=0;
    }

    public SpaceTime(double distanceKm, double timeMin) {
        this.distanceKm=Math.abs(distanceKm);
        this.timeMin=Math.abs(timeMin);
        speedKph = speed();
    }

    public double speed() {
        return distanceKm / timeMin * 60;
    }

    public double getDistanceKm() {
        return distanceKm;
    }

    public double getSpeedKph() {
        return speedKph;
    }

    public double getTimeMin() {
        return timeMin;
    }

    public void setDistanceKm(double distanceKm) {
        this.distanceKm = distanceKm;
    }

    public void setSpeedKph(double speedKph) {
        this.speedKph = speedKph;
    }

    public void setTimeMin(double timeMin) {
        this.timeMin = timeMin;
    }

    @Override
    public String toString() {
        return  " -Distance covered [Km]: " + distanceKm +
                ", time [min]: " + timeMin +
                ", speed [k/h]: " + speedKph+"\n" ;
    }

}
