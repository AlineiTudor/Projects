package model.sports;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class TestBicycling {
    @Test
    void testMets() {
        Bicycling bicycling = new Bicycling(50, 240);
        assertEquals(5.8 * 4, bicycling.mets());
    }
}
