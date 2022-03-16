package model.sports;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestRunning {
    @Test
    void testMets(){
        Running running=new Running(12,120);
        assertEquals(12,running.mets());
    }
}
