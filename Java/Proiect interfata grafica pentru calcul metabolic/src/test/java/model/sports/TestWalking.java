package model.sports;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestWalking {
    @Test
    void testMets() {
        Walking walking = new Walking(14, 120);
        assertEquals(7 * 2, walking.mets());
    }
}
