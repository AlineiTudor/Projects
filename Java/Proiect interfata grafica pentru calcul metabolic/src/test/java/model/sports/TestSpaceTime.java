package model.sports;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestSpaceTime {
    @Test
    void testSpeed() {
        SpaceTime spaceTime = new SpaceTime(30, 120);
        assertEquals(15, spaceTime.speed());
        assertEquals(15, spaceTime.getSpeedKph());
    }

    @Test
    void testToString() {
        SpaceTime spaceTime = new SpaceTime(30, 120);
        assertEquals(" -Distance covered [Km]: " + 30.0 +
                        ", time [min]: " + 120.0 +
                        ", speed [k/h]: " + 15.0 + "\n"
                , " -Distance covered [Km]: " + spaceTime.getDistanceKm() +
                        ", time [min]: " + spaceTime.getTimeMin() +
                        ", speed [k/h]: " + spaceTime.getSpeedKph() + "\n");
    }
}
