package ex4.sensors;

import ex4.events.TemperatureEvent;
import ex4.units.CoolingUnit;
import ex4.units.HeatingUnit;

public class TempSensor {
    private static TempSensor sensor;

    private TempSensor(){
    }

    public static TempSensor getSensor(){
        if(sensor==null){
            sensor=new TempSensor();
        }
        return sensor;
    }

    public String adaptTemperature(TemperatureEvent temperatureEvent, int refTemp) {
        if (temperatureEvent.getVlaue() <= refTemp) {
            return new HeatingUnit().startHU(refTemp)+"\n";
        } else {
            return new CoolingUnit().startCU(refTemp)+"\n";
        }

    }
}
