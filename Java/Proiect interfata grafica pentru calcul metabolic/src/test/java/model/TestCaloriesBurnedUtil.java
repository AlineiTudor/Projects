package model;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestCaloriesBurnedUtil {
    @Test
    void testDetermineCalories() {
        assertEquals(26, CaloriesBurnedUtil.determineCalories(13, 48));
    }
}
