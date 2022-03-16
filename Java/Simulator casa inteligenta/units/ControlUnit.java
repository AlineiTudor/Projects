package ex4.units;

import ex4.events.Event;
import ex4.events.EventType;
import ex4.events.FireEvent;
import ex4.events.TemperatureEvent;
import ex4.sensors.FireSensor;
import ex4.sensors.TempSensor;

import java.io.FileWriter;
import java.io.IOException;

public class ControlUnit {
    private static volatile ControlUnit instance=null;
    private ControlUnit(){}
    public static ControlUnit getInstance(){
        synchronized (ControlUnit.class){
            if(instance==null){
                instance=new ControlUnit();
            }
        }
        return instance;
    }

    public void controlHouse(Event event, FileWriter wr)throws IOException {
        if(event.getType()== EventType.TEMPERATURE){
            TempSensor tempSensor=TempSensor.getSensor();
            wr.write(tempSensor.adaptTemperature((TemperatureEvent) event,22));
        }
        else if(event.getType()==EventType.FIRE){
            FireSensor f=new FireSensor();
            wr.write(f.activate((FireEvent) event));
        }
        else{
            wr.write("Nothing wrong with the house.\n");
        }
    }

}
