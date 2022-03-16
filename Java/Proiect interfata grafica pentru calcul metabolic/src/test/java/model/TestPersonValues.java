package model;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestPersonValues {
    @Test
    void testGetters() {
        PersonValues personValues = new PersonValues(1, 2, 3);
        assertEquals(1, personValues.getHeightCm());
        assertEquals(2, personValues.getWeightKg());
        assertEquals(3, personValues.getAge());
        assertEquals(20 + (int) 6.25 - 5 * 3 - 85, personValues.getBmr());
    }

    @Test
    void testToString() {
        PersonValues personValues = new PersonValues(1, 2, 3);
        assertEquals("   Age=" + 3 + ";\n" +
                        "   Height=" + 1 + ";\n" +
                        "   Weight=" + 2 + ";\n"
                , "   Age=" + personValues.getAge() + ";\n" +
                        "   Height=" + personValues.getHeightCm() + ";\n" +
                        "   Weight=" + personValues.getWeightKg() + ";\n");
    }
}
