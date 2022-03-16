package model.sports.swim;

import model.sports.Activity;
import model.sports.SpaceTime;

public class Swimming extends SpaceTime implements Activity {
    private SwimmingStyles swimStyle;

    public Swimming(double timeMin, SwimmingStyles swimStyle) {
        super();
        setTimeMin(timeMin);
        this.swimStyle = swimStyle;
    }

    @Override
    public double mets() {
        if (swimStyle == SwimmingStyles.CRAWL) {
            return 8.3 * getTimeMin() / 60;
        }
        if (swimStyle == SwimmingStyles.BACKSTROKE) {
            return 9.5 * getTimeMin() / 60;
        }
        if (swimStyle == SwimmingStyles.BUTTERFLY) {
            return 13.8 * getTimeMin() / 60;
        }
        return 10.3 * getTimeMin() / 60;

    }

    public SwimmingStyles getSwimStyle() {
        return swimStyle;
    }

    public void setSwimStyle(SwimmingStyles swimStyle) {
        this.swimStyle = swimStyle;
    }

    @Override
    public String toString() {
        return "Swimming: " +
                "style->" + swimStyle + ", time: " + getTimeMin() + " min\n";
    }
}
