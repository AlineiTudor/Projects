package model.sports;

import model.sports.swim.Swimming;
import model.sports.swim.SwimmingStyles;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestSwimming {
    @Test
    void testMets() {
        Swimming swimming = new Swimming(60, SwimmingStyles.BUTTERFLY);
        assertEquals(13.8, swimming.mets());
    }
}
