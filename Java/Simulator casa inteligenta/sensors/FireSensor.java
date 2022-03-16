package ex4.sensors;

import ex4.events.FireEvent;
import ex4.units.AlarmUnit;
import ex4.units.GsmUnit;

public class FireSensor {
    public String activate(FireEvent fireEvent){
        if(fireEvent.isSmoke()){
            return "-------\nFire sensor is on:\n"+
                    new AlarmUnit().startAlarm()+"\n"+
                    new GsmUnit().callOwner()+"\n-------------";

        }
        return "No fire.\n";
    }
}
